//----------------------------------------------------------------------------------
// This header files contains definitions for a bit stream encoder for an U3D data 
// block as specified in Standard ECMA-363 (Universal 3D File Format), 4th edition 
// (June 2007) (referred below as "the Standard")
//
// \file    U3D_ContextManager.cpp
// \author  Axel Newe (axel.newe@fau.de)
// \date    2016-10-01
//----------------------------------------------------------------------------------


// Local includes
#include "U3D_ContextManager.h"


ML_START_NAMESPACE

void ContextManager::addSymbol(MLuint32 context, MLuint32 symbol)
{
  if (context < mlU3D::Context_StaticFull && context != mlU3D::Context_Uncompressed8 && symbol < MaximumSymbolInHistogram)  // Check if dynamic context: nothing to do if static or if the symbol is larger than the maximum symbol allowed in the histogram
  { 
    MLuint32 NewSize = symbol + ArraySizeIncrement;

    if (0 == _cumulativeCount[context].size())           // Allocate new arrays if they do not exist yet 
    { 
      _cumulativeCount[context].resize(NewSize);
      _symbolCount[context].resize(NewSize);

      // Init the histogram
      _cumulativeCount[context][0] = 1;
      _symbolCount[context][0] = 1;
    }
    else if (_cumulativeCount[context].size() <= symbol)  // Allocate new arrays if they are too small.
    { 
      _cumulativeCount[context].resize(NewSize);
      _symbolCount[context].resize(NewSize);
    }

    if (_cumulativeCount[context][0] >= Elephant)        // If total number of occurances is larger than Elephant, scale down the values to avoid overflow
    {
      int len = (int)_cumulativeCount[context].size();
      MLuint16 tempAccum = 0;

      for(int i = len - 1; i >= 0; i--)
      {
        _symbolCount[context][i] >>= 1;
        tempAccum += _symbolCount[context][i];
        _cumulativeCount[context][i] = tempAccum;
      }

      // Preserve the initial escape value of 1 for the symbol count and cumulative count
      _symbolCount[context][0]++;
      _cumulativeCount[context][0]++;
    }

    _symbolCount[context][symbol]++;

    for(MLuint32 i = 0; i <= symbol; i++)
    {
      _cumulativeCount[context][i]++;
    }

  }
}

MLuint32 ContextManager::hash(){
	MLuint32 ret = 0;
	for (int i = 0; i < mlU3D::Context_StaticFull; i++){
		for (auto j : this->_cumulativeCount[i]){
			ret += j;
		}
		for (auto j : this->_symbolCount[i]){
			ret += j;
		}
	}
	return ret;

}

MLuint32 ContextManager::getSymbolFrequency(MLuint32 context, MLuint32 symbol)
{
  // The static case is 1.
  MLuint32 rValue = 1;

  if (context < mlU3D::Context_StaticFull && context != mlU3D::Context_Uncompressed8)
  {
    // The default for the dynamic case is 0
    rValue = 0;

    if ( (0 != _symbolCount[context].size()) && (symbol < _symbolCount[context].size()) )
    {
      rValue = (MLuint32) _symbolCount[context][symbol];
    }
    else if (symbol == 0)  // If the histogram hasn't been created yet, the symbol 0 is the escape value and should return 1
    { 
      rValue = 1;
    }
  }

  return rValue;
}

MLuint32 ContextManager::getCumulativeSymbolFrequency(MLuint32 context, MLuint32 symbol)
{
  // The static case is just the value of the symbol.
  MLuint32 rValue = symbol - 1;

  if (context < mlU3D::Context_StaticFull && context != mlU3D::Context_Uncompressed8)
  {
    rValue = 0;

    if ( 0 != _cumulativeCount[context].size() )
    {
      if( symbol < _cumulativeCount[context].size() )
      {
        rValue = (MLuint32)(_cumulativeCount[context][0] - _cumulativeCount[context][symbol]);
      }
      else
      {
        rValue = (MLuint32)(_cumulativeCount[context][0]);
      }
    }
  }

  return rValue;
}

MLuint32 ContextManager::getTotalSymbolFrequency(MLuint32 context)
{
  if (context < mlU3D::Context_StaticFull && context != mlU3D::Context_Uncompressed8)
  {
    MLuint32 rValue = 1;

    if(0 != _cumulativeCount[context].size())
    {
      rValue = _cumulativeCount[context][0];
    }

    return rValue;
  }
  else
  {
    if (context == mlU3D::Context_Uncompressed8)
    {
      return 256;
    }
    else
    {
      return context - mlU3D::Context_StaticFull;
    }
  }
}

MLuint32 ContextManager::getSymbolFromFrequency(MLuint32 context, MLuint32 symbolFrequency)
{
  MLuint32 rValue = 0;

  if (context < mlU3D::Context_StaticFull && context != mlU3D::Context_Uncompressed8)
  {
    rValue = 0;

    if (0 != _cumulativeCount[context].size() && symbolFrequency != 0 && _cumulativeCount[context][0] >= symbolFrequency)
    {
      MLuint32 i = 0;

      for(i = 0; i < _cumulativeCount[context].size(); i++)
      {
        if (getCumulativeSymbolFrequency(context, i) <= symbolFrequency) 
        {
          rValue = i;
        }
        else
        {
          break;
        }
      }
    }
  }
  else
  {
    rValue = symbolFrequency + 1;
  }

  return rValue;
}


ML_END_NAMESPACE



