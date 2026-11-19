ù
rC:\Users\oscar\source\repos\TrickTakingMissions\Server\ServerTrickTakingMissions\Domain\Properties\AssemblyInfo.cs
[ 
assembly 	
:	 

AssemblyTitle 
( 
$str !
)! "
]" #
[		 
assembly		 	
:			 

AssemblyDescription		 
(		 
$str		 !
)		! "
]		" #
[

 
assembly

 	
:

	 
!
AssemblyConfiguration

  
(

  !
$str

! #
)

# $
]

$ %
[ 
assembly 	
:	 

AssemblyCompany 
( 
$str 
) 
] 
[ 
assembly 	
:	 

AssemblyProduct 
( 
$str #
)# $
]$ %
[ 
assembly 	
:	 

AssemblyCopyright 
( 
$str 0
)0 1
]1 2
[ 
assembly 	
:	 

AssemblyTrademark 
( 
$str 
)  
]  !
[ 
assembly 	
:	 

AssemblyCulture 
( 
$str 
) 
] 
[ 
assembly 	
:	 


ComVisible 
( 
false 
) 
] 
[ 
assembly 	
:	 

Guid 
( 
$str 6
)6 7
]7 8
[   
assembly   	
:  	 

AssemblyVersion   
(   
$str   $
)  $ %
]  % &
[!! 
assembly!! 	
:!!	 

AssemblyFileVersion!! 
(!! 
$str!! (
)!!( )
]!!) *Ç
vC:\Users\oscar\source\repos\TrickTakingMissions\Server\ServerTrickTakingMissions\Domain\Match\Tricks\TrickTurnRules.cs
	namespace 	
Domain
 
