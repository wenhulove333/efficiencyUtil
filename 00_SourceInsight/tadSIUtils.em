/* tadSIUtils.em - a collection of useful editing macros for TAD project */

macro AddMyName()
{
	szName = ASK("Please Input your name ")
    if(szName == "#")
    {
       szName = ""
       SetReg ("myName", "")
    }
    else
    {
       SetReg ("myName", szName)
    }
    return szName
}

macro InsertFunctionHeader()
{
	//Get the owner's name from the register, if not exist, then skip.
	szMyName = getReg("myName")
  szfeatureOrProntoName = getReg("featureOrProntoName")

	//Get current time
	SysTime = GetSysTime(1)
  szYear=SysTime.Year
  szMonth=SysTime.month
  szDay=SysTime.day

	//Get a handler to the current file buffer and the name and location of the current symbol where the cursor is.
	hbuf = GetCurrentBuf()
	szFunc = GetCurSymbol();
	ln = GetBufLnCur(hbuf)
  szCurLnText = GetBufLine(hbuf, ln)
  szCurLnFirstPos = 0
  szCurLnLastPos = 0
  len = strlen(szCurLnText)
  while (szCurLnLastPos != len)
  {
    if (szCurLnText[szCurLnLastPos] != " ")
    {
      break;
    }
    szCurLnLastPos++;
  }
  
  szCurLnTextSpace = strmid(szCurLnText, szCurLnFirstPos, szCurLnLastPos)
  
	//begin to assemble the header
	sz = Cat(szCurLnTextSpace, "/**************************************************************************")
	InsBufLine(hbuf, ln, sz)
	szDescription = ASK("Please Input the description of Function ")
	sz = Cat(szCurLnTextSpace, " * DESCRIPTION  : ")
	sz = Cat(sz, szDescription)
	InsBufLine(hbuf, ln + 1, sz)
	sz = Cat(szCurLnTextSpace, " * FUNCTION     : ")
	sz = Cat(sz, szFunc)
	InsBufLine(hbuf, ln + 2, sz)
	sz = Cat(szCurLnTextSpace, " * INPUT PARAM  : ")
	InsBufLine(hbuf, ln + 3, sz)
	sz = Cat(szCurLnTextSpace, " * CREATED      : ")
	sz = Cat(sz, "@szMyName@ @szfeatureOrProntoName@ @szYear@.@szMonth@.@szDay@")
	InsBufLine(hbuf, ln + 4, sz)
	sz = Cat(szCurLnTextSpace, " *************************************************************************/")
	InsBufLine(hbuf, ln + 5, sz)
  
  //if the cursor is before the function, need to delete the last line.
  if (szCurLnLastPos == len)
  {
    DelBufLine(hbuf, ln + 6)
  }
}

macro AddFeatureOrProntoName()
{
	szfeatureOrProntoName = ASK("Please Input your Feature Or Pronto Name ")
    if(szfeatureOrProntoName == "#")
    {
       szfeatureOrProntoName = ""
       SetReg ("featureOrProntoName", "")
    }
    else
    {
       SetReg ("featureOrProntoName", szfeatureOrProntoName)
    }
    return szfeatureOrProntoName
}

macro InsertCommentInSourceCode()
{
  szfeatureOrProntoName = getReg("featureOrProntoName")
  szMyName = getReg("myName")
  
  SysTime = GetSysTime(1)
  szYear=SysTime.Year
  szMonth=SysTime.month
  szDay=SysTime.day
  
  hbuf = GetCurrentBuf()
	ln = GetBufLnCur(hbuf)
  szCurLnText = GetBufLine(hbuf, ln)
  
  sz = Cat(szCurLnText, "//@szfeatureOrProntoName@ @szMyName@ @szYear@.@szMonth@.@szDay@")
  PutBufLine (hbuf, ln, sz)
}