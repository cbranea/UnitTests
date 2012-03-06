GMPA1UT ;; 
 ;;;Problem List;;02/21/12
 I $T(EN^XTMUNIT)'="" D EN^XTMUNIT("GMPA1UT")
 Q
 ;
STARTUP ; 
 N LST,LSTNAME,ERR,LOC
 S DUZ=1,DUZ(0)="@",IO="",U="^"
 K ^GMPL
 S ^GMPL(125.1,0)="PROBLEM SELECTION LIST CONTENTS^125.1IP^^"
 S ^GMPL(125.11,0)="PROBLEM SELECTION CATEGORY^125.11^^"
 S ^GMPL(125.12,0)="PROBLEM SELECTION CATEGORY CONTENTS^125.12P^^"
 S ^GMPL(125.8,0)="PROBLEM LIST AUDIT^125.8P^^"
 S ^GMPL(125.99,0)="PROBLEM LIST SITE PARAMETERS^125.99^1^1"
 S ^GMPL(125.99,1,0)="HOSPITAL^1^1^1^C^1"
 S ^GMPL(125.99,"B","HOSPITAL",1)=""
 S ^GMPL(125,0)="PROBLEM SELECTION LIST^125I^^"
 Q
 ;
SHUTDOWN ;
 Q
 ;
NEWLST ; Test New list
 ;
 S LSTNAME="PList1",LOC="W" 
 S LST=$$NEWLST^GMPLAPI1(LSTNAME,LOC,.ERR)
 D CHKEQ^XTMUNIT(0,+LST,"INCORRECT LIST IEN")
 D CHKEQ^XTMUNIT("INVALIDPARAM",$P(@ERR@(1),U,1),"INVALID ERROR")
 ;
 S LSTNAME="" K @ERR
 S LST=$$NEWLST^GMPLAPI1(LSTNAME,,.ERR)
 D CHKEQ^XTMUNIT(0,+LST,"INCORRECT LIST IEN")
 D CHKEQ^XTMUNIT("INVALIDPARAM",$P(@ERR@(1),U,1),"INVALID ERROR")
 ;
 S LSTNAME="PList1",LOC=$P(^SC(0),U,4)+1
 K @ERR
 S LST=$$NEWLST^GMPLAPI1(LSTNAME,LOC,.ERR)
 D CHKEQ^XTMUNIT(0,+LST,"INCORRECT LIST IEN")
 D CHKEQ^XTMUNIT("LOCNOTFOUND",$P(@ERR@(1),U,1),"INVALID ERROR")
 ;
 S LSTNAME="PL" K @ERR
 S LST=$$NEWLST^GMPLAPI1(LSTNAME,,.ERR)
 D CHKEQ^XTMUNIT(0,+LST,"INCORRECT LIST IEN")
 D CHKEQ^XTMUNIT("INVALIDPARAM",$P(@ERR@(1),U,1),"INVALID ERROR")
 ;
 S LSTNAME="L" K @ERR
 F I=1:1:30 S LSTNAME=LSTNAME_"L"
 S LST=$$NEWLST^GMPLAPI1(LSTNAME,,.ERR)
 D CHKEQ^XTMUNIT(0,+LST,"INCORRECT LIST IEN")
 D CHKEQ^XTMUNIT("INVALIDPARAM",$P(@ERR@(1),U,1),"INVALID ERROR")
 ;
 S LSTNAME="PList1" K @ERR
 S LST=$$NEWLST^GMPLAPI1(LSTNAME,$P(^SC(0),U,3),.ERR)
 D CHKEQ^XTMUNIT(1,+LST,"INCORRECT LIST IEN")
 ;
 S LSTNAME="PList1",LOC=$P(^SC(0),U,4) K @ERR
 S LST=$$NEWLST^GMPLAPI1(LSTNAME,LOC,.ERR)
 D CHKEQ^XTMUNIT(1,+LST,"INCORRECT LIST IEN")
 D CHKEQ^XTMUNIT("LISTEXIST",$P(@ERR@(1),U,1),"INVALID ERROR")
 ;
 D CHKEQ^XTMUNIT(1,$P(^GMPL(125,0),U,3),"INCORRECT MOST RECENTLY IEN")
 D CHKEQ^XTMUNIT(1,$P(^GMPL(125,0),U,4),"INCORRECT ENTRIES COUNT")
 D CHKEQ^XTMUNIT("",^GMPL(125,"B",LSTNAME,LST),"INCORRECT CROSS-REFERENCE")
 D CHKEQ^XTMUNIT(LSTNAME_U_U_LOC,^GMPL(125,LST,0),"INCORRECT LIST IEN")
 Q
 ;
ASSUSR ; Test Assign list to users (ASSGNUSR)
 N USR
 S USR=1 K @ERR
 D ASSGNUSR^GMPLAPI1($P(^GMPL(125,0),U,3)+1,USR,.ERR)
 D CHKEQ^XTMUNIT("LISTNOTFOUND",$P(@ERR@(1),U,1),"INVALID ERROR")
 ;
 K @ERR
 D ASSGNUSR^GMPLAPI1(LST,$P(^VA(200,0),U,3)+1,.ERR)
 D CHKEQ^XTMUNIT("PROVNOTFOUND",$P(@ERR@(1),U,1),"INVALID ERROR")
 ;
 K @ERR
 D ASSGNUSR^GMPLAPI1(LST,USR,.ERR)
 D CHKEQ^XTMUNIT(^VA(200,USR,125),U_LST,"INVALID ERROR")
 ;
 Q
 ;
REMUSR ; Test Remove list from users
 N USR
 S USR=1 K @ERR
 D REMUSR^GMPLAPI1($P(^GMPL(125,0),U,3)+1,USR,.ERR)
 D CHKEQ^XTMUNIT("LISTNOTFOUND",$P(@ERR@(1),U,1),"INVALID ERROR")
 ;
 K @ERR
 D REMUSR^GMPLAPI1(LST,$P(^VA(200,0),U,3)+1,.ERR)
 D CHKEQ^XTMUNIT("PROVNOTFOUND",$P(@ERR@(1),U,1),"INVALID ERROR")
 ;
 K @ERR
 D REMUSR^GMPLAPI1(LST,USR,.ERR)
 D CHKEQ^XTMUNIT(^VA(200,USR,125),U,"INVALID ERROR")
 ;
 Q
 ;
XTENT 
 ;;NEWLST
 ;;ASSUSR
 ;;REMUSR
 Q