{ 
public 

static 
class 
TrickTurnRules &
{ 
public 
static 
byte 
GetNextTurnSeat *
(* +
byte+ /
currentSeat0 ;
,; <
int= @
playerCountA L
)L M
{ 	
return  
ParticipantSeatRules '
.' ( 
GetNextClockwiseSeat( <
(< =
currentSeat= H
,H I
playerCountJ U
)U V
;V W
} 	
public 
static 
bool 
IsTrickComplete *
(* +
IReadOnlyList+ 8
<8 9
TrickCardPlay9 F
>F G

trickPlaysH R
,R S
intT W
playerCountX c
)c d
{ 	
if 
( 
! !
MatchPlayerCountRules &
.& '"
IsPlayerCountSupported' =
(= >
playerCount> I
)I J
)J K
{ 
throw 
new '
ArgumentOutOfRangeException 5
(5 6
nameof6 <
(< =
playerCount= H
)H I
)I J
;J K
} 
return 

trickPlays 
!=  
null! %
&&& (

trickPlays) 3
.3 4
Count4 9
==: <
playerCount= H
;H I
} 	
public 
static 
byte "
GetNextTrickLeaderSeat 1
(1 2
IReadOnlyList2 ?
<? @
TrickCardPlay@ M
>M N

trickPlaysO Y
,Y Z
int[ ^
playerCount_ j
)j k
{ 	
if 
( 

trickPlays 
is 
null "
)" #
{ 
throw   
new   !
ArgumentNullException   /
(  / 0
nameof  0 6
(  6 7

trickPlays  7 A
)  A B
)  B C
;  C D
}!! 
if## 
(## 
!## 
IsTrickComplete##  
(##  !

trickPlays##! +
,##+ ,
playerCount##- 8
)##8 9
)##9 :
{$$ 
throw%% 
new%% '
ArgumentOutOfRangeException%% 5
(%%5 6
nameof%%6 <
(%%< =

trickPlays%%= G
)%%G H
)%%H I
;%%I J
}&& 
TrickCardPlay(( 
winningPlay(( %
=((& '
TrickWinnerRules((( 8
.((8 9 
DetermineTrickWinner((9 M
(((M N

trickPlays((N X
)((X Y
;((Y Z
return)) 
winningPlay)) 
.)) 
Seat)) #
;))# $
}** 	
}++ 
},, Á(
†C:\Users\oscar\source\repos\TrickTakingMissions\Server\ServerTrickTakingMissions\Domain\Match\SpecialPreparation\MissionSpecialPreparationRules.FinalMissions.cs
	namespace 	
Domain
 
{ 
public 

static 
partial 
class *
MissionSpecialPreparationRules  >
{ 
public 
static 
bool &
CanAssignTrickDistribution 5
(5 6+
MissionTrickDistributionContext6 U
contextV ]
)] ^
{		 	
return

 
context

 
?

 
.

 
Attempt

 #
!=

$ &
null

' +
&&

, .
context

/ 6
.

6 7

Definition

7 A
?

A B
.

B C
SpecialRule

C N
==

O Q"
SpecialMissionRuleType &
.& '*
M50_SplitTrickWinsDistribution' E
&&F H
context 
. 
Attempt 
.  
Phase  %
==& (
MissionAttemptPhase) <
.< =
RoleAndPreparation= O
&&P R
context 
. !
ActingParticipantSeat -
==. 0
context1 8
.8 9
Attempt9 @
.@ A
CaptainSeatA L
&&M O-
!HasDistinctValidDistributionSeats 5
(5 6
context6 =
)= >
;> ?
} 	
private 
static 
bool -
!HasDistinctValidDistributionSeats =
(= >+
MissionTrickDistributionContext> ]
context^ e
)e f
{ 	
int 
participantCount  
=! "
context# *
.* +
Attempt+ 2
.2 3
PlayerCount3 >
;> ?
return 
context 
. %
FirstFourTricksWinnerSeat 4
>=5 7
$num8 9
&&: <
context= D
.D E%
FirstFourTricksWinnerSeatE ^
<_ `
participantCounta q
&&r t
context 
. 
LastTrickWinnerSeat +
>=, .
$num/ 0
&&1 3
context4 ;
.; <
LastTrickWinnerSeat< O
<P Q
participantCountR b
&&c e
context 
. %
FirstFourTricksWinnerSeat 1
!=2 4
context5 <
.< =
LastTrickWinnerSeat= P
;P Q
} 	
public 
static 
MissionAttemptState )#
AssignTrickDistribution* A
(A B+
MissionTrickDistributionContextB a
contextb i
)i j
{ 	
if 
( 
! &
CanAssignTrickDistribution +
(+ ,
context, 3
)3 4
)4 5
{ 
throw 
new 
ArgumentException +
(+ ,
nameof, 2
(2 3
context3 :
): ;
); <
;< =
} $
MissionRoleConfiguration $
roles% *
=+ ,
context- 4
.4 5
Attempt5 <
.< =

RoleConfig= G
??H J$
MissionRoleConfigurationK c
.c d
Defaultd k
;k l
return   
context   
.   
Attempt   "
with  # '
{!! 

RoleConfig"" 
="" 
roles"" "
with""# '
{## %
FirstFourTricksWinnerSeat$$ -
=$$. /
($$0 1
byte$$1 5
)$$5 6
context$$6 =
.$$= >%
FirstFourTricksWinnerSeat$$> W
,$$W X
LastTrickWinnerSeat%% '
=%%( )
(%%* +
byte%%+ /
)%%/ 0
context%%0 7
.%%7 8
LastTrickWinnerSeat%%8 K
}&& 
,&& 
Phase'' 
='' 
MissionAttemptPhase'' +
.''+ ,
PlayingTricks'', 9
}(( 
;(( 
})) 	
public++ 
static++ 
byte++ 
?++ '
GetRequiredHeartCaptureSeat++ 7
(++7 8$
MissionRoleConfiguration++8 P
roles++Q V
,++V W
int++X [
participantCount++\ l
)++l m
{,, 	
byte-- 
?-- 
requiredSeat-- 
=--  
null--! %
;--% &
if.. 
(.. 
roles.. 
?.. 
... 
HeartNineOwnerSeat.. )
...) *
HasValue..* 2
==..3 5
true..6 :
)..: ;
{// 
requiredSeat00 
=00  
ParticipantSeatRules00 3
.003 4 
GetNextClockwiseSeat004 H
(00H I
roles00I N
.00N O
HeartNineOwnerSeat00O a
.00a b
Value00b g
,00g h
participantCount11 $
)11$ %
;11% &
}22 
return33 
requiredSeat33 
;33  
}44 	
}55 
}66 •O
íC:\Users\oscar\source\repos\TrickTakingMissions\Server\ServerTrickTakingMissions\Domain\Match\SpecialPreparation\MissionSpecialPreparationRules.cs
	namespace 	
Domain
 
{ 
public 

static 
partial 
class *
MissionSpecialPreparationRules  >
{		 
public

 
static

 
MissionAttemptPhase

 )
GetInitialPhase

* 9
(

9 :
MissionDefinition

: K

definition

L V
)

V W
{ 	
MissionAttemptPhase 
phase  %
=& '

definition( 2
.2 3
ObjectiveCardCount3 E
==F H
$numI J
? 
MissionAttemptPhase %
.% &
PlayingTricks& 3
:4 5
MissionAttemptPhase6 I
.I J
ObjectiveDraftingJ [
;[ \
if 
( )
IsSingleRoleSelectionRequired -
(- .

definition. 8
.8 9
SpecialRule9 D
)D E
||F H

definition 
. 
SpecialRule &
==' )"
SpecialMissionRuleType* @
.@ A0
$M46_SeatLeftOfHeartNineWinsAllHeartsA e
||f h

definition 
. 
SpecialRule &
==' )"
SpecialMissionRuleType* @
.@ A*
M50_SplitTrickWinsDistributionA _
)_ `
{ 
phase 
= 
MissionAttemptPhase +
.+ ,
RoleAndPreparation, >
;> ?
} 
return 
phase 
; 
} 	
public 
static 
bool 
CanAssignRole (
(( )(
MissionRoleAssignmentContext) E
contextF M
)M N
{ 	
bool 
	isAllowed 
= 
IsRoleContextValid /
(/ 0
context0 7
)7 8
;8 9
if 
( 
	isAllowed 
&& 
MissionSetupRules .
.. /*
IsBlindObjectiveAssignmentRule/ M
(M N
contextN U
.U V

DefinitionV `
.` a
SpecialRulea l
)l m
)m n
{ 
	isAllowed 
= 
context #
.# $#
SelectedParticipantSeat$ ;
!=< >
context? F
.F G
AttemptG N
.N O
CaptainSeatO Z
&&[ ]
MissionSetupRules %
.% &(
AreAllBlindResponsesRecorded& B
(B C
contextC J
.J K
ResponsesBySeatK Z
,Z [
context 
.  
Attempt  '
.' (
PlayerCount( 3
,3 4
context5 <
.< =
Attempt= D
.D E
CaptainSeatE P
)P Q
;Q R
} 
return   
	isAllowed   
;   
}!! 	
private## 
static## 
bool## 
IsRoleContextValid## .
(##. /(
MissionRoleAssignmentContext##/ K
context##L S
)##S T
{$$ 	
return%% 
context%% 
?%% 
.%% 
Attempt%% #
!=%%$ &
null%%' +
&&%%, .
context%%/ 6
.%%6 7

Definition%%7 A
!=%%B D
null%%E I
&&%%J L)
IsSingleRoleSelectionRequired&& -
(&&- .
context&&. 5
.&&5 6

Definition&&6 @
.&&@ A
SpecialRule&&A L
)&&L M
&&&&N P
context'' 
.'' 
Attempt'' 
.''  
Phase''  %
==''& (
MissionAttemptPhase'') <
.''< =
RoleAndPreparation''= O
&&''P R
context(( 
.(( !
ActingParticipantSeat(( -
==((. 0
context((1 8
.((8 9
Attempt((9 @
.((@ A
CaptainSeat((A L
&&((M O
context)) 
.)) #
SelectedParticipantSeat)) /
>=))0 2
$num))3 4
&&))5 7
context))8 ?
.))? @#
SelectedParticipantSeat))@ W
<))X Y
context))Z a
.))a b
Attempt))b i
.))i j
PlayerCount))j u
;))u v
}** 	
public,, 
static,, 
MissionAttemptState,, )

AssignRole,,* 4
(,,4 5(
MissionRoleAssignmentContext,,5 Q
context,,R Y
),,Y Z
{-- 	
if.. 
(.. 
!.. 
CanAssignRole.. 
(.. 
context.. &
)..& '
)..' (
{// 
throw00 
new00 
ArgumentException00 +
(00+ ,
nameof00, 2
(002 3
context003 :
)00: ;
)00; <
;00< =
}11 
bool22 
isBlindAssignment22 "
=22# $
MissionSetupRules22% 6
.226 7*
IsBlindObjectiveAssignmentRule227 U
(22U V
context22V ]
.22] ^

Definition22^ h
.22h i
SpecialRule22i t
)22t u
;22u v
return33 
context33 
.33 
Attempt33 "
with33# '
{44 

RoleConfig55 
=55 
CreateAssignedRoles55 0
(550 1
context551 8
)558 9
,559 :

Objectives66 
=66 
isBlindAssignment66 .
?66/ 0
MissionSetupRules661 B
.66B C#
AutoAssignAllObjectives66C Z
(66Z [
context66[ b
.66b c
Attempt66c j
.66j k

Objectives66k u
,66u v
(77 
byte77 
)77 
context77 !
.77! "#
SelectedParticipantSeat77" 9
)779 :
:77; <
context77= D
.77D E
Attempt77E L
.77L M

Objectives77M W
,77W X
Phase88 
=88 
context88 
.88  

Definition88  *
.88* +
SpecialRule88+ 6
==887 9"
SpecialMissionRuleType88: P
.88P Q(
M11_CaptainSilencesOnePlayer88Q m
?99 
MissionAttemptPhase99 )
.99) *
ObjectiveDrafting99* ;
:99< =
MissionAttemptPhase99> Q
.99Q R
PlayingTricks99R _
}:: 
;:: 
};; 	
private<< 
static<< 
bool<< )
IsSingleRoleSelectionRequired<< 9
(<<9 :"
SpecialMissionRuleType<<: P
specialRule<<Q \
)<<\ ]
{== 	
return>> 
MissionSetupRules>> $
.>>$ %*
IsBlindObjectiveAssignmentRule>>% C
(>>C D
specialRule>>D O
)>>O P
||>>Q S
specialRule?? 
==?? "
SpecialMissionRuleType?? 5
.??5 6(
M11_CaptainSilencesOnePlayer??6 R
||??S U
specialRule@@ 
==@@ "
SpecialMissionRuleType@@ 5
.@@5 6C
7M33_SelectedPlayerWinsExactlyOneTrickWithoutSpecialCard@@6 m
||@@n p
specialRuleAA 
==AA "
SpecialMissionRuleTypeAA 5
.AA5 6I
=M41_SelectedPlayerWinsOnlyFirstAndLastTrickWithoutSpecialCardAA6 s
;AAs t
}BB 	
privateDD 
staticDD $
MissionRoleConfigurationDD /
CreateAssignedRolesDD0 C
(DDC D(
MissionRoleAssignmentContextDDD `
contextDDa h
)DDh i
{EE 	
byteFF #
selectedParticipantSeatFF (
=FF) *
(FF+ ,
byteFF, 0
)FF0 1
contextFF1 8
.FF8 9#
SelectedParticipantSeatFF9 P
;FFP Q$
MissionRoleConfigurationGG $
rolesGG% *
=GG+ ,
contextGG- 4
.GG4 5
AttemptGG5 <
.GG< =

RoleConfigGG= G
??GGH J$
MissionRoleConfigurationGGK c
.GGc d
DefaultGGd k
;GGk l
ifHH 
(HH 
MissionSetupRulesHH !
.HH! "*
IsBlindObjectiveAssignmentRuleHH" @
(HH@ A
contextHHA H
.HHH I

DefinitionHHI S
.HHS T
SpecialRuleHHT _
)HH_ `
)HH` a
{II 
rolesJJ 
=JJ 
rolesJJ 
withJJ "
{JJ# $%
SoleObjectiveAssigneeSeatJJ% >
=JJ? @#
selectedParticipantSeatJJA X
}JJY Z
;JJZ [
}KK 
elseLL 
ifLL 
(LL 
contextLL 
.LL 

DefinitionLL '
.LL' (
SpecialRuleLL( 3
==LL4 6"
SpecialMissionRuleTypeLL7 M
.LLM N(
M11_CaptainSilencesOnePlayerLLN j
)LLj k
{MM 
rolesNN 
=NN 
rolesNN 
withNN "
{NN# $
SilencedPlayerSeatNN% 7
=NN8 9#
selectedParticipantSeatNN: Q
}NNR S
;NNS T
}OO 
elsePP 
ifPP 
(PP 
contextPP 
.PP 

DefinitionPP '
.PP' (
SpecialRulePP( 3
==PP4 6"
SpecialMissionRuleTypeQQ &
.QQ& 'C
7M33_SelectedPlayerWinsExactlyOneTrickWithoutSpecialCardQQ' ^
)QQ^ _
{RR 
rolesSS 
=SS 
rolesSS 
withSS "
{SS# $!
SingleTrickWinnerSeatSS% :
=SS; <#
selectedParticipantSeatSS= T
}SSU V
;SSV W
}TT 
elseUU 
{VV 
rolesWW 
=WW 
rolesWW 
withWW "
{WW# $'
FirstAndLastTrickWinnerSeatWW% @
=WWA B#
selectedParticipantSeatWWC Z
}WW[ \
;WW\ ]
}XX 
returnYY 
rolesYY 
;YY 
}ZZ 	
}[[ 
}\\ ù	
ÜC:\Users\oscar\source\repos\TrickTakingMissions\Server\ServerTrickTakingMissions\Domain\Match\Setup\MissionTrickDistributionContext.cs
	namespace 	
Domain
 
{ 
public 

sealed 
record +
MissionTrickDistributionContext 8
{ 
public 
MissionAttemptState "
Attempt# *
{+ ,
get- 0
;0 1
init2 6
;6 7
}8 9
public		 
MissionDefinition		  

Definition		! +
{		, -
get		. 1
;		1 2
init		3 7
;		7 8
}		9 :
public

 
int

 !
ActingParticipantSeat

 (
{

) *
get

+ .
;

. /
init

0 4
;

4 5
}

6 7
public 
int %
FirstFourTricksWinnerSeat ,
{- .
get/ 2
;2 3
init4 8
;8 9
}: ;
public 
int 
LastTrickWinnerSeat &
{' (
get) ,
;, -
init. 2
;2 3
}4 5
} 
} ®
{C:\Users\oscar\source\repos\TrickTakingMissions\Server\ServerTrickTakingMissions\Domain\Match\Setup\ParticipantSeatRules.cs
	namespace 	
Domain
 
{ 
public 

static 
class  
ParticipantSeatRules ,
{ 
public 
static 
byte  
GetNextClockwiseSeat /
(/ 0
byte0 4
currentSeat5 @
,@ A
intB E
playerCountF Q
)Q R
{ 	
if		 
(		 
!		 !
MatchPlayerCountRules		 &
.		& '"
IsPlayerCountSupported		' =
(		= >
playerCount		> I
)		I J
)		J K
{

 
throw 
new '
ArgumentOutOfRangeException 5
(5 6
nameof6 <
(< =
playerCount= H
)H I
)I J
;J K
} 
if 
( 
currentSeat 
>= 
playerCount *
)* +
{ 
throw 
new '
ArgumentOutOfRangeException 5
(5 6
nameof6 <
(< =
currentSeat= H
)H I
)I J
;J K
} 
return 
( 
byte 
) 
( 
( 
currentSeat &
+' (
$num) *
)* +
%, -
playerCount. 9
)9 :
;: ;
} 	
} 
} ˆì
xC:\Users\oscar\source\repos\TrickTakingMissions\Server\ServerTrickTakingMissions\Domain\Match\Setup\MissionSetupRules.cs
	namespace 	
Domain
 
{ 
public 

static 
class 
MissionSetupRules )
{ 
public 
static 
bool 
CanDraftObjective ,
(, -
MissionDraftContext- @
contextA H
)H I
{ 	
bool 
canDraft 
= 
false !
;! "
if 
( 
IsDraftContextValid #
(# $
context$ +
)+ ,
&&- /
context0 7
.7 8
ObjectiveIndex8 F
>=G I
$numJ K
&&L N
context 
. 
ObjectiveIndex &
<' (
context) 0
.0 1
CurrentObjectives1 B
.B C
CountC H
)H I
{ 
canDraft 
= #
CanAssignDraftObjective 2
(2 3
context3 :
): ;
;; <
} 
return 
canDraft 
; 
} 	
private 
static 
bool 
IsDraftContextValid /
(/ 0
MissionDraftContext0 C
contextD K
)K L
{   	
return!! 
context!! 
!=!! 
null!! "
&&!!# %
context!!& -
.!!- .

Definition!!. 8
!=!!9 ;
null!!< @
&&!!A C
context!!D K
.!!K L
CurrentObjectives!!L ]
!=!!^ `
null!!a e
&&!!f h!
MatchPlayerCountRules"" %
.""% &"
IsPlayerCountSupported""& <
(""< =
context""= D
.""D E
PlayerCount""E P
)""P Q
&&""R T
context## 
.## %
CurrentObjectiveDraftSeat## 1
<##2 3
context##4 ;
.##; <
PlayerCount##< G
&&##H J
context##K R
.##R S
AttemptingSeat##S a
<##b c
context##d k
.##k l
PlayerCount##l w
;##w x
}$$ 	
private&& 
static&& 
bool&& #
CanAssignDraftObjective&& 3
(&&3 4
MissionDraftContext&&4 G
context&&H O
)&&O P
{'' 	
bool(( 
	canAssign(( 
=(( 
!(( 
context(( %
.((% &
CurrentObjectives((& 7
[((7 8
context((8 ?
.((? @
ObjectiveIndex((@ N
]((N O
.((O P
AssignedSeat((P \
.((\ ]
HasValue((] e
;((e f
if)) 
()) *
IsBlindObjectiveAssignmentRule)) .
()). /
context))/ 6
.))6 7

Definition))7 A
.))A B
SpecialRule))B M
)))M N
)))N O
{** 
	canAssign++ 
=++ 
	canAssign++ %
&&++& (
context++) 0
.++0 1

RoleConfig++1 ;
!=++< >
null++? C
&&++D F
context,, 
.,, 

RoleConfig,, &
.,,& '%
SoleObjectiveAssigneeSeat,,' @
==,,A C
context,,D K
.,,K L
AttemptingSeat,,L Z
;,,Z [
}-- 
else.. 
{// 
	canAssign00 
=00 
	canAssign00 %
&&00& (
context00) 0
.000 1
AttemptingSeat001 ?
==00@ B
context00C J
.00J K%
CurrentObjectiveDraftSeat00K d
;00d e
}11 
return22 
	canAssign22 
;22 
}33 	
public@@ 
static@@ 
IReadOnlyList@@ #
<@@# $
MissionObjective@@$ 4
>@@4 5
AssignObjective@@6 E
(@@E F
IReadOnlyListAA 
<AA 
MissionObjectiveAA *
>AA* +
currentObjectivesAA, =
,AA= >
intBB 
objectiveIndexBB 
,BB 
byteCC 
assignedSeatCC 
)CC 
{DD 	
ifEE 
(EE 
currentObjectivesEE !
isEE" $
nullEE% )
)EE) *
{FF 
throwGG 
newGG !
ArgumentNullExceptionGG /
(GG/ 0
nameofGG0 6
(GG6 7
currentObjectivesGG7 H
)GGH I
)GGI J
;GGJ K
}HH 
ifJJ 
(JJ 
objectiveIndexJJ 
<JJ  
$numJJ! "
||JJ# %
objectiveIndexJJ& 4
>=JJ5 7
currentObjectivesJJ8 I
.JJI J
CountJJJ O
)JJO P
{KK 
throwLL 
newLL '
ArgumentOutOfRangeExceptionLL 5
(LL5 6
nameofLL6 <
(LL< =
objectiveIndexLL= K
)LLK L
)LLL M
;LLM N
}MM 
varOO 
updatedListOO 
=OO 
newOO !
ListOO" &
<OO& '
MissionObjectiveOO' 7
>OO7 8
(OO8 9
currentObjectivesOO9 J
)OOJ K
;OOK L
updatedListPP 
[PP 
objectiveIndexPP &
]PP& '
=PP( )
updatedListPP* 5
[PP5 6
objectiveIndexPP6 D
]PPD E
withPPF J
{QQ 
AssignedSeatRR 
=RR 
assignedSeatRR +
,RR+ ,

IsRevealedSS 
=SS 
trueSS !
}TT 
;TT 
returnVV 
updatedListVV 
.VV 

AsReadOnlyVV )
(VV) *
)VV* +
;VV+ ,
}WW 	
publicbb 
staticbb 
IReadOnlyListbb #
<bb# $
MissionObjectivebb$ 4
>bb4 5#
AutoAssignAllObjectivesbb6 M
(bbM N
IReadOnlyListcc 
<cc 
MissionObjectivecc *
>cc* +
currentObjectivescc, =
,cc= >
bytedd 
assignedSeatdd 
)dd 
{ee 	
ifff 
(ff 
currentObjectivesff !
isff" $
nullff% )
)ff) *
{gg 
throwhh 
newhh !
ArgumentNullExceptionhh /
(hh/ 0
nameofhh0 6
(hh6 7
currentObjectiveshh7 H
)hhH I
)hhI J
;hhJ K
}ii 
varkk 
updatedListkk 
=kk 
newkk !
Listkk" &
<kk& '
MissionObjectivekk' 7
>kk7 8
(kk8 9
currentObjectiveskk9 J
.kkJ K
CountkkK P
)kkP Q
;kkQ R
foreachll 
(ll 
MissionObjectivell %
	objectivell& /
inll0 2
currentObjectivesll3 D
)llD E
{mm 
updatedListnn 
.nn 
Addnn 
(nn  
	objectivenn  )
withnn* .
{oo 
AssignedSeatpp  
=pp! "
assignedSeatpp# /
,pp/ 0

IsRevealedqq 
=qq  
trueqq! %
}rr 
)rr 
;rr 
}ss 
returnuu 
updatedListuu 
.uu 

AsReadOnlyuu )
(uu) *
)uu* +
;uu+ ,
}vv 	
public~~ 
static~~ 
bool~~ (
AreAllBlindResponsesRecorded~~ 7
(~~7 8
IReadOnlyDictionary 
<  
byte  $
,$ %)
BlindObjectiveCapableResponse& C
>C D
responsesBySeatE T
,T U
int
ÄÄ 
playerCount
ÄÄ 
,
ÄÄ 
byte
ÄÄ !
captainSeat
ÄÄ" -
)
ÄÄ- .
{
ÅÅ 	
bool
ÇÇ "
areResponsesComplete
ÇÇ %
=
ÇÇ& '
responsesBySeat
ÇÇ( 7
!=
ÇÇ8 :
null
ÇÇ; ?
&&
ÇÇ@ B#
MatchPlayerCountRules
ÉÉ %
.
ÉÉ% &$
IsPlayerCountSupported
ÉÉ& <
(
ÉÉ< =
playerCount
ÉÉ= H
)
ÉÉH I
&&
ÉÉJ L
captainSeat
ÉÉM X
<
ÉÉY Z
playerCount
ÉÉ[ f
;
ÉÉf g
if
ÑÑ 
(
ÑÑ "
areResponsesComplete
ÑÑ $
)
ÑÑ$ %
{
ÖÖ "
areResponsesComplete
ÜÜ $
=
ÜÜ% &

Enumerable
ÜÜ' 1
.
ÜÜ1 2
Range
ÜÜ2 7
(
ÜÜ7 8
$num
ÜÜ8 9
,
ÜÜ9 :
playerCount
ÜÜ; F
)
ÜÜF G
.
ÜÜG H
Where
ÜÜH M
(
ÜÜM N
seat
ÜÜN R
=>
ÜÜS U
seat
ÜÜV Z
!=
ÜÜ[ ]
captainSeat
ÜÜ^ i
)
ÜÜi j
.
áá 
All
áá 
(
áá 
seat
áá 
=>
áá  
responsesBySeat
áá! 0
.
áá0 1
TryGetValue
áá1 <
(
áá< =
(
áá= >
byte
áá> B
)
ááB C
seat
ááC G
,
ááG H
out
ááI L+
BlindObjectiveCapableResponse
ááM j
response
áák s
)
áás t
&&
ááu w
(
àà 
response
àà !
==
àà" $+
BlindObjectiveCapableResponse
àà% B
.
ààB C
Yes
ààC F
||
ààG I
response
ààJ R
==
ààS U+
BlindObjectiveCapableResponse
ââ 9
.
ââ9 :
No
ââ: <
)
ââ< =
)
ââ= >
;
ââ> ?
}
ää 
return
ãã "
areResponsesComplete
ãã '
;
ãã' (
}
åå 	
public
ïï 
static
ïï 
bool
ïï '
ValidateRoleConfiguration
ïï 4
(
ïï4 5
MissionDefinition
ññ 

definition
ññ (
,
ññ( )&
MissionRoleConfiguration
óó $

roleConfig
óó% /
,
óó/ 0
int
òò 
playerCount
òò 
)
òò 
{
ôô 	
if
öö 
(
öö 

definition
öö 
is
öö 
null
öö "
||
öö# %

roleConfig
öö& 0
is
öö1 3
null
öö4 8
||
öö9 ;
playerCount
öö< G
<=
ööH J
$num
ööK L
)
ööL M
{
õõ 
return
úú 
false
úú 
;
úú 
}
ùù 
switch
üü 
(
üü 

definition
üü 
.
üü 
SpecialRule
üü *
)
üü* +
{
†† 
case
°° $
SpecialMissionRuleType
°° +
.
°°+ ,*
M11_CaptainSilencesOnePlayer
°°, H
:
°°H I
return
¢¢ 
IsValidSeatRole
¢¢ *
(
¢¢* +

roleConfig
¢¢+ 5
.
¢¢5 6 
SilencedPlayerSeat
¢¢6 H
,
¢¢H I
playerCount
¢¢J U
)
¢¢U V
;
¢¢V W
case
§§ $
SpecialMissionRuleType
§§ +
.
§§+ ,8
*M20_CaptainAssignsAllObjectivesToOnePlayer
§§, V
:
§§V W
case
•• $
SpecialMissionRuleType
•• +
.
••+ ,8
*M27_CaptainAssignsAllObjectivesToOnePlayer
••, V
:
••V W
return
¶¶ 
IsValidSeatRole
¶¶ *
(
¶¶* +

roleConfig
¶¶+ 5
.
¶¶5 6'
SoleObjectiveAssigneeSeat
¶¶6 O
,
¶¶O P
playerCount
¶¶Q \
)
¶¶\ ]
;
¶¶] ^
case
®® $
SpecialMissionRuleType
®® +
.
®®+ ,E
7M33_SelectedPlayerWinsExactlyOneTrickWithoutSpecialCard
®®, c
:
®®c d
return
©© 
IsValidSeatRole
©© *
(
©©* +

roleConfig
©©+ 5
.
©©5 6#
SingleTrickWinnerSeat
©©6 K
,
©©K L
playerCount
©©M X
)
©©X Y
;
©©Y Z
case
´´ $
SpecialMissionRuleType
´´ +
.
´´+ ,K
=M41_SelectedPlayerWinsOnlyFirstAndLastTrickWithoutSpecialCard
´´, i
:
´´i j
return
¨¨ 
IsValidSeatRole
¨¨ *
(
¨¨* +

roleConfig
¨¨+ 5
.
¨¨5 6)
FirstAndLastTrickWinnerSeat
¨¨6 Q
,
¨¨Q R
playerCount
¨¨S ^
)
¨¨^ _
;
¨¨_ `
case
ÆÆ $
SpecialMissionRuleType
ÆÆ +
.
ÆÆ+ ,,
M50_SplitTrickWinsDistribution
ÆÆ, J
:
ÆÆJ K
return
ØØ  
ValidateSplitRoles
ØØ -
(
ØØ- .

roleConfig
ØØ. 8
,
ØØ8 9
playerCount
ØØ: E
)
ØØE F
;
ØØF G
default
±± 
:
±± 
return
≤≤ 
true
≤≤ 
;
≤≤  
}
≥≥ 
}
¥¥ 	
public
∂∂ 
static
∂∂ 
bool
∂∂ #
CanPassObjectiveDraft
∂∂ 0
(
∂∂0 1!
MissionDraftContext
∂∂1 D
context
∂∂E L
)
∂∂L M
{
∑∑ 	
return
∏∏ 
context
∏∏ 
!=
∏∏ 
null
∏∏ "
&&
∏∏# %
context
∏∏& -
.
∏∏- .

Definition
∏∏. 8
!=
∏∏9 ;
null
∏∏< @
&&
∏∏A C
context
∏∏D K
.
∏∏K L
CurrentObjectives
∏∏L ]
!=
∏∏^ `
null
∏∏a e
&&
∏∏f h#
MatchPlayerCountRules
ππ %
.
ππ% &$
IsPlayerCountSupported
ππ& <
(
ππ< =
context
ππ= D
.
ππD E
PlayerCount
ππE P
)
ππP Q
&&
ππR T
!
∫∫ ,
IsBlindObjectiveAssignmentRule
∫∫ /
(
∫∫/ 0
context
∫∫0 7
.
∫∫7 8

Definition
∫∫8 B
.
∫∫B C
SpecialRule
∫∫C N
)
∫∫N O
&&
∫∫P R
context
ªª 
.
ªª 
AttemptingSeat
ªª &
==
ªª' )
context
ªª* 1
.
ªª1 2'
CurrentObjectiveDraftSeat
ªª2 K
&&
ªªL N
context
ºº 
.
ºº 
AttemptingSeat
ºº &
<
ºº' (
context
ºº) 0
.
ºº0 1
PlayerCount
ºº1 <
&&
ºº= ?
context
ΩΩ 
.
ΩΩ 
CurrentObjectives
ΩΩ )
.
ΩΩ) *
Any
ΩΩ* -
(
ΩΩ- .
	objective
ΩΩ. 7
=>
ΩΩ8 :
!
ΩΩ; <
	objective
ΩΩ< E
.
ΩΩE F
AssignedSeat
ΩΩF R
.
ΩΩR S
HasValue
ΩΩS [
)
ΩΩ[ \
;
ΩΩ\ ]
}
ææ 	
public
¿¿ 
static
¿¿ !
MissionAttemptState
¿¿ )#
AdvanceObjectiveDraft
¿¿* ?
(
¿¿? @!
MissionAttemptState
¡¡ 
attemptState
¡¡  ,
,
¡¡, -
bool
¡¡. 2"
hasSelectedObjective
¡¡3 G
)
¡¡G H
{
¬¬ 	
if
√√ 
(
√√ 
attemptState
√√ 
==
√√ 
null
√√  $
)
√√$ %
{
ƒƒ 
throw
≈≈ 
new
≈≈ #
ArgumentNullException
≈≈ /
(
≈≈/ 0
nameof
≈≈0 6
(
≈≈6 7
attemptState
≈≈7 C
)
≈≈C D
)
≈≈D E
;
≈≈E F
}
∆∆ 
byte
«« 
nextSeat
«« 
=
«« "
ParticipantSeatRules
«« 0
.
««0 1"
GetNextClockwiseSeat
««1 E
(
««E F
attemptState
»» 
.
»» '
CurrentObjectiveDraftSeat
»» 6
,
»»6 7
attemptState
»»8 D
.
»»D E
PlayerCount
»»E P
)
»»P Q
;
»»Q R
int
…… 
nextPassCount
…… 
=
…… "
hasSelectedObjective
……  4
?
……5 6
$num
……7 8
:
……9 :
attemptState
……; G
.
……G H0
"ConsecutiveObjectiveDraftPassCount
……H j
+
……k l
$num
……m n
;
……n o
if
   
(
   
nextPassCount
   
>=
    
attemptState
  ! -
.
  - .
PlayerCount
  . 9
)
  9 :
{
ÀÀ 
nextPassCount
ÃÃ 
=
ÃÃ 
$num
ÃÃ  !
;
ÃÃ! "
}
ÕÕ 
return
ŒŒ 
attemptState
ŒŒ 
with
ŒŒ  $
{
œœ '
CurrentObjectiveDraftSeat
–– )
=
––* +
nextSeat
––, 4
,
––4 50
"ConsecutiveObjectiveDraftPassCount
—— 2
=
——3 4
nextPassCount
——5 B
}
““ 
;
““ 
}
”” 	
public
’’ 
static
’’ 
bool
’’ ,
IsBlindObjectiveAssignmentRule
’’ 9
(
’’9 :$
SpecialMissionRuleType
’’: P
specialRule
’’Q \
)
’’\ ]
{
÷÷ 	
return
◊◊ 
specialRule
◊◊ 
==
◊◊ !$
SpecialMissionRuleType
◊◊" 8
.
◊◊8 98
*M20_CaptainAssignsAllObjectivesToOnePlayer
◊◊9 c
||
◊◊d f
specialRule
ÿÿ 
==
ÿÿ !$
SpecialMissionRuleType
ÿÿ" 8
.
ÿÿ8 98
*M27_CaptainAssignsAllObjectivesToOnePlayer
ÿÿ9 c
;
ÿÿc d
}
ŸŸ 	
private
€€ 
static
€€ 
bool
€€ 
IsValidSeatRole
€€ +
(
€€+ ,
byte
€€, 0
?
€€0 1
seat
€€2 6
,
€€6 7
int
€€8 ;
playerCount
€€< G
)
€€G H
{
‹‹ 	
return
›› 
seat
›› 
.
›› 
HasValue
››  
&&
››! #
seat
››$ (
.
››( )
Value
››) .
<
››/ 0
playerCount
››1 <
;
››< =
}
ﬁﬁ 	
private
‡‡ 
static
‡‡ 
bool
‡‡  
ValidateSplitRoles
‡‡ .
(
‡‡. /&
MissionRoleConfiguration
‡‡/ G

roleConfig
‡‡H R
,
‡‡R S
int
‡‡T W
playerCount
‡‡X c
)
‡‡c d
{
·· 	
bool
‚‚ #
hasValidFirstFourSeat
‚‚ &
=
‚‚' (
IsValidSeatRole
‚‚) 8
(
‚‚8 9

roleConfig
‚‚9 C
.
‚‚C D'
FirstFourTricksWinnerSeat
‚‚D ]
,
‚‚] ^
playerCount
‚‚_ j
)
‚‚j k
;
‚‚k l
bool
„„ #
hasValidLastTrickSeat
„„ &
=
„„' (
IsValidSeatRole
„„) 8
(
„„8 9

roleConfig
„„9 C
.
„„C D!
LastTrickWinnerSeat
„„D W
,
„„W X
playerCount
„„Y d
)
„„d e
;
„„e f
bool
‰‰ 
areRolesDistinct
‰‰ !
=
‰‰" #

roleConfig
‰‰$ .
.
‰‰. /'
FirstFourTricksWinnerSeat
‰‰/ H
.
‰‰H I
GetValueOrDefault
‰‰I Z
(
‰‰Z [
)
‰‰[ \
!=
‰‰] _

roleConfig
ÂÂ$ .
.
ÂÂ. /!
LastTrickWinnerSeat
ÂÂ/ B
.
ÂÂB C
GetValueOrDefault
ÂÂC T
(
ÂÂT U
)
ÂÂU V
;
ÂÂV W
return
ÁÁ #
hasValidFirstFourSeat
ÁÁ (
&&
ÁÁ) +#
hasValidLastTrickSeat
ÁÁ, A
&&
ÁÁB D
areRolesDistinct
ÁÁE U
;
ÁÁU V
}
ËË 	
}
ÈÈ 
}ÍÍ ç
C:\Users\oscar\source\repos\TrickTakingMissions\Server\ServerTrickTakingMissions\Domain\Match\Setup\MissionRoleConfiguration.cs
	namespace 	
Domain
 
{ 
public 

sealed 
record $
MissionRoleConfiguration 1
{ 
public 
byte 
? 
HeartNineOwnerSeat '
{( )
get* -
;- .
init/ 3
;3 4
}5 6
public

 
bool

 '
HasIdentifiedHeartNineOwner

 /
{

0 1
get

2 5
;

5 6
init

7 ;
;

; <
}

= >
public 
byte 
? 
SilencedPlayerSeat '
{( )
get* -
;- .
init/ 3
;3 4
}5 6
public 
byte 
? %
SoleObjectiveAssigneeSeat .
{/ 0
get1 4
;4 5
init6 :
;: ;
}< =
public 
byte 
? !
SingleTrickWinnerSeat *
{+ ,
get- 0
;0 1
init2 6
;6 7
}8 9
public 
byte 
? '
FirstAndLastTrickWinnerSeat 0
{1 2
get3 6
;6 7
init8 <
;< =
}> ?
public 
byte 
? %
FirstFourTricksWinnerSeat .
{/ 0
get1 4
;4 5
init6 :
;: ;
}< =
public 
byte 
? 
LastTrickWinnerSeat (
{) *
get+ .
;. /
init0 4
;4 5
}6 7
public 
static $
MissionRoleConfiguration .
Default/ 6
{7 8
get9 <
;< =
}> ?
=@ A
newB E$
MissionRoleConfigurationF ^
(^ _
)_ `
;` a
} 
} ã

ÉC:\Users\oscar\source\repos\TrickTakingMissions\Server\ServerTrickTakingMissions\Domain\Match\Setup\MissionRoleAssignmentContext.cs
	namespace 	
Domain
 
{ 
public 

sealed 
record (
MissionRoleAssignmentContext 5
{		 
public

 
MissionAttemptState

 "
Attempt

# *
{

+ ,
get

- 0
;

0 1
init

2 6
;

6 7
}

8 9
public 
MissionDefinition  

Definition! +
{, -
get. 1
;1 2
init3 7
;7 8
}9 :
public 
int !
ActingParticipantSeat (
{) *
get+ .
;. /
init0 4
;4 5
}6 7
public 
int #
SelectedParticipantSeat *
{+ ,
get- 0
;0 1
init2 6
;6 7
}8 9
public 
IReadOnlyDictionary "
<" #
byte# '
,' ()
BlindObjectiveCapableResponse) F
>F G
ResponsesBySeatH W
{X Y
getZ ]
;] ^
init_ c
;c d
}e f
} 
} ı[
ÄC:\Users\oscar\source\repos\TrickTakingMissions\Server\ServerTrickTakingMissions\Domain\Match\Setup\MissionObjectiveDealRules.cs
	namespace 	
Domain
 
{ 
public 

static 
class %
MissionObjectiveDealRules 1
{ 
private 
const 
int &
FirstNormalObjectiveCardId 4
=5 6
$num7 8
;8 9
public 
const 
int #
NormalObjectiveDeckSize 0
=1 2
$num3 5
;5 6
public 
const 
int 
HeartNineCardId (
=) *
$num+ -
;- .
public 
static 
IReadOnlyList #
<# $
MissionObjective$ 4
>4 5
DrawObjectives6 D
(D E
MissionDefinition 

definition (
,( )
Random 
randomGenerator "
)" #
{ 	
if 
( 
randomGenerator 
is  "
null# '
)' (
{ 
throw   
new   !
ArgumentNullException   /
(  / 0
nameof  0 6
(  6 7
randomGenerator  7 F
)  F G
)  G H
;  H I
}!! 
int## 
[## 
]## 
normalCardIds## 
=##  !

Enumerable##" ,
.##, -
Range##- 2
(##2 3&
FirstNormalObjectiveCardId##3 M
,##M N#
NormalObjectiveDeckSize##O f
)##f g
.##g h
ToArray##h o
(##o p
)##p q
;##q r
ShuffleCardIds$$ 
($$ 
normalCardIds$$ (
,$$( )
randomGenerator$$* 9
)$$9 :
;$$: ;
return&& 
CreateObjectives&& #
(&&# $

definition&&$ .
,&&. /
normalCardIds&&0 =
)&&= >
;&&> ?
}'' 	
public)) 
static)) 
IReadOnlyList)) #
<))# $
MissionObjective))$ 4
>))4 5
CreateObjectives))6 F
())F G
MissionDefinition** 

definition** (
,**( )
IReadOnlyList*** 7
<**7 8
int**8 ;
>**; <!
shuffledNormalCardIds**= R
)**R S
{++ 	
if,, 
(,, 

definition,, 
==,, 
null,, "
),," #
{-- 
throw.. 
new.. !
ArgumentNullException.. /
(../ 0
nameof..0 6
(..6 7

definition..7 A
)..A B
)..B C
;..C D
}// 
if00 
(00 !
shuffledNormalCardIds00 %
==00& (
null00) -
)00- .
{11 
throw22 
new22 !
ArgumentNullException22 /
(22/ 0
nameof220 6
(226 7!
shuffledNormalCardIds227 L
)22L M
)22M N
;22N O
}33 
if44 
(44 

definition44 
.44 
Tokens44 !
==44" $
null44% )
)44) *
{55 
throw66 
new66 
ArgumentException66 +
(66+ ,
nameof66, 2
(662 3

definition663 =
)66= >
)66> ?
;66? @
}77 !
ValidateObjectiveDeck88 !
(88! "

definition88" ,
,88, -!
shuffledNormalCardIds88. C
)88C D
;88D E
bool99 
shouldStartRevealed99 $
=99% &
!99' (
MissionSetupRules99( 9
.999 :*
IsBlindObjectiveAssignmentRule99: X
(99X Y

definition99Y c
.99c d
SpecialRule99d o
)99o p
;99p q
var:: 
drawnObjectives:: 
=::  !
new::" %
List::& *
<::* +
MissionObjective::+ ;
>::; <
(::< =

definition::= G
.::G H
ObjectiveCardCount::H Z
)::Z [
;::[ \
for<< 
(<< 
int<< 
index<< 
=<< 
$num<< 
;<< 
index<<  %
<<<& '

definition<<( 2
.<<2 3
ObjectiveCardCount<<3 E
;<<E F
index<<G L
++<<L N
)<<N O
{== 
int>> 
cardId>> 
=>> !
shuffledNormalCardIds>> 2
[>>2 3
index>>3 8
]>>8 9
;>>9 :
ObjectiveTokenType?? "
token??# (
=??) *
index??+ 0
<??1 2

definition??3 =
.??= >
Tokens??> D
.??D E
Count??E J
?@@ 

definition@@  
.@@  !
Tokens@@! '
[@@' (
index@@( -
]@@- .
:AA 
ObjectiveTokenTypeAA (
.AA( )
NoneAA) -
;AA- .
drawnObjectivesCC 
.CC  
AddCC  #
(CC# $
newCC$ '
MissionObjectiveCC( 8
{DD 
CardIdEE 
=EE 
cardIdEE #
,EE# $
TokenFF 
=FF 
tokenFF !
,FF! "
AssignedSeatGG  
=GG! "
nullGG# '
,GG' (

IsRevealedHH 
=HH  
shouldStartRevealedHH! 4
,HH4 5
StatusII 
=II 
ObjectiveStatusII ,
.II, -
PendingII- 4
,II4 5"
CompletedAtTrickNumberJJ *
=JJ+ ,
nullJJ- 1
}KK 
)KK 
;KK 
}LL 
returnNN 
drawnObjectivesNN "
.NN" #

AsReadOnlyNN# -
(NN- .
)NN. /
;NN/ 0
}OO 	
publicXX 
staticXX 
byteXX !
GetHeartNineOwnerSeatXX 0
(XX0 1
IReadOnlyListXX1 >
<XX> ?
IReadOnlyListXX? L
<XXL M
CardXXM Q
>XXQ R
>XXR S
handsBySeatXXT _
)XX_ `
{YY 	
ifZZ 
(ZZ 
handsBySeatZZ 
isZZ 
nullZZ #
)ZZ# $
{[[ 
throw\\ 
new\\ !
ArgumentNullException\\ /
(\\/ 0
nameof\\0 6
(\\6 7
handsBySeat\\7 B
)\\B C
)\\C D
;\\D E
}]] 
for__ 
(__ 
int__ 
	seatIndex__ 
=__  
$num__! "
;__" #
	seatIndex__$ -
<__. /
handsBySeat__0 ;
.__; <
Count__< A
;__A B
	seatIndex__C L
++__L N
)__N O
{`` 
IReadOnlyListaa 
<aa 
Cardaa "
>aa" #
handaa$ (
=aa) *
handsBySeataa+ 6
[aa6 7
	seatIndexaa7 @
]aa@ A
;aaA B
ifbb 
(bb 
handbb 
!=bb 
nullbb  
&&bb! #
handbb$ (
.bb( )
Anybb) ,
(bb, -
cardbb- 1
=>bb2 4
cardbb5 9
.bb9 :
Suitbb: >
==bb? A
CardSuitbbB J
.bbJ K
HeartbbK P
&&bbQ S
cardbbT X
.bbX Y
NumberbbY _
==bb` b!
MissionFailureReasonsbbc x
.bbx y+
ForbiddenTrickWinnerCardNumber	bby ó
)
bbó ò
)
bbò ô
{cc 
returndd 
(dd 
bytedd  
)dd  !
	seatIndexdd! *
;dd* +
}ee 
}ff 
throwhh 
newhh %
InvalidOperationExceptionhh /
(hh/ 0
$strhh0 a
)hha b
;hhb c
}ii 	
publicrr 
staticrr 
byterr $
GetTargetHeartWinnerSeatrr 3
(rr3 4
byterr4 8
heartNineOwnerSeatrr9 K
,rrK L
intrrM P
playerCountrrQ \
)rr\ ]
{ss 	
iftt 
(tt 
playerCounttt 
<=tt 
$numtt  
)tt  !
{uu 
throwvv 
newvv '
ArgumentOutOfRangeExceptionvv 5
(vv5 6
nameofvv6 <
(vv< =
playerCountvv= H
)vvH I
)vvI J
;vvJ K
}ww 
returnyy 
(yy 
byteyy 
)yy 
(yy 
(yy 
heartNineOwnerSeatyy -
+yy. /
$numyy0 1
)yy1 2
%yy3 4
playerCountyy5 @
)yy@ A
;yyA B
}zz 	
private|| 
static|| 
void|| !
ValidateObjectiveDeck|| 1
(||1 2
MissionDefinition}} 

definition}} (
,}}( )
IReadOnlyList}}* 7
<}}7 8
int}}8 ;
>}}; <!
shuffledNormalCardIds}}= R
)}}R S
{~~ 	
if 
( 

definition 
. 
ObjectiveCardCount -
<. /
$num0 1
||2 4

definition5 ?
.? @
ObjectiveCardCount@ R
>S T#
NormalObjectiveDeckSizeU l
||m o#
shuffledNormalCardIds
ÄÄ %
.
ÄÄ% &
Count
ÄÄ& +
!=
ÄÄ, .%
NormalObjectiveDeckSize
ÄÄ/ F
||
ÄÄG I#
shuffledNormalCardIds
ÅÅ %
.
ÅÅ% &
Distinct
ÅÅ& .
(
ÅÅ. /
)
ÅÅ/ 0
.
ÅÅ0 1
Count
ÅÅ1 6
(
ÅÅ6 7
)
ÅÅ7 8
!=
ÅÅ9 ;%
NormalObjectiveDeckSize
ÅÅ< S
||
ÅÅT V#
shuffledNormalCardIds
ÇÇ %
.
ÇÇ% &
Any
ÇÇ& )
(
ÇÇ) *
cardId
ÇÇ* 0
=>
ÇÇ1 3
cardId
ÉÉ 
<
ÉÉ (
FirstNormalObjectiveCardId
ÉÉ 7
||
ÉÉ8 :
cardId
ÉÉ; A
>
ÉÉB C%
NormalObjectiveDeckSize
ÉÉD [
)
ÉÉ[ \
)
ÉÉ\ ]
{
ÑÑ 
throw
ÖÖ 
new
ÖÖ 
ArgumentException
ÖÖ +
(
ÖÖ+ ,
nameof
ÖÖ, 2
(
ÖÖ2 3#
shuffledNormalCardIds
ÖÖ3 H
)
ÖÖH I
)
ÖÖI J
;
ÖÖJ K
}
ÜÜ 
}
áá 	
private
ââ 
static
ââ 
void
ââ 
ShuffleCardIds
ââ *
(
ââ* +
int
ââ+ .
[
ââ. /
]
ââ/ 0
cardIds
ââ1 8
,
ââ8 9
Random
ââ: @
randomGenerator
ââA P
)
ââP Q
{
ää 	
for
ãã 
(
ãã 
int
ãã 
currentIndex
ãã !
=
ãã" #
cardIds
ãã$ +
.
ãã+ ,
Length
ãã, 2
-
ãã3 4
$num
ãã5 6
;
ãã6 7
currentIndex
ãã8 D
>
ããE F
$num
ããG H
;
ããH I
currentIndex
ããJ V
--
ããV X
)
ããX Y
{
åå 
int
çç 
	swapIndex
çç 
=
çç 
randomGenerator
çç  /
.
çç/ 0
Next
çç0 4
(
çç4 5
currentIndex
çç5 A
+
ççB C
$num
ççD E
)
ççE F
;
ççF G
int
éé 
displacedId
éé 
=
éé  !
cardIds
éé" )
[
éé) *
currentIndex
éé* 6
]
éé6 7
;
éé7 8
cardIds
èè 
[
èè 
currentIndex
èè $
]
èè$ %
=
èè& '
cardIds
èè( /
[
èè/ 0
	swapIndex
èè0 9
]
èè9 :
;
èè: ;
cardIds
êê 
[
êê 
	swapIndex
êê !
]
êê! "
=
êê# $
displacedId
êê% 0
;
êê0 1
}
ëë 
}
íí 	
}
ìì 
}îî ¶
zC:\Users\oscar\source\repos\TrickTakingMissions\Server\ServerTrickTakingMissions\Domain\Match\Setup\MissionDraftContext.cs
	namespace 	
Domain
 
{ 
public		 

sealed		 
record		 
MissionDraftContext		 ,
{

 
public 
MissionDefinition  

Definition! +
{, -
get. 1
;1 2
init3 7
;7 8
}9 :
public 
IReadOnlyList 
< 
MissionObjective -
>- .
CurrentObjectives/ @
{A B
getC F
;F G
initH L
;L M
}N O
public 
int 
ObjectiveIndex !
{" #
get$ '
;' (
init) -
;- .
}/ 0
public 
byte 
AttemptingSeat "
{# $
get% (
;( )
init* .
;. /
}0 1
public 
byte %
CurrentObjectiveDraftSeat -
{. /
get0 3
;3 4
init5 9
;9 :
}; <
public 
byte 
CaptainSeat 
{  !
get" %
;% &
init' +
;+ ,
}- .
public $
MissionRoleConfiguration '

RoleConfig( 2
{3 4
get5 8
;8 9
init: >
;> ?
}@ A
public 
int 
PlayerCount 
{  
get! $
;$ %
init& *
;* +
}, -
} 
} †;
ÅC:\Users\oscar\source\repos\TrickTakingMissions\Server\ServerTrickTakingMissions\Domain\Match\Evaluation\MissionFailureReasons.cs
	namespace 	
Domain
 
{ 
public 

static 
class !
MissionFailureReasons -
{ 
public 
const 
string (
ObjectiveCapturedByWrongSeat 8
=9 :
$str; v
;v w
public		 
const		 
string		 ,
 MultipleOrderedTokensInSameTrick		 <
=		= >
$str			? à
;
		à â
public

 
const

 
string

 *
MultipleArrowTokensInSameTrick

 :
=

; <
$str	

= Ñ
;


Ñ Ö
public 
const 
string '
OmegaSimultaneousCompletion 7
=8 9
$str	: Ü
;
Ü á
public 
const 
string +
PrecedingOrderTokenNotCompleted ;
=< =
$str	> è
;
è ê
public 
const 
string +
PrecedingArrowTokenNotCompleted ;
=< =
$str	> ä
;
ä ã
public 
const 
string *
OmegaObjectiveNotCompletedLast :
=; <
$str= f
;f g
public 
const 
string (
Mission48OmegaNotInLastTrick 8
=9 :
$str	; Å
;
Å Ç
public 
const 
string 3
'Mission48PendingNonOmegaBeforeLastTrick C
=D E
$str	F ò
;
ò ô
public 
const 
string '
Mission05AllPlayersWonTrick 7
=8 9
$str: d
;d e
public 
const 
string &
Mission09NoTrickWonWithOne 6
=7 8
$str9 j
;j k
public 
const 
string )
Mission13SpecialCardLostTrick 9
=: ;
$str< r
;r s
public 
const 
string *
Mission13NotAllSpecialCardsWon :
=; <
$str= c
;c d
public 
const 
string %
Mission16TrickWonWithNine 5
=6 7
$str8 h
;h i
public 
const 
string ,
 Mission26LessTwoTricksWonWithOne <
== >
$str? }
;} ~
public 
const 
string ,
 Mission29TrickDifferenceExceeded <
== >
$str	? É
;
É Ñ
public 
const 
string #
Mission33RoleUnassigned 3
=4 5
$str6 d
;d e
public 
const 
string '
Mission33WonWithSpecialCard 7
=8 9
$str: l
;l m
public 
const 
string &
Mission33WonMultipleTricks 6
=7 8
$str9 c
;c d
public 
const 
string -
!Mission33DidNotWinExactlyOneTrick =
=> ?
$str@ p
;p q
public 
const 
string /
#Mission34CaptainDidNotWinFirstTrick ?
=@ A
$strB h
;h i
public 
const 
string .
"Mission34CaptainDidNotWinLastTrick >
=? @
$strA f
;f g
public 
const 
string #
Mission41RoleUnassigned 3
=4 5
$str6 l
;l m
public   
const   
string   /
#Mission41FirstTrickNotWonBySelected   ?
=  @ A
$str  B r
;  r s
public!! 
const!! 
string!! -
!Mission41FirstTrickWonWithSpecial!! =
=!!> ?
$str!!@ |
;!!| }
public"" 
const"" 
string"" 3
'Mission41IntermediateTrickWonBySelected"" C
=""D E
$str""F t
;""t u
public## 
const## 
string## .
"Mission41LastTrickNotWonBySelected## >
=##? @
$str##A p
;##p q
public$$ 
const$$ 
string$$ ,
 Mission41LastTrickWonWithSpecial$$ <
=$$= >
$str$$? z
;$$z {
public%% 
const%% 
string%% )
Mission44SpecialOrderViolated%% 9
=%%: ;
$str%%< |
;%%| }
public&& 
const&& 
string&& *
Mission44NotAllSpecialCardsWon&& :
=&&; <
$str&&= b
;&&b c
public'' 
const'' 
string'' *
Mission46HeartNineUnidentified'' :
=''; <
$str''= e
;''e f
public(( 
const(( 
string(( -
!Mission46HeartCapturedByWrongSeat(( =
=((> ?
$str	((@ å
;
((å ç
public)) 
const)) 
string)) $
Mission50RolesUnassigned)) 4
=))5 6
$str))7 e
;))e f
public** 
const** 
string** /
#Mission50FirstFourTricksWrongWinner** ?
=**@ A
$str	**B Ü
;
**Ü á
public++ 
const++ 
string++ ,
 Mission50FirstFourWinnerWonExtra++ <
=++= >
$str	++? Ü
;
++Ü á
public,, 
const,, 
string,, ,
 Mission50LastTrickWinnerWonEarly,, <
=,,= >
$str,,? |
;,,| }
public-- 
const-- 
string-- )
Mission50LastTrickWrongWinner-- 9
=--: ;
$str--< r
;--r s
public.. 
const.. 
string.. .
"Mission50RemainingPlayerWonNoTrick.. >
=..? @
$str..A l
;..l m
public// 
const// 
string// .
"MissionRemainingTricksInsufficient// >
=//? @
$str	//A ì
;
//ì î
public11 
const11 
string11 ,
 ObjectivesIncompleteAtMissionEnd11 <
=11= >
$str	11? â
;
11â ä
public22 
const22 
string22 !
MissionSuccessMessage22 1
=222 3
$str224 U
;22U V
public44 
const44 
string44 %
Mission46HeartsIncomplete44 5
=446 7
$str55 L
;55L M
public77 
const77 
int77 '
MaxTrickDifferenceThreshold77 4
=775 6
$num777 8
;778 9
public88 
const88 
int88 '
Mission50InitialTricksCount88 4
=885 6
$num887 8
;888 9
public99 
const99 
int99 "
TotalSpecialCardsCount99 /
=990 1
$num992 3
;993 4
public:: 
const:: 
int:: &
Mission26RequiredOnesCount:: 3
=::4 5
$num::6 7
;::7 8
public;; 
const;; 
int;; *
ForbiddenTrickWinnerCardNumber;; 7
=;;8 9
$num;;: ;
;;;; <
public<< 
const<< 
int<< )
RequiredTrickWinnerCardNumber<< 6
=<<7 8
$num<<9 :
;<<: ;
}== 
}>> ¬
~C:\Users\oscar\source\repos\TrickTakingMissions\Server\ServerTrickTakingMissions\Domain\Match\Lifecycle\MissionAttemptState.cs
	namespace 	
Domain
 
{ 
public

 

sealed

 
record

 
MissionAttemptState

 ,
{ 
public 
int 
MissionAttemptId #
{$ %
get& )
;) *
init+ /
;/ 0
}1 2
public 
int 
MissionNumber  
{! "
get# &
;& '
init( ,
;, -
}. /
public 
int 
AttemptNumber  
{! "
get# &
;& '
init( ,
;, -
}. /
public 
MissionAttemptPhase "
Phase# (
{) *
get+ .
;. /
init0 4
;4 5
}6 7
public  
MissionAttemptStatus #
Status$ *
{+ ,
get- 0
;0 1
init2 6
;6 7
}8 9
public 
byte 
CaptainSeat 
{  !
get" %
;% &
init' +
;+ ,
}- .
public 
int 
PlayerCount 
{  
get! $
;$ %
init& *
;* +
}, -
public 
byte %
CurrentObjectiveDraftSeat -
{. /
get0 3
;3 4
init5 9
;9 :
}; <
public 
int .
"ConsecutiveObjectiveDraftPassCount 5
{6 7
get8 ;
;; <
init= A
;A B
}C D
public 
bool !
HasUsedDistressSignal )
{* +
get, /
;/ 0
init1 5
;5 6
}7 8
public   $
MissionRoleConfiguration   '

RoleConfig  ( 2
{  3 4
get  5 8
;  8 9
init  : >
;  > ?
}  @ A
public"" 
IReadOnlyList"" 
<"" 
MissionObjective"" -
>""- .

Objectives""/ 9
{"": ;
get""< ?
;""? @
init""A E
;""E F
}""G H
public$$ 
IReadOnlyList$$ 
<$$ )
PlayerRadioCommunicationState$$ :
>$$: ;%
RadioCommunicationsBySeat$$< U
{$$V W
get$$X [
;$$[ \
init$$] a
;$$a b
}$$c d
}%% 
}&& †
|C:\Users\oscar\source\repos\TrickTakingMissions\Server\ServerTrickTakingMissions\Domain\Match\Setup\MatchPlayerCountRules.cs
	namespace 	
Domain
 
{ 
internal 
static 
class !
MatchPlayerCountRules /
{ 
internal 
static 
bool "
IsPlayerCountSupported 3
(3 4
int4 7
playerCount8 C
)C D
{		 	
return

 
playerCount

 
>=

 !
LobbyRoomRules

" 0
.

0 1
MinimumPlayerLimit

1 C
&& 
playerCount 
<= !
LobbyRoomRules" 0
.0 1
MaximumPlayerLimit1 C
;C D
} 	
} 
} ˛
rC:\Users\oscar\source\repos\TrickTakingMissions\Server\ServerTrickTakingMissions\Domain\Match\Setup\MissionDeal.cs
	namespace 	
Domain
 
{ 
public		 

sealed		 
record		 
MissionDeal		 $
{

 
public 
IReadOnlyList 
< 
IReadOnlyList *
<* +
Card+ /
>/ 0
>0 1
HandsBySeat2 =
{> ?
get@ C
;C D
initE I
;I J
}K L
public 
byte 
CaptainSeat 
{  !
get" %
;% &
init' +
;+ ,
}- .
public 
int  
TotalTricksInMission '
{( )
get* -
;- .
init/ 3
;3 4
}5 6
} 
} ‹
ÉC:\Users\oscar\source\repos\TrickTakingMissions\Server\ServerTrickTakingMissions\Domain\Match\Lifecycle\DisconnectionPolicyRules.cs
	namespace 	
Domain
 
{ 
public 

static 
class $
DisconnectionPolicyRules 0
{ 
public 
const 
int *
ReconnectionGracePeriodSeconds 7
=8 9
$num: <
;< =
public 
static 
bool !
HasGracePeriodExpired 0
(0 1
DateTime1 9
disconnectedAtUtc: K
,K L
DateTimeM U

currentUtcV `
)` a
{ 	
return 
( 

currentUtc 
-  
disconnectedAtUtc! 2
)2 3
.3 4
TotalSeconds4 @
>=A C*
ReconnectionGracePeriodSecondsD b
;b c
} 	
public 
static 
bool (
MustReturnToLobbyImmediately 7
(7 8
int8 ;%
remainingConnectedPlayers< U
)U V
{   	
return!! %
remainingConnectedPlayers!! ,
<!!- .
LobbyRoomRules!!/ =
.!!= >
MinimumPlayerLimit!!> P
;!!P Q
}"" 	
public.. 
static.. )
DisconnectionResolutionOption.. 3+
ResolveRemainingPlayersDecision..4 S
(..S T
IReadOnlyDictionary// 
<//  
byte//  $
,//$ %)
DisconnectionResolutionOption//& C
>//C D
votesBySeat//E P
,//P Q
int00  
remainingPlayerCount00 $
)00$ %
{11 	
if22 
(22 (
MustReturnToLobbyImmediately22 ,
(22, - 
remainingPlayerCount22- A
)22A B
)22B C
{33 
return44 )
DisconnectionResolutionOption44 4
.444 5
ReturnToLobby445 B
;44B C
}55 
if77 
(77 
votesBySeat77 
is77 
null77 #
||77$ &
votesBySeat77' 2
.772 3
Count773 8
==779 ;
$num77< =
)77= >
{88 
return99 )
DisconnectionResolutionOption99 4
.994 5
None995 9
;999 :
}:: 
if<< 
(<< 
votesBySeat<< 
.<< 
Values<< "
.<<" #
Any<<# &
(<<& '
vote<<' +
=><<, .
vote<</ 3
==<<4 6)
DisconnectionResolutionOption<<7 T
.<<T U
ReturnToLobby<<U b
)<<b c
)<<c d
{== 
return>> )
DisconnectionResolutionOption>> 4
.>>4 5
ReturnToLobby>>5 B
;>>B C
}?? 
boolAA 
allVotedRestartAA  
=AA! "
votesBySeatAA# .
.AA. /
CountAA/ 4
==AA5 7 
remainingPlayerCountAA8 L
&&AAM O
votesBySeatBB# .
.BB. /
ValuesBB/ 5
.BB5 6
AllBB6 9
(BB9 :
voteBB: >
=>BB? A
voteBBB F
==BBG I)
DisconnectionResolutionOptionBBJ g
.BBg h+
RestartMissionWithThreePlayers	BBh Ü
)
BBÜ á
;
BBá à
returnDD 
allVotedRestartDD "
?EE )
DisconnectionResolutionOptionEE /
.EE/ 0*
RestartMissionWithThreePlayersEE0 N
:FF )
DisconnectionResolutionOptionFF /
.FF/ 0
NoneFF0 4
;FF4 5
}GG 	
}HH 
}II ´/
ÇC:\Users\oscar\source\repos\TrickTakingMissions\Server\ServerTrickTakingMissions\Domain\Match\Lifecycle\MissionProgressionRules.cs
	namespace 	
Domain
 
{ 
public

 

static

 
class

 #
MissionProgressionRules

 /
{ 
public 
const 
int  
MinimumMissionNumber -
=. /
$num0 1
;1 2
public 
const 
int  
MaximumMissionNumber -
=. /
$num0 2
;2 3
public 
const 
int  
InitialAttemptNumber -
=. /
$num0 1
;1 2
public 
static 
bool #
CanAdvanceToNextMission 2
(2 3
int3 6 
currentMissionNumber7 K
,K L
intM P
targetMissionCountQ c
)c d
{ 	
return  
currentMissionNumber '
>=( * 
MinimumMissionNumber+ ?
&&@ B 
currentMissionNumber '
<( )
targetMissionCount* <
&&= ? 
currentMissionNumber '
<( ) 
MaximumMissionNumber* >
;> ?
} 	
public$$ 
static$$ 
IReadOnlyCollection$$ )
<$$) *
byte$$* .
>$$. /
RegisterVote$$0 <
($$< =
IReadOnlyCollection%% 
<%%  
byte%%  $
>%%$ %
currentVotes%%& 2
,%%2 3
byte&& 

votingSeat&& 
,&& 
int'' 
playerCount'' 
)'' 
{(( 	
if)) 
()) 
!)) !
MatchPlayerCountRules)) &
.))& '"
IsPlayerCountSupported))' =
())= >
playerCount))> I
)))I J
||))K M

votingSeat** 
>=** 
playerCount** )
)**) *
{++ 
throw,, 
new,, '
ArgumentOutOfRangeException,, 5
(,,5 6
nameof,,6 <
(,,< =

votingSeat,,= G
),,G H
),,H I
;,,I J
}-- 
if.. 
(.. 
currentVotes.. 
!=.. 
null..  $
&&..% '
currentVotes..( 4
...4 5
Any..5 8
(..8 9
seat..9 =
=>..> @
seat..A E
>=..F H
playerCount..I T
)..T U
)..U V
{// 
throw00 
new00 
ArgumentException00 +
(00+ ,
nameof00, 2
(002 3
currentVotes003 ?
)00? @
)00@ A
;00A B
}11 
var22 
updatedVotes22 
=22 
new22 "
HashSet22# *
<22* +
byte22+ /
>22/ 0
(220 1
currentVotes221 =
??22> @
Array22A F
.22F G
Empty22G L
<22L M
byte22M Q
>22Q R
(22R S
)22S T
)22T U
{33 

votingSeat44 
}55 
;55 
return66 
updatedVotes66 
.66  
ToList66  &
(66& '
)66' (
.66( )

AsReadOnly66) 3
(663 4
)664 5
;665 6
}77 	
public?? 
static?? 
bool?? 
IsVoteUnanimous?? *
(??* +
IReadOnlyCollection??+ >
<??> ?
byte??? C
>??C D
currentVotes??E Q
,??Q R
int??S V
playerCount??W b
)??b c
{@@ 	
boolAA 
isUnanimousAA 
=AA 
falseAA $
;AA$ %
ifBB 
(BB 
currentVotesBB 
!=BB 
nullBB  $
&&BB% '!
MatchPlayerCountRulesCC %
.CC% &"
IsPlayerCountSupportedCC& <
(CC< =
playerCountCC= H
)CCH I
)CCI J
{DD 
isUnanimousEE 
=EE 
currentVotesEE *
.EE* +
DistinctEE+ 3
(EE3 4
)EE4 5
.EE5 6
CountEE6 ;
(EE; <
)EE< =
==EE> @
playerCountEEA L
&&EEM O
currentVotesFF  
.FF  !
AllFF! $
(FF$ %
seatFF% )
=>FF* ,
seatFF- 1
<FF2 3
playerCountFF4 ?
)FF? @
;FF@ A
}GG 
returnHH 
isUnanimousHH 
;HH 
}II 	
publicQQ 
staticQQ 
intQQ  
AdvanceToNextMissionQQ .
(QQ. /
intQQ/ 2 
currentMissionNumberQQ3 G
,QQG H
intQQI L
targetMissionCountQQM _
)QQ_ `
{RR 	
intSS 
nextMissionSS 
=SS #
CanAdvanceToNextMissionSS 5
(SS5 6 
currentMissionNumberSS6 J
,SSJ K
targetMissionCountSSL ^
)SS^ _
?TT  
currentMissionNumberTT &
+TT' (
$numTT) *
:UU  
currentMissionNumberUU &
;UU& '
returnWW 
nextMissionWW 
;WW 
}XX 	
public__ 
static__ 
int__ 
RestartAttempt__ (
(__( )
int__) , 
currentAttemptNumber__- A
)__A B
{`` 	
ifaa 
(aa  
currentAttemptNumberaa $
<aa% & 
InitialAttemptNumberaa' ;
||aa< > 
currentAttemptNumberaa? S
==aaT V
intaaW Z
.aaZ [
MaxValueaa[ c
)aac d
{bb 
throwcc 
newcc '
ArgumentOutOfRangeExceptioncc 5
(cc5 6
nameofcc6 <
(cc< = 
currentAttemptNumbercc= Q
)ccQ R
)ccR S
;ccS T
}dd 
returnee  
currentAttemptNumberee '
+ee( )
$numee* +
;ee+ ,
}ff 	
}gg 
}hh Ç÷
ÇC:\Users\oscar\source\repos\TrickTakingMissions\Server\ServerTrickTakingMissions\Domain\Match\Evaluation\MissionEvaluationRules.cs
	namespace 	
Domain
 
{ 
public 

static 
partial 
class "
MissionEvaluationRules  6
{ 
private 
const 
int #
FirstMissionTrickNumber 1
=2 3
$num4 5
;5 6
private 
const 
int  
FirstSpecialCardRank .
=/ 0
(1 2
int2 5
)5 6
SpecialCardSymbol6 G
.G H
DiamondH O
;O P
public 
static #
MissionEvaluationResult -"
EvaluateCompletedTrick. D
(D E$
MissionEvaluationContextE ]
context^ e
)e f
{ 	%
ValidateEvaluationContext %
(% &
context& -
)- .
;. /
var 
updatedObjectives !
=" #
new$ '
List( ,
<, -
MissionObjective- =
>= >
(> ?
context? F
.F G
CurrentObjectivesG X
)X Y
;Y Z#
MissionEvaluationResult #
missionEvaluation$ 5
=6 7%
EvaluateObjectivesInTrick8 Q
(Q R
contextR Y
,Y Z
updatedObjectives[ l
)l m
;m n
if 
( 
missionEvaluation !
==" $
null% )
)) *
{ 
missionEvaluation !
=" #
EvaluateSpecialRule$ 7
(7 8
context8 ?
,? @
updatedObjectivesA R
)R S
;S T
} 
if   
(   
missionEvaluation   !
==  " $
null  % )
)  ) *
{!! 
missionEvaluation"" !
=""" #"
DetermineOverallStatus""$ :
("": ;
context""; B
,""B C
updatedObjectives""D U
)""U V
;""V W
}## 
return$$ 
missionEvaluation$$ $
;$$$ %
}%% 	
private'' 
static'' #
MissionEvaluationResult'' .
EvaluateSpecialRule''/ B
(''B C$
MissionEvaluationContext(( $
context((% ,
,((, -
List)) 
<)) 
MissionObjective)) !
>))! "
updatedObjectives))# 4
)))4 5
{** 	#
MissionEvaluationResult++ #
countResult++$ /
=++0 1)
EvaluateTrickCountConstraints++2 O
(++O P
context++P W
,++W X
updatedObjectives++Y j
)++j k
;++k l
if,, 
(,, 
countResult,, 
!=,, 
null,, #
),,# $
{-- 
return.. 
countResult.. "
;.." #
}// #
MissionEvaluationResult11 #
cardNumResult11$ 1
=112 3)
EvaluateCardNumberConstraints114 Q
(11Q R
context11R Y
,11Y Z
updatedObjectives11[ l
)11l m
;11m n
if22 
(22 
cardNumResult22 
!=22  
null22! %
)22% &
{33 
return44 
cardNumResult44 $
;44$ %
}55 #
MissionEvaluationResult77 #
specialCardResult77$ 5
=776 7*
EvaluateSpecialCardConstraints778 V
(77V W
context77W ^
,77^ _
updatedObjectives77` q
)77q r
;77r s
if88 
(88 
specialCardResult88 !
!=88" $
null88% )
)88) *
{99 
return:: 
specialCardResult:: (
;::( )
};; #
MissionEvaluationResult== # 
assignedPlayerResult==$ 8
===9 :-
!EvaluateAssignedPlayerConstraints==; \
(==\ ]
context==] d
,==d e
updatedObjectives==f w
)==w x
;==x y
if>> 
(>>  
assignedPlayerResult>> $
!=>>% '
null>>( ,
)>>, -
{?? 
return@@  
assignedPlayerResult@@ +
;@@+ ,
}AA 
returnCC +
EvaluateDistributionConstraintsCC 2
(CC2 3
contextCC3 :
,CC: ;
updatedObjectivesCC< M
)CCM N
;CCN O
}DD 	
privateFF 
staticFF #
MissionEvaluationResultFF .)
EvaluateTrickCountConstraintsFF/ L
(FFL M$
MissionEvaluationContextGG $
contextGG% ,
,GG, -
ListHH 
<HH 
MissionObjectiveHH !
>HH! "
updatedObjectivesHH# 4
)HH4 5
{II 	#
MissionEvaluationResultJJ #
resultJJ$ *
=JJ+ ,
nullJJ- 1
;JJ1 2
ifKK 
(KK 
contextKK 
.KK 

DefinitionKK "
.KK" #
SpecialRuleKK# .
==KK/ 1"
SpecialMissionRuleTypeKK2 H
.KKH I%
M05_OnePlayerWinsNoTricksKKI b
)KKb c
{LL 
boolMM "
hasEveryParticipantWonMM +
=MM, -

EnumerableMM. 8
.MM8 9
RangeMM9 >
(MM> ?
$numMM? @
,MM@ A
contextMMB I
.MMI J
PlayerCountMMJ U
)MMU V
.NN 
AllNN 
(NN 
seatNN 
=>NN  
GetTricksWonNN! -
(NN- .
contextNN. 5
.NN5 6 
TotalTricksWonBySeatNN6 J
,NNJ K
seatNNL P
)NNP Q
>NNR S
$numNNT U
)NNU V
;NNV W
ifOO 
(OO "
hasEveryParticipantWonOO *
)OO* +
{PP 
resultQQ 
=QQ #
MissionEvaluationResultQQ 4
.QQ4 5
FailQQ5 9
(QQ9 :
updatedObjectivesQQ: K
,QQK L!
MissionFailureReasonsRR -
.RR- .'
Mission05AllPlayersWonTrickRR. I
)RRI J
;RRJ K
}SS 
}TT 
elseUU 
ifUU 
(UU 
contextUU 
.UU 

DefinitionUU '
.UU' (
SpecialRuleUU( 3
==UU4 6"
SpecialMissionRuleTypeUU7 M
.UUM N%
M29_MaxTrickDifferenceTwoUUN g
||UUh j
contextVV 
.VV 

DefinitionVV "
.VV" #
SpecialRuleVV# .
==VV/ 1"
SpecialMissionRuleTypeWW *
.WW* +?
3M34_CaptainWinsFirstAndLastTrickAndMaxDifferenceTwoWW+ ^
)WW^ _
{XX 
intYY 
wonTrickDifferenceYY &
=YY' (*
CalculateTrickDifferenceSpreadYY) G
(YYG H
contextZZ 
.ZZ  
TotalTricksWonBySeatZZ 0
,ZZ0 1
contextZZ2 9
.ZZ9 :
PlayerCountZZ: E
)ZZE F
;ZZF G
if[[ 
([[ 
wonTrickDifference[[ &
>[[' (!
MissionFailureReasons[[) >
.[[> ?'
MaxTrickDifferenceThreshold[[? Z
)[[Z [
{\\ 
result]] 
=]] #
MissionEvaluationResult]] 4
.]]4 5
Fail]]5 9
(]]9 :
updatedObjectives]]: K
,]]K L!
MissionFailureReasons^^ -
.^^- .,
 Mission29TrickDifferenceExceeded^^. N
)^^N O
;^^O P
}__ 
}`` 
returnaa 
resultaa 
;aa 
}bb 	
privatedd 
staticdd #
MissionEvaluationResultdd .)
EvaluateCardNumberConstraintsdd/ L
(ddL M$
MissionEvaluationContextee $
contextee% ,
,ee, -
Listff 
<ff 
MissionObjectiveff !
>ff! "
updatedObjectivesff# 4
)ff4 5
{gg 	#
MissionEvaluationResulthh #
resulthh$ *
=hh+ ,
nullhh- 1
;hh1 2
switchii 
(ii 
contextii 
.ii 

Definitionii &
.ii& '
SpecialRuleii' 2
)ii2 3
{jj 
casekk "
SpecialMissionRuleTypekk +
.kk+ ,%
M09_WinTrickWithNumberOnekk, E
:kkE F
resultll 
=ll $
EvaluateWinningNormalOnell 5
(ll5 6
contextll6 =
,ll= >
updatedObjectivesll? P
)llP Q
;llQ R
breakmm 
;mm 
casenn "
SpecialMissionRuleTypenn +
.nn+ ,(
M16_NoTrickWonWithNumberNinenn, H
:nnH I
caseoo "
SpecialMissionRuleTypeoo +
.oo+ ,(
M17_NoTrickWonWithNumberNineoo, H
:ooH I
ifpp 
(pp 
contextpp 
.pp  
WinningPlaypp  +
.pp+ ,
Cardpp, 0
.pp0 1
Suitpp1 5
!=pp6 8
CardSuitpp9 A
.ppA B
SpecialppB I
&&ppJ L
contextqq 
.qq  
WinningPlayqq  +
.qq+ ,
Cardqq, 0
.qq0 1
Numberqq1 7
==qq8 :!
MissionFailureReasonsqq; P
.qqP Q*
ForbiddenTrickWinnerCardNumberqqQ o
)qqo p
{rr 
resultss 
=ss  #
MissionEvaluationResultss! 8
.ss8 9
Failss9 =
(ss= >
updatedObjectivesss> O
,ssO P!
MissionFailureReasonstt 1
.tt1 2%
Mission16TrickWonWithNinett2 K
)ttK L
;ttL M
}uu 
breakvv 
;vv 
caseww "
SpecialMissionRuleTypeww +
.ww+ ,)
M26_TwoTricksWonWithNumberOneww, I
:wwI J
resultxx 
=xx (
EvaluateTwoWinningNormalOnesxx 9
(xx9 :
contextxx: A
,xxA B
updatedObjectivesxxC T
)xxT U
;xxU V
breakyy 
;yy 
defaultzz 
:zz 
break{{ 
;{{ 
}|| 
return}} 
result}} 
;}} 
}~~ 	
private
ÄÄ 
static
ÄÄ %
MissionEvaluationResult
ÄÄ .*
EvaluateTwoWinningNormalOnes
ÄÄ/ K
(
ÄÄK L&
MissionEvaluationContext
ÄÄL d
context
ÄÄe l
,
ÄÄl m
List
ÅÅ 
<
ÅÅ 
MissionObjective
ÅÅ !
>
ÅÅ! "
updatedObjectives
ÅÅ# 4
)
ÅÅ4 5
{
ÇÇ 	
int
ÉÉ &
missingWinningNormalOnes
ÉÉ (
=
ÉÉ) *#
MissionFailureReasons
ÉÉ+ @
.
ÉÉ@ A(
Mission26RequiredOnesCount
ÉÉA [
-
ÉÉ\ ]
context
ÑÑ 
.
ÑÑ )
TricksWonWithNormalOneCount
ÑÑ 3
;
ÑÑ3 4%
MissionEvaluationResult
ÖÖ #
result
ÖÖ$ *
=
ÖÖ+ ,
null
ÖÖ- 1
;
ÖÖ1 2
if
ÜÜ 
(
ÜÜ &
missingWinningNormalOnes
ÜÜ (
<=
ÜÜ) +
$num
ÜÜ, -
)
ÜÜ- .
{
áá 
result
àà 
=
àà %
MissionEvaluationResult
àà 0
.
àà0 1
Success
àà1 8
(
àà8 9
updatedObjectives
àà9 J
,
ààJ K#
MissionFailureReasons
ââ )
.
ââ) *#
MissionSuccessMessage
ââ* ?
)
ââ? @
;
ââ@ A
}
ää 
else
ãã 
if
ãã 
(
ãã &
missingWinningNormalOnes
ãã -
>
ãã. /
context
ãã0 7
.
ãã7 8"
TotalTricksInMission
ãã8 L
-
ããM N
context
ããO V
.
ããV W 
CurrentTrickNumber
ããW i
)
ããi j
{
åå 
result
çç 
=
çç %
MissionEvaluationResult
çç 0
.
çç0 1
Fail
çç1 5
(
çç5 6
updatedObjectives
çç6 G
,
ççG H#
MissionFailureReasons
éé )
.
éé) *.
 Mission26LessTwoTricksWonWithOne
éé* J
)
ééJ K
;
ééK L
}
èè 
return
êê 
result
êê 
;
êê 
}
ëë 	
private
ìì 
static
ìì %
MissionEvaluationResult
ìì .&
EvaluateWinningNormalOne
ìì/ G
(
ììG H&
MissionEvaluationContext
ììH `
context
ììa h
,
ììh i
List
îî 
<
îî 
MissionObjective
îî !
>
îî! "
updatedObjectives
îî# 4
)
îî4 5
{
ïï 	%
MissionEvaluationResult
ññ #
result
ññ$ *
=
ññ+ ,
null
ññ- 1
;
ññ1 2
if
óó 
(
óó 
context
óó 
.
óó )
TricksWonWithNormalOneCount
óó 3
>
óó4 5
$num
óó6 7
)
óó7 8
{
òò 
result
ôô 
=
ôô %
MissionEvaluationResult
ôô 0
.
ôô0 1
Success
ôô1 8
(
ôô8 9
updatedObjectives
ôô9 J
,
ôôJ K#
MissionFailureReasons
öö )
.
öö) *#
MissionSuccessMessage
öö* ?
)
öö? @
;
öö@ A
}
õõ 
else
úú 
if
úú 
(
úú 
context
úú 
.
úú  
CurrentTrickNumber
úú /
==
úú0 2
context
úú3 :
.
úú: ;"
TotalTricksInMission
úú; O
)
úúO P
{
ùù 
result
ûû 
=
ûû %
MissionEvaluationResult
ûû 0
.
ûû0 1
Fail
ûû1 5
(
ûû5 6
updatedObjectives
ûû6 G
,
ûûG H#
MissionFailureReasons
üü )
.
üü) *(
Mission09NoTrickWonWithOne
üü* D
)
üüD E
;
üüE F
}
†† 
return
°° 
result
°° 
;
°° 
}
¢¢ 	
private
§§ 
static
§§ %
MissionEvaluationResult
§§ .)
EvaluateSpecialCardProgress
§§/ J
(
§§J K&
MissionEvaluationContext
§§K c
context
§§d k
,
§§k l
List
•• 
<
•• 
MissionObjective
•• !
>
••! "
updatedObjectives
••# 4
)
••4 5
{
¶¶ 	
int
ßß #
remainingSpecialToWin
ßß %
=
ßß& '#
MissionFailureReasons
ßß( =
.
ßß= >$
TotalSpecialCardsCount
ßß> T
-
ßßU V"
CountSpecialCardsWon
ßßW k
(
ßßk l
context
ßßl s
)
ßßs t
;
ßßt u%
MissionEvaluationResult
®® #
result
®®$ *
=
®®+ ,
null
®®- 1
;
®®1 2
if
©© 
(
©© 
context
©© 
.
©© 

Definition
©© "
.
©©" #
SpecialRule
©©# .
==
©©/ 1$
SpecialMissionRuleType
©©2 H
.
©©H I7
)M44_SpecialCardsWinTricksInAscendingOrder
©©I r
&&
©©s u
context
™™ 
.
™™ 
WinningPlay
™™ #
.
™™# $
Card
™™$ (
.
™™( )
Suit
™™) -
==
™™. 0
CardSuit
™™1 9
.
™™9 :
Special
™™: A
&&
™™B D
!
™™E F$
IsSpecialCardAscending
™™F \
(
™™\ ]
context
™™] d
)
™™d e
)
™™e f
{
´´ 
result
¨¨ 
=
¨¨ %
MissionEvaluationResult
¨¨ 0
.
¨¨0 1
Fail
¨¨1 5
(
¨¨5 6
updatedObjectives
¨¨6 G
,
¨¨G H#
MissionFailureReasons
≠≠ )
.
≠≠) *+
Mission44SpecialOrderViolated
≠≠* G
)
≠≠G H
;
≠≠H I
}
ÆÆ 
if
ØØ 
(
ØØ 
result
ØØ 
==
ØØ 
null
ØØ 
&&
ØØ !#
remainingSpecialToWin
ØØ" 7
==
ØØ8 :
$num
ØØ; <
)
ØØ< =
{
∞∞ 
result
±± 
=
±± %
MissionEvaluationResult
±± 0
.
±±0 1
Success
±±1 8
(
±±8 9
updatedObjectives
±±9 J
,
±±J K#
MissionFailureReasons
≤≤ )
.
≤≤) *#
MissionSuccessMessage
≤≤* ?
)
≤≤? @
;
≤≤@ A
}
≥≥ 
if
¥¥ 
(
¥¥ 
result
¥¥ 
==
¥¥ 
null
¥¥ 
&&
¥¥ !#
remainingSpecialToWin
¥¥" 7
>
¥¥8 9
context
¥¥: A
.
¥¥A B"
TotalTricksInMission
¥¥B V
-
¥¥W X
context
¥¥Y `
.
¥¥` a 
CurrentTrickNumber
¥¥a s
)
¥¥s t
{
µµ 
result
∂∂ 
=
∂∂ %
MissionEvaluationResult
∂∂ 0
.
∂∂0 1
Fail
∂∂1 5
(
∂∂5 6
updatedObjectives
∂∂6 G
,
∂∂G H#
MissionFailureReasons
∑∑ )
.
∑∑) *,
Mission13NotAllSpecialCardsWon
∑∑* H
)
∑∑H I
;
∑∑I J
}
∏∏ 
return
ππ 
result
ππ 
;
ππ 
}
∫∫ 	
private
ºº 
static
ºº %
MissionEvaluationResult
ºº .,
EvaluateSpecialCardConstraints
ºº/ M
(
ººM N&
MissionEvaluationContext
ΩΩ $
context
ΩΩ% ,
,
ΩΩ, -
List
ææ 
<
ææ 
MissionObjective
ææ !
>
ææ! "
updatedObjectives
ææ# 4
)
ææ4 5
{
øø 	%
MissionEvaluationResult
¿¿ #
result
¿¿$ *
=
¿¿+ ,
null
¿¿- 1
;
¿¿1 2
bool
¡¡ "
isSpecialCardMission
¡¡ %
=
¡¡& '
context
¡¡( /
.
¡¡/ 0

Definition
¡¡0 :
.
¡¡: ;
SpecialRule
¡¡; F
==
¡¡G I$
SpecialMissionRuleType
¬¬ &
.
¬¬& '.
 M13_WinTrickWithEverySpecialCard
¬¬' G
||
¬¬H J
context
¬¬K R
.
¬¬R S

Definition
¬¬S ]
.
¬¬] ^
SpecialRule
¬¬^ i
==
¬¬j l$
SpecialMissionRuleType
√√ &
.
√√& '7
)M44_SpecialCardsWinTricksInAscendingOrder
√√' P
;
√√P Q
if
ƒƒ 
(
ƒƒ "
isSpecialCardMission
ƒƒ $
)
ƒƒ$ %
{
≈≈ 
bool
∆∆  
hasLostSpecialCard
∆∆ '
=
∆∆( )
context
∆∆* 1
.
∆∆1 2!
CompletedTrickPlays
∆∆2 E
.
∆∆E F
Any
∆∆F I
(
∆∆I J
play
∆∆J N
=>
∆∆O Q
play
«« 
.
«« 
Card
«« 
.
«« 
Suit
«« "
==
««# %
CardSuit
««& .
.
««. /
Special
««/ 6
&&
««7 9
play
««: >
!=
««? A
context
««B I
.
««I J
WinningPlay
««J U
)
««U V
;
««V W
result
»» 
=
»»  
hasLostSpecialCard
»» +
?
…… %
MissionEvaluationResult
…… -
.
……- .
Fail
……. 2
(
……2 3
updatedObjectives
……3 D
,
……D E#
MissionFailureReasons
   -
.
  - .+
Mission13SpecialCardLostTrick
  . K
)
  K L
:
ÀÀ )
EvaluateSpecialCardProgress
ÀÀ 1
(
ÀÀ1 2
context
ÀÀ2 9
,
ÀÀ9 :
updatedObjectives
ÀÀ; L
)
ÀÀL M
;
ÀÀM N
}
ÃÃ 
return
ÕÕ 
result
ÕÕ 
;
ÕÕ 
}
ŒŒ 	
private
–– 
static
–– 
bool
–– $
IsSpecialCardAscending
–– 2
(
––2 3&
MissionEvaluationContext
––3 K
context
––L S
)
––S T
{
—— 	
SpecialCardSymbol
““ 
currentSymbol
““ +
=
““, -
context
““. 5
.
““5 6
WinningPlay
““6 A
.
““A B
Card
““B F
.
““F G
SpecialSymbol
““G T
;
““T U
int
”” 
priorSpecialCount
”” !
=
””" #
(
””$ %
context
””% ,
.
””, -"
SpecialCardsWonSoFar
””- A
??
””B D
Array
””E J
.
””J K
Empty
””K P
<
””P Q
Card
””Q U
>
””U V
(
””V W
)
””W X
)
””X Y
.
‘‘ 
Count
‘‘ 
(
‘‘ 
card
‘‘ 
=>
‘‘ 
card
‘‘ #
.
‘‘# $
Suit
‘‘$ (
==
‘‘) +
CardSuit
‘‘, 4
.
‘‘4 5
Special
‘‘5 <
&&
‘‘= ?
card
‘‘@ D
.
‘‘D E
IdCard
‘‘E K
!=
‘‘L N
context
‘‘O V
.
‘‘V W
WinningPlay
‘‘W b
.
‘‘b c
Card
‘‘c g
.
‘‘g h
IdCard
‘‘h n
)
‘‘n o
;
‘‘o p
SpecialCardSymbol
’’ 
expectedSymbol
’’ ,
=
’’- .
(
’’/ 0
SpecialCardSymbol
’’0 A
)
’’A B
(
’’B C
priorSpecialCount
’’C T
+
’’U V"
FirstSpecialCardRank
’’W k
)
’’k l
;
’’l m
return
◊◊ 
currentSymbol
◊◊  
==
◊◊! #
expectedSymbol
◊◊$ 2
;
◊◊2 3
}
ÿÿ 	
private
⁄⁄ 
static
⁄⁄ %
MissionEvaluationResult
⁄⁄ ./
!EvaluateAssignedPlayerConstraints
⁄⁄/ P
(
⁄⁄P Q&
MissionEvaluationContext
€€ $
context
€€% ,
,
€€, -
List
‹‹ 
<
‹‹ 
MissionObjective
‹‹ !
>
‹‹! "
updatedObjectives
‹‹# 4
)
‹‹4 5
{
›› 	
switch
ﬁﬁ 
(
ﬁﬁ 
context
ﬁﬁ 
.
ﬁﬁ 

Definition
ﬁﬁ &
.
ﬁﬁ& '
SpecialRule
ﬁﬁ' 2
)
ﬁﬁ2 3
{
ﬂﬂ 
case
‡‡ $
SpecialMissionRuleType
‡‡ +
.
‡‡+ ,E
7M33_SelectedPlayerWinsExactlyOneTrickWithoutSpecialCard
‡‡, c
:
‡‡c d
return
·· 
EvaluateMission33
·· ,
(
··, -
context
··- 4
,
··4 5
updatedObjectives
··6 G
)
··G H
;
··H I
case
„„ $
SpecialMissionRuleType
„„ +
.
„„+ ,A
3M34_CaptainWinsFirstAndLastTrickAndMaxDifferenceTwo
„„, _
:
„„_ `
return
‰‰ 
EvaluateMission34
‰‰ ,
(
‰‰, -
context
‰‰- 4
,
‰‰4 5
updatedObjectives
‰‰6 G
)
‰‰G H
;
‰‰H I
case
ÊÊ $
SpecialMissionRuleType
ÊÊ +
.
ÊÊ+ ,K
=M41_SelectedPlayerWinsOnlyFirstAndLastTrickWithoutSpecialCard
ÊÊ, i
:
ÊÊi j
return
ÁÁ 
EvaluateMission41
ÁÁ ,
(
ÁÁ, -
context
ÁÁ- 4
,
ÁÁ4 5
updatedObjectives
ÁÁ6 G
)
ÁÁG H
;
ÁÁH I
default
ÈÈ 
:
ÈÈ 
return
ÍÍ 
null
ÍÍ 
;
ÍÍ  
}
ÎÎ 
}
ÏÏ 	
private
ÓÓ 
static
ÓÓ %
MissionEvaluationResult
ÓÓ .
EvaluateMission33
ÓÓ/ @
(
ÓÓ@ A&
MissionEvaluationContext
ÔÔ $
context
ÔÔ% ,
,
ÔÔ, -
List
 
<
 
MissionObjective
 !
>
! "
updatedObjectives
# 4
)
4 5
{
ÒÒ 	%
MissionEvaluationResult
ÚÚ #
result
ÚÚ$ *
=
ÚÚ+ ,%
MissionEvaluationResult
ÚÚ- D
.
ÚÚD E
Fail
ÚÚE I
(
ÚÚI J
updatedObjectives
ÚÚJ [
,
ÚÚ[ \#
MissionFailureReasons
ÛÛ %
.
ÛÛ% &%
Mission33RoleUnassigned
ÛÛ& =
)
ÛÛ= >
;
ÛÛ> ?
byte
ÙÙ 
?
ÙÙ %
selectedParticipantSeat
ÙÙ )
=
ÙÙ* +
context
ÙÙ, 3
.
ÙÙ3 4

RoleConfig
ÙÙ4 >
?
ÙÙ> ?
.
ÙÙ? @#
SingleTrickWinnerSeat
ÙÙ@ U
;
ÙÙU V
if
ıı 
(
ıı %
selectedParticipantSeat
ıı '
.
ıı' (
HasValue
ıı( 0
&&
ıı1 3%
selectedParticipantSeat
ıı4 K
.
ııK L
Value
ııL Q
<
ııR S
context
ııT [
.
ıı[ \
PlayerCount
ıı\ g
)
ııg h
{
ˆˆ 
result
˜˜ 
=
˜˜ '
EvaluateSingleTrickWinner
˜˜ 2
(
˜˜2 3
context
˜˜3 :
,
˜˜: ;
updatedObjectives
˜˜< M
)
˜˜M N
;
˜˜N O
}
¯¯ 
return
˘˘ 
result
˘˘ 
;
˘˘ 
}
˙˙ 	
private
¸¸ 
static
¸¸ %
MissionEvaluationResult
¸¸ .'
EvaluateSingleTrickWinner
¸¸/ H
(
¸¸H I&
MissionEvaluationContext
¸¸I a
context
¸¸b i
,
¸¸i j
List
˝˝ 
<
˝˝ 
MissionObjective
˝˝ !
>
˝˝! "
updatedObjectives
˝˝# 4
)
˝˝4 5
{
˛˛ 	
byte
ˇˇ %
selectedParticipantSeat
ˇˇ (
=
ˇˇ) *
context
ˇˇ+ 2
.
ˇˇ2 3

RoleConfig
ˇˇ3 =
.
ˇˇ= >#
SingleTrickWinnerSeat
ˇˇ> S
.
ˇˇS T
Value
ˇˇT Y
;
ˇˇY Z
int
ÄÄ .
 selectedParticipantWonTrickCount
ÄÄ 0
=
ÄÄ1 2
GetTricksWon
ÄÄ3 ?
(
ÄÄ? @
context
ÄÄ@ G
.
ÄÄG H"
TotalTricksWonBySeat
ÄÄH \
,
ÄÄ\ ]%
selectedParticipantSeat
ÄÄ^ u
)
ÄÄu v
;
ÄÄv w%
MissionEvaluationResult
ÅÅ #
result
ÅÅ$ *
=
ÅÅ+ ,
null
ÅÅ- 1
;
ÅÅ1 2
if
ÇÇ 
(
ÇÇ 
context
ÇÇ 
.
ÇÇ 
WinningPlay
ÇÇ #
.
ÇÇ# $
Seat
ÇÇ$ (
==
ÇÇ) +%
selectedParticipantSeat
ÇÇ, C
&&
ÇÇD F
context
ÉÉ 
.
ÉÉ 
WinningPlay
ÉÉ #
.
ÉÉ# $
Card
ÉÉ$ (
.
ÉÉ( )
Suit
ÉÉ) -
==
ÉÉ. 0
CardSuit
ÉÉ1 9
.
ÉÉ9 :
Special
ÉÉ: A
)
ÉÉA B
{
ÑÑ 
result
ÖÖ 
=
ÖÖ %
MissionEvaluationResult
ÖÖ 0
.
ÖÖ0 1
Fail
ÖÖ1 5
(
ÖÖ5 6
updatedObjectives
ÖÖ6 G
,
ÖÖG H#
MissionFailureReasons
ÜÜ )
.
ÜÜ) *)
Mission33WonWithSpecialCard
ÜÜ* E
)
ÜÜE F
;
ÜÜF G
}
áá 
else
àà 
if
àà 
(
àà .
 selectedParticipantWonTrickCount
àà 5
>
àà6 7
$num
àà8 9
)
àà9 :
{
ââ 
result
ää 
=
ää %
MissionEvaluationResult
ää 0
.
ää0 1
Fail
ää1 5
(
ää5 6
updatedObjectives
ää6 G
,
ääG H#
MissionFailureReasons
ãã )
.
ãã) *(
Mission33WonMultipleTricks
ãã* D
)
ããD E
;
ããE F
}
åå 
else
çç 
if
çç 
(
çç 
context
çç 
.
çç  
CurrentTrickNumber
çç /
==
çç0 2
context
çç3 :
.
çç: ;"
TotalTricksInMission
çç; O
&&
ççP R.
 selectedParticipantWonTrickCount
éé 0
!=
éé1 3
$num
éé4 5
)
éé5 6
{
èè 
result
êê 
=
êê %
MissionEvaluationResult
êê 0
.
êê0 1
Fail
êê1 5
(
êê5 6
updatedObjectives
êê6 G
,
êêG H#
MissionFailureReasons
ëë )
.
ëë) */
!Mission33DidNotWinExactlyOneTrick
ëë* K
)
ëëK L
;
ëëL M
}
íí 
return
ìì 
result
ìì 
;
ìì 
}
îî 	
private
ññ 
static
ññ %
MissionEvaluationResult
ññ .
EvaluateMission34
ññ/ @
(
ññ@ A&
MissionEvaluationContext
óó $
context
óó% ,
,
óó, -
List
òò 
<
òò 
MissionObjective
òò !
>
òò! "
updatedObjectives
òò# 4
)
òò4 5
{
ôô 	%
MissionEvaluationResult
öö #
result
öö$ *
=
öö+ ,
null
öö- 1
;
öö1 2
if
õõ 
(
õõ 
context
õõ 
.
õõ  
CurrentTrickNumber
õõ *
==
õõ+ -
$num
õõ. /
&&
õõ0 2
context
õõ3 :
.
õõ: ;
WinningPlay
õõ; F
.
õõF G
Seat
õõG K
!=
õõL N
context
õõO V
.
õõV W
CaptainSeat
õõW b
)
õõb c
{
úú 
result
ùù 
=
ùù %
MissionEvaluationResult
ùù 0
.
ùù0 1
Fail
ùù1 5
(
ùù5 6
updatedObjectives
ùù6 G
,
ùùG H#
MissionFailureReasons
ûû )
.
ûû) *1
#Mission34CaptainDidNotWinFirstTrick
ûû* M
)
ûûM N
;
ûûN O
}
üü 
else
†† 
if
†† 
(
†† 
context
†† 
.
††  
CurrentTrickNumber
†† /
==
††0 2
context
††3 :
.
††: ;"
TotalTricksInMission
††; O
&&
††P R
context
°° 
.
°° 
WinningPlay
°° #
.
°°# $
Seat
°°$ (
!=
°°) +
context
°°, 3
.
°°3 4
CaptainSeat
°°4 ?
)
°°? @
{
¢¢ 
result
££ 
=
££ %
MissionEvaluationResult
££ 0
.
££0 1
Fail
££1 5
(
££5 6
updatedObjectives
££6 G
,
££G H#
MissionFailureReasons
§§ )
.
§§) *0
"Mission34CaptainDidNotWinLastTrick
§§* L
)
§§L M
;
§§M N
}
•• 
return
¶¶ 
result
¶¶ 
;
¶¶ 
}
ßß 	
private
©© 
static
©© %
MissionEvaluationResult
©© .
EvaluateMission41
©©/ @
(
©©@ A&
MissionEvaluationContext
™™ $
context
™™% ,
,
™™, -
List
´´ 
<
´´ 
MissionObjective
´´ !
>
´´! "
updatedObjectives
´´# 4
)
´´4 5
{
¨¨ 	%
MissionEvaluationResult
≠≠ #
result
≠≠$ *
=
≠≠+ ,%
MissionEvaluationResult
≠≠- D
.
≠≠D E
Fail
≠≠E I
(
≠≠I J
updatedObjectives
≠≠J [
,
≠≠[ \#
MissionFailureReasons
ÆÆ %
.
ÆÆ% &%
Mission41RoleUnassigned
ÆÆ& =
)
ÆÆ= >
;
ÆÆ> ?
byte
ØØ 
?
ØØ 
selectedSeat
ØØ 
=
ØØ  
context
ØØ! (
.
ØØ( )

RoleConfig
ØØ) 3
?
ØØ3 4
.
ØØ4 5)
FirstAndLastTrickWinnerSeat
ØØ5 P
;
ØØP Q
if
∞∞ 
(
∞∞ 
selectedSeat
∞∞ 
.
∞∞ 
HasValue
∞∞ %
&&
∞∞& (
selectedSeat
∞∞) 5
.
∞∞5 6
Value
∞∞6 ;
<
∞∞< =
context
∞∞> E
.
∞∞E F
PlayerCount
∞∞F Q
)
∞∞Q R
{
±± 
result
≤≤ 
=
≤≤ (
EvaluateFirstAndLastWinner
≤≤ 3
(
≤≤3 4
context
≤≤4 ;
,
≤≤; <
updatedObjectives
≤≤= N
)
≤≤N O
;
≤≤O P
}
≥≥ 
return
¥¥ 
result
¥¥ 
;
¥¥ 
}
µµ 	
private
∑∑ 
static
∑∑ %
MissionEvaluationResult
∑∑ .(
EvaluateFirstAndLastWinner
∑∑/ I
(
∑∑I J&
MissionEvaluationContext
∑∑J b
context
∑∑c j
,
∑∑j k
List
∏∏ 
<
∏∏ 
MissionObjective
∏∏ !
>
∏∏! "

objectives
∏∏# -
)
∏∏- .
{
ππ 	
bool
∫∫ 
isFirstTrick
∫∫ 
=
∫∫ 
context
∫∫  '
.
∫∫' ( 
CurrentTrickNumber
∫∫( :
==
∫∫; =%
FirstMissionTrickNumber
∫∫> U
;
∫∫U V
bool
ªª 
isLastTrick
ªª 
=
ªª 
context
ªª &
.
ªª& ' 
CurrentTrickNumber
ªª' 9
==
ªª: <
context
ªª= D
.
ªªD E"
TotalTricksInMission
ªªE Y
;
ªªY Z
bool
ºº 
hasSelectedWinner
ºº "
=
ºº# $
context
ºº% ,
.
ºº, -
WinningPlay
ºº- 8
.
ºº8 9
Seat
ºº9 =
==
ºº> @
context
ººA H
.
ººH I

RoleConfig
ººI S
.
ººS T)
FirstAndLastTrickWinnerSeat
ººT o
;
ººo p
string
ΩΩ 
failureReason
ΩΩ  
=
ΩΩ! "
null
ΩΩ# '
;
ΩΩ' (
if
ææ 
(
ææ 
isFirstTrick
ææ 
||
ææ 
isLastTrick
ææ  +
)
ææ+ ,
{
øø 
failureReason
¿¿ 
=
¿¿ )
GetFirstOrLastWinnerFailure
¿¿  ;
(
¿¿; <
context
¿¿< C
,
¿¿C D
hasSelectedWinner
¿¿E V
)
¿¿V W
;
¿¿W X
}
¡¡ 
else
¬¬ 
if
¬¬ 
(
¬¬ 
hasSelectedWinner
¬¬ &
)
¬¬& '
{
√√ 
failureReason
ƒƒ 
=
ƒƒ #
MissionFailureReasons
ƒƒ  5
.
ƒƒ5 65
'Mission41IntermediateTrickWonBySelected
ƒƒ6 ]
;
ƒƒ] ^
}
≈≈ 
return
∆∆ 
failureReason
∆∆  
==
∆∆! #
null
∆∆$ (
?
∆∆) *
null
∆∆+ /
:
∆∆0 1%
MissionEvaluationResult
∆∆2 I
.
∆∆I J
Fail
∆∆J N
(
∆∆N O

objectives
∆∆O Y
,
∆∆Y Z
failureReason
∆∆[ h
)
∆∆h i
;
∆∆i j
}
«« 	
private
…… 
static
…… 
string
…… )
GetFirstOrLastWinnerFailure
…… 9
(
……9 :&
MissionEvaluationContext
……: R
context
……S Z
,
……Z [
bool
……\ `
hasSelectedWinner
……a r
)
……r s
{
   	
bool
ÀÀ 
isFirstTrick
ÀÀ 
=
ÀÀ 
context
ÀÀ  '
.
ÀÀ' ( 
CurrentTrickNumber
ÀÀ( :
==
ÀÀ; =%
FirstMissionTrickNumber
ÀÀ> U
;
ÀÀU V
string
ÃÃ 
failureReason
ÃÃ  
=
ÃÃ! "
null
ÃÃ# '
;
ÃÃ' (
if
ÕÕ 
(
ÕÕ 
!
ÕÕ 
hasSelectedWinner
ÕÕ "
)
ÕÕ" #
{
ŒŒ 
failureReason
œœ 
=
œœ 
isFirstTrick
œœ  ,
?
œœ- .#
MissionFailureReasons
œœ/ D
.
œœD E1
#Mission41FirstTrickNotWonBySelected
œœE h
:
–– #
MissionFailureReasons
–– +
.
––+ ,0
"Mission41LastTrickNotWonBySelected
––, N
;
––N O
}
—— 
else
““ 
if
““ 
(
““ 
context
““ 
.
““ 
WinningPlay
““ (
.
““( )
Card
““) -
.
““- .
Suit
““. 2
==
““3 5
CardSuit
““6 >
.
““> ?
Special
““? F
)
““F G
{
”” 
failureReason
‘‘ 
=
‘‘ 
isFirstTrick
‘‘  ,
?
‘‘- .#
MissionFailureReasons
‘‘/ D
.
‘‘D E/
!Mission41FirstTrickWonWithSpecial
‘‘E f
:
’’ #
MissionFailureReasons
’’ +
.
’’+ ,.
 Mission41LastTrickWonWithSpecial
’’, L
;
’’L M
}
÷÷ 
return
◊◊ 
failureReason
◊◊  
;
◊◊  !
}
ÿÿ 	
private
⁄⁄ 
static
⁄⁄ %
MissionEvaluationResult
⁄⁄ .-
EvaluateDistributionConstraints
⁄⁄/ N
(
⁄⁄N O&
MissionEvaluationContext
€€ $
context
€€% ,
,
€€, -
List
‹‹ 
<
‹‹ 
MissionObjective
‹‹ !
>
‹‹! "
updatedObjectives
‹‹# 4
)
‹‹4 5
{
›› 	
if
ﬁﬁ 
(
ﬁﬁ 
context
ﬁﬁ 
.
ﬁﬁ 

Definition
ﬁﬁ "
.
ﬁﬁ" #
SpecialRule
ﬁﬁ# .
==
ﬁﬁ/ 1$
SpecialMissionRuleType
ﬁﬁ2 H
.
ﬁﬁH I2
$M46_SeatLeftOfHeartNineWinsAllHearts
ﬁﬁI m
)
ﬁﬁm n
{
ﬂﬂ 
return
‡‡ 
EvaluateMission46
‡‡ (
(
‡‡( )
context
‡‡) 0
,
‡‡0 1
updatedObjectives
‡‡2 C
)
‡‡C D
;
‡‡D E
}
·· 
if
„„ 
(
„„ 
context
„„ 
.
„„ 

Definition
„„ "
.
„„" #
SpecialRule
„„# .
==
„„/ 1$
SpecialMissionRuleType
„„2 H
.
„„H I,
M50_SplitTrickWinsDistribution
„„I g
)
„„g h
{
‰‰ 
return
ÂÂ 
EvaluateMission50
ÂÂ (
(
ÂÂ( )
context
ÂÂ) 0
,
ÂÂ0 1
updatedObjectives
ÂÂ2 C
)
ÂÂC D
;
ÂÂD E
}
ÊÊ 
return
ËË 
null
ËË 
;
ËË 
}
ÈÈ 	
private
ÎÎ 
static
ÎÎ %
MissionEvaluationResult
ÎÎ .
EvaluateMission46
ÎÎ/ @
(
ÎÎ@ A&
MissionEvaluationContext
ÏÏ $
context
ÏÏ% ,
,
ÏÏ, -
List
ÌÌ 
<
ÌÌ 
MissionObjective
ÌÌ !
>
ÌÌ! "
updatedObjectives
ÌÌ# 4
)
ÌÌ4 5
{
ÓÓ 	
string
ÔÔ 
failureReason
ÔÔ  
=
ÔÔ! "
null
ÔÔ# '
;
ÔÔ' (%
MissionEvaluationResult
 #
result
$ *
=
+ ,
null
- 1
;
1 2
if
ÒÒ 
(
ÒÒ 
!
ÒÒ 
context
ÒÒ 
.
ÒÒ  
HeartNineOwnerSeat
ÒÒ +
.
ÒÒ+ ,
HasValue
ÒÒ, 4
||
ÒÒ5 7
context
ÒÒ8 ?
.
ÒÒ? @ 
HeartNineOwnerSeat
ÒÒ@ R
.
ÒÒR S
Value
ÒÒS X
>=
ÒÒY [
context
ÒÒ\ c
.
ÒÒc d
PlayerCount
ÒÒd o
)
ÒÒo p
{
ÚÚ 
failureReason
ÛÛ 
=
ÛÛ #
MissionFailureReasons
ÛÛ  5
.
ÛÛ5 6,
Mission46HeartNineUnidentified
ÛÛ6 T
;
ÛÛT U
}
ÙÙ 
else
ıı 
{
ˆˆ 
failureReason
˜˜ 
=
˜˜ $
GetHeartCaptureFailure
˜˜  6
(
˜˜6 7
context
˜˜7 >
)
˜˜> ?
;
˜˜? @
}
¯¯ 
if
˘˘ 
(
˘˘ 
failureReason
˘˘ 
!=
˘˘  
null
˘˘! %
)
˘˘% &
{
˙˙ 
result
˚˚ 
=
˚˚ %
MissionEvaluationResult
˚˚ 0
.
˚˚0 1
Fail
˚˚1 5
(
˚˚5 6
updatedObjectives
˚˚6 G
,
˚˚G H
failureReason
˚˚I V
)
˚˚V W
;
˚˚W X
}
¸¸ 
else
˝˝ 
if
˝˝ 
(
˝˝ 
context
˝˝ 
.
˝˝ $
CapturedHeartCardCount
˝˝ 3
==
˝˝4 6&
s_requiredHeartCardCount
˝˝7 O
)
˝˝O P
{
˛˛ 
result
ˇˇ 
=
ˇˇ %
MissionEvaluationResult
ˇˇ 0
.
ˇˇ0 1
Success
ˇˇ1 8
(
ˇˇ8 9
updatedObjectives
ˇˇ9 J
,
ˇˇJ K#
MissionFailureReasons
ÄÄ )
.
ÄÄ) *#
MissionSuccessMessage
ÄÄ* ?
)
ÄÄ? @
;
ÄÄ@ A
}
ÅÅ 
return
ÇÇ 
result
ÇÇ 
;
ÇÇ 
}
ÉÉ 	
private
ÖÖ 
static
ÖÖ 
readonly
ÖÖ 
int
ÖÖ  #&
s_requiredHeartCardCount
ÖÖ$ <
=
ÖÖ= >!
TrickTakingMissions
ÜÜ 
.
ÜÜ  
Rules
ÜÜ  %
.
ÜÜ% &
Rules
ÜÜ& +
.
ÜÜ+ ,
	DeckRules
ÜÜ, 5
.
ÜÜ5 6 
CreateStandardDeck
ÜÜ6 H
(
ÜÜH I
)
ÜÜI J
.
ÜÜJ K
Count
ÜÜK P
(
ÜÜP Q
card
ÜÜQ U
=>
ÜÜV X
card
ÜÜY ]
.
ÜÜ] ^
Suit
ÜÜ^ b
==
ÜÜc e
CardSuit
ÜÜf n
.
ÜÜn o
Heart
ÜÜo t
)
ÜÜt u
;
ÜÜu v
private
àà 
static
àà 
string
àà $
GetHeartCaptureFailure
àà 4
(
àà4 5&
MissionEvaluationContext
àà5 M
context
ààN U
)
ààU V
{
ââ 	
if
ää 
(
ää 
context
ää 
.
ää $
CapturedHeartCardCount
ää .
<
ää/ 0
$num
ää1 2
||
ää3 5
context
ää6 =
.
ää= >$
CapturedHeartCardCount
ää> T
>
ääU V&
s_requiredHeartCardCount
ääW o
)
ääo p
{
ãã 
throw
åå 
new
åå 
ArgumentException
åå +
(
åå+ ,
nameof
åå, 2
(
åå2 3
context
åå3 :
.
åå: ;$
CapturedHeartCardCount
åå; Q
)
ååQ R
)
ååR S
;
ååS T
}
çç 
byte
éé 

targetSeat
éé 
=
éé "
ParticipantSeatRules
éé 2
.
éé2 3"
GetNextClockwiseSeat
éé3 G
(
ééG H
context
ééH O
.
ééO P 
HeartNineOwnerSeat
ééP b
.
ééb c
Value
ééc h
,
ééh i
context
èè 
.
èè 
PlayerCount
èè #
)
èè# $
;
èè$ %
bool
êê 
hasHeartCard
êê 
=
êê 
context
êê  '
.
êê' (!
CompletedTrickPlays
êê( ;
.
êê; <
Any
êê< ?
(
êê? @
play
êê@ D
=>
êêE G
play
êêH L
.
êêL M
Card
êêM Q
.
êêQ R
Suit
êêR V
==
êêW Y
CardSuit
êêZ b
.
êêb c
Heart
êêc h
)
êêh i
;
êêi j
string
ëë 
failureReason
ëë  
=
ëë! "
null
ëë# '
;
ëë' (
if
íí 
(
íí 
hasHeartCard
íí 
&&
íí 
context
íí  '
.
íí' (
WinningPlay
íí( 3
.
íí3 4
Seat
íí4 8
!=
íí9 ;

targetSeat
íí< F
)
ííF G
{
ìì 
failureReason
îî 
=
îî #
MissionFailureReasons
îî  5
.
îî5 6/
!Mission46HeartCapturedByWrongSeat
îî6 W
;
îîW X
}
ïï 
else
ññ 
if
ññ 
(
ññ 
context
ññ 
.
ññ  
CurrentTrickNumber
ññ /
==
ññ0 2
context
ññ3 :
.
ññ: ;"
TotalTricksInMission
ññ; O
&&
ññP R
context
óó 
.
óó $
CapturedHeartCardCount
óó .
!=
óó/ 1&
s_requiredHeartCardCount
óó2 J
)
óóJ K
{
òò 
failureReason
ôô 
=
ôô #
MissionFailureReasons
ôô  5
.
ôô5 6'
Mission46HeartsIncomplete
ôô6 O
;
ôôO P
}
öö 
return
õõ 
failureReason
õõ  
;
õõ  !
}
úú 	
private
ûû 
static
ûû %
MissionEvaluationResult
ûû .
EvaluateMission50
ûû/ @
(
ûû@ A&
MissionEvaluationContext
üü $
context
üü% ,
,
üü, -
List
†† 
<
†† 
MissionObjective
†† !
>
††! "
updatedObjectives
††# 4
)
††4 5
{
°° 	
string
¢¢ 
failureReason
¢¢  
=
¢¢! "#
MissionFailureReasons
¢¢# 8
.
¢¢8 9&
Mission50RolesUnassigned
¢¢9 Q
;
¢¢Q R
if
££ 
(
££ 
MissionSetupRules
££ !
.
££! "'
ValidateRoleConfiguration
££" ;
(
££; <
context
££< C
.
££C D

Definition
££D N
,
££N O
context
££P W
.
££W X

RoleConfig
££X b
,
££b c
context
§§ 
.
§§ 
PlayerCount
§§ #
)
§§# $
)
§§$ %
{
•• 
failureReason
¶¶ 
=
¶¶ )
GetTrickDistributionFailure
¶¶  ;
(
¶¶; <
context
¶¶< C
)
¶¶C D
;
¶¶D E
}
ßß 
return
®® 
failureReason
®®  
==
®®! #
null
®®$ (
?
®®) *
null
®®+ /
:
®®0 1%
MissionEvaluationResult
®®2 I
.
®®I J
Fail
®®J N
(
®®N O
updatedObjectives
®®O `
,
®®` a
failureReason
®®b o
)
®®o p
;
®®p q
}
©© 	
private
´´ 
static
´´ 
string
´´ )
GetTrickDistributionFailure
´´ 9
(
´´9 :&
MissionEvaluationContext
´´: R
context
´´S Z
)
´´Z [
{
¨¨ 	
string
≠≠ 
failureReason
≠≠  
=
≠≠! "
null
≠≠# '
;
≠≠' (
bool
ÆÆ 
isLastTrick
ÆÆ 
=
ÆÆ 
context
ÆÆ &
.
ÆÆ& ' 
CurrentTrickNumber
ÆÆ' 9
==
ÆÆ: <
context
ÆÆ= D
.
ÆÆD E"
TotalTricksInMission
ÆÆE Y
;
ÆÆY Z
if
ØØ 
(
ØØ 
context
ØØ 
.
ØØ  
CurrentTrickNumber
ØØ *
<=
ØØ+ -#
MissionFailureReasons
ØØ. C
.
ØØC D)
Mission50InitialTricksCount
ØØD _
)
ØØ_ `
{
∞∞ 
if
±± 
(
±± 
context
±± 
.
±± 
WinningPlay
±± '
.
±±' (
Seat
±±( ,
!=
±±- /
context
±±0 7
.
±±7 8

RoleConfig
±±8 B
.
±±B C'
FirstFourTricksWinnerSeat
±±C \
)
±±\ ]
{
≤≤ 
failureReason
≥≥ !
=
≥≥" ##
MissionFailureReasons
≥≥$ 9
.
≥≥9 :1
#Mission50FirstFourTricksWrongWinner
≥≥: ]
;
≥≥] ^
}
¥¥ 
}
µµ 
else
∂∂ 
{
∑∑ 
failureReason
∏∏ 
=
∏∏ -
GetLateTrickDistributionFailure
∏∏  ?
(
∏∏? @
context
∏∏@ G
,
∏∏G H
isLastTrick
∏∏I T
)
∏∏T U
;
∏∏U V
}
ππ 
if
∫∫ 
(
∫∫ 
failureReason
∫∫ 
==
∫∫  
null
∫∫! %
&&
∫∫& (
context
∫∫) 0
.
∫∫0 1 
CurrentTrickNumber
∫∫1 C
>=
∫∫D F
context
∫∫G N
.
∫∫N O"
TotalTricksInMission
∫∫O c
-
∫∫d e
$num
∫∫f g
)
∫∫g h
{
ªª 
bool
ºº *
haveRemainingParticipantsWon
ºº 1
=
ºº2 3

Enumerable
ºº4 >
.
ºº> ?
Range
ºº? D
(
ººD E
$num
ººE F
,
ººF G
context
ººH O
.
ººO P
PlayerCount
ººP [
)
ºº[ \
.
ΩΩ 
Where
ΩΩ 
(
ΩΩ 
seat
ΩΩ 
=>
ΩΩ  "
seat
ΩΩ# '
!=
ΩΩ( *
context
ΩΩ+ 2
.
ΩΩ2 3

RoleConfig
ΩΩ3 =
.
ΩΩ= >'
FirstFourTricksWinnerSeat
ΩΩ> W
&&
ΩΩX Z
seat
ææ 
!=
ææ 
context
ææ  '
.
ææ' (

RoleConfig
ææ( 2
.
ææ2 3!
LastTrickWinnerSeat
ææ3 F
)
ææF G
.
øø 
All
øø 
(
øø 
seat
øø 
=>
øø  
GetTricksWon
øø! -
(
øø- .
context
øø. 5
.
øø5 6"
TotalTricksWonBySeat
øø6 J
,
øøJ K
seat
øøL P
)
øøP Q
>
øøR S
$num
øøT U
)
øøU V
;
øøV W
if
¿¿ 
(
¿¿ 
!
¿¿ *
haveRemainingParticipantsWon
¿¿ 1
)
¿¿1 2
{
¡¡ 
failureReason
¬¬ !
=
¬¬" ##
MissionFailureReasons
¬¬$ 9
.
¬¬9 :0
"Mission50RemainingPlayerWonNoTrick
¬¬: \
;
¬¬\ ]
}
√√ 
}
ƒƒ 
return
≈≈ 
failureReason
≈≈  
;
≈≈  !
}
∆∆ 	
private
»» 
static
»» 
string
»» -
GetLateTrickDistributionFailure
»» =
(
»»= >&
MissionEvaluationContext
»»> V
context
»»W ^
,
»»^ _
bool
»»` d
isLastTrick
»»e p
)
»»p q
{
…… 	
string
   
failureReason
    
=
  ! "
null
  # '
;
  ' (
if
ÀÀ 
(
ÀÀ 
context
ÀÀ 
.
ÀÀ 
WinningPlay
ÀÀ #
.
ÀÀ# $
Seat
ÀÀ$ (
==
ÀÀ) +
context
ÀÀ, 3
.
ÀÀ3 4

RoleConfig
ÀÀ4 >
.
ÀÀ> ?'
FirstFourTricksWinnerSeat
ÀÀ? X
)
ÀÀX Y
{
ÃÃ 
failureReason
ÕÕ 
=
ÕÕ #
MissionFailureReasons
ÕÕ  5
.
ÕÕ5 6.
 Mission50FirstFourWinnerWonExtra
ÕÕ6 V
;
ÕÕV W
}
ŒŒ 
else
œœ 
if
œœ 
(
œœ 
!
œœ 
isLastTrick
œœ !
&&
œœ" $
context
œœ% ,
.
œœ, -
WinningPlay
œœ- 8
.
œœ8 9
Seat
œœ9 =
==
œœ> @
context
œœA H
.
œœH I

RoleConfig
œœI S
.
œœS T!
LastTrickWinnerSeat
œœT g
)
œœg h
{
–– 
failureReason
—— 
=
—— #
MissionFailureReasons
——  5
.
——5 6.
 Mission50LastTrickWinnerWonEarly
——6 V
;
——V W
}
““ 
else
”” 
if
”” 
(
”” 
isLastTrick
””  
&&
””! #
context
””$ +
.
””+ ,
WinningPlay
””, 7
.
””7 8
Seat
””8 <
!=
””= ?
context
””@ G
.
””G H

RoleConfig
””H R
.
””R S!
LastTrickWinnerSeat
””S f
)
””f g
{
‘‘ 
failureReason
’’ 
=
’’ #
MissionFailureReasons
’’  5
.
’’5 6+
Mission50LastTrickWrongWinner
’’6 S
;
’’S T
}
÷÷ 
return
◊◊ 
failureReason
◊◊  
;
◊◊  !
}
ÿÿ 	
private
⁄⁄ 
static
⁄⁄ %
MissionEvaluationResult
⁄⁄ .$
DetermineOverallStatus
⁄⁄/ E
(
⁄⁄E F&
MissionEvaluationContext
€€ $
context
€€% ,
,
€€, -
List
‹‹ 
<
‹‹ 
MissionObjective
‹‹ !
>
‹‹! "
updatedObjectives
‹‹# 4
)
‹‹4 5
{
›› 	
bool
ﬁﬁ  
isPenultimateTrick
ﬁﬁ #
=
ﬁﬁ$ %
context
ﬁﬁ& -
.
ﬁﬁ- . 
CurrentTrickNumber
ﬁﬁ. @
==
ﬁﬁA C
context
ﬁﬁD K
.
ﬁﬁK L"
TotalTricksInMission
ﬁﬁL `
-
ﬁﬁa b
$num
ﬁﬁc d
;
ﬁﬁd e
if
ﬂﬂ 
(
ﬂﬂ 
context
ﬂﬂ 
.
ﬂﬂ 

Definition
ﬂﬂ "
.
ﬂﬂ" #
SpecialRule
ﬂﬂ# .
==
ﬂﬂ/ 1$
SpecialMissionRuleType
ﬂﬂ2 H
.
ﬂﬂH I4
&M48_OmegaObjectiveCompletedInLastTrick
ﬂﬂI o
&&
ﬂﬂp r 
isPenultimateTrick
‡‡ "
)
‡‡" #
{
·· 
MissionObjective
‚‚  
pendingNonOmega
‚‚! 0
=
‚‚1 2
updatedObjectives
‚‚3 D
.
„„ 
FirstOrDefault
„„ #
(
„„# $
o
„„$ %
=>
„„& (
o
„„) *
.
„„* +
Token
„„+ 0
!=
„„1 3 
ObjectiveTokenType
„„4 F
.
„„F G
Omega
„„G L
&&
„„M O
o
„„P Q
.
„„Q R
Status
„„R X
!=
„„Y [
ObjectiveStatus
„„\ k
.
„„k l
	Completed
„„l u
)
„„u v
;
„„v w
if
‰‰ 
(
‰‰ 
pendingNonOmega
‰‰ #
!=
‰‰$ &
null
‰‰' +
)
‰‰+ ,
{
ÂÂ 
return
ÊÊ 
FailObjective
ÊÊ (
(
ÊÊ( )
updatedObjectives
ÊÊ) :
,
ÊÊ: ;
pendingNonOmega
ÊÊ< K
.
ÊÊK L
CardId
ÊÊL R
,
ÊÊR S#
MissionFailureReasons
ÊÊT i
.
ÊÊi j6
'Mission48PendingNonOmegaBeforeLastTrickÊÊj ë
)ÊÊë í
;ÊÊí ì
}
ÁÁ 
}
ËË 
bool
ÍÍ $
allObjectivesCompleted
ÍÍ '
=
ÍÍ( )
updatedObjectives
ÍÍ* ;
.
ÍÍ; <
All
ÍÍ< ?
(
ÍÍ? @
o
ÍÍ@ A
=>
ÍÍB D
o
ÍÍE F
.
ÍÍF G
Status
ÍÍG M
==
ÍÍN P
ObjectiveStatus
ÍÍQ `
.
ÍÍ` a
	Completed
ÍÍa j
)
ÍÍj k
;
ÍÍk l
bool
ÎÎ 
isLastTrick
ÎÎ 
=
ÎÎ 
context
ÎÎ &
.
ÎÎ& ' 
CurrentTrickNumber
ÎÎ' 9
==
ÎÎ: <
context
ÎÎ= D
.
ÎÎD E"
TotalTricksInMission
ÎÎE Y
;
ÎÎY Z
if
ÌÌ 
(
ÌÌ 
!
ÌÌ $
allObjectivesCompleted
ÌÌ '
&&
ÌÌ( *
isLastTrick
ÌÌ+ 6
)
ÌÌ6 7
{
ÓÓ 
MissionObjective
ÔÔ  
firstPending
ÔÔ! -
=
ÔÔ. /
updatedObjectives
ÔÔ0 A
.
ÔÔA B
First
ÔÔB G
(
ÔÔG H
o
ÔÔH I
=>
ÔÔJ L
o
ÔÔM N
.
ÔÔN O
Status
ÔÔO U
!=
ÔÔV X
ObjectiveStatus
ÔÔY h
.
ÔÔh i
	Completed
ÔÔi r
)
ÔÔr s
;
ÔÔs t
return
 
FailObjective
 $
(
$ %
updatedObjectives
% 6
,
6 7
firstPending
8 D
.
D E
CardId
E K
,
K L#
MissionFailureReasons
M b
.
b c/
 ObjectivesIncompleteAtMissionEndc É
)É Ñ
;Ñ Ö
}
ÒÒ 
bool
ÛÛ .
 hasPendingSpecialRuleConstraints
ÛÛ 1
=
ÛÛ2 3.
 HasOngoingSpecialRuleConstraints
ÛÛ4 T
(
ÛÛT U
context
ÛÛU \
.
ÛÛ\ ]

Definition
ÛÛ] g
.
ÛÛg h
SpecialRule
ÛÛh s
)
ÛÛs t
;
ÛÛt u
if
ÙÙ 
(
ÙÙ $
allObjectivesCompleted
ÙÙ &
&&
ÙÙ' )
(
ÙÙ* +
!
ÙÙ+ ,.
 hasPendingSpecialRuleConstraints
ÙÙ, L
||
ÙÙM O
isLastTrick
ÙÙP [
)
ÙÙ[ \
)
ÙÙ\ ]
{
ıı 
return
ˆˆ %
MissionEvaluationResult
ˆˆ .
.
ˆˆ. /
Success
ˆˆ/ 6
(
ˆˆ6 7
updatedObjectives
ˆˆ7 H
,
ˆˆH I#
MissionFailureReasons
ˆˆJ _
.
ˆˆ_ `#
MissionSuccessMessage
ˆˆ` u
)
ˆˆu v
;
ˆˆv w
}
˜˜ 
return
˘˘ %
MissionEvaluationResult
˘˘ *
.
˘˘* +

InProgress
˘˘+ 5
(
˘˘5 6
updatedObjectives
˘˘6 G
)
˘˘G H
;
˘˘H I
}
˙˙ 	
private
¸¸ 
static
¸¸ 
bool
¸¸ .
 HasOngoingSpecialRuleConstraints
¸¸ <
(
¸¸< =$
SpecialMissionRuleType
¸¸= S
specialRule
¸¸T _
)
¸¸_ `
{
˝˝ 	
return
˛˛ 
specialRule
˛˛ 
!=
˛˛ !$
SpecialMissionRuleType
˛˛" 8
.
˛˛8 9
None
˛˛9 =
&&
˛˛> @
specialRule
ˇˇ 
!=
ˇˇ $
SpecialMissionRuleType
ˇˇ 5
.
ˇˇ5 6*
M11_CaptainSilencesOnePlayer
ˇˇ6 R
&&
ˇˇS U
specialRule
ÄÄ 
!=
ÄÄ $
SpecialMissionRuleType
ÄÄ 5
.
ÄÄ5 6*
M17_NoTrickWonWithNumberNine
ÄÄ6 R
&&
ÄÄS U
specialRule
ÅÅ 
!=
ÅÅ $
SpecialMissionRuleType
ÅÅ 5
.
ÅÅ5 68
*M20_CaptainAssignsAllObjectivesToOnePlayer
ÅÅ6 `
&&
ÅÅa c
specialRule
ÇÇ 
!=
ÇÇ $
SpecialMissionRuleType
ÇÇ 5
.
ÇÇ5 68
*M27_CaptainAssignsAllObjectivesToOnePlayer
ÇÇ6 `
;
ÇÇ` a
}
ÉÉ 	
private
ÖÖ 
static
ÖÖ 
int
ÖÖ ,
CalculateTrickDifferenceSpread
ÖÖ 9
(
ÖÖ9 :!
IReadOnlyDictionary
ÖÖ: M
<
ÖÖM N
int
ÖÖN Q
,
ÖÖQ R
int
ÖÖS V
>
ÖÖV W
tricksBySeat
ÖÖX d
,
ÖÖd e
int
ÖÖf i
playerCount
ÖÖj u
)
ÖÖu v
{
ÜÜ 	
int
áá "
maximumWonTrickCount
áá $
=
áá% &
$num
áá' (
;
áá( )
int
àà "
minimumWonTrickCount
àà $
=
àà% &
int
àà' *
.
àà* +
MaxValue
àà+ 3
;
àà3 4
for
ââ 
(
ââ 
int
ââ 
participantSeat
ââ $
=
ââ% &
$num
ââ' (
;
ââ( )
participantSeat
ââ* 9
<
ââ: ;
playerCount
ââ< G
;
ââG H
participantSeat
ââI X
++
ââX Z
)
ââZ [
{
ää 
int
ãã 
wonTrickCount
ãã !
=
ãã" #
GetTricksWon
ãã$ 0
(
ãã0 1
tricksBySeat
ãã1 =
,
ãã= >
participantSeat
ãã? N
)
ããN O
;
ããO P"
maximumWonTrickCount
åå $
=
åå% &
Math
åå' +
.
åå+ ,
Max
åå, /
(
åå/ 0"
maximumWonTrickCount
åå0 D
,
ååD E
wonTrickCount
ååF S
)
ååS T
;
ååT U"
minimumWonTrickCount
çç $
=
çç% &
Math
çç' +
.
çç+ ,
Min
çç, /
(
çç/ 0"
minimumWonTrickCount
çç0 D
,
ççD E
wonTrickCount
ççF S
)
ççS T
;
ççT U
}
éé 
return
èè "
maximumWonTrickCount
èè '
-
èè( )"
minimumWonTrickCount
èè* >
;
èè> ?
}
êê 	
private
íí 
static
íí 
int
íí "
CountSpecialCardsWon
íí /
(
íí/ 0&
MissionEvaluationContext
íí0 H
context
ííI P
)
ííP Q
{
ìì 	
var
îî 

wonSymbols
îî 
=
îî 
new
îî  
HashSet
îî! (
<
îî( )
SpecialCardSymbol
îî) :
>
îî: ;
(
îî; <
(
ïï 
context
ïï 
.
ïï "
SpecialCardsWonSoFar
ïï -
??
ïï. 0
Array
ïï1 6
.
ïï6 7
Empty
ïï7 <
<
ïï< =
Card
ïï= A
>
ïïA B
(
ïïB C
)
ïïC D
)
ïïD E
.
ññ 
Where
ññ 
(
ññ 
c
ññ 
=>
ññ 
c
ññ  !
.
ññ! "
Suit
ññ" &
==
ññ' )
CardSuit
ññ* 2
.
ññ2 3
Special
ññ3 :
)
ññ: ;
.
óó 
Select
óó 
(
óó 
c
óó 
=>
óó  
c
óó! "
.
óó" #
SpecialSymbol
óó# 0
)
óó0 1
)
óó1 2
;
óó2 3
if
ôô 
(
ôô 
context
ôô 
.
ôô 
WinningPlay
ôô #
.
ôô# $
Card
ôô$ (
.
ôô( )
Suit
ôô) -
==
ôô. 0
CardSuit
ôô1 9
.
ôô9 :
Special
ôô: A
)
ôôA B
{
öö 

wonSymbols
õõ 
.
õõ 
Add
õõ 
(
õõ 
context
õõ &
.
õõ& '
WinningPlay
õõ' 2
.
õõ2 3
Card
õõ3 7
.
õõ7 8
SpecialSymbol
õõ8 E
)
õõE F
;
õõF G
}
úú 
return
ûû 

wonSymbols
ûû 
.
ûû 
Count
ûû #
;
ûû# $
}
üü 	
private
°° 
static
°° 
int
°° 
GetTricksWon
°° '
(
°°' (!
IReadOnlyDictionary
°°( ;
<
°°; <
int
°°< ?
,
°°? @
int
°°A D
>
°°D E
tricksBySeat
°°F R
,
°°R S
int
°°T W
seat
°°X \
)
°°\ ]
{
¢¢ 	
if
££ 
(
££ 
tricksBySeat
££ 
!=
££ 
null
££  $
&&
££% '
tricksBySeat
££( 4
.
££4 5
TryGetValue
££5 @
(
££@ A
seat
££A E
,
££E F
out
££G J
int
££K N
count
££O T
)
££T U
)
££U V
{
§§ 
return
•• 
count
•• 
;
•• 
}
¶¶ 
return
®® 
$num
®® 
;
®® 
}
©© 	
}
™™ 
}´´ Êt
tC:\Users\oscar\source\repos\TrickTakingMissions\Server\ServerTrickTakingMissions\Domain\Match\Setup\DeckDealRules.cs
	namespace 	
Domain
 
{		 
public 

static 
class 
DeckDealRules %
{ 
private 
const 
int 
NormalDeckCardCount -
=. /
$num0 2
;2 3
public 
static 
IReadOnlyList #
<# $
Card$ (
>( )
ShuffleDeck* 5
(5 6
IReadOnlyList6 C
<C D
CardD H
>H I
deckJ N
,N O
RandomP V
randomGeneratorW f
)f g
{ 	
if 
( 
deck 
is 
null 
) 
{ 
throw 
new !
ArgumentNullException /
(/ 0
nameof0 6
(6 7
deck7 ;
); <
)< =
;= >
} 
if 
( 
randomGenerator 
is  "
null# '
)' (
{ 
throw 
new !
ArgumentNullException /
(/ 0
nameof0 6
(6 7
randomGenerator7 F
)F G
)G H
;H I
} 
var 
shuffledCards 
= 
new  #
List$ (
<( )
Card) -
>- .
(. /
deck/ 3
)3 4
;4 5
for 
( 
int 
currentIndex !
=" #
shuffledCards$ 1
.1 2
Count2 7
-8 9
$num: ;
;; <
currentIndex= I
>J K
$numL M
;M N
currentIndexO [
--[ ]
)] ^
{   
int!! 
	swapIndex!! 
=!! 
randomGenerator!!  /
.!!/ 0
Next!!0 4
(!!4 5
currentIndex!!5 A
+!!B C
$num!!D E
)!!E F
;!!F G
Card"" 
displacedCard"" "
=""# $
shuffledCards""% 2
[""2 3
currentIndex""3 ?
]""? @
;""@ A
shuffledCards## 
[## 
currentIndex## *
]##* +
=##, -
shuffledCards##. ;
[##; <
	swapIndex##< E
]##E F
;##F G
shuffledCards$$ 
[$$ 
	swapIndex$$ '
]$$' (
=$$) *
displacedCard$$+ 8
;$$8 9
}%% 
return'' 
shuffledCards''  
.''  !

AsReadOnly''! +
(''+ ,
)'', -
;''- .
}(( 	
public** 
static** 
MissionDeal** !
	DealCards**" +
(**+ ,
IReadOnlyList**, 9
<**9 :
Card**: >
>**> ?
shuffledDeck**@ L
,**L M
int**N Q
playerCount**R ]
,**] ^
int++ )
firstSpecialCardReceivingSeat++ -
=++. /
$num++0 1
)++1 2
{,, 	
if-- 
(-- 
shuffledDeck-- 
is-- 
null--  $
)--$ %
{.. 
throw// 
new// !
ArgumentNullException// /
(/// 0
nameof//0 6
(//6 7
shuffledDeck//7 C
)//C D
)//D E
;//E F
}00 
if22 
(22 
shuffledDeck22 
.22 
Count22 "
!=22# %
	DeckRules22& /
.22/ 0
TotalDeckSize220 =
)22= >
{33 
throw44 
new44 '
ArgumentOutOfRangeException44 5
(445 6
nameof446 <
(44< =
shuffledDeck44= I
)44I J
)44J K
;44K L
}55 
if77 
(77 
!77 !
MatchPlayerCountRules77 &
.77& '"
IsPlayerCountSupported77' =
(77= >
playerCount77> I
)77I J
)77J K
{88 
throw99 
new99 '
ArgumentOutOfRangeException99 5
(995 6
nameof996 <
(99< =
playerCount99= H
)99H I
)99I J
;99J K
}:: 
if<< 
(<< )
firstSpecialCardReceivingSeat<< -
<<<. /
$num<<0 1
||<<2 4)
firstSpecialCardReceivingSeat<<5 R
>=<<S U
playerCount<<V a
)<<a b
{== 
throw>> 
new>> '
ArgumentOutOfRangeException>> 5
(>>5 6
nameof>>6 <
(>>< =)
firstSpecialCardReceivingSeat>>= Z
)>>Z [
)>>[ \
;>>\ ]
}?? 
ListAA 
<AA 
ListAA 
<AA 
CardAA 
>AA 
>AA 
handsBySeatAA (
=AA) *
CreateEmptyHandsAA+ ;
(AA; <
playerCountAA< G
)AAG H
;AAH I
byteBB 
captainSeatBB 
=BB 
$numBB  
;BB  !
boolCC 
hasCaptainCardCC 
=CC  !
falseCC" '
;CC' ( 
ValidateOfficialDeckDD  
(DD  !
shuffledDeckDD! -
)DD- .
;DD. /
ListEE 
<EE 
CardEE 
>EE 
separatedDeckEE $
=EE% &
shuffledDeckEE' 3
.EE3 4
WhereEE4 9
(EE9 :
cardEE: >
=>EE? A
cardEEB F
.EEF G
SuitEEG K
!=EEL N
CardSuitEEO W
.EEW X
SpecialEEX _
)EE_ `
.FF 
ConcatFF 
(FF 
shuffledDeckFF $
.FF$ %
WhereFF% *
(FF* +
cardFF+ /
=>FF0 2
cardFF3 7
.FF7 8
SuitFF8 <
==FF= ?
CardSuitFF@ H
.FFH I
SpecialFFI P
)FFP Q
)FFQ R
.FFR S
ToListFFS Y
(FFY Z
)FFZ [
;FF[ \
forGG 
(GG 
intGG 
	cardIndexGG 
=GG  
$numGG! "
;GG" #
	cardIndexGG$ -
<GG. /
separatedDeckGG0 =
.GG= >
CountGG> C
;GGC D
	cardIndexGGE N
++GGN P
)GGP Q
{HH 
CardII 
	dealtCardII 
=II  
separatedDeckII! .
[II. /
	cardIndexII/ 8
]II8 9
;II9 :
intJJ 
receivingSeatJJ !
=JJ" #"
GetReceivingPlayerSeatJJ$ :
(JJ: ;
	cardIndexJJ; D
,JJD E
playerCountJJF Q
,JJQ R)
firstSpecialCardReceivingSeatJJS p
)JJp q
;JJq r
handsBySeatKK 
[KK 
receivingSeatKK )
]KK) *
.KK* +
AddKK+ .
(KK. /
	dealtCardKK/ 8
)KK8 9
;KK9 :
ifMM 
(MM 
IsCaptainCardMM !
(MM! "
	dealtCardMM" +
)MM+ ,
)MM, -
{NN 
captainSeatOO 
=OO  !
(OO" #
byteOO# '
)OO' (
receivingSeatOO( 5
;OO5 6
hasCaptainCardPP "
=PP# $
truePP% )
;PP) *
}QQ 
}RR 
ifTT 
(TT 
!TT 
hasCaptainCardTT 
)TT  
{UU 
throwVV 
newVV 
ArgumentExceptionVV +
(VV+ ,
nameofVV, 2
(VV2 3
shuffledDeckVV3 ?
)VV? @
)VV@ A
;VVA B
}WW 
returnYY 
newYY 
MissionDealYY "
{ZZ 
HandsBySeat[[ 
=[[ 
ToReadOnlyHands[[ -
([[- .
handsBySeat[[. 9
)[[9 :
,[[: ;
CaptainSeat\\ 
=\\ 
captainSeat\\ )
,\\) * 
TotalTricksInMission]] $
=]]% &
	DeckRules]]' 0
.]]0 1
TotalDeckSize]]1 >
/]]? @
playerCount]]A L
}^^ 
;^^ 
}__ 	
privateaa 
staticaa 
intaa "
GetReceivingPlayerSeataa 1
(aa1 2
intaa2 5
dealtCardIndexaa6 D
,aaD E
intaaF I
participantCountaaJ Z
,aaZ [
intbb )
firstSpecialCardReceivingSeatbb -
)bb- .
{cc 	
intdd 
receivingPlayerSeatdd #
=dd$ %
dealtCardIndexdd& 4
%dd5 6
participantCountdd7 G
;ddG H
ifee 
(ee 
dealtCardIndexee 
>=ee !
NormalDeckCardCountee" 5
)ee5 6
{ff 
receivingPlayerSeatgg #
=gg$ %
(gg& '
dealtCardIndexgg' 5
-gg6 7
NormalDeckCardCountgg8 K
+ggL M)
firstSpecialCardReceivingSeatggN k
)ggk l
%hh 
participantCounthh &
;hh& '
}ii 
returnjj 
receivingPlayerSeatjj &
;jj& '
}kk 	
privatemm 
staticmm 
voidmm  
ValidateOfficialDeckmm 0
(mm0 1
IReadOnlyListmm1 >
<mm> ?
Cardmm? C
>mmC D
shuffledDeckmmE Q
)mmQ R
{nn 	
ifoo 
(oo 
shuffledDeckoo 
.oo 
Anyoo  
(oo  !
cardoo! %
=>oo& (
cardoo) -
==oo. 0
nulloo1 5
)oo5 6
||oo7 9
shuffledDeckpp 
.pp 
Selectpp #
(pp# $
cardpp$ (
=>pp) +
cardpp, 0
.pp0 1
IdCardpp1 7
)pp7 8
.pp8 9
Distinctpp9 A
(ppA B
)ppB C
.ppC D
CountppD I
(ppI J
)ppJ K
!=ppL N
	DeckRulesppO X
.ppX Y
TotalDeckSizeppY f
||ppg i
shuffledDeckqq 
.qq 
Anyqq  
(qq  !
cardqq! %
=>qq& (
!qq) *
IsOfficialCardqq* 8
(qq8 9
cardqq9 =
)qq= >
)qq> ?
)qq? @
{rr 
throwss 
newss 
ArgumentExceptionss +
(ss+ ,
nameofss, 2
(ss2 3
shuffledDeckss3 ?
)ss? @
)ss@ A
;ssA B
}tt 
}uu 	
privateww 
staticww 
Listww 
<ww 
Listww  
<ww  !
Cardww! %
>ww% &
>ww& '
CreateEmptyHandsww( 8
(ww8 9
intww9 <
playerCountww= H
)wwH I
{xx 	
varyy 

emptyHandsyy 
=yy 
newyy  
Listyy! %
<yy% &
Listyy& *
<yy* +
Cardyy+ /
>yy/ 0
>yy0 1
(yy1 2
playerCountyy2 =
)yy= >
;yy> ?
for{{ 
({{ 
int{{ 
seat{{ 
={{ 
$num{{ 
;{{ 
seat{{ #
<{{$ %
playerCount{{& 1
;{{1 2
seat{{3 7
++{{7 9
){{9 :
{|| 

emptyHands}} 
.}} 
Add}} 
(}} 
new}} "
List}}# '
<}}' (
Card}}( ,
>}}, -
(}}- .
)}}. /
)}}/ 0
;}}0 1
}~~ 
return
ÄÄ 

emptyHands
ÄÄ 
;
ÄÄ 
}
ÅÅ 	
private
ÉÉ 
static
ÉÉ 
IReadOnlyList
ÉÉ $
<
ÉÉ$ %
IReadOnlyList
ÉÉ% 2
<
ÉÉ2 3
Card
ÉÉ3 7
>
ÉÉ7 8
>
ÉÉ8 9
ToReadOnlyHands
ÉÉ: I
(
ÉÉI J
List
ÉÉJ N
<
ÉÉN O
List
ÉÉO S
<
ÉÉS T
Card
ÉÉT X
>
ÉÉX Y
>
ÉÉY Z
handsBySeat
ÉÉ[ f
)
ÉÉf g
{
ÑÑ 	
var
ÖÖ 
readOnlyHands
ÖÖ 
=
ÖÖ 
new
ÖÖ  #
List
ÖÖ$ (
<
ÖÖ( )
IReadOnlyList
ÖÖ) 6
<
ÖÖ6 7
Card
ÖÖ7 ;
>
ÖÖ; <
>
ÖÖ< =
(
ÖÖ= >
handsBySeat
ÖÖ> I
.
ÖÖI J
Count
ÖÖJ O
)
ÖÖO P
;
ÖÖP Q
foreach
ÜÜ 
(
ÜÜ 
List
ÜÜ 
<
ÜÜ 
Card
ÜÜ 
>
ÜÜ 
hand
ÜÜ  $
in
ÜÜ% '
handsBySeat
ÜÜ( 3
)
ÜÜ3 4
{
áá 
readOnlyHands
àà 
.
àà 
Add
àà !
(
àà! "
hand
àà" &
.
àà& '

AsReadOnly
àà' 1
(
àà1 2
)
àà2 3
)
àà3 4
;
àà4 5
}
ââ 
return
ãã 
readOnlyHands
ãã  
.
ãã  !

AsReadOnly
ãã! +
(
ãã+ ,
)
ãã, -
;
ãã- .
}
åå 	
private
éé 
static
éé 
bool
éé 
IsOfficialCard
éé *
(
éé* +
Card
éé+ /
card
éé0 4
)
éé4 5
{
èè 	
Card
êê 
officialCard
êê 
=
êê 
card
êê  $
.
êê$ %
IdCard
êê% +
>=
êê, .
$num
êê/ 0
&&
êê1 3
card
êê4 8
.
êê8 9
IdCard
êê9 ?
<=
êê@ B
	DeckRules
êêC L
.
êêL M
TotalDeckSize
êêM Z
?
ëë 
	DeckRules
ëë 
.
ëë 
GetCardById
ëë '
(
ëë' (
card
ëë( ,
.
ëë, -
IdCard
ëë- 3
)
ëë3 4
:
ëë5 6
null
ëë7 ;
;
ëë; <
return
íí 
officialCard
íí 
!=
íí  "
null
íí# '
&&
íí( *
card
íí+ /
.
íí/ 0
Suit
íí0 4
==
íí5 7
officialCard
íí8 D
.
ííD E
Suit
ííE I
&&
ííJ L
card
ìì 
.
ìì 
Number
ìì 
==
ìì 
officialCard
ìì +
.
ìì+ ,
Number
ìì, 2
&&
ìì3 5
card
ìì6 :
.
ìì: ;
SpecialSymbol
ìì; H
==
ììI K
officialCard
ììL X
.
ììX Y
SpecialSymbol
ììY f
;
ììf g
}
îî 	
private
ññ 
static
ññ 
bool
ññ 
IsCaptainCard
ññ )
(
ññ) *
Card
ññ* .
card
ññ/ 3
)
ññ3 4
{
óó 	
return
òò 
card
òò 
.
òò 
Suit
òò 
==
òò 
CardSuit
òò  (
.
òò( )
Special
òò) 0
&&
òò1 3
card
òò4 8
.
òò8 9
SpecialSymbol
òò9 F
==
òòG I
SpecialCardSymbol
òòJ [
.
òò[ \
Spade
òò\ a
;
òòa b
}
ôô 	
}
öö 
}õõ è˜
çC:\Users\oscar\source\repos\TrickTakingMissions\Server\ServerTrickTakingMissions\Domain\Match\Evaluation\MissionEvaluationRules.Objectives.cs
	namespace 	
Domain
 
{ 
public		 

static		 
partial		 
class		 "
MissionEvaluationRules		  6
{

 
private 
static 
void %
ValidateEvaluationContext 5
(5 6$
MissionEvaluationContext6 N
contextO V
)V W
{ 	
if 
( 
context 
== 
null 
)  
{ 
throw 
new !
ArgumentNullException /
(/ 0
nameof0 6
(6 7
context7 >
)> ?
)? @
;@ A
} 
if 
( 
context 
. 

Definition "
==# %
null& *
||+ -
context. 5
.5 6
WinningPlay6 A
==B D
nullE I
||J L
context 
. 
CompletedTrickPlays +
==, .
null/ 3
||4 6
context7 >
.> ?
CurrentObjectives? P
==Q S
nullT X
)X Y
{ 
throw 
new 
ArgumentException +
(+ ,
nameof, 2
(2 3
context3 :
): ;
); <
;< =
} *
ValidateRequiredWonTrickCounts *
(* +
context+ 2
)2 3
;3 4
bool 
isTrickNumberValid #
=$ %
context& -
.- .
CurrentTrickNumber. @
>=A C
$numD E
&&F H
context 
. 
CurrentTrickNumber *
<=+ -
context. 5
.5 6 
TotalTricksInMission6 J
;J K
bool !
isWinningPlayIncluded &
=' (
context) 0
.0 1
CompletedTrickPlays1 D
.D E
ContainsE M
(M N
contextN U
.U V
WinningPlayV a
)a b
;b c
if 
( 
! 
isTrickNumberValid #
||$ &
!' (!
isWinningPlayIncluded( =
)= >
{ 
throw 
new 
ArgumentException +
(+ ,
nameof, 2
(2 3
context3 :
): ;
); <
;< =
} 
} 	
private   
static   
void   *
ValidateRequiredWonTrickCounts   :
(  : ;$
MissionEvaluationContext  ; S
context  T [
)  [ \
{!! 	
if"" 
("" -
!IsWonTrickCountValidationRequired"" 1
(""1 2
context""2 9
.""9 :

Definition"": D
.""D E
SpecialRule""E P
)""P Q
)""Q R
{## 
if$$ 
($$ 
!$$ !
MatchPlayerCountRules$$ *
.$$* +"
IsPlayerCountSupported$$+ A
($$A B
context$$B I
.$$I J
PlayerCount$$J U
)$$U V
||$$W Y
context%% 
.%%  
TotalTricksWonBySeat%% 0
==%%1 3
null%%4 8
||%%9 ;
context&& 
.&&  
TotalTricksWonBySeat&& 0
.&&0 1
Count&&1 6
!=&&7 9
context&&: A
.&&A B
PlayerCount&&B M
)&&M N
{'' 
throw(( 
new(( 
ArgumentException(( /
(((/ 0
nameof((0 6
(((6 7
context((7 >
.((> ? 
TotalTricksWonBySeat((? S
)((S T
)((T U
;((U V
})) (
ValidateCompletedTrickCounts** ,
(**, -
context**- 4
)**4 5
;**5 6
}++ 
},, 	
private.. 
static.. 
bool.. -
!IsWonTrickCountValidationRequired.. =
(..= >"
SpecialMissionRuleType..> T
specialRule..U `
)..` a
{// 	
return00 
specialRule00 
==00 !"
SpecialMissionRuleType00" 8
.008 9%
M05_OnePlayerWinsNoTricks009 R
||00S U
specialRule11 
==11 "
SpecialMissionRuleType11 5
.115 6%
M29_MaxTrickDifferenceTwo116 O
||11P R
specialRule22 
==22 "
SpecialMissionRuleType22 5
.225 6C
7M33_SelectedPlayerWinsExactlyOneTrickWithoutSpecialCard226 m
||22n p
specialRule33 
==33 "
SpecialMissionRuleType33 5
.335 6?
3M34_CaptainWinsFirstAndLastTrickAndMaxDifferenceTwo336 i
||33j l
specialRule44 
==44 "
SpecialMissionRuleType44 5
.445 6I
=M41_SelectedPlayerWinsOnlyFirstAndLastTrickWithoutSpecialCard446 s
||44t v
specialRule55 
==55 "
SpecialMissionRuleType55 5
.555 6*
M50_SplitTrickWinsDistribution556 T
;55T U
}66 	
private88 
static88 
void88 (
ValidateCompletedTrickCounts88 8
(888 9$
MissionEvaluationContext889 Q
context88R Y
)88Y Z
{99 	
bool:: 
hasInvalidCount::  
=::! "
context::# *
.::* + 
TotalTricksWonBySeat::+ ?
.::? @
Any::@ C
(::C D
entry::D I
=>::J L
entry;; 
.;; 
Key;; 
<;; 
$num;; 
||;;  
entry;;! &
.;;& '
Key;;' *
>=;;+ -
context;;. 5
.;;5 6
PlayerCount;;6 A
||;;B D
entry;;E J
.;;J K
Value;;K P
<;;Q R
$num;;S T
);;T U
;;;U V
long<< 
countedTricks<< 
=<<  
context<<! (
.<<( ) 
TotalTricksWonBySeat<<) =
.<<= >
Sum<<> A
(<<A B
entry<<B G
=><<H J
(<<K L
long<<L P
)<<P Q
entry<<Q V
.<<V W
Value<<W \
)<<\ ]
;<<] ^
bool== !
hasCountedWinningSeat== &
===' (
context==) 0
.==0 1 
TotalTricksWonBySeat==1 E
.==E F
TryGetValue==F Q
(==Q R
context==R Y
.==Y Z
WinningPlay==Z e
.==e f
Seat==f j
,==j k
out>> 
int>> !
winningSeatTrickCount>> -
)>>- .
&&>>/ 1!
winningSeatTrickCount>>2 G
>>>H I
$num>>J K
;>>K L
if?? 
(?? 
hasInvalidCount?? 
||??  "
countedTricks??# 0
!=??1 3
context??4 ;
.??; <
CurrentTrickNumber??< N
||??O Q
!??R S!
hasCountedWinningSeat??S h
)??h i
{@@ 
throwAA 
newAA 
ArgumentExceptionAA +
(AA+ ,
nameofAA, 2
(AA2 3
contextAA3 :
.AA: ; 
TotalTricksWonBySeatAA; O
)AAO P
)AAP Q
;AAQ R
}BB 
}CC 	
privateEE 
staticEE #
MissionEvaluationResultEE .%
EvaluateObjectivesInTrickEE/ H
(EEH I$
MissionEvaluationContextFF $
contextFF% ,
,FF, -
ListFF. 2
<FF2 3
MissionObjectiveFF3 C
>FFC D
updatedObjectivesFFE V
)FFV W
{GG 	
MissionObjectiveHH 
[HH 
]HH 
capturedObjectivesHH 1
=HH2 3
updatedObjectivesHH4 E
.HHE F
WhereHHF K
(HHK L
	objectiveHHL U
=>HHV X
	objectiveII 
.II 
StatusII  
==II! #
ObjectiveStatusII$ 3
.II3 4
PendingII4 ;
&&II< >
contextII? F
.IIF G
CompletedTrickPlaysIIG Z
.IIZ [
AnyII[ ^
(II^ _
playII_ c
=>IId f
playJJ 
.JJ 
CardJJ 
.JJ 
IdCardJJ $
==JJ% '
	objectiveJJ( 1
.JJ1 2
CardIdJJ2 8
)JJ8 9
)JJ9 :
.JJ: ;
ToArrayJJ; B
(JJB C
)JJC D
;JJD E
MissionObjectiveKK 
wrongCaptureKK )
=KK* +
capturedObjectivesKK, >
.KK> ?
FirstOrDefaultKK? M
(KKM N
	objectiveKKN W
=>KKX Z
	objectiveLL 
.LL 
AssignedSeatLL &
!=LL' )
contextLL* 1
.LL1 2
WinningPlayLL2 =
.LL= >
SeatLL> B
)LLB C
;LLC D#
MissionEvaluationResultMM #
missionEvaluationMM$ 5
=MM6 7
nullMM8 <
;MM< =
ifNN 
(NN 
wrongCaptureNN 
!=NN 
nullNN  $
)NN$ %
{OO 
missionEvaluationPP !
=PP" #
FailObjectivePP$ 1
(PP1 2
updatedObjectivesPP2 C
,PPC D
wrongCapturePPE Q
.PPQ R
CardIdPPR X
,PPX Y!
MissionFailureReasonsQQ )
.QQ) *(
ObjectiveCapturedByWrongSeatQQ* F
)QQF G
;QQG H
}RR 
ifSS 
(SS 
missionEvaluationSS !
==SS" $
nullSS% )
)SS) *
{TT 
missionEvaluationUU !
=UU" #0
$ValidateSimultaneousCaptureConflictsUU$ H
(UUH I
capturedObjectivesUUI [
,UU[ \
updatedObjectivesUU] n
)UUn o
;UUo p
}VV 
ifWW 
(WW 
missionEvaluationWW !
==WW" $
nullWW% )
)WW) *
{XX 
missionEvaluationYY !
=YY" ##
ValidateOrderPrecedenceYY$ ;
(YY; <
contextYY< C
,YYC D
capturedObjectivesYYE W
,YYW X
updatedObjectivesYYY j
)YYj k
;YYk l
}ZZ 
if[[ 
([[ 
missionEvaluation[[ !
==[[" $
null[[% )
)[[) *
{\\ $
ApplyCompletedObjectives]] (
(]]( )
context]]) 0
.]]0 1
CurrentTrickNumber]]1 C
,]]C D
capturedObjectives]]E W
,]]W X
updatedObjectives]]Y j
)]]j k
;]]k l
}^^ 
return__ 
missionEvaluation__ $
;__$ %
}`` 	
privatebb 
staticbb #
MissionEvaluationResultbb .0
$ValidateSimultaneousCaptureConflictsbb/ S
(bbS T
IReadOnlyListcc 
<cc 
MissionObjectivecc *
>cc* +
capturedObjectivescc, >
,cc> ?
Listcc@ D
<ccD E
MissionObjectiveccE U
>ccU V
updatedObjectivesccW h
)cch i
{dd 	#
MissionEvaluationResultee #
missionEvaluationee$ 5
=ee6 7
nullee8 <
;ee< =
ifff 
(ff 
capturedObjectivesff "
.ff" #
Countff# (
>ff) *
$numff+ ,
)ff, -
{gg 
MissionObjectivehh  
numericObjectivehh! 1
=hh2 3
capturedObjectiveshh4 F
.hhF G
FirstOrDefaulthhG U
(hhU V
IsNumericObjectivehhV h
)hhh i
;hhi j
MissionObjectiveii  
[ii  !
]ii! "
arrowObjectivesii# 2
=ii3 4
capturedObjectivesii5 G
.iiG H
WhereiiH M
(iiM N
IsArrowObjectiveiiN ^
)ii^ _
.ii_ `
ToArrayii` g
(iig h
)iih i
;iii j
MissionObjectivejj  
omegaObjectivejj! /
=jj0 1
capturedObjectivesjj2 D
.jjD E
FirstOrDefaultjjE S
(jjS T
	objectivejjT ]
=>jj^ `
	objectivekk 
.kk 
Tokenkk #
==kk$ &
ObjectiveTokenTypekk' 9
.kk9 :
Omegakk: ?
)kk? @
;kk@ A
ifll 
(ll 
numericObjectivell $
!=ll% '
nullll( ,
)ll, -
{mm 
missionEvaluationnn %
=nn& '
FailObjectivenn( 5
(nn5 6
updatedObjectivesnn6 G
,nnG H
numericObjectivennI Y
.nnY Z
CardIdnnZ `
,nn` a!
MissionFailureReasonsoo -
.oo- .,
 MultipleOrderedTokensInSameTrickoo. N
)ooN O
;ooO P
}pp 
ifqq 
(qq 
missionEvaluationqq %
==qq& (
nullqq) -
&&qq. 0
arrowObjectivesqq1 @
.qq@ A
LengthqqA G
>qqH I
$numqqJ K
)qqK L
{rr 
missionEvaluationss %
=ss& '
FailObjectivess( 5
(ss5 6
updatedObjectivesss6 G
,ssG H
arrowObjectivesssI X
[ssX Y
$numssY Z
]ssZ [
.ss[ \
CardIdss\ b
,ssb c!
MissionFailureReasonstt -
.tt- .*
MultipleArrowTokensInSameTricktt. L
)ttL M
;ttM N
}uu 
ifvv 
(vv 
missionEvaluationvv %
==vv& (
nullvv) -
&&vv. 0
omegaObjectivevv1 ?
!=vv@ B
nullvvC G
)vvG H
{ww 
missionEvaluationxx %
=xx& '
FailObjectivexx( 5
(xx5 6
updatedObjectivesxx6 G
,xxG H
omegaObjectivexxI W
.xxW X
CardIdxxX ^
,xx^ _!
MissionFailureReasonsyy -
.yy- .'
OmegaSimultaneousCompletionyy. I
)yyI J
;yyJ K
}zz 
}{{ 
return|| 
missionEvaluation|| $
;||$ %
}}} 	
private 
static #
MissionEvaluationResult .#
ValidateOrderPrecedence/ F
(F G$
MissionEvaluationContextG _
context` g
,g h
IReadOnlyList
ÄÄ 
<
ÄÄ 
MissionObjective
ÄÄ *
>
ÄÄ* + 
capturedObjectives
ÄÄ, >
,
ÄÄ> ?
List
ÄÄ@ D
<
ÄÄD E
MissionObjective
ÄÄE U
>
ÄÄU V
updatedObjectives
ÄÄW h
)
ÄÄh i
{
ÅÅ 	
int
ÇÇ %
completedObjectiveCount
ÇÇ '
=
ÇÇ( )
updatedObjectives
ÇÇ* ;
.
ÇÇ; <
Count
ÇÇ< A
(
ÇÇA B
	objective
ÇÇB K
=>
ÇÇL N
	objective
ÉÉ 
.
ÉÉ 
Status
ÉÉ  
==
ÉÉ! #
ObjectiveStatus
ÉÉ$ 3
.
ÉÉ3 4
	Completed
ÉÉ4 =
)
ÉÉ= >
;
ÉÉ> ?%
MissionEvaluationResult
ÑÑ #
missionEvaluation
ÑÑ$ 5
=
ÑÑ6 7.
 ValidateReservedNumericPositions
ÑÑ8 X
(
ÑÑX Y 
capturedObjectives
ÖÖ "
,
ÖÖ" #
updatedObjectives
ÖÖ$ 5
,
ÖÖ5 6%
completedObjectiveCount
ÖÖ7 N
)
ÖÖN O
;
ÖÖO P
foreach
ÜÜ 
(
ÜÜ 
MissionObjective
ÜÜ %
capturedObjective
ÜÜ& 7
in
ÜÜ8 : 
capturedObjectives
ÜÜ; M
)
ÜÜM N
{
áá 
if
àà 
(
àà 
missionEvaluation
àà %
==
àà& (
null
àà) -
)
àà- .
{
ââ 
missionEvaluation
ää %
=
ää& '*
ValidateNumericTokenPosition
ää( D
(
ääD E
capturedObjective
ãã )
,
ãã) *%
completedObjectiveCount
ãã+ B
,
ããB C
updatedObjectives
ããD U
)
ããU V
;
ããV W
if
åå 
(
åå 
missionEvaluation
åå )
==
åå* ,
null
åå- 1
)
åå1 2
{
çç 
missionEvaluation
éé )
=
éé* +#
ValidateRelativeToken
éé, A
(
ééA B
context
ééB I
,
ééI J
capturedObjective
ééK \
,
éé\ ]
updatedObjectives
éé^ o
)
ééo p
;
éép q
}
èè 
}
êê 
}
ëë 
return
íí 
missionEvaluation
íí $
;
íí$ %
}
ìì 	
private
ïï 
static
ïï %
MissionEvaluationResult
ïï ..
 ValidateReservedNumericPositions
ïï/ O
(
ïïO P
IReadOnlyList
ññ 
<
ññ 
MissionObjective
ññ *
>
ññ* + 
capturedObjectives
ññ, >
,
ññ> ?
List
ññ@ D
<
ññD E
MissionObjective
ññE U
>
ññU V
updatedObjectives
ññW h
,
ññh i
int
óó %
completedObjectiveCount
óó '
)
óó' (
{
òò 	
int
ôô %
finalCompletionPosition
ôô '
=
ôô( )%
completedObjectiveCount
ôô* A
+
ôôB C 
capturedObjectives
ôôD V
.
ôôV W
Count
ôôW \
;
ôô\ ]
MissionObjective
öö  
displacedObjective
öö /
=
öö0 1
updatedObjectives
öö2 C
.
ööC D
FirstOrDefault
ööD R
(
ööR S
	objective
ööS \
=>
öö] _ 
IsNumericObjective
õõ "
(
õõ" #
	objective
õõ# ,
)
õõ, -
&&
õõ. 0
	objective
õõ1 :
.
õõ: ;
Status
õõ; A
==
õõB D
ObjectiveStatus
õõE T
.
õõT U
Pending
õõU \
&&
õõ] _
(
úú 
int
úú 
)
úú 
	objective
úú 
.
úú 
Token
úú $
>
úú% &%
completedObjectiveCount
úú' >
&&
úú? A
(
úúB C
int
úúC F
)
úúF G
	objective
úúG P
.
úúP Q
Token
úúQ V
<=
úúW Y%
finalCompletionPosition
úúZ q
&&
úúr t
!
ùù  
capturedObjectives
ùù #
.
ùù# $
Contains
ùù$ ,
(
ùù, -
	objective
ùù- 6
)
ùù6 7
)
ùù7 8
;
ùù8 9%
MissionEvaluationResult
ûû #
missionEvaluation
ûû$ 5
=
ûû6 7
null
ûû8 <
;
ûû< =
if
üü 
(
üü  
displacedObjective
üü "
!=
üü# %
null
üü& *
)
üü* +
{
†† 
missionEvaluation
°° !
=
°°" #
FailObjective
°°$ 1
(
°°1 2
updatedObjectives
°°2 C
,
°°C D 
displacedObjective
°°E W
.
°°W X
CardId
°°X ^
,
°°^ _#
MissionFailureReasons
¢¢ )
.
¢¢) *-
PrecedingOrderTokenNotCompleted
¢¢* I
)
¢¢I J
;
¢¢J K
}
££ 
return
§§ 
missionEvaluation
§§ $
;
§§$ %
}
•• 	
private
ßß 
static
ßß %
MissionEvaluationResult
ßß .*
ValidateNumericTokenPosition
ßß/ K
(
ßßK L
MissionObjective
ßßL \
capturedObjective
ßß] n
,
ßßn o
int
®® %
completedObjectiveCount
®® '
,
®®' (
List
®®) -
<
®®- .
MissionObjective
®®. >
>
®®> ?
updatedObjectives
®®@ Q
)
®®Q R
{
©© 	
int
™™  
completionPosition
™™ "
=
™™# $%
completedObjectiveCount
™™% <
+
™™= >
$num
™™? @
;
™™@ A
bool
´´ &
isNumericPositionInvalid
´´ )
=
´´* + 
IsNumericObjective
´´, >
(
´´> ?
capturedObjective
´´? P
)
´´P Q
&&
´´R T
(
¨¨ 
int
¨¨ 
)
¨¨ 
capturedObjective
¨¨ &
.
¨¨& '
Token
¨¨' ,
!=
¨¨- / 
completionPosition
¨¨0 B
;
¨¨B C
MissionObjective
≠≠ 
reservedObjective
≠≠ .
=
≠≠/ 0
updatedObjectives
≠≠1 B
.
≠≠B C
FirstOrDefault
≠≠C Q
(
≠≠Q R
	objective
≠≠R [
=>
≠≠\ ^ 
IsNumericObjective
ÆÆ "
(
ÆÆ" #
	objective
ÆÆ# ,
)
ÆÆ, -
&&
ÆÆ. 0
(
ÆÆ1 2
int
ÆÆ2 5
)
ÆÆ5 6
	objective
ÆÆ6 ?
.
ÆÆ? @
Token
ÆÆ@ E
==
ÆÆF H 
completionPosition
ÆÆI [
&&
ÆÆ\ ^
	objective
ØØ 
.
ØØ 
Status
ØØ  
!=
ØØ! #
ObjectiveStatus
ØØ$ 3
.
ØØ3 4
	Completed
ØØ4 =
)
ØØ= >
;
ØØ> ?
bool
∞∞ %
isReservedPositionTaken
∞∞ (
=
∞∞) *
!
∞∞+ , 
IsNumericObjective
∞∞, >
(
∞∞> ?
capturedObjective
∞∞? P
)
∞∞P Q
&&
∞∞R T
reservedObjective
∞∞U f
!=
∞∞g i
null
∞∞j n
;
∞∞n o%
MissionEvaluationResult
±± #
missionEvaluation
±±$ 5
=
±±6 7
null
±±8 <
;
±±< =
if
≤≤ 
(
≤≤ &
isNumericPositionInvalid
≤≤ (
||
≤≤) +%
isReservedPositionTaken
≤≤, C
)
≤≤C D
{
≥≥ 
int
¥¥ 
failedCardId
¥¥  
=
¥¥! "%
isReservedPositionTaken
¥¥# :
?
¥¥; <
reservedObjective
¥¥= N
.
¥¥N O
CardId
¥¥O U
:
¥¥V W
capturedObjective
¥¥X i
.
¥¥i j
CardId
¥¥j p
;
¥¥p q
missionEvaluation
µµ !
=
µµ" #
FailObjective
µµ$ 1
(
µµ1 2
updatedObjectives
µµ2 C
,
µµC D
failedCardId
µµE Q
,
µµQ R#
MissionFailureReasons
∂∂ )
.
∂∂) *-
PrecedingOrderTokenNotCompleted
∂∂* I
)
∂∂I J
;
∂∂J K
}
∑∑ 
return
∏∏ 
missionEvaluation
∏∏ $
;
∏∏$ %
}
ππ 	
private
ªª 
static
ªª %
MissionEvaluationResult
ªª .#
ValidateRelativeToken
ªª/ D
(
ªªD E&
MissionEvaluationContext
ªªE ]
context
ªª^ e
,
ªªe f
MissionObjective
ºº 
capturedObjective
ºº .
,
ºº. /
List
ºº0 4
<
ºº4 5
MissionObjective
ºº5 E
>
ººE F
updatedObjectives
ººG X
)
ººX Y
{
ΩΩ 	%
MissionEvaluationResult
ææ #
missionEvaluation
ææ$ 5
=
ææ6 7
null
ææ8 <
;
ææ< =
if
øø 
(
øø 
IsArrowObjective
øø  
(
øø  !
capturedObjective
øø! 2
)
øø2 3
)
øø3 4
{
¿¿ 
bool
¡¡ #
hasPendingPredecessor
¡¡ *
=
¡¡+ ,
updatedObjectives
¡¡- >
.
¡¡> ?
Any
¡¡? B
(
¡¡B C
	objective
¡¡C L
=>
¡¡M O
IsArrowObjective
¡¡P `
(
¡¡` a
	objective
¡¡a j
)
¡¡j k
&&
¡¡l n
	objective
¬¬ 
.
¬¬ 
Token
¬¬ #
<
¬¬$ %
capturedObjective
¬¬& 7
.
¬¬7 8
Token
¬¬8 =
&&
¬¬> @
	objective
¬¬A J
.
¬¬J K
Status
¬¬K Q
!=
¬¬R T
ObjectiveStatus
¬¬U d
.
¬¬d e
	Completed
¬¬e n
)
¬¬n o
;
¬¬o p
if
√√ 
(
√√ #
hasPendingPredecessor
√√ )
)
√√) *
{
ƒƒ 
missionEvaluation
≈≈ %
=
≈≈& '
FailObjective
≈≈( 5
(
≈≈5 6
updatedObjectives
≈≈6 G
,
≈≈G H
capturedObjective
≈≈I Z
.
≈≈Z [
CardId
≈≈[ a
,
≈≈a b#
MissionFailureReasons
∆∆ -
.
∆∆- .-
PrecedingArrowTokenNotCompleted
∆∆. M
)
∆∆M N
;
∆∆N O
}
«« 
}
»» 
else
…… 
if
…… 
(
…… 
capturedObjective
…… &
.
……& '
Token
……' ,
==
……- / 
ObjectiveTokenType
……0 B
.
……B C
Omega
……C H
)
……H I
{
   
missionEvaluation
ÀÀ !
=
ÀÀ" #%
ValidateOmegaPrecedence
ÀÀ$ ;
(
ÀÀ; <
context
ÀÀ< C
,
ÀÀC D
capturedObjective
ÀÀE V
,
ÀÀV W
updatedObjectives
ÀÀX i
)
ÀÀi j
;
ÀÀj k
}
ÃÃ 
return
ÕÕ 
missionEvaluation
ÕÕ $
;
ÕÕ$ %
}
ŒŒ 	
private
–– 
static
–– 
bool
––  
IsNumericObjective
–– .
(
––. /
MissionObjective
––/ ?
	objective
––@ I
)
––I J
{
—— 	
return
““ 
	objective
““ 
.
““ 
Token
““ "
>=
““# % 
ObjectiveTokenType
““& 8
.
““8 9
OrderOne
““9 A
&&
““B D
	objective
““E N
.
““N O
Token
““O T
<=
““U W 
ObjectiveTokenType
““X j
.
““j k
	OrderFive
““k t
;
““t u
}
”” 	
private
’’ 
static
’’ 
bool
’’ 
IsArrowObjective
’’ ,
(
’’, -
MissionObjective
’’- =
	objective
’’> G
)
’’G H
{
÷÷ 	
return
◊◊ 
	objective
◊◊ 
.
◊◊ 
Token
◊◊ "
>=
◊◊# % 
ObjectiveTokenType
◊◊& 8
.
◊◊8 9
ArrowOne
◊◊9 A
&&
◊◊B D
	objective
◊◊E N
.
◊◊N O
Token
◊◊O T
<=
◊◊U W 
ObjectiveTokenType
◊◊X j
.
◊◊j k
	ArrowFour
◊◊k t
;
◊◊t u
}
ÿÿ 	
private
⁄⁄ 
static
⁄⁄ %
MissionEvaluationResult
⁄⁄ .%
ValidateOmegaPrecedence
⁄⁄/ F
(
⁄⁄F G&
MissionEvaluationContext
⁄⁄G _
context
⁄⁄` g
,
⁄⁄g h
MissionObjective
€€ 
capturedObjective
€€ .
,
€€. /
List
€€0 4
<
€€4 5
MissionObjective
€€5 E
>
€€E F
updatedObjectives
€€G X
)
€€X Y
{
‹‹ 	%
MissionEvaluationResult
›› #
missionEvaluation
››$ 5
=
››6 7
null
››8 <
;
››< =
bool
ﬁﬁ &
hasOtherPendingObjective
ﬁﬁ )
=
ﬁﬁ* +
updatedObjectives
ﬁﬁ, =
.
ﬁﬁ= >
Any
ﬁﬁ> A
(
ﬁﬁA B
	objective
ﬁﬁB K
=>
ﬁﬁL N
	objective
ﬂﬂ 
.
ﬂﬂ 
CardId
ﬂﬂ  
!=
ﬂﬂ! #
capturedObjective
ﬂﬂ$ 5
.
ﬂﬂ5 6
CardId
ﬂﬂ6 <
&&
ﬂﬂ= ?
	objective
ﬂﬂ@ I
.
ﬂﬂI J
Status
ﬂﬂJ P
!=
ﬂﬂQ S
ObjectiveStatus
ﬂﬂT c
.
ﬂﬂc d
	Completed
ﬂﬂd m
)
ﬂﬂm n
;
ﬂﬂn o
if
‡‡ 
(
‡‡ &
hasOtherPendingObjective
‡‡ (
)
‡‡( )
{
·· 
missionEvaluation
‚‚ !
=
‚‚" #
FailObjective
‚‚$ 1
(
‚‚1 2
updatedObjectives
‚‚2 C
,
‚‚C D
capturedObjective
‚‚E V
.
‚‚V W
CardId
‚‚W ]
,
‚‚] ^#
MissionFailureReasons
„„ )
.
„„) *,
OmegaObjectiveNotCompletedLast
„„* H
)
„„H I
;
„„I J
}
‰‰ 
else
ÂÂ 
if
ÂÂ 
(
ÂÂ 
context
ÂÂ 
.
ÂÂ 

Definition
ÂÂ '
.
ÂÂ' (
SpecialRule
ÂÂ( 3
==
ÂÂ4 6$
SpecialMissionRuleType
ÂÂ7 M
.
ÂÂM N4
&M48_OmegaObjectiveCompletedInLastTrick
ÂÂN t
&&
ÂÂu w
context
ÊÊ 
.
ÊÊ  
CurrentTrickNumber
ÊÊ *
!=
ÊÊ+ -
context
ÊÊ. 5
.
ÊÊ5 6"
TotalTricksInMission
ÊÊ6 J
)
ÊÊJ K
{
ÁÁ 
missionEvaluation
ËË !
=
ËË" #
FailObjective
ËË$ 1
(
ËË1 2
updatedObjectives
ËË2 C
,
ËËC D
capturedObjective
ËËE V
.
ËËV W
CardId
ËËW ]
,
ËË] ^#
MissionFailureReasons
ÈÈ )
.
ÈÈ) **
Mission48OmegaNotInLastTrick
ÈÈ* F
)
ÈÈF G
;
ÈÈG H
}
ÍÍ 
return
ÎÎ 
missionEvaluation
ÎÎ $
;
ÎÎ$ %
}
ÏÏ 	
private
ÓÓ 
static
ÓÓ %
MissionEvaluationResult
ÓÓ .
FailObjective
ÓÓ/ <
(
ÓÓ< =
List
ÓÓ= A
<
ÓÓA B
MissionObjective
ÓÓB R
>
ÓÓR S
updatedObjectives
ÓÓT e
,
ÓÓe f
int
ÔÔ 
failedCardId
ÔÔ 
,
ÔÔ 
string
ÔÔ $
failureReason
ÔÔ% 2
)
ÔÔ2 3
{
 	
int
ÒÒ 
objectiveIndex
ÒÒ 
=
ÒÒ  
updatedObjectives
ÒÒ! 2
.
ÒÒ2 3
	FindIndex
ÒÒ3 <
(
ÒÒ< =
	objective
ÒÒ= F
=>
ÒÒG I
	objective
ÒÒJ S
.
ÒÒS T
CardId
ÒÒT Z
==
ÒÒ[ ]
failedCardId
ÒÒ^ j
)
ÒÒj k
;
ÒÒk l
if
ÚÚ 
(
ÚÚ 
objectiveIndex
ÚÚ 
>=
ÚÚ !
$num
ÚÚ" #
)
ÚÚ# $
{
ÛÛ 
updatedObjectives
ÙÙ !
[
ÙÙ! "
objectiveIndex
ÙÙ" 0
]
ÙÙ0 1
=
ÙÙ2 3
updatedObjectives
ÙÙ4 E
[
ÙÙE F
objectiveIndex
ÙÙF T
]
ÙÙT U
with
ÙÙV Z
{
ıı 
Status
ˆˆ 
=
ˆˆ 
ObjectiveStatus
ˆˆ ,
.
ˆˆ, -
Failed
ˆˆ- 3
}
˜˜ 
;
˜˜ 
}
¯¯ 
return
˘˘ %
MissionEvaluationResult
˘˘ *
.
˘˘* +
Fail
˘˘+ /
(
˘˘/ 0
updatedObjectives
˘˘0 A
,
˘˘A B
failureReason
˘˘C P
)
˘˘P Q
;
˘˘Q R
}
˙˙ 	
private
¸¸ 
static
¸¸ 
void
¸¸ &
ApplyCompletedObjectives
¸¸ 4
(
¸¸4 5
int
¸¸5 8"
completedTrickNumber
¸¸9 M
,
¸¸M N
IReadOnlyList
˝˝ 
<
˝˝ 
MissionObjective
˝˝ *
>
˝˝* + 
capturedObjectives
˝˝, >
,
˝˝> ?
List
˝˝@ D
<
˝˝D E
MissionObjective
˝˝E U
>
˝˝U V
updatedObjectives
˝˝W h
)
˝˝h i
{
˛˛ 	
foreach
ˇˇ 
(
ˇˇ 
MissionObjective
ˇˇ %
capturedObjective
ˇˇ& 7
in
ˇˇ8 : 
capturedObjectives
ˇˇ; M
)
ˇˇM N
{
ÄÄ 
int
ÅÅ 
objectiveIndex
ÅÅ "
=
ÅÅ# $
updatedObjectives
ÅÅ% 6
.
ÅÅ6 7
	FindIndex
ÅÅ7 @
(
ÅÅ@ A
	objective
ÅÅA J
=>
ÅÅK M
	objective
ÇÇ 
.
ÇÇ 
CardId
ÇÇ $
==
ÇÇ% '
capturedObjective
ÇÇ( 9
.
ÇÇ9 :
CardId
ÇÇ: @
)
ÇÇ@ A
;
ÇÇA B
updatedObjectives
ÉÉ !
[
ÉÉ! "
objectiveIndex
ÉÉ" 0
]
ÉÉ0 1
=
ÉÉ2 3
capturedObjective
ÉÉ4 E
with
ÉÉF J
{
ÑÑ 
Status
ÖÖ 
=
ÖÖ 
ObjectiveStatus
ÖÖ ,
.
ÖÖ, -
	Completed
ÖÖ- 6
,
ÖÖ6 7$
CompletedAtTrickNumber
ÜÜ *
=
ÜÜ+ ,"
completedTrickNumber
ÜÜ- A
}
áá 
;
áá 
}
àà 
}
ââ 	
}
ää 
}ãã ªu
ÉC:\Users\oscar\source\repos\TrickTakingMissions\Server\ServerTrickTakingMissions\Domain\Match\Evaluation\MissionEvaluationResult.cs
	namespace 	
Domain
 
{ 
public 

sealed 
record #
MissionEvaluationResult 0
{ 
public  
MissionAttemptStatus #
OverallStatus$ 1
{2 3
get4 7
;7 8
init9 =
;= >
}? @
public 
IReadOnlyList 
< 
MissionObjective -
>- .
UpdatedObjectives/ @
{A B
getC F
;F G
initH L
;L M
}N O
public 
string 
Message 
{ 
get  #
;# $
init% )
;) *
}+ ,
public (
MissionEvaluationFailureCode +
FailureCode, 7
{8 9
get: =
;= >
init? C
;C D
}E F
private 
static 
readonly 
IReadOnlyDictionary  3
<3 4
string4 :
,: ;(
MissionEvaluationFailureCode< X
>X Y
s_failureCodesZ h
=i j
new 

Dictionary 
< 
string !
,! "(
MissionEvaluationFailureCode# ?
>? @
{ 
{ !
MissionFailureReasons '
.' ((
ObjectiveCapturedByWrongSeat( D
,D E(
MissionEvaluationFailureCode 0
.0 1(
ObjectiveCapturedByWrongSeat1 M
}N O
,O P
{ !
MissionFailureReasons '
.' (,
 MultipleOrderedTokensInSameTrick( H
,H I(
MissionEvaluationFailureCode 0
.0 1,
 MultipleOrderedTokensInSameTrick1 Q
}R S
,S T
{ !
MissionFailureReasons '
.' (*
MultipleArrowTokensInSameTrick( F
,F G(
MissionEvaluationFailureCode 0
.0 1*
MultipleArrowTokensInSameTrick1 O
}P Q
,Q R
{ !
MissionFailureReasons '
.' ('
OmegaSimultaneousCompletion( C
,C D(
MissionEvaluationFailureCode 0
.0 1'
OmegaSimultaneousCompletion1 L
}M N
,N O
{   !
MissionFailureReasons   '
.  ' (+
PrecedingOrderTokenNotCompleted  ( G
,  G H(
MissionEvaluationFailureCode!! 0
.!!0 1+
PrecedingOrderTokenNotCompleted!!1 P
}!!Q R
,!!R S
{"" !
MissionFailureReasons"" '
.""' (+
PrecedingArrowTokenNotCompleted""( G
,""G H(
MissionEvaluationFailureCode## 0
.##0 1+
PrecedingArrowTokenNotCompleted##1 P
}##Q R
,##R S
{$$ !
MissionFailureReasons$$ '
.$$' (*
OmegaObjectiveNotCompletedLast$$( F
,$$F G(
MissionEvaluationFailureCode%% 0
.%%0 1*
OmegaObjectiveNotCompletedLast%%1 O
}%%P Q
,%%Q R
{&& !
MissionFailureReasons&& '
.&&' (,
 ObjectivesIncompleteAtMissionEnd&&( H
,&&H I(
MissionEvaluationFailureCode'' 0
.''0 1,
 ObjectivesIncompleteAtMissionEnd''1 Q
}''R S
,''S T
{(( !
MissionFailureReasons(( '
.((' ((
Mission48OmegaNotInLastTrick((( D
,((D E(
MissionEvaluationFailureCode)) 0
.))0 1(
Mission48OmegaNotInLastTrick))1 M
}))N O
,))O P
{** !
MissionFailureReasons** '
.**' (&
Mission09NoTrickWonWithOne**( B
,**B C(
MissionEvaluationFailureCode++ 0
.++0 1#
NormalOneDidNotWinTrick++1 H
}++I J
,++J K
{,, !
MissionFailureReasons,, '
.,,' ()
Mission13SpecialCardLostTrick,,( E
,,,E F(
MissionEvaluationFailureCode-- 0
.--0 1 
SpecialCardLostTrick--1 E
}--F G
,--G H
{.. !
MissionFailureReasons.. '
...' (*
Mission13NotAllSpecialCardsWon..( F
,..F G(
MissionEvaluationFailureCode// 0
.//0 12
&SpecialCardsDidNotWinAllRequiredTricks//1 W
}//X Y
,//Y Z
{00 !
MissionFailureReasons00 '
.00' (%
Mission16TrickWonWithNine00( A
,00A B(
MissionEvaluationFailureCode00C _
.00_ `
NormalNineWonTrick00` r
}00s t
,00t u
{11 !
MissionFailureReasons11 '
.11' ('
Mission05AllPlayersWonTrick11( C
,11C D(
MissionEvaluationFailureCode22 0
.220 1-
!AllParticipantsWonAtLeastOneTrick221 R
}22S T
,22T U
{33 !
MissionFailureReasons33 '
.33' (,
 Mission26LessTwoTricksWonWithOne33( H
,33H I(
MissionEvaluationFailureCode44 0
.440 1.
"InsufficientNormalOneWinningTricks441 S
}44T U
,44U V
{55 !
MissionFailureReasons55 '
.55' (,
 Mission29TrickDifferenceExceeded55( H
,55H I(
MissionEvaluationFailureCode66 0
.660 1&
WonTrickDifferenceExceeded661 K
}66L M
,66M N
{77 !
MissionFailureReasons77 '
.77' (#
Mission33RoleUnassigned77( ?
,77? @(
MissionEvaluationFailureCode88 0
.880 1'
SingleTrickWinnerUnassigned881 L
}88M N
,88N O
{99 !
MissionFailureReasons99 '
.99' ('
Mission33WonWithSpecialCard99( C
,99C D(
MissionEvaluationFailureCode:: 0
.::0 11
%SelectedParticipantWonWithSpecialCard::1 V
}::W X
,::X Y
{;; !
MissionFailureReasons;; '
.;;' (&
Mission33WonMultipleTricks;;( B
,;;B C(
MissionEvaluationFailureCode<< 0
.<<0 10
$SelectedParticipantWonMultipleTricks<<1 U
}<<V W
,<<W X
{== !
MissionFailureReasons== '
.==' (-
!Mission33DidNotWinExactlyOneTrick==( I
,==I J(
MissionEvaluationFailureCode>> 0
.>>0 17
+SelectedParticipantDidNotWinExactlyOneTrick>>1 \
}>>] ^
,>>^ _
{?? !
MissionFailureReasons?? '
.??' (/
#Mission34CaptainDidNotWinFirstTrick??( K
,??K L(
MissionEvaluationFailureCode@@ 0
.@@0 1&
CaptainDidNotWinFirstTrick@@1 K
}@@L M
,@@M N
{AA !
MissionFailureReasonsAA '
.AA' (.
"Mission34CaptainDidNotWinLastTrickAA( J
,AAJ K(
MissionEvaluationFailureCodeBB 0
.BB0 1%
CaptainDidNotWinLastTrickBB1 J
}BBK L
,BBL M
{CC !
MissionFailureReasonsCC '
.CC' (#
Mission41RoleUnassignedCC( ?
,CC? @(
MissionEvaluationFailureCodeDD 0
.DD0 1(
FirstAndLastWinnerUnassignedDD1 M
}DDN O
,DDO P
{EE !
MissionFailureReasonsEE '
.EE' (/
#Mission41FirstTrickNotWonBySelectedEE( K
,EEK L(
MissionEvaluationFailureCodeFF 0
.FF0 1+
FirstTrickWonByWrongParticipantFF1 P
}FFQ R
,FFR S
{GG !
MissionFailureReasonsGG '
.GG' (-
!Mission41FirstTrickWonWithSpecialGG( I
,GGI J(
MissionEvaluationFailureCodeHH 0
.HH0 1(
FirstTrickWonWithSpecialCardHH1 M
}HHN O
,HHO P
{II !
MissionFailureReasonsII '
.II' (3
'Mission41IntermediateTrickWonBySelectedII( O
,IIO P(
MissionEvaluationFailureCodeJJ 0
.JJ0 15
)IntermediateTrickWonBySelectedParticipantJJ1 Z
}JJ[ \
,JJ\ ]
{KK !
MissionFailureReasonsKK '
.KK' (.
"Mission41LastTrickNotWonBySelectedKK( J
,KKJ K(
MissionEvaluationFailureCodeLL 0
.LL0 1*
LastTrickWonByWrongParticipantLL1 O
}LLP Q
,LLQ R
{MM !
MissionFailureReasonsMM '
.MM' (,
 Mission41LastTrickWonWithSpecialMM( H
,MMH I(
MissionEvaluationFailureCodeNN 0
.NN0 1'
LastTrickWonWithSpecialCardNN1 L
}NNM N
,NNN O
{OO !
MissionFailureReasonsOO '
.OO' ()
Mission44SpecialOrderViolatedOO( E
,OOE F(
MissionEvaluationFailureCodePP 0
.PP0 1+
SpecialCardWinningOrderViolatedPP1 P
}PPQ R
,PPR S
{QQ !
MissionFailureReasonsQQ '
.QQ' (*
Mission46HeartNineUnidentifiedQQ( F
,QQF G(
MissionEvaluationFailureCodeRR 0
.RR0 1&
HeartNineOwnerUnidentifiedRR1 K
}RRL M
,RRM N
{SS !
MissionFailureReasonsSS '
.SS' (-
!Mission46HeartCapturedByWrongSeatSS( I
,SSI J(
MissionEvaluationFailureCodeTT 0
.TT0 1+
HeartCapturedByWrongParticipantTT1 P
}TTQ R
,TTR S
{UU !
MissionFailureReasonsUU '
.UU' (%
Mission46HeartsIncompleteUU( A
,UUA B(
MissionEvaluationFailureCodeVV 0
.VV0 1$
HeartCardsNotAllCapturedVV1 I
}VVJ K
,VVK L
{WW !
MissionFailureReasonsWW '
.WW' ($
Mission50RolesUnassignedWW( @
,WW@ A(
MissionEvaluationFailureCodeXX 0
.XX0 1'
TrickDistributionUnassignedXX1 L
}XXM N
,XXN O
{YY !
MissionFailureReasonsYY '
.YY' (/
#Mission50FirstFourTricksWrongWinnerYY( K
,YYK L(
MissionEvaluationFailureCodeZZ 0
.ZZ0 1.
"InitialTricksWonByWrongParticipantZZ1 S
}ZZT U
,ZZU V
{[[ !
MissionFailureReasons[[ '
.[[' (,
 Mission50FirstFourWinnerWonExtra[[( H
,[[H I(
MissionEvaluationFailureCode\\ 0
.\\0 1&
InitialTrickWinnerWonExtra\\1 K
}\\L M
,\\M N
{]] !
MissionFailureReasons]] '
.]]' (,
 Mission50LastTrickWinnerWonEarly]]( H
,]]H I(
MissionEvaluationFailureCode^^ 0
.^^0 1$
FinalTrickWinnerWonEarly^^1 I
}^^J K
,^^K L
{__ !
MissionFailureReasons__ '
.__' ()
Mission50LastTrickWrongWinner__( E
,__E F(
MissionEvaluationFailureCode`` 0
.``0 1+
FinalTrickWonByWrongParticipant``1 P
}``Q R
,``R S
{aa !
MissionFailureReasonsaa '
.aa' (.
"Mission50RemainingPlayerWonNoTrickaa( J
,aaJ K(
MissionEvaluationFailureCodebb 0
.bb0 1*
RemainingParticipantWonNoTrickbb1 O
}bbP Q
,bbQ R
{cc !
MissionFailureReasonscc '
.cc' (3
'Mission48PendingNonOmegaBeforeLastTrickcc( O
,ccO P(
MissionEvaluationFailureCodedd 0
.dd0 13
'Mission48PendingNonOmegaBeforeLastTrickdd1 X
}ddY Z
}ee 
;ee 
publicgg 
staticgg #
MissionEvaluationResultgg -
Successgg. 5
(gg5 6
IReadOnlyListgg6 C
<ggC D
MissionObjectiveggD T
>ggT U

objectivesggV `
,gg` a
stringggb h
messageggi p
=ggq r
nullggs w
)ggw x
{hh 	
returnii 
newii #
MissionEvaluationResultii .
{jj 
OverallStatuskk 
=kk  
MissionAttemptStatuskk  4
.kk4 5
	Succeededkk5 >
,kk> ?
UpdatedObjectivesll !
=ll" #

objectivesll$ .
.ll. /
ToArrayll/ 6
(ll6 7
)ll7 8
,ll8 9
Messagemm 
=mm 
messagemm !
}nn 
;nn 
}oo 	
publicqq 
staticqq #
MissionEvaluationResultqq -

InProgressqq. 8
(qq8 9
IReadOnlyListqq9 F
<qqF G
MissionObjectiveqqG W
>qqW X

objectivesqqY c
,qqc d
stringqqe k
messageqql s
=qqt u
nullqqv z
)qqz {
{rr 	
returnss 
newss #
MissionEvaluationResultss .
{tt 
OverallStatusuu 
=uu  
MissionAttemptStatusuu  4
.uu4 5

InProgressuu5 ?
,uu? @
UpdatedObjectivesvv !
=vv" #

objectivesvv$ .
.vv. /
ToArrayvv/ 6
(vv6 7
)vv7 8
,vv8 9
Messageww 
=ww 
messageww !
}xx 
;xx 
}yy 	
public{{ 
static{{ #
MissionEvaluationResult{{ -
Fail{{. 2
({{2 3
IReadOnlyList{{3 @
<{{@ A
MissionObjective{{A Q
>{{Q R

objectives{{S ]
,{{] ^
string{{_ e
reason{{f l
){{l m
{|| 	
return}} 
new}} #
MissionEvaluationResult}} .
{~~ 
OverallStatus 
=  
MissionAttemptStatus  4
.4 5
Failed5 ;
,; <
UpdatedObjectives
ÄÄ !
=
ÄÄ" #

objectives
ÄÄ$ .
.
ÄÄ. /
ToArray
ÄÄ/ 6
(
ÄÄ6 7
)
ÄÄ7 8
,
ÄÄ8 9
FailureCode
ÅÅ 
=
ÅÅ 
GetFailureCode
ÅÅ ,
(
ÅÅ, -
reason
ÅÅ- 3
)
ÅÅ3 4
,
ÅÅ4 5
Message
ÇÇ 
=
ÇÇ 
reason
ÇÇ  
}
ÉÉ 
;
ÉÉ 
}
ÑÑ 	
private
ÖÖ 
static
ÖÖ *
MissionEvaluationFailureCode
ÖÖ 3
GetFailureCode
ÖÖ4 B
(
ÖÖB C
string
ÖÖC I
failureReason
ÖÖJ W
)
ÖÖW X
{
ÜÜ 	*
MissionEvaluationFailureCode
áá (
failureCode
áá) 4
=
áá5 6*
MissionEvaluationFailureCode
áá7 S
.
ááS T&
SpecialMissionConstraint
ááT l
;
áál m
if
àà 
(
àà 
failureReason
àà 
!=
àà  
null
àà! %
&&
àà& (
s_failureCodes
àà) 7
.
àà7 8
TryGetValue
àà8 C
(
ààC D
failureReason
ààD Q
,
ààQ R
out
ààS V
var
ààW Z
knownFailureCode
àà[ k
)
ààk l
)
ààl m
{
ââ 
failureCode
ää 
=
ää 
knownFailureCode
ää .
;
ää. /
}
ãã 
return
åå 
failureCode
åå 
;
åå 
}
çç 	
}
éé 
}èè ¬
àC:\Users\oscar\source\repos\TrickTakingMissions\Server\ServerTrickTakingMissions\Domain\Match\Evaluation\MissionEvaluationFailureCode.cs
	namespace 	
Domain
 
{ 
public 

enum (
MissionEvaluationFailureCode ,
{ 
None 
= 
$num 
, (
ObjectiveCapturedByWrongSeat $
=% &
$num' (
,( ),
 MultipleOrderedTokensInSameTrick (
=) *
$num+ ,
,, -*
MultipleArrowTokensInSameTrick		 &
=		' (
$num		) *
,		* +'
OmegaSimultaneousCompletion

 #
=

$ %
$num

& '
,

' (+
PrecedingOrderTokenNotCompleted '
=( )
$num* +
,+ ,+
PrecedingArrowTokenNotCompleted '
=( )
$num* +
,+ ,*
OmegaObjectiveNotCompletedLast &
=' (
$num) *
,* +,
 ObjectivesIncompleteAtMissionEnd (
=) *
$num+ ,
,, -(
Mission48OmegaNotInLastTrick $
=% &
$num' (
,( )3
'Mission48PendingNonOmegaBeforeLastTrick /
=0 1
$num2 4
,4 5$
SpecialMissionConstraint  
=! "
$num# %
,% &-
!AllParticipantsWonAtLeastOneTrick )
=* +
$num, .
,. /#
NormalOneDidNotWinTrick 
=  !
$num" $
,$ % 
SpecialCardLostTrick 
= 
$num !
,! "2
&SpecialCardsDidNotWinAllRequiredTricks .
=/ 0
$num1 3
,3 4
NormalNineWonTrick 
= 
$num 
,  .
"InsufficientNormalOneWinningTricks *
=+ ,
$num- /
,/ 0&
WonTrickDifferenceExceeded "
=# $
$num% '
,' ('
SingleTrickWinnerUnassigned #
=$ %
$num& (
,( )1
%SelectedParticipantWonWithSpecialCard -
=. /
$num0 2
,2 30
$SelectedParticipantWonMultipleTricks ,
=- .
$num/ 1
,1 27
+SelectedParticipantDidNotWinExactlyOneTrick 3
=4 5
$num6 8
,8 9&
CaptainDidNotWinFirstTrick "
=# $
$num% '
,' (%
CaptainDidNotWinLastTrick !
=" #
$num$ &
,& '(
FirstAndLastWinnerUnassigned $
=% &
$num' )
,) *+
FirstTrickWonByWrongParticipant   '
=  ( )
$num  * ,
,  , -(
FirstTrickWonWithSpecialCard!! $
=!!% &
$num!!' )
,!!) *5
)IntermediateTrickWonBySelectedParticipant"" 1
=""2 3
$num""4 6
,""6 7*
LastTrickWonByWrongParticipant## &
=##' (
$num##) +
,##+ ,'
LastTrickWonWithSpecialCard$$ #
=$$$ %
$num$$& (
,$$( )+
SpecialCardWinningOrderViolated%% '
=%%( )
$num%%* ,
,%%, -&
HeartNineOwnerUnidentified&& "
=&&# $
$num&&% '
,&&' (+
HeartCapturedByWrongParticipant'' '
=''( )
$num''* ,
,'', -$
HeartCardsNotAllCaptured((  
=((! "
$num((# %
,((% &'
TrickDistributionUnassigned)) #
=))$ %
$num))& (
,))( ).
"InitialTricksWonByWrongParticipant** *
=**+ ,
$num**- /
,**/ 0&
InitialTrickWinnerWonExtra++ "
=++# $
$num++% '
,++' ($
FinalTrickWinnerWonEarly,,  
=,,! "
$num,,# %
,,,% &+
FinalTrickWonByWrongParticipant-- '
=--( )
$num--* ,
,--, -*
RemainingParticipantWonNoTrick.. &
=..' (
$num..) +
}// 
}00 ê
ÑC:\Users\oscar\source\repos\TrickTakingMissions\Server\ServerTrickTakingMissions\Domain\Match\Evaluation\MissionEvaluationContext.cs
	namespace 	
Domain
 
{ 
public		 

sealed		 
record		 $
MissionEvaluationContext		 1
{

 
public 
MissionDefinition  

Definition! +
{, -
get. 1
;1 2
init3 7
;7 8
}9 :
public 
int  
TotalTricksInMission '
{( )
get* -
;- .
init/ 3
;3 4
}5 6
public 
int 
CurrentTrickNumber %
{& '
get( +
;+ ,
init- 1
;1 2
}3 4
public 
TrickCardPlay 
WinningPlay (
{) *
get+ .
;. /
init0 4
;4 5
}6 7
public 
IReadOnlyList 
< 
TrickCardPlay *
>* +
CompletedTrickPlays, ?
{@ A
getB E
;E F
initG K
;K L
}M N
public 
IReadOnlyList 
< 
MissionObjective -
>- .
CurrentObjectives/ @
{A B
getC F
;F G
initH L
;L M
}N O
public 
IReadOnlyDictionary "
<" #
int# &
,& '
int( +
>+ , 
TotalTricksWonBySeat- A
{B C
getD G
;G H
initI M
;M N
}O P
public 
IReadOnlyList 
< 
Card !
>! " 
SpecialCardsWonSoFar# 7
{8 9
get: =
;= >
init? C
;C D
}E F
public 
int '
TricksWonWithNormalOneCount .
{/ 0
get1 4
;4 5
init6 :
;: ;
}< =
public $
MissionRoleConfiguration '

RoleConfig( 2
{3 4
get5 8
;8 9
init: >
;> ?
}@ A
public 
int "
CapturedHeartCardCount )
{* +
get, /
;/ 0
init1 5
;5 6
}7 8
public!! 
byte!! 
?!! 
HeartNineOwnerSeat!! '
{!!( )
get!!* -
;!!- .
init!!/ 3
;!!3 4
}!!5 6
public## 
byte## 
CaptainSeat## 
{##  !
get##" %
;##% &
init##' +
;##+ ,
}##- .
public%% 
int%% 
PlayerCount%% 
{%%  
get%%! $
;%%$ %
init%%& *
;%%* +
}%%, -
}&& 
}'' ¥P
}C:\Users\oscar\source\repos\TrickTakingMissions\Server\ServerTrickTakingMissions\Domain\Match\Distress\DistressSignalRules.cs
	namespace 	
Domain
 
{ 
public 

static 
class 
DistressSignalRules +
{ 
private 
const 
int 
FirstTrickNumber *
=+ ,
$num- .
;. /
public 
static 
bool $
CanExecuteDistressSignal 3
(3 4!
DistressSignalContext4 I
contextJ Q
)Q R
{ 	
if 
( 
context 
is 
null 
||  "
!# $%
AreTimingPrerequisitesMet$ =
(= >
context> E
)E F
)F G
{ 
return 
false 
; 
} 
if 
( 
context 
. 
HandsBySeat #
is$ &
null' +
||, .
context/ 6
.6 7"
SelectedPassCardBySeat7 M
isN P
nullQ U
)U V
{ 
return 
false 
; 
}   
int"" 
playerCount"" 
="" 
context"" %
.""% &
HandsBySeat""& 1
.""1 2
Count""2 7
;""7 8
if## 
(## 
!## !
MatchPlayerCountRules## &
.##& '"
IsPlayerCountSupported##' =
(##= >
playerCount##> I
)##I J
||##K M
context$$ 
.$$ "
SelectedPassCardBySeat$$ .
.$$. /
Count$$/ 4
!=$$5 7
playerCount$$8 C
)$$C D
{%% 
return&& 
false&& 
;&& 
}'' 
return)) 

Enumerable)) 
.)) 
Range)) #
())# $
$num))$ %
,))% &
playerCount))' 2
)))2 3
.** 
All** 
(** 
seat** 
=>**  
IsValidPassSelection** 1
(**1 2
context++ 
.++ 
HandsBySeat++ '
[++' (
seat++( ,
]++, -
,++- .
context++/ 6
.++6 7"
SelectedPassCardBySeat++7 M
,++M N
(++O P
byte++P T
)++T U
seat++U Y
)++Y Z
)++Z [
;++[ \
},, 	
public77 
static77 
IReadOnlyList77 #
<77# $
IReadOnlyList77$ 1
<771 2
Card772 6
>776 7
>777 8
ExecuteCardPass779 H
(77H I!
DistressSignalContext77I ^
context77_ f
)77f g
{88 	
if99 
(99 
context99 
is99 
null99 
)99  
{:: 
throw;; 
new;; !
ArgumentNullException;; /
(;;/ 0
nameof;;0 6
(;;6 7
context;;7 >
);;> ?
);;? @
;;;@ A
}<< 
if>> 
(>> 
!>> $
CanExecuteDistressSignal>> )
(>>) *
context>>* 1
)>>1 2
)>>2 3
{?? 
throw@@ 
new@@ %
InvalidOperationException@@ 3
(@@3 4
$str@@4 n
)@@n o
;@@o p
}AA 
intCC 
playerCountCC 
=CC 
contextCC %
.CC% &
HandsBySeatCC& 1
.CC1 2
CountCC2 7
;CC7 8
ListDD 
<DD 
ListDD 
<DD 
CardDD 
>DD 
>DD 
updatedHandsDD )
=DD* +
newDD, /
ListDD0 4
<DD4 5
ListDD5 9
<DD9 :
CardDD: >
>DD> ?
>DD? @
(DD@ A
playerCountDDA L
)DDL M
;DDM N
forFF 
(FF 
intFF 
seatFF 
=FF 
$numFF 
;FF 
seatFF #
<FF$ %
playerCountFF& 1
;FF1 2
seatFF3 7
++FF7 9
)FF9 :
{GG 
CardHH 
	passedOutHH 
=HH  
contextHH! (
.HH( )"
SelectedPassCardBySeatHH) ?
[HH? @
(HH@ A
byteHHA E
)HHE F
seatHHF J
]HHJ K
;HHK L
ListII 
<II 
CardII 
>II 
remainingCardsII )
=II* +
contextII, 3
.II3 4
HandsBySeatII4 ?
[II? @
seatII@ D
]IID E
.JJ 
WhereJJ 
(JJ 
cardJJ 
=>JJ  "
cardJJ# '
.JJ' (
IdCardJJ( .
!=JJ/ 1
	passedOutJJ2 ;
.JJ; <
IdCardJJ< B
)JJB C
.KK 
ToListKK 
(KK 
)KK 
;KK 
updatedHandsLL 
.LL 
AddLL  
(LL  !
remainingCardsLL! /
)LL/ 0
;LL0 1
}MM 
forOO 
(OO 
intOO 

senderSeatOO 
=OO  !
$numOO" #
;OO# $

senderSeatOO% /
<OO0 1
playerCountOO2 =
;OO= >

senderSeatOO? I
++OOI K
)OOK L
{PP 
intQQ 
receiverSeatQQ  
=QQ! " 
ResolveReceivingSeatQQ# 7
(QQ7 8

senderSeatQQ8 B
,QQB C
playerCountQQD O
,QQO P
contextQQQ X
.QQX Y
AgreedDirectionQQY h
)QQh i
;QQi j
CardRR 

passedCardRR 
=RR  !
contextRR" )
.RR) *"
SelectedPassCardBySeatRR* @
[RR@ A
(RRA B
byteRRB F
)RRF G

senderSeatRRG Q
]RRQ R
;RRR S
updatedHandsSS 
[SS 
receiverSeatSS )
]SS) *
.SS* +
AddSS+ .
(SS. /

passedCardSS/ 9
)SS9 :
;SS: ;
}TT 
returnVV 
updatedHandsVV 
.VV  
SelectVV  &
(VV& '
handVV' +
=>VV, .
(VV/ 0
IReadOnlyListVV0 =
<VV= >
CardVV> B
>VVB C
)VVC D
handVVD H
.VVH I

AsReadOnlyVVI S
(VVS T
)VVT U
)VVU V
.VVV W
ToListVVW ]
(VV] ^
)VV^ _
.VV_ `

AsReadOnlyVV` j
(VVj k
)VVk l
;VVl m
}WW 	
privateYY 
staticYY 
boolYY %
AreTimingPrerequisitesMetYY 5
(YY5 6!
DistressSignalContextYY6 K
contextYYL S
)YYS T
{ZZ 	
bool[[ 
isBeforeFirstTrick[[ #
=[[$ %
context[[& -
.[[- .
CurrentTrickNumber[[. @
<=[[A C
FirstTrickNumber[[D T
&&[[U W
![[X Y
context[[Y `
.[[` a
IsTrickInProgress[[a r
;[[r s
bool\\ 
isNotYetUsed\\ 
=\\ 
!\\  !
context\\! (
.\\( )!
HasUsedDistressSignal\\) >
&&\\? A
!\\B C
context\\C J
.\\J K$
HasAnyPlayerCommunicated\\K c
;\\c d
bool]] 
hasValidDirection]] "
=]]# $
context]]% ,
.]], -
AgreedDirection]]- <
==]]= ?
PassDirection]]@ M
.]]M N
Left]]N R
||]]S U
context^^% ,
.^^, -
AgreedDirection^^- <
==^^= ?
PassDirection^^@ M
.^^M N
Right^^N S
;^^S T
return`` 
isBeforeFirstTrick`` %
&&``& (
isNotYetUsed``) 5
&&``6 8
hasValidDirection``9 J
;``J K
}aa 	
privatecc 
staticcc 
boolcc  
IsValidPassSelectioncc 0
(cc0 1
IReadOnlyListdd 
<dd 
Carddd 
>dd 
handdd  $
,dd$ %
IReadOnlyDictionaryee 
<ee  
byteee  $
,ee$ %
Cardee& *
>ee* +

selectionsee, 6
,ee6 7
byteff 
seatff 
)ff 
{gg 	
ifhh 
(hh 
handhh 
ishh 
nullhh 
||hh 
!hh  !

selectionshh! +
.hh+ ,
TryGetValuehh, 7
(hh7 8
seathh8 <
,hh< =
outhh> A
CardhhB F
selectedCardhhG S
)hhS T
||hhU W
selectedCardhhX d
ishhe g
nullhhh l
)hhl m
{ii 
returnjj 
falsejj 
;jj 
}kk 
boolmm 
isNonSpecialmm 
=mm 
selectedCardmm  ,
.mm, -
Suitmm- 1
!=mm2 4
CardSuitmm5 =
.mm= >
Specialmm> E
;mmE F
boolnn 
isInHandnn 
=nn 
handnn  
.nn  !
Anynn! $
(nn$ %
cardnn% )
=>nn* ,
cardnn- 1
.nn1 2
IdCardnn2 8
==nn9 ;
selectedCardnn< H
.nnH I
IdCardnnI O
)nnO P
;nnP Q
returnpp 
isNonSpecialpp 
&&pp  "
isInHandpp# +
;pp+ ,
}qq 	
privatess 
staticss 
intss  
ResolveReceivingSeatss /
(ss/ 0
intss0 3

senderSeatss4 >
,ss> ?
intss@ C
playerCountssD O
,ssO P
PassDirectionssQ ^
	directionss_ h
)ssh i
{tt 	
returnuu 
	directionuu 
==uu 
PassDirectionuu  -
.uu- .
Leftuu. 2
?vv 
(vv 

senderSeatvv 
+vv 
$numvv  !
)vv! "
%vv# $
playerCountvv% 0
:ww 
(ww 

senderSeatww 
-ww 
$numww  !
+ww" #
playerCountww$ /
)ww/ 0
%ww1 2
playerCountww3 >
;ww> ?
}xx 	
}yy 
}zz ≠)
oC:\Users\oscar\source\repos\TrickTakingMissions\Server\ServerTrickTakingMissions\Domain\Lobby\LobbyRoomRules.cs
	namespace 	
Domain
 
{ 
public 

static 
class 
LobbyRoomRules &
{ 
public 
const 
byte %
DefaultTargetMissionCount 3
=4 5
$num6 7
;7 8
public		 
const		 
byte		 %
MinimumTargetMissionCount		 3
=		4 5
$num		6 7
;		7 8
public

 
const

 
byte

 %
MaximumTargetMissionCount

 3
=

4 5
$num

6 8
;

8 9
public 
const 
byte 
DefaultPlayerLimit ,
=- .
$num/ 0
;0 1
public 
const 
byte 
MinimumPlayerLimit ,
=- .
$num/ 0
;0 1
public 
const 
byte 
MaximumPlayerLimit ,
=- .
$num/ 0
;0 1
public 
const 
byte !
MinimumPlayersToStart /
=0 1
$num2 3
;3 4
public 
const 
byte 
StatusWaiting '
=( )
$num* +
;+ ,
public 
const 
byte 
StatusInGame &
=' (
$num) *
;* +
public 
const 
byte 
StatusClosed &
=' (
$num) *
;* +
public 
static 
bool  
IsConfigurationValid /
(/ 0
byte0 4
targetMissionCount5 G
,G H
byteI M
playerLimitN Y
,Y Z
int[ ^
currentPlayerCount_ q
)q r
{ 	
return 
targetMissionCount %
>=& (%
MinimumTargetMissionCount) B
&&C E
targetMissionCountF X
<=Y [%
MaximumTargetMissionCount\ u
&&v x
playerLimit 
>= 
MinimumPlayerLimit 1
&&2 4
playerLimit5 @
<=A C
MaximumPlayerLimitD V
&&W Y
currentPlayerCount "
<=# %
playerLimit& 1
;1 2
} 	
public"" 
static"" 
byte"" %
ResolveTargetMissionCount"" 4
(""4 5
byte""5 9!
requestedMissionCount"": O
)""O P
{## 	
bool$$ 
isWithinBounds$$ 
=$$  !!
requestedMissionCount$$" 7
>=$$8 :%
MinimumTargetMissionCount$$; T
&&$$U W!
requestedMissionCount%%" 7
<=%%8 :%
MaximumTargetMissionCount%%; T
;%%T U
return'' 
isWithinBounds'' !
?(( !
requestedMissionCount(( '
:)) %
DefaultTargetMissionCount)) +
;))+ ,
}** 	
public11 
static11 
byte11 
ResolvePlayerLimit11 -
(11- .
byte11. 2 
requestedPlayerLimit113 G
)11G H
{22 	
bool33 
isWithinBounds33 
=33  ! 
requestedPlayerLimit33" 6
>=337 9
MinimumPlayerLimit33: L
&&33M O 
requestedPlayerLimit44" 6
<=447 9
MaximumPlayerLimit44: L
;44L M
return66 
isWithinBounds66 !
?77  
requestedPlayerLimit77 &
:88 
DefaultPlayerLimit88 $
;88$ %
}99 	
publicAA 
staticAA 
boolAA 
HasAvailableSlotAA +
(AA+ ,
intAA, /
currentPlayerCountAA0 B
,AAB C
byteAAD H
playerLimitAAI T
)AAT U
{BB 	
returnCC 
currentPlayerCountCC %
>=CC& (
$numCC) *
&&CC+ -
currentPlayerCountCC. @
<CCA B
playerLimitCCC N
;CCN O
}DD 	
publicKK 
staticKK 
boolKK #
IsRoomWaitingForPlayersKK 2
(KK2 3
byteKK3 7

roomStatusKK8 B
)KKB C
{LL 	
returnMM 

roomStatusMM 
==MM  
StatusWaitingMM! .
;MM. /
}NN 	
publicWW 
staticWW 
boolWW 
CanLaunchMatchWW )
(WW) *
intWW* -
currentPlayerCountWW. @
,WW@ A
boolWWB F
isEveryPlayerReadyWWG Y
,WWY Z
byteWW[ _

roomStatusWW` j
)WWj k
{XX 	
boolYY 
hasMinimumPlayersYY "
=YY# $
currentPlayerCountYY% 7
>=YY8 :!
MinimumPlayersToStartYY; P
;YYP Q
boolZZ 
	isWaitingZZ 
=ZZ #
IsRoomWaitingForPlayersZZ 4
(ZZ4 5

roomStatusZZ5 ?
)ZZ? @
;ZZ@ A
return\\ 
	isWaiting\\ 
&&\\ 
hasMinimumPlayers\\  1
&&\\2 4
isEveryPlayerReady\\5 G
;\\G H
}]] 	
}^^ 
}__ †
C:\Users\oscar\source\repos\TrickTakingMissions\Server\ServerTrickTakingMissions\Domain\Match\Distress\DistressSignalContext.cs
	namespace 	
Domain
 
{ 
public

 

sealed

 
record

 !
DistressSignalContext

 .
{ 
public 
int 
CurrentTrickNumber %
{& '
get( +
;+ ,
init- 1
;1 2
}3 4
public 
bool 
IsTrickInProgress %
{& '
get( +
;+ ,
init- 1
;1 2
}3 4
public 
bool !
HasUsedDistressSignal )
{* +
get, /
;/ 0
init1 5
;5 6
}7 8
public 
bool $
HasAnyPlayerCommunicated ,
{- .
get/ 2
;2 3
init4 8
;8 9
}: ;
public 
PassDirection 
AgreedDirection ,
{- .
get/ 2
;2 3
init4 8
;8 9
}: ;
public 
IReadOnlyList 
< 
IReadOnlyList *
<* +
Card+ /
>/ 0
>0 1
HandsBySeat2 =
{> ?
get@ C
;C D
initE I
;I J
}K L
public 
IReadOnlyDictionary "
<" #
byte# '
,' (
Card) -
>- ."
SelectedPassCardBySeat/ E
{F G
getH K
;K L
initM Q
;Q R
}S T
} 
} ø
oC:\Users\oscar\source\repos\TrickTakingMissions\Server\ServerTrickTakingMissions\Domain\Lobby\LobbyCodeRules.cs
	namespace 	
Domain
 
{ 
public		 

static		 
class		 
LobbyCodeRules		 &
{

 
public 
const 
int 

CodeLength #
=$ %
$num& '
;' (
private 
const 
string 
AllowedCharacters .
=/ 0
$str1 S
;S T
private 
static 
readonly 
Random  &
CodeGenerator' 4
=5 6
new7 :
Random; A
(A B
)B C
;C D
private 
static 
readonly 
object  &
GeneratorSyncRoot' 8
=9 :
new; >
object? E
(E F
)F G
;G H
public 
static 
string 
GenerateCode )
() *
)* +
{ 	
char 
[ 
] 
buffer 
= 
new 
char  $
[$ %

CodeLength% /
]/ 0
;0 1
lock 
( 
GeneratorSyncRoot #
)# $
{ 
for 
( 
int 
index 
=  
$num! "
;" #
index$ )
<* +

CodeLength, 6
;6 7
index8 =
++= ?
)? @
{ 
int 
	charIndex !
=" #
CodeGenerator$ 1
.1 2
Next2 6
(6 7
AllowedCharacters7 H
.H I
LengthI O
)O P
;P Q
buffer 
[ 
index  
]  !
=" #
AllowedCharacters$ 5
[5 6
	charIndex6 ?
]? @
;@ A
} 
}   
return"" 
new"" 
string"" 
("" 
buffer"" $
)""$ %
;""% &
}## 	
public** 
static** 
string** 
NormalizeCode** *
(*** +
string**+ 1
rawCode**2 9
)**9 :
{++ 	
return,, 
string,, 
.,, 
IsNullOrWhiteSpace,, ,
(,,, -
rawCode,,- 4
),,4 5
?-- 
string-- 
.-- 
Empty-- 
:.. 
rawCode.. 
... 
Trim.. 
(.. 
)..  
...  !
ToUpperInvariant..! 1
(..1 2
)..2 3
;..3 4
}// 	
public66 
static66 
bool66 
IsCodeFormatValid66 ,
(66, -
string66- 3
	lobbyCode664 =
)66= >
{77 	
string88 
normalizedCode88 !
=88" #
NormalizeCode88$ 1
(881 2
	lobbyCode882 ;
)88; <
;88< =
bool99 
hasValidLength99 
=99  !
normalizedCode99" 0
.990 1
Length991 7
==998 :

CodeLength99; E
;99E F
bool:: 
hasValidCharacters:: #
=::$ %
hasValidLength::& 4
&&::5 7
normalizedCode::8 F
.::F G
All::G J
(::J K
IsAllowedCharacter::K ]
)::] ^
;::^ _
return<< 
hasValidCharacters<< %
;<<% &
}== 	
private?? 
static?? 
bool?? 
IsAllowedCharacter?? .
(??. /
char??/ 3
	character??4 =
)??= >
{@@ 	
returnAA 
AllowedCharactersAA $
.AA$ %
IndexOfAA% ,
(AA, -
	characterAA- 6
)AA6 7
>=AA8 :
$numAA; <
;AA< =
}BB 	
}CC 
}DD ô
sC:\Users\oscar\source\repos\TrickTakingMissions\Server\ServerTrickTakingMissions\Domain\Lobby\GuestIdentityRules.cs
	namespace 	
Domain
 
{ 
public 

static 
class 
GuestIdentityRules *
{		 
public

 
const

 
string

 
GuestUsernamePrefix

 /
=

0 1
$str

2 :
;

: ;
private 
const 
int 
SuffixModulus '
=( )
$num* /
;/ 0
public 
static 
bool 
IsGuestUserId (
(( )
int) ,
userId- 3
)3 4
{ 	
return 
userId 
< 
$num 
; 
} 	
public 
static 
string 
BuildGuestUsername /
(/ 0
int0 3
userId4 :
): ;
{ 	
int 
suffix 
= 
Math 
. 
Abs !
(! "
userId" (
)( )
%* +
SuffixModulus, 9
;9 :
return!! 
GuestUsernamePrefix!! &
+!!' (
suffix!!) /
.!!/ 0
ToString!!0 8
(!!8 9
$str!!9 =
)!!= >
;!!> ?
}"" 	
}## 
}$$ ¯
ÇC:\Users\oscar\source\repos\TrickTakingMissions\Server\ServerTrickTakingMissions\Domain\ChatModeration\ProhibitedChatExpression.cs
	namespace 	
Domain
 
{ 
public 

sealed 
record $
ProhibitedChatExpression 1
{ 
public 
string 
ExpressionText $
{% &
get' *
;* +
init, 0
;0 1
}2 3
public 
string !
ExpressionCultureName +
{, -
get. 1
;1 2
init3 7
;7 8
}9 :
public

 "
ChatInfractionCategory

 %
InfractionCategory

& 8
{

9 :
get

; >
;

> ?
init

@ D
;

D E
}

F G
public 
bool %
CanMatchObfuscatedLetters -
{. /
get0 3
;3 4
init5 9
;9 :
}; <
} 
} Ñ
wC:\Users\oscar\source\repos\TrickTakingMissions\Server\ServerTrickTakingMissions\Domain\Compatibility\IsExternalInit.cs
	namespace 	
System
 
. 
Runtime 
. 
CompilerServices )
{ 
internal 
static 
class 
IsExternalInit (
{ 
} 
} ∫
ÉC:\Users\oscar\source\repos\TrickTakingMissions\Server\ServerTrickTakingMissions\Domain\ChatModeration\NormalizedChatMessageText.cs
	namespace 	
Domain
 
{ 
public 

sealed 
record %
NormalizedChatMessageText 2
{ 
public		 
string		 %
ComparableChatMessageText		 /
{		0 1
get		2 5
;		5 6
init		7 ;
;		; <
}		= >
public 
IReadOnlyList 
< 
int  
>  !#
OriginalCharacterStarts" 9
{: ;
get< ?
;? @
initA E
;E F
}G H
public 
IReadOnlyList 
< 
int  
>  !!
OriginalCharacterEnds" 7
{8 9
get: =
;= >
init? C
;C D
}E F
} 
} ÿ
ÉC:\Users\oscar\source\repos\TrickTakingMissions\Server\ServerTrickTakingMissions\Domain\ChatModeration\ChatMessageTextNormalizer.cs
	namespace 	
Domain
 
{ 
public		 

sealed		 
class		 %
ChatMessageTextNormalizer		 1
{

 
public %
NormalizedChatMessageText ($
NormalizeChatMessageText) A
(A B
stringB H#
originalChatMessageTextI `
)` a
{ 	
StringBuilder %
comparableChatMessageText 3
=4 5
new6 9
StringBuilder: G
(G H
)H I
;I J
List 
< 
int 
> #
originalCharacterStarts -
=. /
new0 3
List4 8
<8 9
int9 <
>< =
(= >
)> ?
;? @
List 
< 
int 
> !
originalCharacterEnds +
=, -
new. 1
List2 6
<6 7
int7 :
>: ;
(; <
)< =
;= >!
TextElementEnumerator !
textElements" .
=/ 0

StringInfo1 ;
.; <$
GetTextElementEnumerator< T
(T U#
originalChatMessageTextU l
)l m
;m n
while 
( 
textElements 
.  
MoveNext  (
(( )
)) *
)* +
{ 
string 
originalTextElement *
=+ ,
textElements- 9
.9 :
GetTextElement: H
(H I
)I J
;J K
string !
normalizedTextElement ,
=- .
originalTextElement/ B
.B C
	NormalizeC L
(L M
NormalizationFormM ^
.^ _
FormKD_ e
)e f
. 
ToLowerInvariant %
(% &
)& '
;' (
foreach 
( 
char 
normalizedCharacter 1
in2 4!
normalizedTextElement5 J
)J K
{ 
UnicodeCategory #
characterCategory$ 5
=6 7
char8 <
.< =
GetUnicodeCategory= O
(O P
normalizedCharacterP c
)c d
;d e
if 
( 
characterCategory )
!=* ,
UnicodeCategory- <
.< =
NonSpacingMark= K
&&L N
characterCategory %
!=& (
UnicodeCategory) 8
.8 9
Format9 ?
)? @
{ %
comparableChatMessageText 1
.1 2
Append2 8
(8 9
normalizedCharacter9 L
)L M
;M N#
originalCharacterStarts /
./ 0
Add0 3
(3 4
textElements4 @
.@ A
ElementIndexA M
)M N
;N O!
originalCharacterEnds -
.- .
Add. 1
(1 2
textElements2 >
.> ?
ElementIndex? K
+L M
originalTextElementN a
.a b
Lengthb h
)h i
;i j
} 
}   
}!! 
return## 
new## %
NormalizedChatMessageText## 0
{$$ %
ComparableChatMessageText%% )
=%%* +%
comparableChatMessageText%%, E
.%%E F
ToString%%F N
(%%N O
)%%O P
,%%P Q#
OriginalCharacterStarts&& '
=&&( )#
originalCharacterStarts&&* A
.&&A B

AsReadOnly&&B L
(&&L M
)&&M N
,&&N O!
OriginalCharacterEnds'' %
=''& '!
originalCharacterEnds''( =
.''= >

AsReadOnly''> H
(''H I
)''I J
}(( 
;(( 
})) 	
}** 
}++ ∆É
~C:\Users\oscar\source\repos\TrickTakingMissions\Server\ServerTrickTakingMissions\Domain\ChatModeration\ChatMessageModerator.cs
	namespace 	
Domain
 
{ 
public

 

sealed

 
class

  
ChatMessageModerator

 ,
{ 
private 
const 
string '
ObfuscationSeparatorPattern 8
=9 :
$str; L
;L M
private 
const 
int )
MaximumRegexMatchMilliseconds 7
=8 9
$num: <
;< =
private 
const 
int *
MaximumPreparationMilliseconds 8
=9 :
$num; ?
;? @
private 
const 
int 0
$MaximumMessageModerationMilliseconds >
=? @
$numA D
;D E
private 
readonly %
ChatMessageTextNormalizer 2&
_chatMessageTextNormalizer3 M
;M N
private 
readonly 
List 
< 
KeyValuePair *
<* +
Regex+ 0
,0 1"
ChatInfractionCategory2 H
>H I
>I J#
_chatExpressionPatternsK b
;b c
public  
ChatMessageModerator #
(# $
IEnumerable$ /
</ 0$
ProhibitedChatExpression0 H
>H I%
prohibitedChatExpressionsJ c
)c d
{ 	&
_chatMessageTextNormalizer &
=' (
new) ,%
ChatMessageTextNormalizer- F
(F G
)G H
;H I#
_chatExpressionPatterns #
=$ %
new& )
List* .
<. /
KeyValuePair/ ;
<; <
Regex< A
,A B"
ChatInfractionCategoryC Y
>Y Z
>Z [
([ \
)\ ]
;] ^
	Stopwatch 
preparationTimer &
=' (
	Stopwatch) 2
.2 3
StartNew3 ;
(; <
)< =
;= >
foreach 
( $
ProhibitedChatExpression -$
prohibitedChatExpression. F
inG I%
prohibitedChatExpressionsJ c
)c d
{ "
EnsureWithinTimeBudget &
(& '
preparationTimer' 7
,7 8*
MaximumPreparationMilliseconds9 W
)W X
;X Y
Regex 
expressionPattern '
=( )
new* -
Regex. 3
(3 4"
BuildExpressionPattern4 J
(J K$
prohibitedChatExpressionK c
)c d
,d e
RegexOptions  
.  !
CultureInvariant! 1
,1 2
TimeSpan 
. 
FromMilliseconds -
(- .)
MaximumRegexMatchMilliseconds. K
)K L
)L M
;M N#
_chatExpressionPatterns '
.' (
Add( +
(+ ,
new, /
KeyValuePair0 <
<< =
Regex= B
,B C"
ChatInfractionCategoryD Z
>Z [
([ \
expressionPattern %
,% &$
prohibitedChatExpression' ?
.? @
InfractionCategory@ R
)R S
)S T
;T U"
EnsureWithinTimeBudget   &
(  & '
preparationTimer  ' 7
,  7 8*
MaximumPreparationMilliseconds  9 W
)  W X
;  X Y
}!! 
}"" 	
public$$ )
ChatMessageModerationDecision$$ ,
EvaluateChatMessage$$- @
($$@ A
string$$A G#
originalChatMessageText$$H _
)$$_ `
{%% 	
	Stopwatch&& 
moderationTimer&& %
=&&& '
	Stopwatch&&( 1
.&&1 2
StartNew&&2 :
(&&: ;
)&&; <
;&&< =%
NormalizedChatMessageText'' %%
normalizedChatMessageText''& ?
=''@ A&
_chatMessageTextNormalizer(( *
.((* +$
NormalizeChatMessageText((+ C
(((C D#
originalChatMessageText((D [
)(([ \
;((\ ]
bool)) 
[)) 
])) &
censoredOriginalCharacters)) -
=)). /
new))0 3
bool))4 8
[))8 9#
originalChatMessageText))9 P
.))P Q
Length))Q W
]))W X
;))X Y"
ChatInfractionCategory** "&
detectedInfractionCategory**# =
=**> ?"
ChatInfractionCategory**@ V
.**V W
None**W [
;**[ \
foreach++ 
(++ 
KeyValuePair++ !
<++! "
Regex++" '
,++' ("
ChatInfractionCategory++) ?
>++? @
expressionPattern++A R
in++S U#
_chatExpressionPatterns++V m
)++m n
{,, "
EnsureWithinTimeBudget-- &
(--& '
moderationTimer--' 6
,--6 70
$MaximumMessageModerationMilliseconds--8 \
)--\ ]
;--] ^
MatchCollection.. 
expressionMatches..  1
=..2 3
expressionPattern..4 E
...E F
Key..F I
...I J
Matches..J Q
(..Q R%
normalizedChatMessageText// -
.//- .%
ComparableChatMessageText//. G
)//G H
;//H I
foreach00 
(00 
Match00 
expressionMatch00 .
in00/ 1
expressionMatches002 C
)00C D
{11 "
EnsureWithinTimeBudget22 *
(22* +
moderationTimer22+ :
,22: ;0
$MaximumMessageModerationMilliseconds22< `
)22` a
;22a b"
MarkOriginalCharacters33 *
(33* +&
censoredOriginalCharacters33+ E
,33E F%
normalizedChatMessageText33G `
,33` a
expressionMatch33b q
)33q r
;33r s
if44 
(44 
expressionPattern44 )
.44) *
Value44* /
>440 1&
detectedInfractionCategory442 L
)44L M
{55 &
detectedInfractionCategory66 2
=663 4
expressionPattern665 F
.66F G
Value66G L
;66L M
}77 
}88 
}99 "
EnsureWithinTimeBudget;; "
(;;" #
moderationTimer;;# 2
,;;2 30
$MaximumMessageModerationMilliseconds;;4 X
);;X Y
;;;Y Z
return<< 
new<< )
ChatMessageModerationDecision<< 4
{== #
CensoredChatMessageText>> '
=>>( )"
MaskOriginalCharacters>>* @
(>>@ A#
originalChatMessageText>>A X
,>>X Y&
censoredOriginalCharacters>>Z t
)>>t u
,>>u v&
DetectedInfractionCategory?? *
=??+ ,&
detectedInfractionCategory??- G
}@@ 
;@@ 
}AA 	
privateCC 
staticCC 
voidCC "
EnsureWithinTimeBudgetCC 2
(CC2 3
	StopwatchCC3 <
operationTimerCC= K
,CCK L
intCCM P&
maximumElapsedMillisecondsCCQ k
)CCk l
{DD 	
ifEE 
(EE 
operationTimerEE 
.EE 
ElapsedMillisecondsEE 2
>EE3 4&
maximumElapsedMillisecondsEE5 O
)EEO P
{FF 
throwGG 
newGG 
TimeoutExceptionGG *
(GG* +
$strGG+ j
)GGj k
;GGk l
}HH 
}II 	
privateKK 
stringKK "
BuildExpressionPatternKK -
(KK- .$
ProhibitedChatExpressionKK. F$
prohibitedChatExpressionKKG _
)KK_ `
{LL 	
stringMM $
normalizedExpressionTextMM +
=MM, -&
_chatMessageTextNormalizerMM. H
.MMH I$
NormalizeChatMessageTextMMI a
(MMa b$
prohibitedChatExpressionNN (
.NN( )
ExpressionTextNN) 7
)NN7 8
.NN8 9%
ComparableChatMessageTextNN9 R
;NNR S
ListOO 
<OO 
stringOO 
>OO $
expressionLetterPatternsOO 1
=OO2 3
newOO4 7
ListOO8 <
<OO< =
stringOO= C
>OOC D
(OOD E
)OOE F
;OOF G
foreachPP 
(PP 
charPP 
expressionCharacterPP -
inPP. 0$
normalizedExpressionTextPP1 I
)PPI J
{QQ $
expressionLetterPatternsRR (
.RR( )
AddRR) ,
(RR, -
GetCharacterPatternRR- @
(RR@ A
expressionCharacterRRA T
,RRT U$
prohibitedChatExpressionSS ,
.SS, -%
CanMatchObfuscatedLettersSS- F
)SSF G
)SSG H
;SSH I
}TT 
stringVV 
expressionSeparatorVV &
=VV' ($
prohibitedChatExpressionVV) A
.VVA B%
CanMatchObfuscatedLettersVVB [
?WW '
ObfuscationSeparatorPatternWW -
:WW. /
stringWW0 6
.WW6 7
EmptyWW7 <
;WW< =
returnXX 
$strXX '
+XX( )
stringXX* 0
.XX0 1
JoinXX1 5
(XX5 6
expressionSeparatorXX6 I
,XXI J$
expressionLetterPatternsXXK c
)XXc d
+XXe f
$strYY #
;YY# $
}ZZ 	
private\\ 
static\\ 
string\\ 
GetCharacterPattern\\ 1
(\\1 2
char\\2 6
expressionCharacter\\7 J
,\\J K
bool\\L P%
canMatchObfuscatedLetters\\Q j
)\\j k
{]] 	
string^^ 
characterPattern^^ #
=^^$ %
Regex^^& +
.^^+ ,
Escape^^, 2
(^^2 3
expressionCharacter^^3 F
.^^F G
ToString^^G O
(^^O P
)^^P Q
)^^Q R
;^^R S
if__ 
(__ 
char__ 
.__ 
IsWhiteSpace__ !
(__! "
expressionCharacter__" 5
)__5 6
)__6 7
{`` 
characterPatternaa  
=aa! "
$straa# )
;aa) *
}bb 
elsecc 
ifcc 
(cc 
expressionCharactercc (
==cc) +
$charcc, 0
)cc0 1
{dd 
characterPatternee  
=ee! "
$stree# :
;ee: ;
}ff 
elsegg 
ifgg 
(gg %
canMatchObfuscatedLettersgg .
&&gg/ 1
chargg2 6
.gg6 7
IsLettergg7 ?
(gg? @
expressionCharactergg@ S
)ggS T
)ggT U
{hh 
characterPatternii  
=ii! "&
GetObfuscatedLetterPatternii# =
(ii= >
expressionCharacterii> Q
)iiQ R
+iiS T
$striiU \
;ii\ ]
}jj 
returnll 
characterPatternll #
;ll# $
}mm 	
privateoo 
staticoo 
stringoo &
GetObfuscatedLetterPatternoo 8
(oo8 9
charoo9 =
expressionCharacteroo> Q
)ooQ R
{pp 	
stringqq 
characterPatternqq #
;qq# $
switchrr 
(rr 
expressionCharacterrr '
)rr' (
{ss 
casett 
$chartt 
:tt 
characterPatterntt *
=tt+ ,
$strtt- 4
;tt4 5
breaktt6 ;
;tt; <
caseuu 
$charuu 
:uu 
characterPatternuu *
=uu+ ,
$struu- 3
;uu3 4
breakuu5 :
;uu: ;
casevv 
$charvv 
:vv 
characterPatternvv *
=vv+ ,
$strvv- 4
;vv4 5
breakvv6 ;
;vv; <
caseww 
$charww 
:ww 
characterPatternww *
=ww+ ,
$strww- 3
;ww3 4
breakww5 :
;ww: ;
casexx 
$charxx 
:xx 
characterPatternxx *
=xx+ ,
$strxx- 4
;xx4 5
breakxx6 ;
;xx; <
caseyy 
$charyy 
:yy 
characterPatternyy *
=yy+ ,
$stryy- 3
;yy3 4
breakyy5 :
;yy: ;
defaultzz 
:zz 
characterPatternzz )
=zz* +
Regexzz, 1
.zz1 2
Escapezz2 8
(zz8 9
expressionCharacterzz9 L
.zzL M
ToStringzzM U
(zzU V
)zzV W
)zzW X
;zzX Y
breakzzZ _
;zz_ `
}{{ 
return}} 
characterPattern}} #
;}}# $
}~~ 	
private
ÄÄ 
static
ÄÄ 
void
ÄÄ $
MarkOriginalCharacters
ÄÄ 2
(
ÄÄ2 3
bool
ÄÄ3 7
[
ÄÄ7 8
]
ÄÄ8 9(
censoredOriginalCharacters
ÄÄ: T
,
ÄÄT U'
NormalizedChatMessageText
ÅÅ %'
normalizedChatMessageText
ÅÅ& ?
,
ÅÅ? @
Match
ÅÅA F
expressionMatch
ÅÅG V
)
ÅÅV W
{
ÇÇ 	
int
ÉÉ  
originalMatchStart
ÉÉ "
=
ÉÉ# $'
normalizedChatMessageText
ÉÉ% >
.
ÉÉ> ?%
OriginalCharacterStarts
ÉÉ? V
[
ÉÉV W
expressionMatch
ÉÉW f
.
ÉÉf g
Index
ÉÉg l
]
ÉÉl m
;
ÉÉm n
int
ÑÑ 
originalMatchEnd
ÑÑ  
=
ÑÑ! "'
normalizedChatMessageText
ÑÑ# <
.
ÑÑ< =#
OriginalCharacterEnds
ÑÑ= R
[
ÑÑR S
expressionMatch
ÖÖ 
.
ÖÖ  
Index
ÖÖ  %
+
ÖÖ& '
expressionMatch
ÖÖ( 7
.
ÖÖ7 8
Length
ÖÖ8 >
-
ÖÖ? @
$num
ÖÖA B
]
ÖÖB C
;
ÖÖC D
for
ÜÜ 
(
ÜÜ 
int
ÜÜ $
originalCharacterIndex
ÜÜ +
=
ÜÜ, - 
originalMatchStart
ÜÜ. @
;
ÜÜ@ A$
originalCharacterIndex
ÜÜB X
<
ÜÜY Z
originalMatchEnd
ÜÜ[ k
;
ÜÜk l$
originalCharacterIndex
áá &
++
áá& (
)
áá( )
{
àà (
censoredOriginalCharacters
ââ *
[
ââ* +$
originalCharacterIndex
ââ+ A
]
ââA B
=
ââC D
true
ââE I
;
ââI J
}
ää 
}
ãã 	
private
çç 
static
çç 
string
çç $
MaskOriginalCharacters
çç 4
(
çç4 5
string
çç5 ;%
originalChatMessageText
çç< S
,
ççS T
bool
ççU Y
[
ççY Z
]
ççZ [(
censoredOriginalCharacters
çç\ v
)
ççv w
{
éé 	
StringBuilder
èè %
censoredChatMessageText
èè 1
=
èè2 3
new
èè4 7
StringBuilder
èè8 E
(
èèE F
)
èèF G
;
èèG H
bool
êê *
wasPreviousCharacterCensored
êê -
=
êê. /
false
êê0 5
;
êê5 6
for
ëë 
(
ëë 
int
ëë $
originalCharacterIndex
ëë +
=
ëë, -
$num
ëë. /
;
ëë/ 0$
originalCharacterIndex
ëë1 G
<
ëëH I%
originalChatMessageText
ëëJ a
.
ëëa b
Length
ëëb h
;
ëëh i$
originalCharacterIndex
íí &
++
íí& (
)
íí( )
{
ìì 
bool
îî (
isCurrentCharacterCensored
îî /
=
îî0 1(
censoredOriginalCharacters
îî2 L
[
îîL M$
originalCharacterIndex
îîM c
]
îîc d
;
îîd e
if
ïï 
(
ïï (
isCurrentCharacterCensored
ïï .
&&
ïï/ 1
!
ïï2 3*
wasPreviousCharacterCensored
ïï3 O
)
ïïO P
{
ññ %
censoredChatMessageText
óó +
.
óó+ ,
Append
óó, 2
(
óó2 3
$str
óó3 8
)
óó8 9
;
óó9 :
}
òò 
else
ôô 
if
ôô 
(
ôô 
!
ôô (
isCurrentCharacterCensored
ôô 4
)
ôô4 5
{
öö %
censoredChatMessageText
õõ +
.
õõ+ ,
Append
õõ, 2
(
õõ2 3%
originalChatMessageText
õõ3 J
[
õõJ K$
originalCharacterIndex
õõK a
]
õõa b
)
õõb c
;
õõc d
}
úú *
wasPreviousCharacterCensored
ûû ,
=
ûû- .(
isCurrentCharacterCensored
ûû/ I
;
ûûI J
}
üü 
return
°° %
censoredChatMessageText
°° *
.
°°* +
ToString
°°+ 3
(
°°3 4
)
°°4 5
;
°°5 6
}
¢¢ 	
}
££ 
}§§ Ω
áC:\Users\oscar\source\repos\TrickTakingMissions\Server\ServerTrickTakingMissions\Domain\ChatModeration\ChatMessageModerationDecision.cs
	namespace 	
Domain
 
{ 
public 

sealed 
record )
ChatMessageModerationDecision 6
{ 
public 
string #
CensoredChatMessageText -
{. /
get0 3
;3 4
init5 9
;9 :
}; <
public "
ChatInfractionCategory %&
DetectedInfractionCategory& @
{A B
getC F
;F G
initH L
;L M
}N O
}		 
}

 ò9
}C:\Users\oscar\source\repos\TrickTakingMissions\Server\ServerTrickTakingMissions\Domain\ChatModeration\ChatInfractionRules.cs
	namespace 	
Domain
 
{ 
public 

static 
class 
ChatInfractionRules +
{ 
public		 
const		 
int		 .
"ProfaneChatMessageInfractionPoints		 ;
=		< =
$num		> ?
;		? @
public

 
const

 
int

 2
&ThreateningChatMessageInfractionPoints

 ?
=

@ A
$num

B C
;

C D
public 
const 
int (
ChatInfractionPointThreshold 5
=6 7
$num8 :
;: ;
public 
const 
int :
.ThreateningChatMessageThresholdForPermanentBan G
=H I
$numJ K
;K L
public 
const 
int !
TemporaryChatBanLimit .
=/ 0
$num1 2
;2 3
public 
const 
int (
TemporaryChatBanDurationDays 5
=6 7
$num8 9
;9 :
public 
const 
int $
MaximumChatMessageLength 1
=2 3
$num4 7
;7 8
public 
static 
bool 
IsAccountBanned *
(* +&
ChatAccountInfractionState+ E"
accountInfractionStateF \
,\ ]
DateTime^ f
evaluatedAtUtcg u
)u v
{ 	
return "
accountInfractionState )
.) **
IsChatAccountPermanentlyBanned* H
||I K"
accountInfractionState &
.& '#
ChatAccountBanEndsAtUtc' >
>? @
evaluatedAtUtcA O
;O P
} 	
public 
static 
void 
ResetExpiredCycle ,
(, -&
ChatAccountInfractionState- G"
accountInfractionStateH ^
,^ _
DateTime` h
evaluatedAtUtci w
)w x
{ 	
if 
( "
accountInfractionState &
.& '#
ChatAccountBanEndsAtUtc' >
<=? A
evaluatedAtUtcB P
&&Q S
! "
accountInfractionState '
.' (*
IsChatAccountPermanentlyBanned( F
)F G
{ "
accountInfractionState &
.& '+
AccumulatedChatInfractionPoints' F
=G H
$numI J
;J K"
accountInfractionState &
.& ''
ThreateningChatMessageCount' B
=C D
$numE F
;F G"
accountInfractionState &
.& '#
ChatAccountBanEndsAtUtc' >
=? @
nullA E
;E F
} 
}   	
public"" 
static"" 
int"" &
GetMessageInfractionPoints"" 4
(""4 5"
ChatInfractionCategory""5 K&
detectedInfractionCategory""L f
)""f g
{## 	
int$$ *
currentMessageInfractionPoints$$ .
=$$/ 0
$num$$1 2
;$$2 3
if%% 
(%% &
detectedInfractionCategory%% *
==%%+ -"
ChatInfractionCategory%%. D
.%%D E
Threat%%E K
)%%K L
{&& *
currentMessageInfractionPoints'' .
=''/ 02
&ThreateningChatMessageInfractionPoints''1 W
;''W X
}(( 
else)) 
if)) 
()) &
detectedInfractionCategory)) /
==))0 2"
ChatInfractionCategory))3 I
.))I J
	Profanity))J S
)))S T
{** *
currentMessageInfractionPoints++ .
=++/ 0.
"ProfaneChatMessageInfractionPoints++1 S
;++S T
},, 
return.. *
currentMessageInfractionPoints.. 1
;..1 2
}// 	
public44 
static44 
void44 "
ApplyMessageInfraction44 1
(441 2&
ChatAccountInfractionState442 L"
accountInfractionState44M c
,44c d"
ChatInfractionCategory55 "&
detectedInfractionCategory55# =
,55= >
DateTime55? G
evaluatedAtUtc55H V
)55V W
{66 	
ResetExpiredCycle77 
(77 "
accountInfractionState77 4
,774 5
evaluatedAtUtc776 D
)77D E
;77E F
if88 
(88 
!88 
IsAccountBanned88  
(88  !"
accountInfractionState88! 7
,887 8
evaluatedAtUtc889 G
)88G H
)88H I
{99 "
accountInfractionState:: &
.::& '+
AccumulatedChatInfractionPoints::' F
+=::G I&
GetMessageInfractionPoints;; .
(;;. /&
detectedInfractionCategory;;/ I
);;I J
;;;J K
if<< 
(<< &
detectedInfractionCategory<< .
==<</ 1"
ChatInfractionCategory<<2 H
.<<H I
Threat<<I O
)<<O P
{== "
accountInfractionState>> *
.>>* +'
ThreateningChatMessageCount>>+ F
++>>F H
;>>H I
}?? 
ifAA 
(AA "
accountInfractionStateAA *
.AA* ++
AccumulatedChatInfractionPointsAA+ J
>=AAK M(
ChatInfractionPointThresholdAAN j
)AAj k
{BB "
ApplyThresholdSanctionCC *
(CC* +"
accountInfractionStateCC+ A
,CCA B
evaluatedAtUtcCCC Q
)CCQ R
;CCR S
}DD 
}EE 
}FF 	
privateHH 
staticHH 
voidHH "
ApplyThresholdSanctionHH 2
(HH2 3&
ChatAccountInfractionStateHH3 M"
accountInfractionStateHHN d
,HHd e
DateTimeII 
evaluatedAtUtcII #
)II# $
{JJ 	
boolKK $
hasPermanentBanConditionKK )
=KK* +"
accountInfractionStateKK, B
.KKB C'
ThreateningChatMessageCountKKC ^
>=KK_ a:
.ThreateningChatMessageThresholdForPermanentBanLL >
||LL? A"
accountInfractionStateMM &
.MM& ')
PreviousTemporaryChatBanCountMM' D
>=MME G!
TemporaryChatBanLimitMMH ]
;MM] ^
ifNN 
(NN $
hasPermanentBanConditionNN (
)NN( )
{OO "
accountInfractionStatePP &
.PP& '*
IsChatAccountPermanentlyBannedPP' E
=PPF G
truePPH L
;PPL M"
accountInfractionStateQQ &
.QQ& '#
ChatAccountBanEndsAtUtcQQ' >
=QQ? @
nullQQA E
;QQE F
}RR 
elseSS 
{TT "
accountInfractionStateUU &
.UU& ')
PreviousTemporaryChatBanCountUU' D
++UUD F
;UUF G"
accountInfractionStateVV &
.VV& '#
ChatAccountBanEndsAtUtcVV' >
=VV? @
evaluatedAtUtcVVA O
.VVO P
AddDaysVVP W
(VVW X(
TemporaryChatBanDurationDaysVVX t
)VVt u
;VVu v
}WW 
}XX 	
}YY 
}ZZ Ï
ÄC:\Users\oscar\source\repos\TrickTakingMissions\Server\ServerTrickTakingMissions\Domain\ChatModeration\ChatInfractionCategory.cs
	namespace 	
Domain
 
{ 
public 

enum "
ChatInfractionCategory &
{ 
None 
= 
$num 
, 
	Profanity 
= 
$num 
, 
Threat 
= 
$num 
}		 
}

 ¡	
ÑC:\Users\oscar\source\repos\TrickTakingMissions\Server\ServerTrickTakingMissions\Domain\ChatModeration\ChatAccountInfractionState.cs
	namespace 	
Domain
 
{ 
public 

sealed 
class &
ChatAccountInfractionState 2
{ 
public		 
int		 +
AccumulatedChatInfractionPoints		 2
{		3 4
get		5 8
;		8 9
set		: =
;		= >
}		? @
public 
int '
ThreateningChatMessageCount .
{/ 0
get1 4
;4 5
set6 9
;9 :
}; <
public 
int )
PreviousTemporaryChatBanCount 0
{1 2
get3 6
;6 7
set8 ;
;; <
}= >
public 
bool *
IsChatAccountPermanentlyBanned 2
{3 4
get5 8
;8 9
set: =
;= >
}? @
public 
DateTime 
? #
ChatAccountBanEndsAtUtc 0
{1 2
get3 6
;6 7
set8 ;
;; <
}= >
} 
} ù$
sC:\Users\oscar\source\repos\TrickTakingMissions\Server\ServerTrickTakingMissions\Domain\Account\UserAccountRules.cs
	namespace 	
Domain
 
{ 
public

 

static

 
class

 
UserAccountRules

 (
{ 
public 
const 
int !
MinimumUsernameLength .
=/ 0
$num1 2
;2 3
public 
const 
int !
MaximumUsernameLength .
=/ 0
$num1 3
;3 4
public 
const 
int 
MaximumEmailLength +
=, -
$num. 1
;1 2
public 
const 
int 
Sha256HashLength )
=* +
$num, .
;. /
private 
const 
string 
UsernamePattern ,
=- .
$str/ C
;C D
private 
const 
string 
EmailPattern )
=* +
$str, I
;I J
public 
static 
bool 
IsUsernameValid *
(* +
string+ 1
username2 :
): ;
{ 	
bool 
isValid 
= 
false  
;  !
if 
( 
! 
string 
. 
IsNullOrWhiteSpace *
(* +
username+ 3
)3 4
)4 5
{ 
string 
trimmedUsername &
=' (
username) 1
.1 2
Trim2 6
(6 7
)7 8
;8 9
if   
(   
trimmedUsername   #
.  # $
Length  $ *
>=  + -!
MinimumUsernameLength  . C
&&  D F
trimmedUsername!! #
.!!# $
Length!!$ *
<=!!+ -!
MaximumUsernameLength!!. C
&&!!D F
Regex"" 
."" 
IsMatch"" !
(""! "
trimmedUsername""" 1
,""1 2
UsernamePattern""3 B
)""B C
)""C D
{## 
isValid$$ 
=$$ 
true$$ "
;$$" #
}%% 
}&& 
return(( 
isValid(( 
;(( 
})) 	
public00 
static00 
bool00 
IsEmailValid00 '
(00' (
string00( .
email00/ 4
)004 5
{11 	
bool22 
isValid22 
=22 
false22  
;22  !
if44 
(44 
!44 
string44 
.44 
IsNullOrWhiteSpace44 *
(44* +
email44+ 0
)440 1
)441 2
{55 
string66 
trimmedEmail66 #
=66$ %
email66& +
.66+ ,
Trim66, 0
(660 1
)661 2
;662 3
if77 
(77 
trimmedEmail77  
.77  !
Length77! '
<=77( *
MaximumEmailLength77+ =
&&77> @
Regex88 
.88 
IsMatch88 !
(88! "
trimmedEmail88" .
,88. /
EmailPattern880 <
)88< =
)88= >
{99 
isValid:: 
=:: 
true:: "
;::" #
};; 
}<< 
return>> 
isValid>> 
;>> 
}?? 	
publicFF 
staticFF 
boolFF 
IsPasswordHashValidFF .
(FF. /
stringFF/ 5
passwordHashFF6 B
)FFB C
{GG 	
boolHH 
isValidHH 
=HH 
falseHH  
;HH  !
ifJJ 
(JJ 
!JJ 
stringJJ 
.JJ 
IsNullOrWhiteSpaceJJ *
(JJ* +
passwordHashJJ+ 7
)JJ7 8
)JJ8 9
{KK 
stringLL 
trimmedHashLL "
=LL# $
passwordHashLL% 1
.LL1 2
TrimLL2 6
(LL6 7
)LL7 8
;LL8 9
ifMM 
(MM 
trimmedHashMM 
.MM  
LengthMM  &
==MM' )
Sha256HashLengthMM* :
&&MM; =
trimmedHashNN 
.NN  
AllNN  #
(NN# $
UriNN$ '
.NN' (

IsHexDigitNN( 2
)NN2 3
)NN3 4
{OO 
isValidPP 
=PP 
truePP "
;PP" #
}QQ 
}RR 
returnTT 
isValidTT 
;TT 
}UU 	
}VV 
}WW 