≤
{C:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\UseCases\Match\Radio\RadioCommunicationContextFactory.cs
	namespace 	
Application
 
. 
UseCases 
{ 
internal		 
static		 
class		 ,
 RadioCommunicationContextFactory		 :
{

 
internal 
static %
RadioCommunicationContext 1
Create2 8
(8 9

MatchState9 C
stateD I
,I J
intK N
participantUserIdO `
,` a%
RadioCommunicationRequest %
request& -
=. /
null0 4
)4 5
{ 	
int 
seat 
= 
Array 
. 
IndexOf $
($ %
state% *
.* +
ParticipantUserIds+ =
,= >
participantUserId? P
)P Q
;Q R
var 
hand 
= 
state 
. #
PlayerHandCardIdsBySeat 4
[4 5
seat5 9
]9 :
.: ;
Select; A
(A B
	DeckRulesB K
.K L
GetCardByIdL W
)W X
.X Y
ToArrayY `
(` a
)a b
;b c
return 
new %
RadioCommunicationContext 0
{ 
	HandCards 
= 
hand  
,  !
CardToCommunicate !
=" #
hand$ (
.( )
FirstOrDefault) 7
(7 8
card8 <
=>= ?
card@ D
.D E
IdCardE K
==L N
requestO V
?V W
.W X
CardIdX ^
)^ _
,_ `
CurrentTrickNumber "
=# $
state% *
.* +
CurrentTrickNumber+ =
,= >
IsTrickInProgress !
=" #
state$ )
.) *!
CurrentTrickCardPlays* ?
.? @
Count@ E
>F G
$numH I
,I J&
HasCommunicatedThisAttempt *
=+ ,
state 
. 2
&RadioCommunicationsByParticipantUserId @
.@ A
ContainsKeyA L
(L M
participantUserIdM ^
)^ _
,_ `
IsSilencedByCaptain #
=$ %
state& +
.+ ,
MissionAttempt, :
.: ;

RoleConfig; E
?E F
.F G
SilencedPlayerSeatG Y
==Z \
seat] a
,a b
CommunicationRule !
=" #
MissionCatalog$ 2
.2 3

GetMission3 =
(= >
state> C
.C D
MissionAttemptD R
.R S
MissionNumberS `
)` a
.a b
CommunicationRuleb s
,s t
SelectedPosition  
=! ")
RadioCommunicationRuleMapping# @
.@ A
MapRequestedMarkerA S
(S T
request 
? 
. 
SelectedMarker +
??, .
RadioPublicMarker/ @
.@ A
NoneA E
)E F
} 
; 
} 	
} 
} ˙B
ãC:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\UseCases\Match\Preparation\MatchSnapshotProjection.SpecialPreparation.cs
	namespace		 	
Application		
 
.		 
UseCases		 
{

 
internal 
static 
partial 
class !#
MatchSnapshotProjection" 9
{ 
private 
static #
MissionPreparationStage .
GetPreparationStage/ B
(B C

MatchStateC M
stateN S
)S T
{ 	#
MissionPreparationStage #
stage$ )
=* +#
MissionPreparationStage, C
.C D
NoneD H
;H I
switch 
( 
state 
. 
MissionAttempt (
.( )
Phase) .
). /
{ 
case 
MissionAttemptPhase (
.( )
RoleAndPreparation) ;
:; <
stage 
= &
GetSpecialPreparationStage 6
(6 7
state7 <
)< =
;= >
break 
; 
case 
MissionAttemptPhase (
.( )
ObjectiveDrafting) :
:: ;
stage 
= #
MissionPreparationStage 3
.3 4
ObjectiveDrafting4 E
;E F
break 
; 
case 
MissionAttemptPhase (
.( )
PlayingTricks) 6
:6 7
stage 
= #
MissionPreparationStage 3
.3 4
PlayingTricks4 A
;A B
break 
; 
case 
MissionAttemptPhase (
.( )
Finished) 1
:1 2
stage 
= #
MissionPreparationStage 3
.3 4
Finished4 <
;< =
break 
; 
default 
: 
break 
; 
}   
return!! 
stage!! 
;!! 
}"" 	
private$$ 
static$$ #
MissionPreparationStage$$ .&
GetSpecialPreparationStage$$/ I
($$I J

MatchState$$J T
state$$U Z
)$$Z [
{%% 	
bool&& 
isBlind&& 
=&& 
MissionSetupRules&& ,
.&&, -*
IsBlindObjectiveAssignmentRule&&- K
(&&K L
MissionCatalog'' 
.'' 

GetMission'' )
('') *
state''* /
.''/ 0
MissionAttempt''0 >
.''> ?
MissionNumber''? L
)''L M
.''M N
SpecialRule''N Y
)''Y Z
;''Z [#
MissionPreparationStage(( #
stage(($ )
=((* +#
GetRolePreparationStage((, C
(((C D
state((D I
)((I J
;((J K
if)) 
()) 
isBlind)) 
))) 
{** 
stage++ 
=++ 
MissionSetupRules++ )
.++) *(
AreAllBlindResponsesRecorded++* F
(++F G
state++G L
.++L M 
BlindResponsesBySeat++M a
,++a b
state,, 
.,, 
ParticipantUserIds,, ,
.,,, -
Length,,- 3
,,,3 4
(,,5 6
byte,,6 :
),,: ;
state,,; @
.,,@ A
MissionCaptainSeat,,A S
),,S T
?-- #
MissionPreparationStage-- -
.--- .
AssigneeSelection--. ?
:--@ A#
MissionPreparationStage--B Y
.--Y Z
BlindResponses--Z h
;--h i
}.. 
return// 
stage// 
;// 
}00 	
private22 
static22 #
MissionPreparationStage22 .#
GetRolePreparationStage22/ F
(22F G

MatchState22G Q
state22R W
)22W X
{33 	"
SpecialMissionRuleType44 "
rule44# '
=44( )
MissionCatalog44* 8
.448 9

GetMission449 C
(44C D
state44D I
.44I J
MissionAttempt44J X
.44X Y
MissionNumber44Y f
)44f g
.44g h
SpecialRule44h s
;44s t#
MissionPreparationStage55 #
stage55$ )
=55* +#
MissionPreparationStage55, C
.55C D
RoleSelection55D Q
;55Q R
if66 
(66 
rule66 
==66 "
SpecialMissionRuleType66 .
.66. /0
$M46_SeatLeftOfHeartNineWinsAllHearts66/ S
)66S T
{77 
stage88 
=88 #
MissionPreparationStage88 /
.88/ 0#
HeartNineIdentification880 G
;88G H
}99 
else:: 
if:: 
(:: 
rule:: 
==:: "
SpecialMissionRuleType:: 3
.::3 4*
M50_SplitTrickWinsDistribution::4 R
)::R S
{;; 
stage<< 
=<< #
MissionPreparationStage<< /
.<</ 0&
TrickDistributionSelection<<0 J
;<<J K
}== 
return>> 
stage>> 
;>> 
}?? 	
privateAA 
staticAA 
intAA 
?AA !
GetParticipantForRoleAA 1
(AA1 2

MatchStateAA2 <
stateAA= B
,AAB C
byteAAD H
?AAH I
seatAAJ N
)AAN O
{BB 	
returnCC 
seatCC 
.CC 
HasValueCC  
?CC! "
(CC# $
intCC$ '
?CC' (
)CC( )
stateCC) .
.CC. /
ParticipantUserIdsCC/ A
[CCA B
seatCCB F
.CCF G
ValueCCG L
]CCL M
:CCN O
nullCCP T
;CCT U
}DD 	
privateFF 
staticFF 
intFF 
[FF 
]FF '
GetEligibleRoleParticipantsFF 8
(FF8 9

MatchStateFF9 C
stateFFD I
,FFI J
intFFK N
participantSeatFFO ^
)FF^ _
{GG 	
intHH 
[HH 
]HH 

candidatesHH 
;HH 
ifII 
(II 
GetPreparationStageII #
(II# $
stateII$ )
)II) *
==II+ -#
MissionPreparationStageII. E
.IIE F&
TrickDistributionSelectionIIF `
&&IIa c
participantSeatJJ 
==JJ  "
stateJJ# (
.JJ( )
MissionCaptainSeatJJ) ;
)JJ; <
{KK 

candidatesLL 
=LL 
(LL 
intLL !
[LL! "
]LL" #
)LL# $
stateLL$ )
.LL) *
ParticipantUserIdsLL* <
.LL< =
CloneLL= B
(LLB C
)LLC D
;LLD E
}MM 
elseNN 
{OO 

candidatesPP 
=PP 

EnumerablePP '
.PP' (
RangePP( -
(PP- .
$numPP. /
,PP/ 0
statePP1 6
.PP6 7
ParticipantUserIdsPP7 I
.PPI J
LengthPPJ P
)PPP Q
.PPQ R
WherePPR W
(PPW X
targetPPX ^
=>PP_ a*
MissionSpecialPreparationRulesQQ 2
.QQ2 3
CanAssignRoleQQ3 @
(QQ@ A
MatchUseCaseQQA M
.QQM N
CreateRoleContextQQN _
(QQ_ `
stateQQ` e
,QQe f
participantSeatRR '
,RR' (
targetRR) /
)RR/ 0
)RR0 1
)RR1 2
.RR2 3
SelectRR3 9
(RR9 :
targetRR: @
=>RRA C
stateRRD I
.RRI J
ParticipantUserIdsRRJ \
[RR\ ]
targetRR] c
]RRc d
)RRd e
.RRe f
ToArrayRRf m
(RRm n
)RRn o
;RRo p
}SS 
returnTT 

candidatesTT 
;TT 
}UU 	
privateWW 
staticWW "
BlindObjectiveResponseWW -
MapBlindResponseWW. >
(WW> ?)
BlindObjectiveCapableResponseWW? \
responseWW] e
)WWe f
{XX 	
returnYY 
responseYY 
==YY )
BlindObjectiveCapableResponseYY <
.YY< =
YesYY= @
?YYA B"
BlindObjectiveResponseYYC Y
.YYY Z
YesYYZ ]
:YY^ _"
BlindObjectiveResponseZZ &
.ZZ& '
NoZZ' )
;ZZ) *
}[[ 	
}\\ 
}]] ø?
ÖC:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\UseCases\Match\Preparation\MatchUseCase.FinalMissionPreparation.cs
	namespace 	
Application
 
. 
UseCases 
{		 
public

 

sealed

 
partial

 
class

 
MatchUseCase

  ,
{ 
private 
static $
MissionPreparationCommit /+
IdentifyRequestedHeartNineOwner0 O
(O P

MatchStateP Z
state[ `
,` a%
MissionPreparationRequest %
request& -
,- .
int/ 2
participantUserId3 D
)D E
{ 	$
MissionPreparationCommit $
commit% +
=, -
RejectPreparation. ?
(? @
request@ G
,G H'
MissionPreparationRejectionI d
.d e
InvalidTargete r
)r s
;s t
int 
	actorSeat 
= 
Array !
.! "
IndexOf" )
() *
state* /
./ 0
ParticipantUserIds0 B
,B C
participantUserIdD U
)U V
;V W
bool #
isIdentificationMission (
=) *
MissionCatalog+ 9
.9 :

GetMission: D
(D E
stateE J
.J K
MissionAttemptK Y
.Y Z
MissionNumberZ g
)g h
.h i
SpecialRulei t
==u w"
SpecialMissionRuleType &
.& '0
$M46_SeatLeftOfHeartNineWinsAllHearts' K
;K L
if 
( #
isIdentificationMission '
&&( *
state+ 0
.0 1
MissionAttempt1 ?
.? @

RoleConfig@ J
?J K
.K L
HeartNineOwnerSeatL ^
==_ a
	actorSeatb k
&&l n
state 
. #
PlayerHandCardIdsBySeat -
[- .
	actorSeat. 7
]7 8
.8 9
Contains9 A
(A B%
MissionObjectiveDealRulesB [
.[ \
HeartNineCardId\ k
)k l
)l m
{ 
commit 
= 
state 
. $
CommitSpecialPreparation 7
(7 8
request8 ?
,? @
participantUserIdA R
,R S
newT W$
SpecialPreparationChangeX p
{ 
UpdatedAttempt "
=# $
state% *
.* +
MissionAttempt+ 9
with: >
{ 

RoleConfig "
=# $
state% *
.* +
MissionAttempt+ 9
.9 :

RoleConfig: D
withE I
{J K'
HasIdentifiedHeartNineOwnerL g
=h i
truej n
}o p
,p q
Phase 
= 
MissionAttemptPhase  3
.3 4
PlayingTricks4 A
} 
, 
ResponsesBySeat #
=$ %
state& +
.+ , 
BlindResponsesBySeat, @
,@ A
HasStageChanged #
=$ %
true& *
} 
) 
; 
}   
return!! 
commit!! 
;!! 
}"" 	
private$$ 
static$$ $
MissionPreparationCommit$$ /,
 AssignRequestedTrickDistribution$$0 P
($$P Q

MatchState$$Q [
state$$\ a
,$$a b%
MissionPreparationRequest%% %
request%%& -
,%%- .
int%%/ 2
participantUserId%%3 D
)%%D E
{&& 	
var'' 
context'' 
='' 
new'' +
MissionTrickDistributionContext'' =
{(( 
Attempt)) 
=)) 
state)) 
.))  
MissionAttempt))  .
,)). /

Definition** 
=** 
MissionCatalog** +
.**+ ,

GetMission**, 6
(**6 7
state**7 <
.**< =
MissionAttempt**= K
.**K L
MissionNumber**L Y
)**Y Z
,**Z [!
ActingParticipantSeat++ %
=++& '
Array++( -
.++- .
IndexOf++. 5
(++5 6
state++6 ;
.++; <
ParticipantUserIds++< N
,++N O
participantUserId++P a
)++a b
,++b c%
FirstFourTricksWinnerSeat,, )
=,,* +
Array,,, 1
.,,1 2
IndexOf,,2 9
(,,9 :
state,,: ?
.,,? @
ParticipantUserIds,,@ R
,,,R S
request-- 
.-- 2
&FirstFourTricksWinnerParticipantUserId-- B
)--B C
,--C D
LastTrickWinnerSeat.. #
=..$ %
Array..& +
...+ ,
IndexOf.., 3
(..3 4
state..4 9
...9 :
ParticipantUserIds..: L
,..L M
request..N U
...U V,
 LastTrickWinnerParticipantUserId..V v
)..v w
}// 
;// '
MissionPreparationRejection00 '
	rejection00( 1
=002 3
context004 ;
.00; <!
ActingParticipantSeat00< Q
==00R T
state00U Z
.00Z [
MissionCaptainSeat00[ m
?11 '
MissionPreparationRejection11 -
.11- .
InvalidTarget11. ;
:11< ='
MissionPreparationRejection11> Y
.11Y Z
CaptainRequired11Z i
;11i j$
MissionPreparationCommit22 $
commit22% +
=22, -
RejectPreparation22. ?
(22? @
request22@ G
,22G H
	rejection22I R
)22R S
;22S T
if33 
(33 *
MissionSpecialPreparationRules33 .
.33. /&
CanAssignTrickDistribution33/ I
(33I J
context33J Q
)33Q R
)33R S
{44 
commit55 
=55 
state55 
.55 $
CommitSpecialPreparation55 7
(557 8
request558 ?
,55? @
participantUserId55A R
,55R S
new55T W$
SpecialPreparationChange55X p
{66 
UpdatedAttempt77 "
=77# $*
MissionSpecialPreparationRules77% C
.77C D#
AssignTrickDistribution77D [
(77[ \
context77\ c
)77c d
,77d e
ResponsesBySeat88 #
=88$ %
state88& +
.88+ , 
BlindResponsesBySeat88, @
,88@ A
HasStageChanged99 #
=99$ %
true99& *
}:: 
):: 
;:: 
};; 
return<< 
commit<< 
;<< 
}== 	
internal?? 
static?? 
int?? 
CountCapturedHearts?? /
(??/ 0

MatchState??0 :
state??; @
)??@ A
{@@ 	
byteAA 
?AA 

targetSeatAA 
=AA *
MissionSpecialPreparationRulesAA =
.AA= >'
GetRequiredHeartCaptureSeatAA> Y
(AAY Z
stateBB 
.BB 
MissionAttemptBB $
.BB$ %

RoleConfigBB% /
,BB/ 0
stateBB1 6
.BB6 7
ParticipantUserIdsBB7 I
.BBI J
LengthBBJ P
)BBP Q
;BBQ R
returnCC 

targetSeatCC 
.CC 
HasValueCC &
?CC' (
stateCC) .
.CC. /
WonCardIdsBySeatCC/ ?
[CC? @

targetSeatCC@ J
.CCJ K
ValueCCK P
]CCP Q
.CCQ R
CountCCR W
(CCW X
cardIdCCX ^
=>CC_ a
	DeckRulesDD 
.DD 
GetCardByIdDD %
(DD% &
cardIdDD& ,
)DD, -
.DD- .
SuitDD. 2
==DD3 5
CardSuitDD6 >
.DD> ?
HeartDD? D
)DDD E
:DDF G
$numDDH I
;DDI J
}EE 	
}FF 
}GG ÏÔ
ÄC:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\UseCases\Match\Preparation\MatchUseCase.SpecialPreparation.cs
	namespace		 	
Application		
 
.		 
UseCases		 
{

 
public 

sealed 
partial 
class 
MatchUseCase  ,
{ 
private 
const 
int /
#MaximumPreparationRequestsPerSecond =
=> ?
$num@ A
;A B
private 
const 
int -
!MaximumPreparationLobbyCodeLength ;
=< =
$num> @
;@ A
public $
MissionPreparationCommit '%
ProcessMissionPreparation( A
(A B%
MissionPreparationRequestB [
request\ c
,c d
inte h
participantUserId 
) 
{ 	
var 
commit 
= 
RejectPreparation *
(* +
request+ 2
,2 3'
MissionPreparationRejection4 O
.O P
InvalidSubmissionP a
)a b
;b c
if 
( 
request 
!= 
null 
&&  "
!# $
string$ *
.* +
IsNullOrWhiteSpace+ =
(= >
request> E
.E F
	LobbyCodeF O
)O P
&&Q S
request 
. 
	LobbyCode !
.! "
Length" (
<=) +-
!MaximumPreparationLobbyCodeLength, M
)M N
{ 

MatchState 

matchState %
=& '
_matchStateStore( 8
.8 9
	FindMatch9 B
(B C
requestC J
.J K
	LobbyCodeK T
)T U
;U V
commit 
= 
RejectPreparation *
(* +
request+ 2
,2 3'
MissionPreparationRejection4 O
.O P
MatchUnavailableP `
)` a
;a b
if 
( 

matchState 
!= !
null" &
)& '
{ 
lock 
( 

matchState $
)$ %
{ 
commit 
=  %
ResolveMissionPreparation! :
(: ;

matchState; E
,E F
requestG N
,N O
participantUserIdP a
)a b
;b c
} 
} 
}   
return!! 
commit!! 
;!! 
}"" 	
private$$ 
static$$ $
MissionPreparationCommit$$ /%
ResolveMissionPreparation$$0 I
($$I J

MatchState$$J T

matchState$$U _
,$$_ `%
MissionPreparationRequest%% %
request%%& -
,%%- .
int%%/ 2
participantUserId%%3 D
)%%D E
{&& 	'
MissionPreparationRejection'' '
	rejection''( 1
=''2 3'
ValidatePreparationIdentity''4 O
(''O P

matchState''P Z
,''Z [
request''\ c
,''c d
participantUserId''e v
)''v w
;''w x$
MissionPreparationCommit(( $
commit((% +
;((+ ,
if)) 
()) 
	rejection)) 
!=)) '
MissionPreparationRejection)) 8
.))8 9
None))9 =
)))= >
{** 
commit++ 
=++ 
RejectPreparation++ *
(++* +
request+++ 2
,++2 3
	rejection++4 =
)++= >
;++> ?
},, 
else-- 
if-- 
(-- 

matchState-- 
.--  +
ProcessedPreparationSubmissions--  ?
.--? @
TryGetValue--@ K
(--K L
request--L S
.--S T*
MissionPreparationSubmissionId--T r
,--r s
out.. '
ProcessedMissionPreparation.. /
previous..0 8
)..8 9
)..9 :
{// 
commit00 
=00 
previous00 !
.00! "
ParticipantUserId00" 3
==004 6
participantUserId007 H
&&00I K
previous00L T
.00T U
Request00U \
==00] _
request00` g
?11 
previous11 
.11 
Commit11 %
with11& *
{11+ ,
HasStateChanged11- <
=11= >
false11? D
}11E F
:22 
RejectPreparation22 '
(22' (
request22( /
,22/ 0'
MissionPreparationRejection221 L
.22L M$
SubmissionIdentityReused22M e
)22e f
;22f g
}33 
else44 
{55 
commit66 
=66 !
ProcessNewPreparation66 .
(66. /

matchState66/ 9
,669 :
request66; B
,66B C
participantUserId66D U
)66U V
;66V W
}77 
return88 
commit88 
;88 
}99 	
private;; 
static;; '
MissionPreparationRejection;; 2'
ValidatePreparationIdentity;;3 N
(;;N O

MatchState;;O Y

matchState;;Z d
,;;d e%
MissionPreparationRequest<< %
request<<& -
,<<- .
int<</ 2
participantUserId<<3 D
)<<D E
{== 	'
MissionPreparationRejection>> '
	rejection>>( 1
=>>2 3'
MissionPreparationRejection>>4 O
.>>O P
None>>P T
;>>T U
if?? 
(?? 
!?? 

matchState?? 
.?? 
ParticipantUserIds?? .
.??. /
Contains??/ 7
(??7 8
participantUserId??8 I
)??I J
)??J K
{@@ 
	rejectionAA 
=AA '
MissionPreparationRejectionAA 7
.AA7 8!
ParticipantNotAllowedAA8 M
;AAM N
}BB 
elseCC 
ifCC 
(CC 
requestCC 
.CC 
MatchIdCC $
!=CC% '

matchStateCC( 2
.CC2 3
MatchIdCC3 :
||CC; =
requestCC> E
.CCE F*
MissionPreparationSubmissionIdCCF d
==CCe g
GuidCCh l
.CCl m
EmptyCCm r
||CCs u
!DD 
EnumDD 
.DD 
	IsDefinedDD 
(DD  
typeofDD  &
(DD& '$
MissionPreparationActionDD' ?
)DD? @
,DD@ A
requestDDB I
.DDI J
ActionDDJ P
)DDP Q
||DDR T
!DDU V$
HasValidPreparationShapeDDV n
(DDn o
requestDDo v
)DDv w
)DDw x
{EE 
	rejectionFF 
=FF '
MissionPreparationRejectionFF 7
.FF7 8
InvalidSubmissionFF8 I
;FFI J
}GG 
elseHH 
ifHH 
(HH 
requestHH 
.HH 
MissionAttemptIdHH -
!=HH. 0

matchStateHH1 ;
.HH; <
MissionAttemptHH< J
.HHJ K
MissionAttemptIdHHK [
)HH[ \
{II 
	rejectionJJ 
=JJ '
MissionPreparationRejectionJJ 7
.JJ7 8
WrongMissionAttemptJJ8 K
;JJK L
}KK 
returnLL 
	rejectionLL 
;LL 
}MM 	
privateOO 
staticOO 
boolOO $
HasValidPreparationShapeOO 4
(OO4 5%
MissionPreparationRequestOO5 N
requestOOO V
)OOV W
{PP 	
boolQQ 
isValidQQ 
;QQ 
switchRR 
(RR 
requestRR 
.RR 
ActionRR "
)RR" #
{SS 
caseTT $
MissionPreparationActionTT -
.TT- .

AssignRoleTT. 8
:TT8 9
isValidUU 
=UU $
HasNoDistributionTargetsUU 6
(UU6 7
requestUU7 >
)UU> ?
&&UU@ B
requestUUC J
.UUJ K%
SelectedParticipantUserIdUUK d
!=UUe g
$numUUh i
&&UUj l
requestVV 
.VV  
ResponseVV  (
==VV) +)
BlindObjectiveCapableResponseVV, I
.VVI J
PendingVVJ Q
;VVQ R
breakWW 
;WW 
caseXX $
MissionPreparationActionXX -
.XX- .
RecordBlindResponseXX. A
:XXA B
isValidYY 
=YY (
HasValidBlindResponsePayloadYY :
(YY: ;
requestYY; B
)YYB C
;YYC D
breakZZ 
;ZZ 
case[[ $
MissionPreparationAction[[ -
.[[- ."
IdentifyHeartNineOwner[[. D
:[[D E
isValid\\ 
=\\ $
HasNoDistributionTargets\\ 6
(\\6 7
request\\7 >
)\\> ?
&&\\@ B"
HasNoSingleRolePayload\\C Y
(\\Y Z
request\\Z a
)\\a b
;\\b c
break]] 
;]] 
case^^ $
MissionPreparationAction^^ -
.^^- .#
AssignTrickDistribution^^. E
:^^E F
isValid__ 
=__ '
HasValidDistributionPayload__ 9
(__9 :
request__: A
)__A B
;__B C
break`` 
;`` 
defaultaa 
:aa 
isValidbb 
=bb 
falsebb #
;bb# $
breakcc 
;cc 
}dd 
returnee 
isValidee 
;ee 
}ff 	
privatehh 
statichh 
boolhh $
HasNoDistributionTargetshh 4
(hh4 5%
MissionPreparationRequesthh5 N
requesthhO V
)hhV W
{ii 	
returnjj 
requestjj 
.jj 2
&FirstFourTricksWinnerParticipantUserIdjj A
==jjB D
$numjjE F
&&jjG I
requestjjJ Q
.jjQ R,
 LastTrickWinnerParticipantUserIdjjR r
==jjs u
$numjjv w
;jjw x
}kk 	
privatemm 
staticmm 
boolmm "
HasNoSingleRolePayloadmm 2
(mm2 3%
MissionPreparationRequestmm3 L
requestmmM T
)mmT U
{nn 	
returnoo 
requestoo 
.oo %
SelectedParticipantUserIdoo 4
==oo5 7
$numoo8 9
&&oo: <
requestoo= D
.ooD E
ResponseooE M
==ooN P)
BlindObjectiveCapableResponseooQ n
.oon o
Pendingooo v
;oov w
}pp 	
privaterr 
staticrr 
boolrr (
HasValidBlindResponsePayloadrr 8
(rr8 9%
MissionPreparationRequestrr9 R
requestrrS Z
)rrZ [
{ss 	
returntt $
HasNoDistributionTargetstt +
(tt+ ,
requesttt, 3
)tt3 4
&&tt5 7
requesttt8 ?
.tt? @%
SelectedParticipantUserIdtt@ Y
==ttZ \
$numtt] ^
&&tt_ a
(uu 
requestuu 
.uu 
Responseuu !
==uu" $)
BlindObjectiveCapableResponseuu% B
.uuB C
YesuuC F
||uuG I
requestuuJ Q
.uuQ R
ResponseuuR Z
==uu[ ])
BlindObjectiveCapableResponsevv 1
.vv1 2
Novv2 4
)vv4 5
;vv5 6
}ww 	
privateyy 
staticyy 
boolyy '
HasValidDistributionPayloadyy 7
(yy7 8%
MissionPreparationRequestyy8 Q
requestyyR Y
)yyY Z
{zz 	
return{{ "
HasNoSingleRolePayload{{ )
({{) *
request{{* 1
){{1 2
&&{{3 5
request{{6 =
.{{= >2
&FirstFourTricksWinnerParticipantUserId{{> d
!={{e g
$num{{h i
&&{{j l
request|| 
.|| ,
 LastTrickWinnerParticipantUserId|| 8
!=||9 ;
$num||< =
;||= >
}}} 	
private 
static $
MissionPreparationCommit /!
ProcessNewPreparation0 E
(E F

MatchStateF P

matchStateQ [
,[ \'
MissionPreparationRequest
ÄÄ %
request
ÄÄ& -
,
ÄÄ- .
int
ÄÄ/ 2
participantUserId
ÄÄ3 D
)
ÄÄD E
{
ÅÅ 	)
MissionPreparationRejection
ÇÇ '
	rejection
ÇÇ( 1
=
ÇÇ2 3'
ValidatePreparationWindow
ÇÇ4 M
(
ÇÇM N

matchState
ÇÇN X
,
ÇÇX Y
request
ÇÇZ a
,
ÇÇa b
participantUserId
ÇÇc t
)
ÇÇt u
;
ÇÇu v&
MissionPreparationCommit
ÉÉ $
commit
ÉÉ% +
=
ÉÉ, -
RejectPreparation
ÉÉ. ?
(
ÉÉ? @
request
ÉÉ@ G
,
ÉÉG H
	rejection
ÉÉI R
)
ÉÉR S
;
ÉÉS T
if
ÑÑ 
(
ÑÑ 
	rejection
ÑÑ 
==
ÑÑ )
MissionPreparationRejection
ÑÑ 8
.
ÑÑ8 9
None
ÑÑ9 =
)
ÑÑ= >
{
ÖÖ 
commit
ÜÜ 
=
ÜÜ (
CommitRequestedPreparation
ÜÜ 3
(
ÜÜ3 4

matchState
ÜÜ4 >
,
ÜÜ> ?
request
ÜÜ@ G
,
ÜÜG H
participantUserId
ÜÜI Z
)
ÜÜZ [
;
ÜÜ[ \
}
áá 
return
àà 
commit
àà 
;
àà 
}
ââ 	
private
ãã 
static
ãã &
MissionPreparationCommit
ãã /(
CommitRequestedPreparation
ãã0 J
(
ããJ K

MatchState
ããK U

matchState
ããV `
,
ãã` a'
MissionPreparationRequest
åå %
request
åå& -
,
åå- .
int
åå/ 2
participantUserId
åå3 D
)
ååD E
{
çç 	&
MissionPreparationCommit
éé $
commit
éé% +
;
éé+ ,
switch
èè 
(
èè 
request
èè 
.
èè 
Action
èè "
)
èè" #
{
êê 
case
ëë &
MissionPreparationAction
ëë -
.
ëë- .

AssignRole
ëë. 8
:
ëë8 9
commit
íí 
=
íí (
AssignRequestedMissionRole
íí 7
(
íí7 8

matchState
íí8 B
,
ííB C
request
ííD K
,
ííK L
participantUserId
ííM ^
)
íí^ _
;
íí_ `
break
ìì 
;
ìì 
case
îî &
MissionPreparationAction
îî -
.
îî- .!
RecordBlindResponse
îî. A
:
îîA B
commit
ïï 
=
ïï !
RecordBlindResponse
ïï 0
(
ïï0 1

matchState
ïï1 ;
,
ïï; <
request
ïï= D
,
ïïD E
participantUserId
ïïF W
)
ïïW X
;
ïïX Y
break
ññ 
;
ññ 
case
óó &
MissionPreparationAction
óó -
.
óó- .$
IdentifyHeartNineOwner
óó. D
:
óóD E
commit
òò 
=
òò -
IdentifyRequestedHeartNineOwner
òò <
(
òò< =

matchState
òò= G
,
òòG H
request
òòI P
,
òòP Q
participantUserId
òòR c
)
òòc d
;
òòd e
break
ôô 
;
ôô 
case
öö &
MissionPreparationAction
öö -
.
öö- .%
AssignTrickDistribution
öö. E
:
ööE F
commit
õõ 
=
õõ .
 AssignRequestedTrickDistribution
õõ =
(
õõ= >

matchState
õõ> H
,
õõH I
request
õõJ Q
,
õõQ R
participantUserId
õõS d
)
õõd e
;
õõe f
break
úú 
;
úú 
default
ùù 
:
ùù 
commit
ûû 
=
ûû 
RejectPreparation
ûû .
(
ûû. /
request
ûû/ 6
,
ûû6 7)
MissionPreparationRejection
ûû8 S
.
ûûS T
InvalidSubmission
ûûT e
)
ûûe f
;
ûûf g
break
üü 
;
üü 
}
†† 
return
°° 
commit
°° 
;
°° 
}
¢¢ 	
private
§§ 
static
§§ )
MissionPreparationRejection
§§ 2'
ValidatePreparationWindow
§§3 L
(
§§L M

MatchState
§§M W

matchState
§§X b
,
§§b c'
MissionPreparationRequest
•• %
request
••& -
,
••- .
int
••/ 2
participantUserId
••3 D
)
••D E
{
¶¶ 	)
MissionPreparationRejection
ßß '
	rejection
ßß( 1
=
ßß2 3)
MissionPreparationRejection
ßß4 O
.
ßßO P!
RequestLimitReached
ßßP c
;
ßßc d
if
®® 
(
®® &
MatchActionRequestLimits
®® (
.
®®( )&
ConsumeParticipantWindow
®®) A
(
®®A B

matchState
®®B L
.
®®L M-
PreparationBudgetsByParticipant
®®M l
,
®®l m
participantUserId
©© !
,
©©! "1
#MaximumPreparationRequestsPerSecond
©©# F
)
©©F G
!=
©©H J
null
©©K O
)
©©O P
{
™™ 
	rejection
´´ 
=
´´ &
ValidatePreparationStage
´´ 4
(
´´4 5

matchState
´´5 ?
,
´´? @
request
´´A H
)
´´H I
;
´´I J
}
¨¨ 
return
≠≠ 
	rejection
≠≠ 
;
≠≠ 
}
ÆÆ 	
private
∞∞ 
static
∞∞ )
MissionPreparationRejection
∞∞ 2&
ValidatePreparationStage
∞∞3 K
(
∞∞K L

MatchState
∞∞L V

matchState
∞∞W a
,
∞∞a b'
MissionPreparationRequest
±± %
request
±±& -
)
±±- .
{
≤≤ 	)
MissionPreparationRejection
≥≥ '
	rejection
≥≥( 1
=
≥≥2 3)
MissionPreparationRejection
≥≥4 O
.
≥≥O P
None
≥≥P T
;
≥≥T U
if
¥¥ 
(
¥¥ 

matchState
¥¥ 
.
¥¥ 
MissionAttempt
¥¥ )
.
¥¥) *
Phase
¥¥* /
!=
¥¥0 2!
MissionAttemptPhase
¥¥3 F
.
¥¥F G 
RoleAndPreparation
¥¥G Y
||
¥¥Z \
request
µµ 
.
µµ '
MissionPreparationStageId
µµ 1
!=
µµ2 4

matchState
µµ5 ?
.
µµ? @'
MissionPreparationStageId
µµ@ Y
)
µµY Z
{
∂∂ 
	rejection
∑∑ 
=
∑∑ )
MissionPreparationRejection
∑∑ 7
.
∑∑7 8
StageMismatch
∑∑8 E
;
∑∑E F
}
∏∏ 
else
ππ 
{
∫∫ 
bool
ªª 
isCurrentVersion
ªª %
=
ªª& '
request
ªª( /
.
ªª/ 0
Action
ªª0 6
!=
ªª7 9&
MissionPreparationAction
ªª: R
.
ªªR S!
RecordBlindResponse
ªªS f
?
ºº 
request
ºº 
.
ºº '
ExpectedMatchStateVersion
ºº 7
==
ºº8 :

matchState
ºº; E
.
ººE F
MatchStateVersion
ººF W
:
ΩΩ 
request
ΩΩ 
.
ΩΩ '
ExpectedMatchStateVersion
ΩΩ 7
>=
ΩΩ8 :

matchState
ΩΩ; E
.
ΩΩE F+
PreparationStageOpenedVersion
ΩΩF c
&&
ΩΩd f
request
ææ 
.
ææ  '
ExpectedMatchStateVersion
ææ  9
<=
ææ: <

matchState
ææ= G
.
ææG H
MatchStateVersion
ææH Y
;
ææY Z
	rejection
øø 
=
øø 
isCurrentVersion
øø ,
?
øø- .)
MissionPreparationRejection
øø/ J
.
øøJ K
None
øøK O
:
øøP Q)
MissionPreparationRejection
¿¿ /
.
¿¿/ 0
StaleMatchState
¿¿0 ?
;
¿¿? @
}
¡¡ 
return
¬¬ 
	rejection
¬¬ 
;
¬¬ 
}
√√ 	
private
≈≈ 
static
≈≈ &
MissionPreparationCommit
≈≈ /(
AssignRequestedMissionRole
≈≈0 J
(
≈≈J K

MatchState
≈≈K U

matchState
≈≈V `
,
≈≈` a'
MissionPreparationRequest
∆∆ %
request
∆∆& -
,
∆∆- .
int
∆∆/ 2
participantUserId
∆∆3 D
)
∆∆D E
{
«« 	
int
»» 
	actorSeat
»» 
=
»» 
Array
»» !
.
»»! "
IndexOf
»»" )
(
»») *

matchState
»»* 4
.
»»4 5 
ParticipantUserIds
»»5 G
,
»»G H
participantUserId
»»I Z
)
»»Z [
;
»»[ \
int
…… 

targetSeat
…… 
=
…… 
Array
…… "
.
……" #
IndexOf
……# *
(
……* +

matchState
……+ 5
.
……5 6 
ParticipantUserIds
……6 H
,
……H I
request
……J Q
.
……Q R'
SelectedParticipantUserId
……R k
)
……k l
;
……l m
var
   
context
   
=
   
CreateRoleContext
   +
(
  + ,

matchState
  , 6
,
  6 7
	actorSeat
  8 A
,
  A B

targetSeat
  C M
)
  M N
;
  N O)
MissionPreparationRejection
ÀÀ '
	rejection
ÀÀ( 1
=
ÀÀ2 3)
MissionPreparationRejection
ÀÀ4 O
.
ÀÀO P
InvalidTarget
ÀÀP ]
;
ÀÀ] ^&
MissionPreparationCommit
ÃÃ $
commit
ÃÃ% +
=
ÃÃ, -
null
ÃÃ. 2
;
ÃÃ2 3
if
ÕÕ 
(
ÕÕ 
	actorSeat
ÕÕ 
!=
ÕÕ 

matchState
ÕÕ '
.
ÕÕ' ( 
MissionCaptainSeat
ÕÕ( :
)
ÕÕ: ;
{
ŒŒ 
	rejection
œœ 
=
œœ )
MissionPreparationRejection
œœ 7
.
œœ7 8
CaptainRequired
œœ8 G
;
œœG H
}
–– 
else
—— 
if
—— 
(
—— 
MissionSetupRules
—— &
.
——& ',
IsBlindObjectiveAssignmentRule
——' E
(
——E F
context
——F M
.
——M N

Definition
——N X
.
——X Y
SpecialRule
——Y d
)
——d e
&&
——f h
!
““ 
MissionSetupRules
““ "
.
““" #*
AreAllBlindResponsesRecorded
““# ?
(
““? @

matchState
““@ J
.
““J K"
BlindResponsesBySeat
““K _
,
““_ `

matchState
”” 
.
””  
ParticipantUserIds
”” 1
.
””1 2
Length
””2 8
,
””8 9
(
””: ;
byte
””; ?
)
””? @

matchState
””@ J
.
””J K 
MissionCaptainSeat
””K ]
)
””] ^
)
””^ _
{
‘‘ 
	rejection
’’ 
=
’’ )
MissionPreparationRejection
’’ 7
.
’’7 8
ResponsesPending
’’8 H
;
’’H I
}
÷÷ 
else
◊◊ 
if
◊◊ 
(
◊◊ ,
MissionSpecialPreparationRules
◊◊ 3
.
◊◊3 4
CanAssignRole
◊◊4 A
(
◊◊A B
context
◊◊B I
)
◊◊I J
)
◊◊J K
{
ÿÿ 
commit
ŸŸ 
=
ŸŸ 

matchState
ŸŸ #
.
ŸŸ# $&
CommitSpecialPreparation
ŸŸ$ <
(
ŸŸ< =
request
ŸŸ= D
,
ŸŸD E
participantUserId
ŸŸF W
,
ŸŸW X
new
ŸŸY \&
SpecialPreparationChange
ŸŸ] u
{
⁄⁄ 
UpdatedAttempt
€€ "
=
€€# $,
MissionSpecialPreparationRules
€€% C
.
€€C D

AssignRole
€€D N
(
€€N O
context
€€O V
)
€€V W
,
€€W X
ResponsesBySeat
‹‹ #
=
‹‹$ %

matchState
‹‹& 0
.
‹‹0 1"
BlindResponsesBySeat
‹‹1 E
,
‹‹E F
HasStageChanged
›› #
=
››$ %
true
››& *
}
ﬁﬁ 
)
ﬁﬁ 
;
ﬁﬁ 
}
ﬂﬂ 
return
‡‡ 
commit
‡‡ 
??
‡‡ 
RejectPreparation
‡‡ .
(
‡‡. /
request
‡‡/ 6
,
‡‡6 7
	rejection
‡‡8 A
)
‡‡A B
;
‡‡B C
}
·· 	
internal
„„ 
static
„„ *
MissionRoleAssignmentContext
„„ 4
CreateRoleContext
„„5 F
(
„„F G

MatchState
„„G Q

matchState
„„R \
,
„„\ ]
int
„„^ a
	actorSeat
„„b k
,
„„k l
int
„„m p

targetSeat
‰‰ 
)
‰‰ 
{
ÂÂ 	
return
ÊÊ 
new
ÊÊ *
MissionRoleAssignmentContext
ÊÊ 3
{
ÁÁ 
Attempt
ËË 
=
ËË 

matchState
ËË $
.
ËË$ %
MissionAttempt
ËË% 3
,
ËË3 4

Definition
ÈÈ 
=
ÈÈ 
MissionCatalog
ÈÈ +
.
ÈÈ+ ,

GetMission
ÈÈ, 6
(
ÈÈ6 7

matchState
ÈÈ7 A
.
ÈÈA B
MissionAttempt
ÈÈB P
.
ÈÈP Q
MissionNumber
ÈÈQ ^
)
ÈÈ^ _
,
ÈÈ_ `#
ActingParticipantSeat
ÍÍ %
=
ÍÍ& '
	actorSeat
ÍÍ( 1
,
ÍÍ1 2%
SelectedParticipantSeat
ÎÎ '
=
ÎÎ( )

targetSeat
ÎÎ* 4
,
ÎÎ4 5
ResponsesBySeat
ÏÏ 
=
ÏÏ  !

matchState
ÏÏ" ,
.
ÏÏ, -"
BlindResponsesBySeat
ÏÏ- A
}
ÌÌ 
;
ÌÌ 
}
ÓÓ 	
private
 
static
 &
MissionPreparationCommit
 /!
RecordBlindResponse
0 C
(
C D

MatchState
D N

matchState
O Y
,
Y Z'
MissionPreparationRequest
ÒÒ %
request
ÒÒ& -
,
ÒÒ- .
int
ÒÒ/ 2
participantUserId
ÒÒ3 D
)
ÒÒD E
{
ÚÚ 	
byte
ÛÛ 
seat
ÛÛ 
=
ÛÛ 
(
ÛÛ 
byte
ÛÛ 
)
ÛÛ 
Array
ÛÛ #
.
ÛÛ# $
IndexOf
ÛÛ$ +
(
ÛÛ+ ,

matchState
ÛÛ, 6
.
ÛÛ6 7 
ParticipantUserIds
ÛÛ7 I
,
ÛÛI J
participantUserId
ÛÛK \
)
ÛÛ\ ]
;
ÛÛ] ^)
MissionPreparationRejection
ÙÙ '
	rejection
ÙÙ( 1
=
ÙÙ2 3)
MissionPreparationRejection
ÙÙ4 O
.
ÙÙO P
InvalidSubmission
ÙÙP a
;
ÙÙa b
bool
ıı 
isBlindMission
ıı 
=
ıı  !
MissionSetupRules
ıı" 3
.
ıı3 4,
IsBlindObjectiveAssignmentRule
ıı4 R
(
ııR S
MissionCatalog
ˆˆ 
.
ˆˆ 

GetMission
ˆˆ )
(
ˆˆ) *

matchState
ˆˆ* 4
.
ˆˆ4 5
MissionAttempt
ˆˆ5 C
.
ˆˆC D
MissionNumber
ˆˆD Q
)
ˆˆQ R
.
ˆˆR S
SpecialRule
ˆˆS ^
)
ˆˆ^ _
;
ˆˆ_ `
if
˜˜ 
(
˜˜ 
isBlindMission
˜˜ 
&&
˜˜ !
seat
˜˜" &
!=
˜˜' )

matchState
˜˜* 4
.
˜˜4 5 
MissionCaptainSeat
˜˜5 G
)
˜˜G H
{
¯¯ 
	rejection
˘˘ 
=
˘˘ 

matchState
˘˘ &
.
˘˘& '"
BlindResponsesBySeat
˘˘' ;
.
˘˘; <
ContainsKey
˘˘< G
(
˘˘G H
seat
˘˘H L
)
˘˘L M
?
˙˙ )
MissionPreparationRejection
˙˙ 1
.
˙˙1 2
AlreadyAnswered
˙˙2 A
:
˙˙B C)
MissionPreparationRejection
˙˙D _
.
˙˙_ `
None
˙˙` d
;
˙˙d e
}
˚˚ 
var
¸¸ 
commit
¸¸ 
=
¸¸ 
RejectPreparation
¸¸ *
(
¸¸* +
request
¸¸+ 2
,
¸¸2 3
	rejection
¸¸4 =
)
¸¸= >
;
¸¸> ?
if
˝˝ 
(
˝˝ 
	rejection
˝˝ 
==
˝˝ )
MissionPreparationRejection
˝˝ 8
.
˝˝8 9
None
˝˝9 =
)
˝˝= >
{
˛˛ 
var
ˇˇ 
	responses
ˇˇ 
=
ˇˇ 

matchState
ˇˇ  *
.
ˇˇ* +"
BlindResponsesBySeat
ˇˇ+ ?
.
ˇˇ? @
ToDictionary
ˇˇ@ L
(
ˇˇL M
entry
ˇˇM R
=>
ˇˇS U
entry
ˇˇV [
.
ˇˇ[ \
Key
ˇˇ\ _
,
ˇˇ_ `
entry
ˇˇa f
=>
ˇˇg i
entry
ˇˇj o
.
ˇˇo p
Value
ˇˇp u
)
ˇˇu v
;
ˇˇv w
	responses
ÄÄ 
.
ÄÄ 
Add
ÄÄ 
(
ÄÄ 
seat
ÄÄ "
,
ÄÄ" #
request
ÄÄ$ +
.
ÄÄ+ ,
Response
ÄÄ, 4
)
ÄÄ4 5
;
ÄÄ5 6
bool
ÅÅ 

isComplete
ÅÅ 
=
ÅÅ  !
MissionSetupRules
ÅÅ" 3
.
ÅÅ3 4*
AreAllBlindResponsesRecorded
ÅÅ4 P
(
ÅÅP Q
	responses
ÅÅQ Z
,
ÅÅZ [

matchState
ÇÇ 
.
ÇÇ  
ParticipantUserIds
ÇÇ 1
.
ÇÇ1 2
Length
ÇÇ2 8
,
ÇÇ8 9
(
ÇÇ: ;
byte
ÇÇ; ?
)
ÇÇ? @

matchState
ÇÇ@ J
.
ÇÇJ K 
MissionCaptainSeat
ÇÇK ]
)
ÇÇ] ^
;
ÇÇ^ _
commit
ÉÉ 
=
ÉÉ 

matchState
ÉÉ #
.
ÉÉ# $&
CommitSpecialPreparation
ÉÉ$ <
(
ÉÉ< =
request
ÉÉ= D
,
ÉÉD E
participantUserId
ÉÉF W
,
ÉÉW X
new
ÉÉY \&
SpecialPreparationChange
ÉÉ] u
{
ÑÑ 
UpdatedAttempt
ÖÖ "
=
ÖÖ# $

matchState
ÖÖ% /
.
ÖÖ/ 0
MissionAttempt
ÖÖ0 >
,
ÖÖ> ?
ResponsesBySeat
ÜÜ #
=
ÜÜ$ %
	responses
ÜÜ& /
,
ÜÜ/ 0
HasStageChanged
áá #
=
áá$ %

isComplete
áá& 0
}
àà 
)
àà 
;
àà 
}
ââ 
return
ää 
commit
ää 
;
ää 
}
ãã 	
private
çç 
static
çç &
MissionPreparationCommit
çç /
RejectPreparation
çç0 A
(
ççA B'
MissionPreparationRequest
ççB [
request
çç\ c
,
ççc d)
MissionPreparationRejection
éé '
	rejection
éé( 1
)
éé1 2
{
èè 	
return
êê 
new
êê &
MissionPreparationCommit
êê /
{
ëë ,
MissionPreparationSubmissionId
íí .
=
íí/ 0
request
íí1 8
?
íí8 9
.
íí9 :,
MissionPreparationSubmissionId
íí: X
??
ííY [
Guid
íí\ `
.
íí` a
Empty
íía f
,
ííf g
	Rejection
ìì 
=
ìì 
	rejection
ìì %
}
îî 
;
îî 
}
ïï 	
}
ññ 
}óó Ÿ-
vC:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\Models\Match\State\MatchState.SpecialPreparation.cs
	namespace 	
Application
 
. 
Models 
{ 
public 

sealed 
partial 
class 

MatchState  *
{ 
public		 
Guid		 %
MissionPreparationStageId		 -
{		. /
get		0 3
;		3 4
private		5 <
set		= @
;		@ A
}		B C
public

 
long

 )
PreparationStageOpenedVersion

 1
{

2 3
get

4 7
;

7 8
private

9 @
set

A D
;

D E
}

F G
public 
IReadOnlyDictionary "
<" #
byte# '
,' ()
BlindObjectiveCapableResponse) F
>F G 
BlindResponsesBySeatH \
{] ^
get_ b
;b c
privated k
setl o
;o p
}q r
=s t
new 

Dictionary 
< 
byte 
,  )
BlindObjectiveCapableResponse! >
>> ?
(? @
)@ A
;A B
public 

Dictionary 
< 
Guid 
, '
ProcessedMissionPreparation  ;
>; <+
ProcessedPreparationSubmissions= \
{] ^
get_ b
;b c
}d e
=f g
new 

Dictionary 
< 
Guid 
,  '
ProcessedMissionPreparation! <
>< =
(= >
)> ?
;? @
public 

Dictionary 
< 
int 
, $
MatchActionRequestBudget 7
>7 8+
PreparationBudgetsByParticipant9 X
{Y Z
get[ ^
;^ _
}` a
=b c
new 

Dictionary 
< 
int 
, $
MatchActionRequestBudget  8
>8 9
(9 :
): ;
;; <
internal $
MissionPreparationCommit )$
CommitSpecialPreparation* B
(B C%
MissionPreparationRequestC \
request] d
,d e
int 
participantUserId !
,! "$
SpecialPreparationChange# ;
preparedChange< J
)J K
{ 	
var 
commit 
= 
new $
MissionPreparationCommit 5
{ *
MissionPreparationSubmissionId .
=/ 0
request1 8
.8 9*
MissionPreparationSubmissionId9 W
,W X&
CommittedMatchStateVersion *
=+ ,
MatchStateVersion- >
+? @
$numA B
,B C
HasStateChanged 
=  !
true" &
} 
; 
var 
retained 
= 
new '
ProcessedMissionPreparation :
{; <
ParticipantUserId= N
=O P
participantUserIdQ b
,b c
Request 
= 
request !
,! "
Commit# )
=* +
commit, 2
}3 4
;4 5
Guid 
nextStageId 
= 
preparedChange -
.- .
HasStageChanged. =
?> ?
Guid@ D
.D E
NewGuidE L
(L M
)M N
:O P%
MissionPreparationStageIdQ j
;j k+
ProcessedPreparationSubmissions +
.+ ,
Add, /
(/ 0
request0 7
.7 8*
MissionPreparationSubmissionId8 V
,V W
retainedX `
)` a
;a b
MissionAttempt 
= 
preparedChange +
.+ ,
UpdatedAttempt, :
;: ; 
BlindResponsesBySeat    
=  ! "
preparedChange  # 1
.  1 2
ResponsesBySeat  2 A
;  A B
MatchStateVersion!! 
=!! 
commit!!  &
.!!& '&
CommittedMatchStateVersion!!' A
;!!A B
if"" 
("" 
preparedChange"" 
."" 
HasStageChanged"" .
)"". /
{## %
MissionPreparationStageId$$ )
=$$* +
nextStageId$$, 7
;$$7 8)
PreparationStageOpenedVersion%% -
=%%. /
MatchStateVersion%%0 A
;%%A B
}&& 
return'' 
commit'' 
;'' 
}(( 	
private** 
void** (
ResetSpecialPreparationState** 1
(**1 2
bool**2 6
isInitialAttempt**7 G
)**G H
{++ 	
TrickStatistics,, 
=,, 
new,, !"
MissionTrickStatistics,," 8
(,,8 9
),,9 :
;,,: ;%
MissionPreparationStageId-- %
=--& '
Guid--( ,
.--, -
NewGuid--- 4
(--4 5
)--5 6
;--6 7)
PreparationStageOpenedVersion.. )
=..* +
MatchStateVersion.., =
+..> ?
(..@ A
isInitialAttempt..A Q
?..R S
$num..T U
:..V W
$num..X Y
)..Y Z
;..Z [ 
BlindResponsesBySeat//  
=//! "
new//# &

Dictionary//' 1
<//1 2
byte//2 6
,//6 7)
BlindObjectiveCapableResponse//8 U
>//U V
(//V W
)//W X
;//X Y+
ProcessedPreparationSubmissions00 +
.00+ ,
Clear00, 1
(001 2
)002 3
;003 4
}11 	
}22 
}33 ø
vC:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\Models\Match\Preparation\PreparedTrickEvaluation.cs
	namespace 	
Application
 
. 
Models 
{ 
public		 

sealed		 
record		 #
PreparedTrickEvaluation		 0
{

 
public $
MissionEvaluationContext '
Context( /
{0 1
get2 5
;5 6
init7 ;
;; <
}= >
public "
MissionTrickStatistics %

Statistics& 0
{1 2
get3 6
;6 7
init8 <
;< =
}> ?
} 
} —
wC:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\Models\Match\Preparation\SpecialPreparationChange.cs
	namespace 	
Application
 
. 
Models 
{ 
public		 

sealed		 
record		 $
SpecialPreparationChange		 1
{

 
public 
MissionAttemptState "
UpdatedAttempt# 1
{2 3
get4 7
;7 8
init9 =
;= >
}? @
public 
IReadOnlyDictionary "
<" #
byte# '
,' ()
BlindObjectiveCapableResponse) F
>F G
ResponsesBySeatH W
{X Y
getZ ]
;] ^
init_ c
;c d
}e f
public 
bool 
HasStageChanged #
{$ %
get& )
;) *
init+ /
;/ 0
}1 2
} 
} È
zC:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\Models\Match\Preparation\ProcessedMissionPreparation.cs
	namespace 	
Application
 
. 
Models 
{ 
public		 

sealed		 
record		 '
ProcessedMissionPreparation		 4
{

 
public 
int 
ParticipantUserId $
{% &
get' *
;* +
init, 0
;0 1
}2 3
public %
MissionPreparationRequest (
Request) 0
{1 2
get3 6
;6 7
init8 <
;< =
}> ?
public $
MissionPreparationCommit '
Commit( .
{/ 0
get1 4
;4 5
init6 :
;: ;
}< =
} 
} ó
wC:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\Models\Match\Preparation\MissionPreparationCommit.cs
	namespace 	
Application
 
. 
Models 
{ 
public		 

sealed		 
record		 $
MissionPreparationCommit		 1
{

 
public 
Guid *
MissionPreparationSubmissionId 2
{3 4
get5 8
;8 9
init: >
;> ?
}@ A
public 
long &
CommittedMatchStateVersion .
{/ 0
get1 4
;4 5
init6 :
;: ;
}< =
public 
bool 
HasStateChanged #
{$ %
get& )
;) *
init+ /
;/ 0
}1 2
public '
MissionPreparationRejection *
	Rejection+ 4
{5 6
get7 :
;: ;
init< @
;@ A
}B C
} 
} ø
xC:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\Models\Match\Preparation\MissionPreparationRequest.cs
	namespace 	
Application
 
. 
Models 
{ 
public		 

sealed		 
record		 %
MissionPreparationRequest		 2
{

 
public 
string 
	LobbyCode 
{  !
get" %
;% &
init' +
;+ ,
}- .
public 
Guid 
MatchId 
{ 
get !
;! "
init# '
;' (
}) *
public 
int 
MissionAttemptId #
{$ %
get& )
;) *
init+ /
;/ 0
}1 2
public 
Guid %
MissionPreparationStageId -
{. /
get0 3
;3 4
init5 9
;9 :
}; <
public 
Guid *
MissionPreparationSubmissionId 2
{3 4
get5 8
;8 9
init: >
;> ?
}@ A
public 
long %
ExpectedMatchStateVersion -
{. /
get0 3
;3 4
init5 9
;9 :
}; <
public $
MissionPreparationAction '
Action( .
{/ 0
get1 4
;4 5
init6 :
;: ;
}< =
public 
int %
SelectedParticipantUserId ,
{- .
get/ 2
;2 3
init4 8
;8 9
}: ;
public 
int 2
&FirstFourTricksWinnerParticipantUserId 9
{: ;
get< ?
;? @
initA E
;E F
}G H
public 
int ,
 LastTrickWinnerParticipantUserId 3
{4 5
get6 9
;9 :
init; ?
;? @
}A B
public )
BlindObjectiveCapableResponse ,
Response- 5
{6 7
get8 ;
;; <
init= A
;A B
}C D
}   
}!! ŸU
ÖC:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\UseCases\Match\Radio\MatchSnapshotProjection.RadioCommunication.cs
	namespace 	
Application
 
. 
UseCases 
{ 
internal		 
static		 
partial		 
class		 !#
MatchSnapshotProjection		" 9
{

 
private 
static ,
 PlayerRadioCommunicationSnapshot 7
[7 8
]8 9%
CreateRadioCommunications: S
(S T

MatchStateT ^

matchState_ i
)i j
{ 	
return 

matchState 
. 2
&RadioCommunicationsByParticipantUserId D
.D E
ValuesE K
.K L
SelectL R
(R S
communicationS `
=>a c
new ,
 PlayerRadioCommunicationSnapshot 4
{ 
ParticipantUserId %
=& '
communication( 5
.5 6
ParticipantUserId6 G
,G H
CommunicatedCardId &
=' (
communication) 6
.6 7
Request7 >
.> ?
CardId? E
,E F
Marker 
=  
MapPublicRadioMarker 1
(1 2
communication2 ?
.? @ 
ResolvedPublicMarker@ T
)T U
,U V)
HasCommunicatedCardBeenPlayed 1
=2 3
!4 5

matchState5 ?
.? @#
PlayerHandCardIdsBySeat@ W
[W X
System 
. 
Array $
.$ %
IndexOf% ,
(, -

matchState- 7
.7 8
ParticipantUserIds8 J
,J K
communicationL Y
.Y Z
ParticipantUserIdZ k
)k l
]l m
. 
Contains !
(! "
communication" /
./ 0
Request0 7
.7 8
CardId8 >
)> ?
} 
) 
. 
ToArray 
( 
) 
; 
} 	
private 
static $
RadioCommunicationMarker / 
MapPublicRadioMarker0 D
(D E
RadioPublicMarkerE V
markerW ]
)] ^
{ 	
return  
s_publicRadioMarkers '
[' (
marker( .
]. /
;/ 0
} 	
private 
static 
readonly 
System  &
.& '
Collections' 2
.2 3
Generic3 :
.: ;
IReadOnlyDictionary; N
<N O
RadioPublicMarkerO `
,` a$
RadioCommunicationMarker $
>$ % 
s_publicRadioMarkers& :
=; <
new   
System   
.   
Collections   "
.  " #
Generic  # *
.  * +

Dictionary  + 5
<  5 6
RadioPublicMarker  6 G
,  G H$
RadioCommunicationMarker  I a
>  a b
{!! 
{"" 
RadioPublicMarker"" #
.""# $
None""$ (
,""( )$
RadioCommunicationMarker""* B
.""B C
None""C G
}""H I
,""I J
{## 
RadioPublicMarker## #
.### $
Highest##$ +
,##+ ,$
RadioCommunicationMarker##- E
.##E F
Highest##F M
}##N O
,##O P
{$$ 
RadioPublicMarker$$ #
.$$# $
Only$$$ (
,$$( )$
RadioCommunicationMarker$$* B
.$$B C
Only$$C G
}$$H I
,$$I J
{%% 
RadioPublicMarker%% #
.%%# $
Lowest%%$ *
,%%* +$
RadioCommunicationMarker%%, D
.%%D E
Lowest%%E K
}%%L M
,%%M N
{&& 
RadioPublicMarker&& #
.&&# $
Hidden&&$ *
,&&* +$
RadioCommunicationMarker&&, D
.&&D E
Hidden&&E K
}&&L M
}'' 
;'' 
private)) 
static)) "
RadioCommunicationMode)) -
GetRadioMode)). :
()): ;

MatchState)); E
state))F K
)))K L
{** 	!
CommunicationRuleType++ !
mode++" &
=++' (
MissionCatalog,, 
.,, 

GetMission,, )
(,,) *
state,,* /
.,,/ 0
MissionAttempt,,0 >
.,,> ?
MissionNumber,,? L
),,L M
.,,M N
CommunicationRule,,N _
;,,_ `
return-- 
s_radioModes-- 
[--  
mode--  $
]--$ %
;--% &
}.. 	
private00 
static00 
readonly00 
System00  &
.00& '
Collections00' 2
.002 3
Generic003 :
.00: ;
IReadOnlyDictionary00; N
<00N O!
CommunicationRuleType00O d
,00d e"
RadioCommunicationMode11 "
>11" #
s_radioModes11$ 0
=111 2
new22 
System22 
.22 
Collections22 "
.22" #
Generic22# *
.22* +

Dictionary22+ 5
<225 6!
CommunicationRuleType226 K
,22K L"
RadioCommunicationMode22M c
>22c d
{33 
{44 !
CommunicationRuleType44 '
.44' (
Standard44( 0
,440 1"
RadioCommunicationMode442 H
.44H I
Standard44I Q
}44R S
,44S T
{55 !
CommunicationRuleType55 '
.55' (
Interference55( 4
,554 5"
RadioCommunicationMode556 L
.55L M
Interference55M Y
}55Z [
,55[ \
{66 !
CommunicationRuleType66 '
.66' (!
DisruptionUntilTrick266( =
,66= >"
RadioCommunicationMode66? U
.66U V!
DisruptionUntilTrick266V k
}66l m
,66m n
{77 !
CommunicationRuleType77 '
.77' (!
DisruptionUntilTrick377( =
,77= >"
RadioCommunicationMode77? U
.77U V!
DisruptionUntilTrick377V k
}77l m
}88 
;88 
private:: 
static:: %
RadioAvailabilitySnapshot:: 0#
CreateRadioAvailability::1 H
(::H I

MatchState::I S
state::T Y
,::Y Z
int::[ ^
participantSeat::_ n
)::n o
{;; 	'
RadioCommunicationRejection<< '
	rejection<<( 1
=<<2 3'
RadioCommunicationRejection<<4 O
.<<O P&
MissionPreparationRequired<<P j
;<<j k
if== 
(== 
state== 
.== 
MissionAttempt== $
.==$ %
Phase==% *
====+ -
MissionAttemptPhase==. A
.==A B
Finished==B J
)==J K
{>> 
	rejection?? 
=?? '
RadioCommunicationRejection?? 7
.??7 8"
MissionAttemptFinished??8 N
;??N O
}@@ 
elseAA 
ifAA 
(AA 
stateAA 
.AA 
MissionAttemptAA )
.AA) *
PhaseAA* /
==AA0 2
MissionAttemptPhaseAA3 F
.AAF G
PlayingTricksAAG T
)AAT U
{BB 
	rejectionCC 
=CC )
RadioCommunicationRuleMappingCC 9
.CC9 :
MapRejectionCC: F
(CCF G#
RadioCommunicationRulesCCG ^
.CC^ _$
GetAvailabilityRejectionCC_ w
(CCw x,
 RadioCommunicationContextFactoryDD 4
.DD4 5
CreateDD5 ;
(DD; <
stateDD< A
,DDA B
stateDDC H
.DDH I
ParticipantUserIdsDDI [
[DD[ \
participantSeatDD\ k
]DDk l
)DDl m
)DDm n
)DDn o
;DDo p
}EE 
returnFF 
newFF %
RadioAvailabilitySnapshotFF 0
{GG 
IsAvailableHH 
=HH 
	rejectionHH '
==HH( *'
RadioCommunicationRejectionHH+ F
.HHF G
NoneHHG K
,HHK L
FailureReasonII 
=II '
s_radioAvailabilityFailuresII  ;
[II; <
	rejectionII< E
]IIE F
}JJ 
;JJ 
}KK 	
privateMM 
staticMM 
readonlyMM 
SystemMM  &
.MM& '
CollectionsMM' 2
.MM2 3
GenericMM3 :
.MM: ;
IReadOnlyDictionaryMM; N
<MMN O'
RadioCommunicationRejectionMMO j
,MMj k+
RadioCommunicationFailureReasonNN +
>NN+ ,'
s_radioAvailabilityFailuresNN- H
=NNI J
newOO 
SystemOO 
.OO 
CollectionsOO "
.OO" #
GenericOO# *
.OO* +

DictionaryOO+ 5
<OO5 6'
RadioCommunicationRejectionOO6 Q
,OOQ R+
RadioCommunicationFailureReasonOOS r
>OOr s
{PP 
{QQ '
RadioCommunicationRejectionQQ -
.QQ- .
NoneQQ. 2
,QQ2 3+
RadioCommunicationFailureReasonQQ4 S
.QQS T
NoneQQT X
}QQY Z
,QQZ [
{RR '
RadioCommunicationRejectionRR -
.RR- .&
MissionPreparationRequiredRR. H
,RRH I+
RadioCommunicationFailureReasonSS 3
.SS3 4&
MissionPreparationRequiredSS4 N
}SSO P
,SSP Q
{TT '
RadioCommunicationRejectionTT -
.TT- ."
MissionAttemptFinishedTT. D
,TTD E+
RadioCommunicationFailureReasonUU 3
.UU3 4"
MissionAttemptFinishedUU4 J
}UUK L
,UUL M
{VV '
RadioCommunicationRejectionVV -
.VV- .*
AlreadyCommunicatedThisAttemptVV. L
,VVL M+
RadioCommunicationFailureReasonWW 3
.WW3 4*
AlreadyCommunicatedThisAttemptWW4 R
}WWS T
,WWT U
{XX '
RadioCommunicationRejectionXX -
.XX- .
SilencedByCaptainXX. ?
,XX? @+
RadioCommunicationFailureReasonXXA `
.XX` a
SilencedByCaptainXXa r
}XXs t
,XXt u
{YY '
RadioCommunicationRejectionYY -
.YY- ..
"CannotCommunicateDuringActiveTrickYY. P
,YYP Q+
RadioCommunicationFailureReasonZZ 3
.ZZ3 4.
"CannotCommunicateDuringActiveTrickZZ4 V
}ZZW X
,ZZX Y
{[[ '
RadioCommunicationRejection[[ -
.[[- .
DisruptedUntilTrick[[. A
,[[A B+
RadioCommunicationFailureReason\\ 3
.\\3 4
DisruptedUntilTrick\\4 G
}\\H I
,\\I J
}]] 
;]] 
}^^ 
}__ Ω
uC:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\UseCases\Match\Core\MissionImplementationPolicy.cs
	namespace 	
Application
 
. 
UseCases 
{ 
internal 
static 
class '
MissionImplementationPolicy 5
{ 
private 
const 
int +
MaximumImplementedMissionNumber 9
=: ;
$num< >
;> ?
internal

 
static

 
bool

 

CanPrepare

 '
(

' (
int

( +
missionNumber

, 9
)

9 :
{ 	
return 
missionNumber  
>=! #
MissionCatalog$ 2
.2 3 
MinimumMissionNumber3 G
&&H J
missionNumber 
<=  +
MaximumImplementedMissionNumber! @
;@ A
} 	
} 
} å
zC:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\Models\Match\Preparation\MissionPreparationRejection.cs
	namespace 	
Application
 
. 
Models 
{ 
public 

enum '
MissionPreparationRejection +
{ 
None 
= 
$num 
, 
InvalidSubmission 
= 
$num 
, 
MatchUnavailable 
= 
$num 
, !
ParticipantNotAllowed		 
=		 
$num		  !
,		! "
WrongMissionAttempt

 
=

 
$num

 
,

  $
SubmissionIdentityReused  
=! "
$num# $
,$ %
StageMismatch 
= 
$num 
, 
StaleMatchState 
= 
$num 
, 
CaptainRequired 
= 
$num 
, 
InvalidTarget 
= 
$num 
, 
ResponsesPending 
= 
$num 
, 
AlreadyAnswered 
= 
$num 
, 
RequestLimitReached 
= 
$num  
,  ! 
OperationUnavailable 
= 
$num !
} 
} Å
wC:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\Models\Match\Preparation\MissionPreparationAction.cs
	namespace 	
Application
 
. 
Models 
{ 
public 

enum $
MissionPreparationAction (
{ 

AssignRole 
= 
$num 
, 
RecordBlindResponse 
= 
$num 
,  "
IdentifyHeartNineOwner 
=  
$num! "
," ##
AssignTrickDistribution		 
=		  !
$num		" #
}

 
} ±
pC:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\Models\Match\Tricks\MissionTrickStatistics.cs
	namespace 	
Application
 
. 
Models 
{ 
public

 

sealed

 
record

 "
MissionTrickStatistics

 /
{ 
private 
const 
int 
NormalOneCardNumber -
=. /
$num0 1
;1 2
public 
int '
TricksWonWithNormalOneCount .
{/ 0
get1 4
;4 5
init6 :
;: ;
}< =
public 
IReadOnlyList 
< 
int  
>  !!
SpecialWinningCardIds" 7
{8 9
get: =
;= >
init? C
;C D
}E F
=G H
ArrayI N
.N O
EmptyO T
<T U
intU X
>X Y
(Y Z
)Z [
;[ \
internal "
MissionTrickStatistics '
IncludeWinner( 5
(5 6
Card6 :
winningCard; F
)F G
{ 	
bool 
isNormalOne 
= 
winningCard *
.* +
Suit+ /
!=0 2
CardSuit3 ;
.; <
Special< C
&&D F
winningCardG R
.R S
NumberS Y
==Z \
NormalOneCardNumber] p
;p q
return 
new "
MissionTrickStatistics -
{ '
TricksWonWithNormalOneCount +
=, -'
TricksWonWithNormalOneCount. I
+J K
(L M
isNormalOneM X
?Y Z
$num[ \
:] ^
$num_ `
)` a
,a b!
SpecialWinningCardIds %
=& '
winningCard( 3
.3 4
Suit4 8
==9 ;
CardSuit< D
.D E
SpecialE L
? !
SpecialWinningCardIds +
.+ ,
Concat, 2
(2 3
new3 6
[6 7
]7 8
{9 :
winningCard; F
.F G
IdCardG M
}N O
)O P
.P Q
DistinctQ Y
(Y Z
)Z [
.[ \
ToArray\ c
(c d
)d e
: !
SpecialWinningCardIds +
.+ ,
ToArray, 3
(3 4
)4 5
} 
; 
} 	
} 
} Æ-
xC:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\UseCases\Match\Radio\RadioCommunicationRuleMapping.cs
	namespace 	
Application
 
. 
UseCases 
{ 
internal 
static 
class )
RadioCommunicationRuleMapping 7
{ 
private		 
static		 
readonly		 
IReadOnlyDictionary		  3
<		3 4
RadioPublicMarker		4 E
,		E F
RadioTokenPosition		G Y
>		Y Z
s_positions		[ f
=		g h
new

 

Dictionary

 
<

 
RadioPublicMarker

 ,
,

, -
RadioTokenPosition

. @
>

@ A
{ 
{ 
RadioPublicMarker #
.# $
None$ (
,( )
RadioTokenPosition* <
.< =
None= A
}B C
,C D
{ 
RadioPublicMarker #
.# $
Highest$ +
,+ ,
RadioTokenPosition- ?
.? @
Highest@ G
}H I
,I J
{ 
RadioPublicMarker #
.# $
Only$ (
,( )
RadioTokenPosition* <
.< =
Only= A
}B C
,C D
{ 
RadioPublicMarker #
.# $
Lowest$ *
,* +
RadioTokenPosition, >
.> ?
Lowest? E
}F G
,G H
{ 
RadioPublicMarker #
.# $
Hidden$ *
,* +
RadioTokenPosition, >
.> ?
Interference? K
}L M
} 
; 
internal 
static 
RadioTokenPosition *
MapRequestedMarker+ =
(= >
RadioPublicMarker> O
markerP V
)V W
=>X Z
s_positions[ f
[f g
markerg m
]m n
;n o
internal 
static 
RadioPublicMarker )
MapResolvedMarker* ;
(; <
RadioTokenPosition< N
positionO W
)W X
{ 	
RadioPublicMarker 
marker $
=% &
RadioPublicMarker' 8
.8 9
None9 =
;= >
foreach 
( 
KeyValuePair !
<! "
RadioPublicMarker" 3
,3 4
RadioTokenPosition5 G
>G H
entryI N
inO Q
s_positionsR ]
)] ^
{ 
if 
( 
entry 
. 
Value 
==  "
position# +
)+ ,
{ 
marker 
= 
entry "
." #
Key# &
;& '
} 
} 
return 
marker 
; 
}   	
internal"" 
static"" '
RadioCommunicationRejection"" 3
MapRejection""4 @
(""@ A-
!RadioCommunicationRejectionReason""A b
reason""c i
)""i j
{## 	
return$$ 
s_rejections$$ 
[$$  
reason$$  &
]$$& '
;$$' (
}%% 	
private'' 
static'' 
readonly'' 
IReadOnlyDictionary''  3
<''3 4-
!RadioCommunicationRejectionReason''4 U
,''U V'
RadioCommunicationRejection(( '
>((' (
s_rejections(() 5
=((6 7
new)) 

Dictionary)) 
<)) -
!RadioCommunicationRejectionReason)) <
,))< ='
RadioCommunicationRejection))> Y
>))Y Z
{** 
{++ -
!RadioCommunicationRejectionReason++ 3
.++3 4
DisruptedUntilTrick++4 G
,++G H'
RadioCommunicationRejection,, /
.,,/ 0
DisruptedUntilTrick,,0 C
},,D E
,,,E F
{-- -
!RadioCommunicationRejectionReason-- 3
.--3 4
SilencedByCaptain--4 E
,--E F'
RadioCommunicationRejection.. /
.../ 0
SilencedByCaptain..0 A
}..B C
,..C D
{// -
!RadioCommunicationRejectionReason// 3
.//3 4
None//4 8
,//8 9'
RadioCommunicationRejection//: U
.//U V
None//V Z
}//[ \
,//\ ]
{00 -
!RadioCommunicationRejectionReason00 3
.003 4
CardNotInHand004 A
,00A B'
RadioCommunicationRejection00C ^
.00^ _
CardNotInHand00_ l
}00m n
,00n o
{11 -
!RadioCommunicationRejectionReason11 3
.113 4!
SpecialCardNotAllowed114 I
,11I J'
RadioCommunicationRejection22 /
.22/ 0!
SpecialCardNotAllowed220 E
}22F G
,22G H
{33 -
!RadioCommunicationRejectionReason33 3
.333 4*
AlreadyCommunicatedThisAttempt334 R
,33R S'
RadioCommunicationRejection44 /
.44/ 0*
AlreadyCommunicatedThisAttempt440 N
}44O P
,44P Q
{55 -
!RadioCommunicationRejectionReason55 3
.553 4.
"CannotCommunicateDuringActiveTrick554 V
,55V W'
RadioCommunicationRejection66 /
.66/ 0.
"CannotCommunicateDuringActiveTrick660 R
}66S T
,66T U
{77 -
!RadioCommunicationRejectionReason77 3
.773 4'
InvalidTokenPositionForCard774 O
,77O P'
RadioCommunicationRejection88 /
.88/ 0'
InvalidTokenPositionForCard880 K
}88L M
}99 
;99 
}:: 
};; òt
zC:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\UseCases\Match\Radio\MatchUseCase.RadioCommunication.cs
	namespace 	
Application
 
. 
UseCases 
{		 
public

 

sealed

 
partial

 
class

 
MatchUseCase

  ,
{ 
private 
const 
int )
MaximumRadioRequestsPerSecond 7
=8 9
$num: ;
;; <
private 
const 
int '
MaximumRadioLobbyCodeLength 5
=6 7
$num8 :
;: ;
public $
RadioCommunicationCommit '$
SubmitRadioCommunication( @
(@ A%
RadioCommunicationRequest %
request& -
,- .
int/ 2
participantUserId3 D
)D E
{ 	
var 
result 
= 
RejectRadio $
($ %
request% ,
,, -'
RadioCommunicationRejection. I
.I J
InvalidSubmissionJ [
)[ \
;\ ]
if 
( 
request 
!= 
null 
&&  "
!# $
string$ *
.* +
IsNullOrWhiteSpace+ =
(= >
request> E
.E F
	LobbyCodeF O
)O P
&&Q S
request 
. 
	LobbyCode !
.! "
Length" (
<=) +'
MaximumRadioLobbyCodeLength, G
)G H
{ 

MatchState 

matchState %
=& '
_matchStateStore( 8
.8 9
	FindMatch9 B
(B C
requestC J
.J K
	LobbyCodeK T
)T U
;U V
result 
= 
RejectRadio $
($ %
request% ,
,, -'
RadioCommunicationRejection. I
.I J
MatchUnavailableJ Z
)Z [
;[ \
if 
( 

matchState 
!= !
null" &
)& '
{ 
lock 
( 

matchState $
)$ %
{ 
result 
=  
ResolveRadioRequest! 4
(4 5

matchState5 ?
,? @
requestA H
,H I
participantUserIdJ [
)[ \
;\ ]
} 
} 
} 
return   
result   
;   
}!! 	
private## 
static## $
RadioCommunicationCommit## /
ResolveRadioRequest##0 C
(##C D

MatchState##D N

matchState##O Y
,##Y Z%
RadioCommunicationRequest$$ %
request$$& -
,$$- .
int$$/ 2
participantUserId$$3 D
)$$D E
{%% 	'
RadioCommunicationRejection&& '
identityRejection&&( 9
=&&: ;!
ValidateRadioIdentity'' %
(''% &

matchState''& 0
,''0 1
request''2 9
,''9 :
participantUserId''; L
)''L M
;''M N$
RadioCommunicationCommit(( $
result((% +
;((+ ,
if)) 
()) 
identityRejection)) !
!=))" $'
RadioCommunicationRejection))% @
.))@ A
None))A E
)))E F
{** 
result++ 
=++ 
RejectRadio++ $
(++$ %
request++% ,
,++, -
identityRejection++. ?
)++? @
;++@ A
},, 
else-- 
if-- 
(-- 

matchState-- 
.--  6
*ProcessedRadioCommunicationsBySubmissionId--  J
.--J K
TryGetValue--K V
(--V W
request.. 
... *
RadioCommunicationSubmissionId.. 6
,..6 7
out..8 ;'
CommittedRadioCommunication..< W
previous..X `
)..` a
)..a b
{// 
result00 
=00 
previous00 !
.00! "
ParticipantUserId00" 3
==004 6
participantUserId007 H
&&00I K
previous00L T
.00T U
Request00U \
==00] _
request00` g
?11 
new11 $
RadioCommunicationCommit11 2
{22 *
RadioCommunicationSubmissionId33 6
=337 8
request339 @
.33@ A*
RadioCommunicationSubmissionId33A _
,33_ `&
CommittedMatchStateVersion44 2
=443 4
previous445 =
.44= >&
CommittedMatchStateVersion44> X
}55 
:66 
RejectRadio66 !
(66! "
request66" )
,66) *'
RadioCommunicationRejection66+ F
.66F G$
SubmissionIdentityReused66G _
)66_ `
;66` a
}77 
else88 
{99 
result:: 
=:: "
ProcessNewRadioRequest:: /
(::/ 0

matchState::0 :
,::: ;
request::< C
,::C D
participantUserId::E V
)::V W
;::W X
};; 
return<< 
result<< 
;<< 
}== 	
private?? 
static?? '
RadioCommunicationRejection?? 2!
ValidateRadioIdentity??3 H
(??H I

MatchState??I S

matchState??T ^
,??^ _%
RadioCommunicationRequest@@ %
request@@& -
,@@- .
int@@/ 2
participantUserId@@3 D
)@@D E
{AA 	'
RadioCommunicationRejectionBB '
	rejectionBB( 1
=BB2 3'
RadioCommunicationRejectionBB4 O
.BBO P
NoneBBP T
;BBT U
ifCC 
(CC 
!CC 

matchStateCC 
.CC 
ParticipantUserIdsCC .
.CC. /
ContainsCC/ 7
(CC7 8
participantUserIdCC8 I
)CCI J
)CCJ K
{DD 
	rejectionEE 
=EE '
RadioCommunicationRejectionEE 7
.EE7 8!
ParticipantNotAllowedEE8 M
;EEM N
}FF 
elseGG 
ifGG 
(GG 
requestGG 
.GG 
MatchIdGG $
!=GG% '

matchStateGG( 2
.GG2 3
MatchIdGG3 :
||GG; =
requestGG> E
.GGE F*
RadioCommunicationSubmissionIdGGF d
==GGe g
GuidGGh l
.GGl m
EmptyGGm r
||GGs u
requestHH 
.HH 
SelectedMarkerHH &
==HH' )
RadioPublicMarkerHH* ;
.HH; <
NoneHH< @
||HHA C
!II 
EnumII 
.II 
	IsDefinedII 
(II  
typeofII  &
(II& '
RadioPublicMarkerII' 8
)II8 9
,II9 :
requestII; B
.IIB C
SelectedMarkerIIC Q
)IIQ R
)IIR S
{JJ 
	rejectionKK 
=KK '
RadioCommunicationRejectionKK 7
.KK7 8
InvalidSubmissionKK8 I
;KKI J
}LL 
elseMM 
ifMM 
(MM 
requestMM 
.MM 
MissionAttemptIdMM -
!=MM. 0

matchStateMM1 ;
.MM; <
MissionAttemptMM< J
.MMJ K
MissionAttemptIdMMK [
)MM[ \
{NN 
	rejectionOO 
=OO '
RadioCommunicationRejectionOO 7
.OO7 8
WrongMissionAttemptOO8 K
;OOK L
}PP 
returnQQ 
	rejectionQQ 
;QQ 
}RR 	
privateTT 
staticTT $
RadioCommunicationCommitTT /"
ProcessNewRadioRequestTT0 F
(TTF G

MatchStateTTG Q

matchStateTTR \
,TT\ ]%
RadioCommunicationRequestUU %
requestUU& -
,UU- .
intUU/ 2
participantUserIdUU3 D
)UUD E
{VV 	'
RadioCommunicationRejectionWW '
	rejectionWW( 1
=WW2 3
ValidateRadioWindowWW4 G
(WWG H

matchStateWWH R
,WWR S
requestWWT [
,WW[ \
participantUserIdWW] n
)WWn o
;WWo p.
"RadioCommunicationValidationResultXX .

validationXX/ 9
=XX: ;
nullXX< @
;XX@ A
ifYY 
(YY 
	rejectionYY 
==YY '
RadioCommunicationRejectionYY 8
.YY8 9
NoneYY9 =
)YY= >
{ZZ 

validation[[ 
=[[ #
RadioCommunicationRules[[ 4
.[[4 5!
ValidateCommunication[[5 J
([[J K
CreateRadioContext\\ &
(\\& '

matchState\\' 1
,\\1 2
request\\3 :
,\\: ;
participantUserId\\< M
)\\M N
)\\N O
;\\O P
	rejection]] 
=]] )
RadioCommunicationRuleMapping]] 9
.]]9 :
MapRejection]]: F
(]]F G

validation]]G Q
.]]Q R
RejectionReason]]R a
)]]a b
;]]b c
}^^ $
RadioCommunicationCommit__ $
result__% +
=__, -
RejectRadio__. 9
(__9 :
request__: A
,__A B
	rejection__C L
)__L M
;__M N
if`` 
(`` 
	rejection`` 
==`` '
RadioCommunicationRejection`` 8
.``8 9
None``9 =
)``= >
{aa 
resultbb 
=bb 

matchStatebb #
.bb# $$
CommitRadioCommunicationbb$ <
(bb< =
newbb= @'
CommittedRadioCommunicationbbA \
{cc 
ParticipantUserIddd %
=dd& '
participantUserIddd( 9
,dd9 :
Requestee 
=ee 
requestee %
,ee% & 
ResolvedPublicMarkerff (
=ff) *)
RadioCommunicationRuleMappingff+ H
.ffH I
MapResolvedMarkerffI Z
(ffZ [

validationff[ e
.ffe f
ResolvedPositionfff v
)ffv w
,ffw x&
CommittedMatchStateVersiongg .
=gg/ 0

matchStategg1 ;
.gg; <
MatchStateVersiongg< M
+ggN O
$numggP Q
}hh 
)hh 
;hh 
}ii 
returnjj 
resultjj 
;jj 
}kk 	
privatemm 
staticmm '
RadioCommunicationRejectionmm 2
ValidateRadioWindowmm3 F
(mmF G

MatchStatemmG Q

matchStatemmR \
,mm\ ]%
RadioCommunicationRequestnn %
requestnn& -
,nn- .
intnn/ 2
participantUserIdnn3 D
)nnD E
{oo 	'
RadioCommunicationRejectionpp '
	rejectionpp( 1
=pp2 3'
RadioCommunicationRejectionpp4 O
.ppO P
RequestLimitReachedppP c
;ppc d
ifqq 
(qq $
MatchActionRequestLimitsqq (
.qq( )$
ConsumeParticipantWindowqq) A
(qqA B

matchStateqqB L
.qqL M+
RadioBudgetsByParticipantUserIdqqM l
,qql m
participantUserIdrr !
,rr! ")
MaximumRadioRequestsPerSecondrr# @
)rr@ A
!=rrB D
nullrrE I
)rrI J
{ss 
	rejectiontt 
=tt 
ValidateRadioPhasett .
(tt. /

matchStatett/ 9
,tt9 :
requesttt; B
)ttB C
;ttC D
}uu 
returnvv 
	rejectionvv 
;vv 
}ww 	
privateyy 
staticyy '
RadioCommunicationRejectionyy 2
ValidateRadioPhaseyy3 E
(yyE F

MatchStateyyF P

matchStateyyQ [
,yy[ \%
RadioCommunicationRequestzz %
requestzz& -
)zz- .
{{{ 	'
RadioCommunicationRejection|| '
	rejection||( 1
=||2 3'
RadioCommunicationRejection||4 O
.||O P&
MissionPreparationRequired||P j
;||j k
if}} 
(}} 

matchState}} 
.}} 
MissionAttempt}} )
.}}) *
Phase}}* /
==}}0 2
MissionAttemptPhase}}3 F
.}}F G
Finished}}G O
)}}O P
{~~ 
	rejection 
= '
RadioCommunicationRejection 7
.7 8"
MissionAttemptFinished8 N
;N O
}
ÄÄ 
else
ÅÅ 
if
ÅÅ 
(
ÅÅ 

matchState
ÅÅ 
.
ÅÅ  
MissionAttempt
ÅÅ  .
.
ÅÅ. /
Phase
ÅÅ/ 4
==
ÅÅ5 7!
MissionAttemptPhase
ÅÅ8 K
.
ÅÅK L
PlayingTricks
ÅÅL Y
)
ÅÅY Z
{
ÇÇ 
	rejection
ÉÉ 
=
ÉÉ 
request
ÉÉ #
.
ÉÉ# $'
ExpectedMatchStateVersion
ÉÉ$ =
==
ÉÉ> @

matchState
ÉÉA K
.
ÉÉK L
MatchStateVersion
ÉÉL ]
?
ÑÑ )
RadioCommunicationRejection
ÑÑ 1
.
ÑÑ1 2
None
ÑÑ2 6
:
ÑÑ7 8)
RadioCommunicationRejection
ÑÑ9 T
.
ÑÑT U
StaleMatchState
ÑÑU d
;
ÑÑd e
}
ÖÖ 
return
ÜÜ 
	rejection
ÜÜ 
;
ÜÜ 
}
áá 	
private
ââ 
static
ââ '
RadioCommunicationContext
ââ 0 
CreateRadioContext
ââ1 C
(
ââC D

MatchState
ââD N

matchState
ââO Y
,
ââY Z'
RadioCommunicationRequest
ää %
request
ää& -
,
ää- .
int
ää/ 2
participantUserId
ää3 D
)
ääD E
{
ãã 	
return
åå .
 RadioCommunicationContextFactory
åå 3
.
åå3 4
Create
åå4 :
(
åå: ;

matchState
åå; E
,
ååE F
participantUserId
ååG X
,
ååX Y
request
ååZ a
)
ååa b
;
ååb c
}
çç 	
private
èè 
static
èè &
RadioCommunicationCommit
èè /
RejectRadio
èè0 ;
(
èè; <'
RadioCommunicationRequest
èè< U
request
èèV ]
,
èè] ^)
RadioCommunicationRejection
êê '
	rejection
êê( 1
)
êê1 2
{
ëë 	
return
íí 
new
íí &
RadioCommunicationCommit
íí /
{
ìì ,
RadioCommunicationSubmissionId
îî .
=
îî/ 0
request
îî1 8
?
îî8 9
.
îî9 :,
RadioCommunicationSubmissionId
îî: X
??
îîY [
Guid
îî\ `
.
îî` a
Empty
îîa f
,
îîf g
	Rejection
ïï 
=
ïï 
	rejection
ïï %
}
ññ 
;
ññ 
}
óó 	
}
òò 
}ôô Ò
vC:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\Models\Match\State\MatchState.RadioCommunication.cs
	namespace 	
Application
 
. 
Models 
{ 
public 

sealed 
partial 
class 

MatchState  *
{ 
public 

Dictionary 
< 
int 
, '
CommittedRadioCommunication :
>: ;2
&RadioCommunicationsByParticipantUserId< b
{c d
gete h
;h i
}j k
=l m
new		 

Dictionary		 
<		 
int		 
,		 '
CommittedRadioCommunication		  ;
>		; <
(		< =
)		= >
;		> ?
public

 

Dictionary

 
<

 
Guid

 
,

 '
CommittedRadioCommunication

  ;
>

; <6
*ProcessedRadioCommunicationsBySubmissionId

= g
{

h i
get

j m
;

m n
}

o p
=

q r
new 

Dictionary 
< 
Guid 
,  '
CommittedRadioCommunication! <
>< =
(= >
)> ?
;? @
public 

Dictionary 
< 
int 
, $
MatchActionRequestBudget 7
>7 8+
RadioBudgetsByParticipantUserId9 X
{Y Z
get[ ^
;^ _
}` a
=b c
new 

Dictionary 
< 
int 
, $
MatchActionRequestBudget  8
>8 9
(9 :
): ;
;; <
internal $
RadioCommunicationCommit )$
CommitRadioCommunication* B
(B C'
CommittedRadioCommunicationC ^
communication_ l
)l m
{ 	2
&RadioCommunicationsByParticipantUserId 2
.2 3
Add3 6
(6 7
communication7 D
.D E
ParticipantUserIdE V
,V W
communicationX e
)e f
;f g6
*ProcessedRadioCommunicationsBySubmissionId 6
.6 7
Add7 :
(: ;
communication; H
.H I
RequestI P
.P Q*
RadioCommunicationSubmissionIdQ o
,o p
communication 
) 
; 
MatchStateVersion 
++ 
;  
return 
new $
RadioCommunicationCommit /
{ *
RadioCommunicationSubmissionId .
=/ 0
communication1 >
.> ?
Request? F
.F G*
RadioCommunicationSubmissionIdG e
,e f&
CommittedMatchStateVersion *
=+ ,
MatchStateVersion- >
,> ?
HasStateChanged 
=  !
true" &
} 
; 
} 	
} 
} ¸
jC:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\Models\Match\Radio\RadioPublicMarker.cs
	namespace 	
Application
 
. 
Models 
{ 
public 

enum 
RadioPublicMarker !
{ 
None 
= 
$num 
, 
Highest 
= 
$num 
, 
Only 
= 
$num 
, 
Lowest		 
=		 
$num		 
,		 
Hidden

 
=

 
$num

 
} 
} ›
rC:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\Models\Match\Radio\RadioCommunicationRequest.cs
	namespace 	
Application
 
. 
Models 
{ 
public 

sealed 
record %
RadioCommunicationRequest 2
{ 
public 
string 
	LobbyCode 
{  !
get" %
;% &
init' +
;+ ,
}- .
public

 
Guid

 
MatchId

 
{

 
get

 !
;

! "
init

# '
;

' (
}

) *
public 
int 
MissionAttemptId #
{$ %
get& )
;) *
init+ /
;/ 0
}1 2
public 
Guid *
RadioCommunicationSubmissionId 2
{3 4
get5 8
;8 9
init: >
;> ?
}@ A
public 
long %
ExpectedMatchStateVersion -
{. /
get0 3
;3 4
init5 9
;9 :
}; <
public 
int 
CardId 
{ 
get 
;  
init! %
;% &
}' (
public 
RadioPublicMarker  
SelectedMarker! /
{0 1
get2 5
;5 6
init7 ;
;; <
}= >
} 
} á
tC:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\Models\Match\Radio\RadioCommunicationRejection.cs
	namespace 	
Application
 
. 
Models 
{ 
public 

enum '
RadioCommunicationRejection +
{ 
None 
= 
$num 
, 
InvalidSubmission 
= 
$num 
, 
MatchUnavailable 
= 
$num 
, !
ParticipantNotAllowed		 
=		 
$num		  !
,		! "
WrongMissionAttempt

 
=

 
$num

 
,

  $
SubmissionIdentityReused  
=! "
$num# $
,$ %
StaleMatchState 
= 
$num 
, &
MissionPreparationRequired "
=# $
$num% &
,& '"
MissionAttemptFinished 
=  
$num! "
," #
CardNotInHand 
= 
$num 
, !
SpecialCardNotAllowed 
= 
$num  "
," #*
AlreadyCommunicatedThisAttempt &
=' (
$num) +
,+ ,.
"CannotCommunicateDuringActiveTrick *
=+ ,
$num- /
,/ 0'
InvalidTokenPositionForCard #
=$ %
$num& (
,( )
RequestLimitReached 
= 
$num  
,  ! 
OperationUnavailable 
= 
$num !
,! "
DisruptedUntilTrick 
= 
$num  
,  !
SilencedByCaptain 
= 
$num 
} 
} ë
qC:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\Models\Match\Radio\RadioCommunicationCommit.cs
	namespace 	
Application
 
. 
Models 
{ 
public 

sealed 
record $
RadioCommunicationCommit 1
{ 
public 
Guid *
RadioCommunicationSubmissionId 2
{3 4
get5 8
;8 9
init: >
;> ?
}@ A
public

 
long

 &
CommittedMatchStateVersion

 .
{

/ 0
get

1 4
;

4 5
init

6 :
;

: ;
}

< =
public 
bool 
HasStateChanged #
{$ %
get& )
;) *
init+ /
;/ 0
}1 2
public '
RadioCommunicationRejection *
	Rejection+ 4
{5 6
get7 :
;: ;
init< @
;@ A
}B C
} 
} ó
tC:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\Models\Match\Radio\CommittedRadioCommunication.cs
	namespace 	
Application
 
. 
Models 
{ 
public 

sealed 
record '
CommittedRadioCommunication 4
{ 
public 
int 
ParticipantUserId $
{% &
get' *
;* +
init, 0
;0 1
}2 3
public

 %
RadioCommunicationRequest

 (
Request

) 0
{

1 2
get

3 6
;

6 7
init

8 <
;

< =
}

> ?
public 
RadioPublicMarker   
ResolvedPublicMarker! 5
{6 7
get8 ;
;; <
init= A
;A B
}C D
public 
long &
CommittedMatchStateVersion .
{/ 0
get1 4
;4 5
init6 :
;: ;
}< =
} 
} ˆ
jC:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\Models\Match\State\MatchStartContext.cs
	namespace 	
Application
 
. 
Models 
{ 
public 

sealed 
record 
MatchStartContext *
{ 
public 
string 
	LobbyCode 
{  !
get" %
;% &
init' +
;+ ,
}- .
public		 
Guid		 
LobbyInstanceId		 #
{		$ %
get		& )
;		) *
init		+ /
;		/ 0
}		1 2
public

 
int

 
[

 
]

 
ParticipantUserIds

 '
{

( )
get

* -
;

- .
init

/ 3
;

3 4
}

5 6
public 
int 
TargetMissionCount %
{& '
get( +
;+ ,
init- 1
;1 2
}3 4
} 
} °
uC:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\Models\Match\Transition\MissionTransitionAction.cs
	namespace 	
Application
 
. 
Models 
{ 
public 

enum #
MissionTransitionAction '
{ 
None 
= 
$num 
, 
RetryCurrentMission 
= 
$num 
,   
AdvanceToNextMission 
= 
$num  
}		 
}

 ˙
qC:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\Models\Match\State\MatchActionRequestLimits.cs
	namespace 	
Application
 
. 
Models 
{ 
public 

static 
class $
MatchActionRequestLimits 0
{ 
public		 
static		 $
MatchActionRequestBudget		 .$
ConsumeParticipantWindow		/ G
(		G H
IDictionary

 
<

 
int

 
,

 $
MatchActionRequestBudget

 5
>

5 6 
budgetsByParticipant

7 K
,

K L
int

M P
participantUserId

Q b
,

b c
int $
maximumRequestsPerSecond (
)( )
{ 	 
budgetsByParticipant  
.  !
TryGetValue! ,
(, -
participantUserId- >
,> ?
out@ C$
MatchActionRequestBudgetD \
previousBudget] k
)k l
;l m$
MatchActionRequestBudget $
consumedBudget% 3
=4 5
ConsumeWindow6 C
(C D
previousBudgetD R
,R S$
maximumRequestsPerSecondT l
)l m
;m n
if 
( 
consumedBudget 
!= !
null" &
)& '
{  
budgetsByParticipant $
[$ %
participantUserId% 6
]6 7
=8 9
consumedBudget: H
;H I
} 
return 
consumedBudget !
;! "
} 	
public 
static $
MatchActionRequestBudget .
ConsumeWindow/ <
(< =$
MatchActionRequestBudget $
previousBudget% 3
,3 4
int5 8$
maximumRequestsPerSecond9 Q
)Q R
{ 	$
MatchActionRequestBudget $
requestBudget% 2
=3 4
previousBudget5 C
??D F
newG J$
MatchActionRequestBudgetK c
(c d
)d e
;e f
long 
requestTimestamp !
=" #
	Stopwatch$ -
.- .
GetTimestamp. :
(: ;
); <
;< =
if 
( 
requestTimestamp  
-! "
requestBudget# 0
.0 1"
WindowStartedTimestamp1 G
>=H J
	StopwatchK T
.T U
	FrequencyU ^
)^ _
{ 
requestBudget 
= 
requestBudget  -
with. 2
{3 4"
WindowStartedTimestamp5 K
=L M
requestTimestampN ^
,^ _
RequestsInWindow` p
=q r
$nums t
}u v
;v w
} $
MatchActionRequestBudget $
consumedBudget% 3
=4 5
null6 :
;: ;
if   
(   
requestBudget   
.   
RequestsInWindow   .
<  / 0$
maximumRequestsPerSecond  1 I
)  I J
{!! 
consumedBudget"" 
=""  
requestBudget""! .
with""/ 3
{""4 5
RequestsInWindow""6 F
=""G H
requestBudget""I V
.""V W
RequestsInWindow""W g
+""h i
$num""j k
}""l m
;""m n
}## 
return$$ 
consumedBudget$$ !
;$$! "
}%% 	
}&& 
}'' Ä2
âC:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\UseCases\Match\Transition\MatchSnapshotProjection.MissionTransition.cs
	namespace 	
Application
 
. 
UseCases 
{ 
internal 
static 
partial 
class !#
MatchSnapshotProjection" 9
{		 
private

 
static

 
readonly

 
IReadOnlyDictionary

  3
<

3 4+
MissionTransitionScheduleStatus

4 S
,

S T#
MissionTransitionStatus #
># $ 
s_transitionStatuses% 9
=: ;
new 

Dictionary 
< +
MissionTransitionScheduleStatus :
,: ;#
MissionTransitionStatus< S
>S T
{ 
{ +
MissionTransitionScheduleStatus 1
.1 2
Inactive2 :
,: ;#
MissionTransitionStatus< S
.S T
InactiveT \
}] ^
,^ _
{ +
MissionTransitionScheduleStatus 1
.1 2"
WaitingForParticipants2 H
,H I#
MissionTransitionStatus +
.+ ,"
WaitingForParticipants, B
}C D
,D E
{ +
MissionTransitionScheduleStatus 1
.1 2
CountingDown2 >
,> ?#
MissionTransitionStatus@ W
.W X
CountingDownX d
}e f
,f g
{ +
MissionTransitionScheduleStatus 1
.1 2
	Preparing2 ;
,; <#
MissionTransitionStatus= T
.T U
	PreparingU ^
}_ `
,` a
{ +
MissionTransitionScheduleStatus 1
.1 2
PreparationFailed2 C
,C D#
MissionTransitionStatusE \
.\ ]
PreparationFailed] n
}o p
,p q
{ +
MissionTransitionScheduleStatus 1
.1 2
AttemptLimitReached2 E
,E F#
MissionTransitionStatusG ^
.^ _
AttemptLimitReached_ r
}s t
,t u
{ +
MissionTransitionScheduleStatus 1
.1 2
CampaignCompleted2 C
,C D#
MissionTransitionStatusE \
.\ ]
CampaignCompleted] n
}o p
,p q
{ +
MissionTransitionScheduleStatus 1
.1 2
MissionUnavailable2 D
,D E#
MissionTransitionStatusF ]
.] ^
MissionUnavailable^ p
}q r
} 
; 
private 
static !
MissionTransitionKind ,
GetTransitionKind- >
(> ?#
MissionTransitionAction? V
transitionActionW g
)g h
{ 	!
MissionTransitionKind !
transitionKind" 0
=1 2!
MissionTransitionKind3 H
.H I
NoneI M
;M N
if 
( 
transitionAction  
==! ##
MissionTransitionAction$ ;
.; <
RetryCurrentMission< O
)O P
{ 
transitionKind 
=  !
MissionTransitionKind! 6
.6 7
RetryCurrentMission7 J
;J K
} 
else   
if   
(   
transitionAction   %
==  & (#
MissionTransitionAction  ) @
.  @ A 
AdvanceToNextMission  A U
)  U V
{!! 
transitionKind"" 
=""  !
MissionTransitionKind""! 6
.""6 7 
AdvanceToNextMission""7 K
;""K L
}## 
return$$ 
transitionKind$$ !
;$$! "
}%% 	
private'' 
static'' %
MissionTransitionSnapshot'' 0#
CreateMissionTransition''1 H
(''H I

MatchState''I S

matchState''T ^
,''^ _
long(( '
serverTimestampMilliseconds(( ,
)((, -
{)) 	
long** !
remainingMilliseconds** &
=**' (
Math**) -
.**- .
Max**. 1
(**1 2
$num**2 3
,**3 4

matchState++ 
.++ 1
%MissionTransitionDeadlineMilliseconds++ @
-++A B'
serverTimestampMilliseconds++C ^
)++^ _
;++_ `
return,, 
new,, %
MissionTransitionSnapshot,, 0
{-- 
MissionAttemptId..  
=..! "

matchState..# -
...- .
MissionAttempt... <
...< =
MissionAttemptId..= M
,..M N
AttemptNumber// 
=// 

matchState//  *
.//* +
MissionAttempt//+ 9
.//9 :
AttemptNumber//: G
,//G H
Kind00 
=00 
GetTransitionKind00 (
(00( )

matchState00) 3
.003 4
TransitionAction004 D
)00D E
,00E F$
DestinationMissionNumber11 (
=11) *

matchState11+ 5
.115 6$
DestinationMissionNumber116 N
,11N O
TargetMissionCount22 "
=22# $

matchState22% /
.22/ 0
TargetMissionCount220 B
,22B C
Status33 
=33  
s_transitionStatuses33 -
[33- .

matchState33. 8
.338 9#
MissionTransitionStatus339 P
]33P Q
,33Q R'
MissionTransitionScheduleId44 +
=44, -

matchState44. 8
.448 9'
MissionTransitionScheduleId449 T
,44T U&
RemainingDelayMilliseconds55 *
=55+ ,
(55- .
int55. 1
)551 2
Math552 6
.556 7
Min557 :
(55: ;!
remainingMilliseconds55; P
,55P Q#
MissionTransitionPolicy66 +
.66+ ,!
CountdownMilliseconds66, A
)66A B
,66B C%
MissingParticipantUserIds77 )
=77* +
(77, -
int77- 0
[770 1
]771 2
)772 3

matchState773 =
.77= >/
#MissingTransitionParticipantUserIds77> a
.77a b
Clone77b g
(77g h
)77h i
}88 
;88 
}99 	
}:: 
};; ˛t
äC:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\UseCases\Match\ObjectiveDraft\MatchSnapshotProjection.ObjectiveDraft.cs
	namespace

 	
Application


 
.

 
UseCases

 
{ 
internal 
static 
partial 
class !#
MatchSnapshotProjection" 9
{ 
private 
static 
readonly 
IReadOnlyDictionary  3
<3 4
ObjectiveTokenType4 F
,F G!
MissionObjectiveTokenH ]
>] ^
s_objectiveTokens_ p
=q r
new 

Dictionary 
< 
ObjectiveTokenType -
,- .!
MissionObjectiveToken/ D
>D E
{ 
{ 
ObjectiveTokenType $
.$ %
None% )
,) *!
MissionObjectiveToken+ @
.@ A
NoneA E
}F G
,G H
{ 
ObjectiveTokenType $
.$ %
OrderOne% -
,- .!
MissionObjectiveToken/ D
.D E
OrderOneE M
}N O
,O P
{ 
ObjectiveTokenType $
.$ %
OrderTwo% -
,- .!
MissionObjectiveToken/ D
.D E
OrderTwoE M
}N O
,O P
{ 
ObjectiveTokenType $
.$ %

OrderThree% /
,/ 0!
MissionObjectiveToken1 F
.F G

OrderThreeG Q
}R S
,S T
{ 
ObjectiveTokenType $
.$ %
	OrderFour% .
,. /!
MissionObjectiveToken0 E
.E F
	OrderFourF O
}P Q
,Q R
{ 
ObjectiveTokenType $
.$ %
	OrderFive% .
,. /!
MissionObjectiveToken0 E
.E F
	OrderFiveF O
}P Q
,Q R
{ 
ObjectiveTokenType $
.$ %
ArrowOne% -
,- .!
MissionObjectiveToken/ D
.D E
ArrowOneE M
}N O
,O P
{ 
ObjectiveTokenType $
.$ %
ArrowTwo% -
,- .!
MissionObjectiveToken/ D
.D E
ArrowTwoE M
}N O
,O P
{ 
ObjectiveTokenType $
.$ %

ArrowThree% /
,/ 0!
MissionObjectiveToken1 F
.F G

ArrowThreeG Q
}R S
,S T
{ 
ObjectiveTokenType $
.$ %
	ArrowFour% .
,. /!
MissionObjectiveToken0 E
.E F
	ArrowFourF O
}P Q
,Q R
{ 
ObjectiveTokenType $
.$ %
Omega% *
,* +!
MissionObjectiveToken, A
.A B
OmegaB G
}H I
} 
; 
private 
static ,
 PlayerMissionPreparationSnapshot 7$
CreateMissionPreparation8 P
(P Q

MatchState 

matchState !
,! "
int# &
participantSeat' 6
)6 7
{   	
MissionAttemptState!! 
attempt!!  '
=!!( )

matchState!!* 4
.!!4 5
MissionAttempt!!5 C
;!!C D
var"" 
snapshot"" 
="" 
new"" ,
 PlayerMissionPreparationSnapshot"" ?
{## /
#AvailableObjectiveDraftSubmissionId$$ 3
=$$4 5
participantSeat$$6 E
==$$F H
attempt$$I P
.$$P Q%
CurrentObjectiveDraftSeat$$Q j
&&$$k m
attempt%% 
.%% 
Phase%% !
==%%" $
MissionAttemptPhase%%% 8
.%%8 9
ObjectiveDrafting%%9 J
?&& 
(&& 
Guid&& 
?&& 
)&& 

matchState&& '
.&&' (-
!CurrentObjectiveDraftSubmissionId&&( I
:&&J K
null&&L P
,&&P Q
MissionAttemptId''  
=''! "
attempt''# *
.''* +
MissionAttemptId''+ ;
,''; <
MissionNumber(( 
=(( 
attempt((  '
.((' (
MissionNumber((( 5
,((5 6
Stage)) 
=)) 
GetPreparationStage)) +
())+ ,

matchState)), 6
)))6 7
,))7 8%
MissionPreparationStageId** )
=*** +

matchState**, 6
.**6 7%
MissionPreparationStageId**7 P
,**P Q*
EligibleRoleParticipantUserIds++ .
=++/ 0'
GetEligibleRoleParticipants++1 L
(++L M

matchState++M W
,++W X
participantSeat++Y h
)++h i
,++i j'
CanRespondToBlindObjectives,, +
=,,, -
GetPreparationStage,,. A
(,,A B

matchState,,B L
),,L M
==,,N P#
MissionPreparationStage-- +
.--+ ,
BlindResponses--, :
&&--; =
participantSeat.. #
!=..$ &

matchState..' 1
...1 2
MissionCaptainSeat..2 D
&&..E G
!// 

matchState// 
.//   
BlindResponsesBySeat//  4
.//4 5
ContainsKey//5 @
(//@ A
(//A B
byte//B F
)//F G
participantSeat//G V
)//V W
,//W X#
BlindObjectiveResponses00 '
=00( )

matchState00* 4
.004 5 
BlindResponsesBySeat005 I
.00I J
Select00J P
(00P Q
entry00Q V
=>00W Y
new11 -
!BlindObjectiveParticipantSnapshot11 9
{11: ;
ParticipantUserId11< M
=11N O

matchState22 "
.22" #
ParticipantUserIds22# 5
[225 6
entry226 ;
.22; <
Key22< ?
]22? @
,22@ A
Response33  
=33! "
MapBlindResponse33# 3
(333 4
entry334 9
.339 :
Value33: ?
)33? @
}33A B
)33B C
.33C D
ToArray33D K
(33K L
)33L M
,33M N%
SilencedParticipantUserId44 )
=44* +
attempt44, 3
.443 4

RoleConfig444 >
?44> ?
.44? @
SilencedPlayerSeat44@ R
.44R S
HasValue44S [
==44\ ^
true44_ c
?55 
(55 
int55 
?55 
)55 

matchState55 &
.55& '
ParticipantUserIds55' 9
[559 :
attempt55: A
.55A B

RoleConfig55B L
.55L M
SilencedPlayerSeat55M _
.55_ `
Value55` e
]55e f
:55g h
null55i m
,55m n'
SoleObjectiveAssigneeUserId66 +
=66, -
attempt66. 5
.665 6

RoleConfig666 @
?66@ A
.66A B%
SoleObjectiveAssigneeSeat66B [
.66[ \
HasValue66\ d
==66e g
true66h l
?77 
(77 
int77 
?77 
)77 

matchState77 &
.77& '
ParticipantUserIds77' 9
[779 :
attempt77: A
.77A B

RoleConfig77B L
.77L M%
SoleObjectiveAssigneeSeat77M f
.77f g
Value77g l
]77l m
:77n o
null77p t
,77t u.
"SingleTrickWinnerParticipantUserId88 2
=883 4
attempt885 <
.88< =

RoleConfig88= G
?88G H
.88H I!
SingleTrickWinnerSeat88I ^
.88^ _
HasValue88_ g
==88h j
true88k o
?99 
(99 
int99 
?99 
)99 

matchState99 &
.99& '
ParticipantUserIds99' 9
[999 :
attempt99: A
.99A B

RoleConfig99B L
.99L M!
SingleTrickWinnerSeat99M b
.99b c
Value99c h
]99h i
:99j k
null99l p
,99p q!
IsPreparationComplete:: %
=::& '
attempt::( /
.::/ 0
Phase::0 5
==::6 8
MissionAttemptPhase::9 L
.::L M
PlayingTricks::M Z
||::[ ]
attempt;; 
.;; 
Phase;; !
==;;" $
MissionAttemptPhase;;% 8
.;;8 9
Finished;;9 A
,;;A B-
!CurrentObjectiveDraftPlayerUserId<< 1
=<<2 3

matchState<<4 >
.<<> ?
ParticipantUserIds<<? Q
[<<Q R
attempt<<R Y
.<<Y Z%
CurrentObjectiveDraftSeat<<Z s
]<<s t
,<<t u

Objectives== 
=== 
attempt== $
.==$ %

Objectives==% /
.==/ 0
Select==0 6
(==6 7
	objective==7 @
=>==A C#
CreateObjectiveSnapshot==D [
(==[ \

matchState==\ f
,==f g
	objective==h q
)==q r
)==r s
.>> 
ToArray>> 
(>> 
)>> 
}?? 
;?? )
ApplyFinalPreparationSnapshot@@ )
(@@) *
snapshot@@* 2
,@@2 3

matchState@@4 >
,@@> ?
participantSeat@@@ O
)@@O P
;@@P Q
returnAA 
snapshotAA 
;AA 
}BB 	
privateDD 
staticDD 
voidDD )
ApplyFinalPreparationSnapshotDD 9
(DD9 :,
 PlayerMissionPreparationSnapshotDD: Z
snapshotDD[ c
,DDc d

MatchStateEE 

matchStateEE !
,EE! "
intEE# &
participantSeatEE' 6
)EE6 7
{FF 	
MissionAttemptStateGG 
attemptGG  '
=GG( )

matchStateGG* 4
.GG4 5
MissionAttemptGG5 C
;GGC D
snapshotHH 
.HH 4
(FirstAndLastTrickWinnerParticipantUserIdHH =
=HH> ?!
GetParticipantForRoleHH@ U
(HHU V

matchStateHHV `
,HH` a
attemptII 
.II 

RoleConfigII "
?II" #
.II# $'
FirstAndLastTrickWinnerSeatII$ ?
)II? @
;II@ A
snapshotJJ 
.JJ 2
&FirstFourTricksWinnerParticipantUserIdJJ ;
=JJ< =!
GetParticipantForRoleJJ> S
(JJS T

matchStateJJT ^
,JJ^ _
attemptKK 
.KK 

RoleConfigKK "
?KK" #
.KK# $%
FirstFourTricksWinnerSeatKK$ =
)KK= >
;KK> ?
snapshotLL 
.LL ,
 LastTrickWinnerParticipantUserIdLL 5
=LL6 7!
GetParticipantForRoleLL8 M
(LLM N

matchStateLLN X
,LLX Y
attemptMM 
.MM 

RoleConfigMM "
?MM" #
.MM# $
LastTrickWinnerSeatMM$ 7
)MM7 8
;MM8 9
snapshotNN 
.NN +
HeartNineOwnerParticipantUserIdNN 4
=NN5 6
attemptNN7 >
.NN> ?

RoleConfigNN? I
?NNI J
.NNJ K'
HasIdentifiedHeartNineOwnerNNK f
==NNg i
trueNNj n
?OO !
GetParticipantForRoleOO '
(OO' (

matchStateOO( 2
,OO2 3
attemptOO4 ;
.OO; <

RoleConfigOO< F
.OOF G
HeartNineOwnerSeatOOG Y
)OOY Z
:OO[ \
nullOO] a
;OOa b
snapshotPP 
.PP 1
%RequiredHeartCaptureParticipantUserIdPP :
=PP; <
attemptPP= D
.PPD E

RoleConfigPPE O
?PPO P
.PPP Q'
HasIdentifiedHeartNineOwnerPPQ l
==PPm o
truePPp t
?QQ !
GetParticipantForRoleQQ '
(QQ' (

matchStateQQ( 2
,QQ2 3*
MissionSpecialPreparationRulesQQ4 R
.QQR S'
GetRequiredHeartCaptureSeatQQS n
(QQn o
attemptRR 
.RR 

RoleConfigRR &
,RR& '
attemptRR( /
.RR/ 0
PlayerCountRR0 ;
)RR; <
)RR< =
:RR> ?
nullRR@ D
;RRD E
snapshotSS 
.SS )
CanIdentifyHeartNineOwnershipSS 2
=SS3 4
GetPreparationStageSS5 H
(SSH I

matchStateSSI S
)SSS T
==SSU W#
MissionPreparationStageTT '
.TT' (#
HeartNineIdentificationTT( ?
&&TT@ B
attemptTTC J
.TTJ K

RoleConfigTTK U
?TTU V
.TTV W
HeartNineOwnerSeatTTW i
==TTj l
participantSeatUU #
;UU# $
}VV 	
privateXX 
staticXX $
MissionObjectiveSnapshotXX /#
CreateObjectiveSnapshotXX0 G
(XXG H

MatchStateYY 

matchStateYY !
,YY! "
MissionObjectiveYY# 3
	objectiveYY4 =
)YY= >
{ZZ 	
return[[ 
new[[ $
MissionObjectiveSnapshot[[ /
{\\ 
MissionObjectiveId]] "
=]]# $

matchState]]% /
.]]/ 0)
ObjectiveCardIdsByObjectiveId]]0 M
.^^ 
Single^^ 
(^^ 
entry^^ !
=>^^" $
entry^^% *
.^^* +
Value^^+ 0
==^^1 3
	objective^^4 =
.^^= >
CardId^^> D
)^^D E
.^^E F
Key^^F I
,^^I J
CardId__ 
=__ 
	objective__ "
.__" #

IsRevealed__# -
?__. /
(__0 1
int__1 4
?__4 5
)__5 6
	objective__6 ?
.__? @
CardId__@ F
:__G H
null__I M
,__M N
Token`` 
=`` 
s_objectiveTokens`` )
[``) *
	objective``* 3
.``3 4
Token``4 9
]``9 :
,``: ; 
AssignedPlayerUserIdaa $
=aa% &
	objectiveaa' 0
.aa0 1
AssignedSeataa1 =
.aa= >
HasValueaa> F
?bb 
(bb 
intbb 
?bb 
)bb 

matchStatebb &
.bb& '
ParticipantUserIdsbb' 9
[bb9 :
	objectivebb: C
.bbC D
AssignedSeatbbD P
.bbP Q
ValuebbQ V
]bbV W
:bbX Y
nullbbZ ^
,bb^ _
Statuscc 
=cc #
MissionEvaluationMappercc 0
.cc0 1
MapObjectiveStatuscc1 C
(ccC D
	objectiveccD M
.ccM N
StatusccN T
)ccT U
,ccU V"
CompletedAtTrickNumberdd &
=dd' (
	objectivedd) 2
.dd2 3"
CompletedAtTrickNumberdd3 I
,ddI J

IsRevealedee 
=ee 
	objectiveee &
.ee& '

IsRevealedee' 1
}ff 
;ff 
}gg 	
}hh 
}ii ê
âC:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\UseCases\Match\Transition\MatchUseCase.MissionTransitionDestination.cs
	namespace 	
Application
 
. 
UseCases 
{ 
public 

sealed 
partial 
class 
MatchUseCase  ,
{		 
private

 
static

 
bool

 $
ResolveMissionTransition

 4
(

4 5

MatchState

5 ?

matchState

@ J
)

J K
{ 	+
MissionTransitionScheduleStatus +
terminalStatus, :
=; <+
MissionTransitionScheduleStatus= \
.\ ]
Inactive] e
;e f
bool 
hasSucceeded 
= 

matchState  *
.* +
MissionAttempt+ 9
.9 :
Status: @
==A C 
MissionAttemptStatusD X
.X Y
	SucceededY b
;b c
int  
currentMissionNumber $
=% &

matchState' 1
.1 2
MissionAttempt2 @
.@ A
MissionNumberA N
;N O
int $
destinationMissionNumber (
=) * 
currentMissionNumber+ ?
;? @#
MissionTransitionAction #
transitionAction$ 4
=5 6#
MissionTransitionAction7 N
.N O
RetryCurrentMissionO b
;b c
if 
( 
hasSucceeded 
) 
{ 
transitionAction  
=! "#
MissionTransitionAction# :
.: ; 
AdvanceToNextMission; O
;O P$
destinationMissionNumber (
=) *#
MissionProgressionRules+ B
.B C 
AdvanceToNextMissionC W
(W X 
currentMissionNumberX l
,l m

matchState 
. 
TargetMissionCount 1
)1 2
;2 3
if 
( $
destinationMissionNumber ,
==- / 
currentMissionNumber0 D
)D E
{ 
terminalStatus "
=# $+
MissionTransitionScheduleStatus% D
.D E
CampaignCompletedE V
;V W
} 
else 
if 
( 
! %
MissionAttemptPreparation 3
.3 4
CanPrepareMission4 E
(E F$
destinationMissionNumberF ^
)^ _
)_ `
{ 
terminalStatus "
=# $+
MissionTransitionScheduleStatus% D
.D E
MissionUnavailableE W
;W X
} 
} 

matchState 
. &
ConfigureMissionTransition 1
(1 2
transitionAction2 B
,B C$
destinationMissionNumberD \
)\ ]
;] ^
if   
(   
terminalStatus   
!=   !+
MissionTransitionScheduleStatus  " A
.  A B
Inactive  B J
&&  K M

matchState!! 
.!! #
MissionTransitionStatus!! 2
!=!!3 5
terminalStatus!!6 D
)!!D E
{"" 

matchState## 
.## (
SetMissionTransitionSchedule## 7
(##7 8
terminalStatus##8 F
,##F G
new##H K$
MatchParticipantPresence##L d
{$$ %
MissingParticipantUserIds%% -
=%%. /
Array%%0 5
.%%5 6
Empty%%6 ;
<%%; <
int%%< ?
>%%? @
(%%@ A
)%%A B
}&& 
,&& 
$num&& 
)&& 
;&& 
}'' 
return(( 
terminalStatus(( !
==((" $+
MissionTransitionScheduleStatus((% D
.((D E
Inactive((E M
;((M N
})) 	
}** 
}++ ƒÌ
C:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\UseCases\Match\ObjectiveDraft\MatchUseCase.ObjectiveDraft.cs
	namespace

 	
Application


 
.

 
UseCases

 
{ 
public 

sealed 
partial 
class 
MatchUseCase  ,
{ 
private 
const 
int 2
&MaximumObjectiveDraftRequestsPerSecond @
=A B
$numC D
;D E
private 
const 
int @
4MaximumRetainedObjectiveDraftDecisionsPerParticipant N
=O P
$numQ T
;T U
public "
ObjectiveDraftDecision %'
ProcessObjectiveDraftAction& A
(A B$
ObjectiveDraftSubmission $$
objectiveDraftSubmission% =
,= >
int? B
participantUserIdC T
)T U
{ 	
var "
objectiveDraftDecision &
=' (
new) ,"
ObjectiveDraftDecision- C
{ &
ObjectiveDraftSubmissionId *
=+ ,$
objectiveDraftSubmission- E
?E F
.F G&
ObjectiveDraftSubmissionIdG a
??b d
Guide i
.i j
Emptyj o
,o p
RejectionReason 
=  !)
ObjectiveDraftRejectionReason" ?
.? @
InvalidSubmission@ Q
} 
; 
if 
( $
objectiveDraftSubmission (
!=) +
null, 0
&&1 3
!4 5
string5 ;
.; <
IsNullOrWhiteSpace< N
(N O$
objectiveDraftSubmissionO g
.g h
	LobbyCodeh q
)q r
)r s
{ 

MatchState 

matchState %
=& '
_matchStateStore( 8
.8 9
	FindMatch9 B
(B C$
objectiveDraftSubmissionC [
.[ \
	LobbyCode\ e
)e f
;f g
if 
( 

matchState 
!= !
null" &
)& '
{ 
lock 
( 

matchState $
)$ %
{ "
objectiveDraftDecision   .
=  / 0*
ProcessObjectiveDraftUnderLock  1 O
(  O P

matchState!! &
,!!& '$
objectiveDraftSubmission!!( @
,!!@ A
participantUserId!!B S
)!!S T
;!!T U
}"" 
}## 
else$$ 
{%% "
objectiveDraftDecision&& *
=&&+ ,"
objectiveDraftDecision&&- C
with&&D H
{'' 
RejectionReason(( '
=((( ))
ObjectiveDraftRejectionReason((* G
.((G H
MatchUnavailable((H X
})) 
;)) 
}** 
}++ 
return,, "
objectiveDraftDecision,, )
;,,) *
}-- 	
private// 
static// "
ObjectiveDraftDecision// -*
ProcessObjectiveDraftUnderLock//. L
(//L M

MatchState00 

matchState00 !
,00! "$
ObjectiveDraftSubmission00# ;$
objectiveDraftSubmission00< T
,00T U
int00V Y
participantUserId00Z k
)00k l
{11 	
var22 "
objectiveDraftDecision22 &
=22' (
new22) ,"
ObjectiveDraftDecision22- C
{33 &
ObjectiveDraftSubmissionId44 *
=44+ ,$
objectiveDraftSubmission44- E
.44E F&
ObjectiveDraftSubmissionId44F `
,44` a&
CommittedMatchStateVersion55 *
=55+ ,

matchState55- 7
.557 8
MatchStateVersion558 I
,55I J
RejectionReason66 
=66  !)
ObjectiveDraftRejectionReason66" ?
.66? @!
ParticipantNotAllowed66@ U
}77 
;77 
int88 
participantSeat88 
=88  !
Array88" '
.88' (
IndexOf88( /
(88/ 0

matchState880 :
.88: ;
ParticipantUserIds88; M
,88M N
participantUserId88O `
)88` a
;88a b
if99 
(99 
participantSeat99 
>=99  "
$num99# $
)99$ %
{:: "
objectiveDraftDecision;; &
=;;' (+
ResolveObjectiveDraftSubmission;;) H
(;;H I

matchState<< 
,<< $
objectiveDraftSubmission<<  8
,<<8 9
participantUserId<<: K
)<<K L
;<<L M
}== 
return>> "
objectiveDraftDecision>> )
;>>) *
}?? 	
privateAA 
staticAA "
ObjectiveDraftDecisionAA -+
ResolveObjectiveDraftSubmissionAA. M
(AAM N

MatchStateBB 

matchStateBB !
,BB! "$
ObjectiveDraftSubmissionBB# ;$
objectiveDraftSubmissionBB< T
,BBT U
intBBV Y
participantUserIdBBZ k
)BBk l
{CC 	"
ObjectiveDraftDecisionDD ""
objectiveDraftDecisionDD# 9
;DD9 :
ifEE 
(EE 

matchStateEE 
.EE $
ProcessedObjectiveDraftsEE 3
.EE3 4
TryGetValueEE4 ?
(EE? @$
objectiveDraftSubmissionEE@ X
.EEX Y&
ObjectiveDraftSubmissionIdEEY s
,EEs t
outFF #
ProcessedObjectiveDraftFF +
processedDraftFF, :
)FF: ;
)FF; <
{GG 
boolHH 
isSameRequestHH "
=HH# $
processedDraftHH% 3
.HH3 4
ParticipantUserIdHH4 E
==HHF H
participantUserIdHHI Z
&&HH[ ]
processedDraftII "
.II" #$
ObjectiveDraftSubmissionII# ;
==II< >$
objectiveDraftSubmissionII? W
;IIW X"
objectiveDraftDecisionJJ &
=JJ' (
processedDraftJJ) 7
.JJ7 8"
ObjectiveDraftDecisionJJ8 N
withJJO S
{KK 
HasStateChangedLL #
=LL$ %
falseLL& +
,LL+ ,

IsAcceptedMM 
=MM  
isSameRequestMM! .
&&MM/ 1
processedDraftMM2 @
.MM@ A"
ObjectiveDraftDecisionMMA W
.MMW X

IsAcceptedMMX b
,MMb c*
HasCompletedSelectionFreeCycleNN 2
=NN3 4
isSameRequestNN5 B
&&NNC E
processedDraftOO &
.OO& '"
ObjectiveDraftDecisionOO' =
.OO= >*
HasCompletedSelectionFreeCycleOO> \
,OO\ ]
RejectionReasonPP #
=PP$ %
isSameRequestPP& 3
?PP4 5
processedDraftPP6 D
.PPD E"
ObjectiveDraftDecisionPPE [
.PP[ \
RejectionReasonPP\ k
:PPl m)
ObjectiveDraftRejectionReasonQQ 5
.QQ5 6$
SubmissionIdentityReusedQQ6 N
}RR 
;RR 
}SS 
elseTT 
{UU "
objectiveDraftDecisionVV &
=VV' ($
ProcessNewObjectiveDraftVV) A
(VVA B

matchStateWW 
,WW $
objectiveDraftSubmissionWW  8
,WW8 9
participantUserIdWW: K
)WWK L
;WWL M
}XX 
returnYY "
objectiveDraftDecisionYY )
;YY) *
}ZZ 	
private\\ 
static\\ "
ObjectiveDraftDecision\\ -$
ProcessNewObjectiveDraft\\. F
(\\F G

MatchState]] 

matchState]] !
,]]! "$
ObjectiveDraftSubmission]]# ;$
objectiveDraftSubmission]]< T
,]]T U
int]]V Y
participantUserId]]Z k
)]]k l
{^^ 	)
ObjectiveDraftRejectionReason__ )
draftRejection__* 8
=__9 :.
"GetObjectiveDraftIdentityRejection`` 2
(``2 3

matchState``3 =
,``= >$
objectiveDraftSubmission``? W
)``W X
;``X Y
ifaa 
(aa 
draftRejectionaa 
==aa !)
ObjectiveDraftRejectionReasonaa" ?
.aa? @
Noneaa@ D
)aaD E
{bb 
draftRejectioncc 
=cc  '
ConsumeObjectiveDraftBudgetcc! <
(cc< =

matchStatecc= G
,ccG H
participantUserIdccI Z
)ccZ [
;cc[ \
}dd 
ifee 
(ee 
draftRejectionee 
==ee !)
ObjectiveDraftRejectionReasonee" ?
.ee? @
Noneee@ D
&&eeE G$
objectiveDraftSubmissionff (
.ff( )&
ObjectiveDraftSubmissionIdff) C
!=ffD F

matchStateffG Q
.ffQ R-
!CurrentObjectiveDraftSubmissionIdffR s
)ffs t
{gg 
draftRejectionhh 
=hh  )
ObjectiveDraftRejectionReasonhh! >
.hh> ?
SubmissionExpiredhh? P
;hhP Q
}ii 
booljj 
	canRecordjj 
=jj 
draftRejectionjj +
==jj, .)
ObjectiveDraftRejectionReasonjj/ L
.jjL M
NonejjM Q
;jjQ R
ifkk 
(kk 
	canRecordkk 
)kk 
{ll 
draftRejectionmm 
=mm  *
GetObjectiveDraftRuleRejectionmm! ?
(mm? @

matchStatenn 
,nn $
objectiveDraftSubmissionnn  8
,nn8 9
participantUserIdnn: K
)nnK L
;nnL M
}oo 
varpp "
objectiveDraftDecisionpp &
=pp' (
newpp) ,"
ObjectiveDraftDecisionpp- C
{qq &
ObjectiveDraftSubmissionIdrr *
=rr+ ,$
objectiveDraftSubmissionrr- E
.rrE F&
ObjectiveDraftSubmissionIdrrF `
,rr` a
RejectionReasonss 
=ss  !
draftRejectionss" 0
,ss0 1&
CommittedMatchStateVersiontt *
=tt+ ,

matchStatett- 7
.tt7 8
MatchStateVersiontt8 I
}uu 
;uu 
ifvv 
(vv 
draftRejectionvv 
==vv !)
ObjectiveDraftRejectionReasonvv" ?
.vv? @
Nonevv@ D
)vvD E
{ww "
objectiveDraftDecisionxx &
=xx' (%
ApplyObjectiveDraftActionxx) B
(xxB C

matchStateyy 
,yy $
objectiveDraftSubmissionyy  8
,yy8 9
participantUserIdyy: K
)yyK L
;yyL M
}zz 
if{{ 
({{ "
objectiveDraftDecision{{ &
.{{& '

IsAccepted{{' 1
){{1 2
{|| (
RetainObjectiveDraftDecision}} ,
(}}, -

matchState}}- 7
,}}7 8
participantUserId}}9 J
,}}J K
new}}L O#
ProcessedObjectiveDraft}}P g
{~~ 
ParticipantUserId %
=& '
participantUserId( 9
,9 :&
ObjectiveDraftSubmission
ÄÄ ,
=
ÄÄ- .&
objectiveDraftSubmission
ÄÄ/ G
,
ÄÄG H$
ObjectiveDraftDecision
ÅÅ *
=
ÅÅ+ ,$
objectiveDraftDecision
ÅÅ- C
}
ÇÇ 
)
ÇÇ 
;
ÇÇ 
}
ÉÉ 
return
ÑÑ $
objectiveDraftDecision
ÑÑ )
;
ÑÑ) *
}
ÖÖ 	
private
áá 
static
áá +
ObjectiveDraftRejectionReason
áá 40
"GetObjectiveDraftIdentityRejection
áá5 W
(
ááW X

MatchState
àà 

matchState
àà !
,
àà! "&
ObjectiveDraftSubmission
àà# ;&
objectiveDraftSubmission
àà< T
)
ààT U
{
ââ 	
bool
ää 
isActionValid
ää 
=
ää  &
objectiveDraftSubmission
ää! 9
.
ää9 :"
ObjectiveDraftAction
ää: N
==
ääO Q"
ObjectiveDraftAction
ääR f
.
ääf g
Pass
ääg k
||
ääl n&
objectiveDraftSubmission
ãã (
.
ãã( )"
ObjectiveDraftAction
ãã) =
==
ãã> @"
ObjectiveDraftAction
ããA U
.
ããU V
SelectObjective
ããV e
;
ããe f
bool
åå 
hasValidObjective
åå "
=
åå# $&
objectiveDraftSubmission
çç (
.
çç( )"
ObjectiveDraftAction
çç) =
==
çç> @"
ObjectiveDraftAction
ççA U
.
ççU V
SelectObjective
ççV e
?
éé &
objectiveDraftSubmission
éé *
.
éé* +(
SelectedMissionObjectiveId
éé+ E
.
ééE F
HasValue
ééF N
&&
ééO Q&
objectiveDraftSubmission
èè ,
.
èè, -(
SelectedMissionObjectiveId
èè- G
!=
èèH J
Guid
èèK O
.
èèO P
Empty
èèP U
:
êê 
!
êê &
objectiveDraftSubmission
êê +
.
êê+ ,(
SelectedMissionObjectiveId
êê, F
.
êêF G
HasValue
êêG O
;
êêO P
bool
ëë 
isIdentityValid
ëë  
=
ëë! "&
objectiveDraftSubmission
ëë# ;
.
ëë; <
MatchId
ëë< C
==
ëëD F

matchState
ëëG Q
.
ëëQ R
MatchId
ëëR Y
&&
ëëZ \&
objectiveDraftSubmission
íí (
.
íí( )
MissionAttemptId
íí) 9
==
íí: <

matchState
íí= G
.
ííG H
MissionAttempt
ííH V
.
ííV W
MissionAttemptId
ííW g
&&
ííh j&
objectiveDraftSubmission
ìì (
.
ìì( )(
ObjectiveDraftSubmissionId
ìì) C
!=
ììD F
Guid
ììG K
.
ììK L
Empty
ììL Q
;
ììQ R
return
îî 
isActionValid
îî  
&&
îî! #
hasValidObjective
îî$ 5
&&
îî6 8
isIdentityValid
îî9 H
?
îîI J+
ObjectiveDraftRejectionReason
îîK h
.
îîh i
None
îîi m
:
îîn o+
ObjectiveDraftRejectionReason
ïï -
.
ïï- .
InvalidSubmission
ïï. ?
;
ïï? @
}
ññ 	
private
òò 
static
òò +
ObjectiveDraftRejectionReason
òò 4)
ConsumeObjectiveDraftBudget
òò5 P
(
òòP Q

MatchState
ôô 

matchState
ôô !
,
ôô! "
int
ôô# &
participantUserId
ôô' 8
)
ôô8 9
{
öö 	&
MatchActionRequestBudget
õõ $
requestBudget
õõ% 2
=
õõ3 4&
MatchActionRequestLimits
õõ5 M
.
õõM N&
ConsumeParticipantWindow
õõN f
(
õõf g

matchState
úú 
.
úú 0
"ObjectiveDraftBudgetsByParticipant
úú =
,
úú= >
participantUserId
úú? P
,
úúP Q4
&MaximumObjectiveDraftRequestsPerSecond
ùù 6
)
ùù6 7
;
ùù7 8
return
ûû 
requestBudget
ûû  
==
ûû! #
null
ûû$ (
?
ûû) *+
ObjectiveDraftRejectionReason
ûû+ H
.
ûûH I!
RequestLimitReached
ûûI \
:
ûû] ^+
ObjectiveDraftRejectionReason
üü -
.
üü- .
None
üü. 2
;
üü2 3
}
†† 	
private
¢¢ 
static
¢¢ 
void
¢¢ *
RetainObjectiveDraftDecision
¢¢ 8
(
¢¢8 9

MatchState
££ 

matchState
££ !
,
££! "
int
££# &
participantUserId
££' 8
,
££8 9%
ProcessedObjectiveDraft
££: Q
processedDraft
££R `
)
££` a
{
§§ 	
if
•• 
(
•• 
!
•• 

matchState
•• 
.
•• 0
"ObjectiveDraftHistoryByParticipant
•• >
.
••> ?
TryGetValue
••? J
(
••J K
participantUserId
••K \
,
••\ ]
out
¶¶ 
Queue
¶¶ 
<
¶¶ 
Guid
¶¶ 
>
¶¶  
participantHistory
¶¶  2
)
¶¶2 3
)
¶¶3 4
{
ßß  
participantHistory
®® "
=
®®# $
new
®®% (
Queue
®®) .
<
®®. /
Guid
®®/ 3
>
®®3 4
(
®®4 5
)
®®5 6
;
®®6 7

matchState
©© 
.
©© 0
"ObjectiveDraftHistoryByParticipant
©© =
.
©©= >
Add
©©> A
(
©©A B
participantUserId
©©B S
,
©©S T 
participantHistory
©©U g
)
©©g h
;
©©h i
}
™™ 
if
´´ 
(
´´  
participantHistory
´´ "
.
´´" #
Count
´´# (
>=
´´) +B
4MaximumRetainedObjectiveDraftDecisionsPerParticipant
´´, `
)
´´` a
{
¨¨ 

matchState
≠≠ 
.
≠≠ &
ProcessedObjectiveDrafts
≠≠ 3
.
≠≠3 4
Remove
≠≠4 :
(
≠≠: ; 
participantHistory
≠≠; M
.
≠≠M N
Dequeue
≠≠N U
(
≠≠U V
)
≠≠V W
)
≠≠W X
;
≠≠X Y
}
ÆÆ 
Guid
ØØ 
submissionId
ØØ 
=
ØØ 
processedDraft
ØØ  .
.
ØØ. /&
ObjectiveDraftSubmission
ØØ/ G
.
ØØG H(
ObjectiveDraftSubmissionId
ØØH b
;
ØØb c

matchState
∞∞ 
.
∞∞ &
ProcessedObjectiveDrafts
∞∞ /
.
∞∞/ 0
Add
∞∞0 3
(
∞∞3 4
submissionId
∞∞4 @
,
∞∞@ A
processedDraft
∞∞B P
)
∞∞P Q
;
∞∞Q R 
participantHistory
±± 
.
±± 
Enqueue
±± &
(
±±& '
submissionId
±±' 3
)
±±3 4
;
±±4 5
}
≤≤ 	
private
¥¥ 
static
¥¥ +
ObjectiveDraftRejectionReason
¥¥ 4,
GetObjectiveDraftRuleRejection
¥¥5 S
(
¥¥S T

MatchState
µµ 

matchState
µµ !
,
µµ! "&
ObjectiveDraftSubmission
µµ# ;&
objectiveDraftSubmission
µµ< T
,
µµT U
int
µµV Y
participantUserId
µµZ k
)
µµk l
{
∂∂ 	+
ObjectiveDraftRejectionReason
∑∑ )
draftRejection
∑∑* 8
=
∑∑9 :+
ObjectiveDraftRejectionReason
∑∑; X
.
∑∑X Y
None
∑∑Y ]
;
∑∑] ^!
MissionAttemptState
∏∏ 
missionAttempt
∏∏  .
=
∏∏/ 0

matchState
∏∏1 ;
.
∏∏; <
MissionAttempt
∏∏< J
;
∏∏J K
if
ππ 
(
ππ 
missionAttempt
ππ 
.
ππ 
Phase
ππ $
!=
ππ% '!
MissionAttemptPhase
ππ( ;
.
ππ; <
ObjectiveDrafting
ππ< M
)
ππM N
{
∫∫ 
draftRejection
ªª 
=
ªª  +
ObjectiveDraftRejectionReason
ªª! >
.
ªª> ?"
PreparationCompleted
ªª? S
;
ªªS T
}
ºº 
else
ΩΩ 
{
ææ 
draftRejection
øø 
=
øø  .
 GetActiveObjectiveDraftRejection
øø! A
(
øøA B

matchState
¿¿ 
,
¿¿ &
objectiveDraftSubmission
¿¿  8
,
¿¿8 9
participantUserId
¿¿: K
)
¿¿K L
;
¿¿L M
}
¡¡ 
return
¬¬ 
draftRejection
¬¬ !
;
¬¬! "
}
√√ 	
private
≈≈ 
static
≈≈ +
ObjectiveDraftRejectionReason
≈≈ 4.
 GetActiveObjectiveDraftRejection
≈≈5 U
(
≈≈U V

MatchState
∆∆ 

matchState
∆∆ !
,
∆∆! "&
ObjectiveDraftSubmission
∆∆# ;&
objectiveDraftSubmission
∆∆< T
,
∆∆T U
int
∆∆V Y
participantUserId
∆∆Z k
)
∆∆k l
{
«« 	!
MissionAttemptState
»» 
missionAttempt
»»  .
=
»»/ 0

matchState
»»1 ;
.
»»; <
MissionAttempt
»»< J
;
»»J K+
ObjectiveDraftRejectionReason
…… )
draftRejection
……* 8
=
……9 :+
ObjectiveDraftRejectionReason
……; X
.
……X Y
None
……Y ]
;
……] ^
if
   
(
   
!
   '
MissionAttemptPreparation
   *
.
  * +
CanPrepareMission
  + <
(
  < =
missionAttempt
  = K
.
  K L
MissionNumber
  L Y
)
  Y Z
)
  Z [
{
ÀÀ 
draftRejection
ÃÃ 
=
ÃÃ  +
ObjectiveDraftRejectionReason
ÃÃ! >
.
ÃÃ> ?"
UnsupportedDraftMode
ÃÃ? S
;
ÃÃS T
}
ÕÕ 
else
ŒŒ 
if
ŒŒ 
(
ŒŒ &
objectiveDraftSubmission
ŒŒ -
.
ŒŒ- .'
ExpectedMatchStateVersion
ŒŒ. G
!=
ŒŒH J

matchState
ŒŒK U
.
ŒŒU V
MatchStateVersion
ŒŒV g
)
ŒŒg h
{
œœ 
draftRejection
–– 
=
––  +
ObjectiveDraftRejectionReason
––! >
.
––> ?
StaleMatchState
––? N
;
––N O
}
—— 
else
““ 
if
““ 
(
““ 

matchState
““ 
.
““   
ParticipantUserIds
““  2
[
““2 3
missionAttempt
““3 A
.
““A B'
CurrentObjectiveDraftSeat
““B [
]
““[ \
!=
““] _
participantUserId
““` q
)
““q r
{
”” 
draftRejection
‘‘ 
=
‘‘  +
ObjectiveDraftRejectionReason
‘‘! >
.
‘‘> ?
NotDraftTurn
‘‘? K
;
‘‘K L
}
’’ 
else
÷÷ 
{
◊◊ 
draftRejection
ÿÿ 
=
ÿÿ  *
ValidateObjectiveDraftChoice
ÿÿ! =
(
ÿÿ= >

matchState
ÿÿ> H
,
ÿÿH I&
objectiveDraftSubmission
ÿÿJ b
,
ÿÿb c
participantUserId
ÿÿd u
)
ÿÿu v
;
ÿÿv w
}
ŸŸ 
return
⁄⁄ 
draftRejection
⁄⁄ !
;
⁄⁄! "
}
€€ 	
private
›› 
static
›› +
ObjectiveDraftRejectionReason
›› 4*
ValidateObjectiveDraftChoice
››5 Q
(
››Q R

MatchState
ﬁﬁ 

matchState
ﬁﬁ !
,
ﬁﬁ! "&
ObjectiveDraftSubmission
ﬁﬁ# ;&
objectiveDraftSubmission
ﬁﬁ< T
,
ﬁﬁT U
int
ﬁﬁV Y
participantUserId
ﬁﬁZ k
)
ﬁﬁk l
{
ﬂﬂ 	!
MissionAttemptState
‡‡ 
missionAttempt
‡‡  .
=
‡‡/ 0

matchState
‡‡1 ;
.
‡‡; <
MissionAttempt
‡‡< J
;
‡‡J K
int
·· 
selectedCardId
·· 
=
··  
$num
··! "
;
··" #

matchState
‚‚ 
.
‚‚ +
ObjectiveCardIdsByObjectiveId
‚‚ 4
.
‚‚4 5
TryGetValue
‚‚5 @
(
‚‚@ A&
objectiveDraftSubmission
„„ (
.
„„( )(
SelectedMissionObjectiveId
„„) C
??
„„D F
Guid
„„G K
.
„„K L
Empty
„„L Q
,
„„Q R
out
„„S V
selectedCardId
„„W e
)
„„e f
;
„„f g
var
‰‰ 
draftContext
‰‰ 
=
‰‰ 
new
‰‰ "!
MissionDraftContext
‰‰# 6
{
ÂÂ 

Definition
ÊÊ 
=
ÊÊ 
MissionCatalog
ÊÊ +
.
ÊÊ+ ,

GetMission
ÊÊ, 6
(
ÊÊ6 7
missionAttempt
ÊÊ7 E
.
ÊÊE F
MissionNumber
ÊÊF S
)
ÊÊS T
,
ÊÊT U
CurrentObjectives
ÁÁ !
=
ÁÁ" #
missionAttempt
ÁÁ$ 2
.
ÁÁ2 3

Objectives
ÁÁ3 =
,
ÁÁ= >
ObjectiveIndex
ËË 
=
ËË  
missionAttempt
ËË! /
.
ËË/ 0

Objectives
ËË0 :
.
ËË: ;
ToList
ËË; A
(
ËËA B
)
ËËB C
.
ÈÈ 
	FindIndex
ÈÈ 
(
ÈÈ 
	objective
ÈÈ (
=>
ÈÈ) +
	objective
ÈÈ, 5
.
ÈÈ5 6
CardId
ÈÈ6 <
==
ÈÈ= ?
selectedCardId
ÈÈ@ N
)
ÈÈN O
,
ÈÈO P
AttemptingSeat
ÍÍ 
=
ÍÍ  
(
ÍÍ! "
byte
ÍÍ" &
)
ÍÍ& '
Array
ÍÍ' ,
.
ÍÍ, -
IndexOf
ÍÍ- 4
(
ÍÍ4 5

matchState
ÍÍ5 ?
.
ÍÍ? @ 
ParticipantUserIds
ÍÍ@ R
,
ÍÍR S
participantUserId
ÍÍT e
)
ÍÍe f
,
ÍÍf g'
CurrentObjectiveDraftSeat
ÎÎ )
=
ÎÎ* +
missionAttempt
ÎÎ, :
.
ÎÎ: ;'
CurrentObjectiveDraftSeat
ÎÎ; T
,
ÎÎT U
CaptainSeat
ÏÏ 
=
ÏÏ 
missionAttempt
ÏÏ ,
.
ÏÏ, -
CaptainSeat
ÏÏ- 8
,
ÏÏ8 9
PlayerCount
ÌÌ 
=
ÌÌ 
missionAttempt
ÌÌ ,
.
ÌÌ, -
PlayerCount
ÌÌ- 8
,
ÌÌ8 9

RoleConfig
ÓÓ 
=
ÓÓ 
missionAttempt
ÓÓ +
.
ÓÓ+ ,

RoleConfig
ÓÓ, 6
}
ÔÔ 
;
ÔÔ 
bool
 
	isAllowed
 
=
 &
objectiveDraftSubmission
 5
.
5 6"
ObjectiveDraftAction
6 J
==
K M"
ObjectiveDraftAction
N b
.
b c
Pass
c g
?
ÒÒ 
MissionSetupRules
ÒÒ #
.
ÒÒ# $#
CanPassObjectiveDraft
ÒÒ$ 9
(
ÒÒ9 :
draftContext
ÒÒ: F
)
ÒÒF G
:
ÚÚ 
MissionSetupRules
ÚÚ #
.
ÚÚ# $
CanDraftObjective
ÚÚ$ 5
(
ÚÚ5 6
draftContext
ÚÚ6 B
)
ÚÚB C
;
ÚÚC D
return
ÛÛ 
	isAllowed
ÛÛ 
?
ÛÛ +
ObjectiveDraftRejectionReason
ÛÛ <
.
ÛÛ< =
None
ÛÛ= A
:
ÛÛB C+
ObjectiveDraftRejectionReason
ÛÛD a
.
ÛÛa b"
ObjectiveUnavailable
ÛÛb v
;
ÛÛv w
}
ÙÙ 	
private
ˆˆ 
static
ˆˆ $
ObjectiveDraftDecision
ˆˆ -'
ApplyObjectiveDraftAction
ˆˆ. G
(
ˆˆG H

MatchState
˜˜ 

matchState
˜˜ !
,
˜˜! "&
ObjectiveDraftSubmission
˜˜# ;&
objectiveDraftSubmission
˜˜< T
,
˜˜T U
int
˜˜V Y
participantUserId
˜˜Z k
)
˜˜k l
{
¯¯ 	!
MissionAttemptState
˘˘ 
missionAttempt
˘˘  .
=
˘˘/ 0

matchState
˘˘1 ;
.
˘˘; <
MissionAttempt
˘˘< J
;
˘˘J K
bool
˙˙ "
hasSelectedObjective
˙˙ %
=
˙˙& '&
objectiveDraftSubmission
˚˚ (
.
˚˚( )"
ObjectiveDraftAction
˚˚) =
==
˚˚> @"
ObjectiveDraftAction
˚˚A U
.
˚˚U V
SelectObjective
˚˚V e
;
˚˚e f
if
¸¸ 
(
¸¸ "
hasSelectedObjective
¸¸ $
)
¸¸$ %
{
˝˝ 
int
˛˛ 
selectedCardId
˛˛ "
=
˛˛# $

matchState
˛˛% /
.
˛˛/ 0+
ObjectiveCardIdsByObjectiveId
˛˛0 M
[
˛˛M N&
objectiveDraftSubmission
ˇˇ ,
.
ˇˇ, -(
SelectedMissionObjectiveId
ˇˇ- G
.
ˇˇG H
Value
ˇˇH M
]
ˇˇM N
;
ˇˇN O
int
ÄÄ 
objectiveIndex
ÄÄ "
=
ÄÄ# $
missionAttempt
ÄÄ% 3
.
ÄÄ3 4

Objectives
ÄÄ4 >
.
ÄÄ> ?
ToList
ÄÄ? E
(
ÄÄE F
)
ÄÄF G
.
ÅÅ 
	FindIndex
ÅÅ 
(
ÅÅ 
	objective
ÅÅ (
=>
ÅÅ) +
	objective
ÅÅ, 5
.
ÅÅ5 6
CardId
ÅÅ6 <
==
ÅÅ= ?
selectedCardId
ÅÅ@ N
)
ÅÅN O
;
ÅÅO P
missionAttempt
ÇÇ 
=
ÇÇ  
missionAttempt
ÇÇ! /
with
ÇÇ0 4
{
ÉÉ 

Objectives
ÑÑ 
=
ÑÑ  
MissionSetupRules
ÑÑ! 2
.
ÑÑ2 3
AssignObjective
ÑÑ3 B
(
ÑÑB C
missionAttempt
ÑÑC Q
.
ÑÑQ R

Objectives
ÑÑR \
,
ÑÑ\ ]
objectiveIndex
ÑÑ^ l
,
ÑÑl m
(
ÖÖ 
byte
ÖÖ 
)
ÖÖ 
Array
ÖÖ #
.
ÖÖ# $
IndexOf
ÖÖ$ +
(
ÖÖ+ ,

matchState
ÖÖ, 6
.
ÖÖ6 7 
ParticipantUserIds
ÖÖ7 I
,
ÖÖI J
participantUserId
ÖÖK \
)
ÖÖ\ ]
)
ÖÖ] ^
}
ÜÜ 
;
ÜÜ 
}
áá 
bool
àà 
hasCompletedCycle
àà "
=
àà# $
!
àà% &"
hasSelectedObjective
àà& :
&&
àà; =
missionAttempt
ââ 
.
ââ 0
"ConsecutiveObjectiveDraftPassCount
ââ A
==
ââB D
missionAttempt
ââE S
.
ââS T
PlayerCount
ââT _
-
ââ` a
$num
ââb c
;
ââc d
missionAttempt
ää 
=
ää 
MissionSetupRules
ää .
.
ää. /#
AdvanceObjectiveDraft
ää/ D
(
ääD E
missionAttempt
ääE S
,
ääS T"
hasSelectedObjective
ääU i
)
ääi j
;
ääj k
if
ãã 
(
ãã 
missionAttempt
ãã 
.
ãã 

Objectives
ãã )
.
ãã) *
All
ãã* -
(
ãã- .
	objective
ãã. 7
=>
ãã8 :
	objective
ãã; D
.
ããD E
AssignedSeat
ããE Q
.
ããQ R
HasValue
ããR Z
)
ããZ [
)
ãã[ \
{
åå 
missionAttempt
çç 
=
çç  
missionAttempt
çç! /
with
çç0 4
{
çç5 6
Phase
çç7 <
=
çç= >!
MissionAttemptPhase
çç? R
.
ççR S
PlayingTricks
ççS `
}
çça b
;
ççb c
}
éé 

matchState
èè 
.
èè "
CommitObjectiveDraft
èè +
(
èè+ ,
missionAttempt
èè, :
)
èè: ;
;
èè; <
return
êê 
new
êê $
ObjectiveDraftDecision
êê -
{
ëë (
ObjectiveDraftSubmissionId
íí *
=
íí+ ,&
objectiveDraftSubmission
íí- E
.
ííE F(
ObjectiveDraftSubmissionId
ííF `
,
íí` a

IsAccepted
ìì 
=
ìì 
true
ìì !
,
ìì! "
HasStateChanged
îî 
=
îî  !
true
îî" &
,
îî& ',
HasCompletedSelectionFreeCycle
ïï .
=
ïï/ 0
hasCompletedCycle
ïï1 B
,
ïïB C(
CommittedMatchStateVersion
ññ *
=
ññ+ ,

matchState
ññ- 7
.
ññ7 8
MatchStateVersion
ññ8 I
}
óó 
;
óó 
}
òò 	
}
ôô 
}öö ¯	
vC:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\Models\Match\Draft\ObjectiveDraftRejectionReason.cs
	namespace 	
Application
 
. 
Models 
{ 
public 

enum )
ObjectiveDraftRejectionReason -
{ 
None 
= 
$num 
, 
MatchUnavailable 
= 
$num 
, !
ParticipantNotAllowed 
= 
$num  !
,! "
InvalidSubmission 
= 
$num 
, $
SubmissionIdentityReused		  
=		! "
$num		# $
,		$ %
StaleMatchState

 
=

 
$num

 
,

 
NotDraftTurn 
= 
$num 
,  
ObjectiveUnavailable 
= 
$num  
,  ! 
PreparationCompleted 
= 
$num  
,  !
RequestLimitReached 
= 
$num 
,   
UnsupportedDraftMode 
= 
$num !
,! "
SubmissionExpired 
= 
$num 
} 
} â
mC:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\Models\Match\Draft\ObjectiveDraftAction.cs
	namespace 	
Application
 
. 
Models 
{ 
public 

enum  
ObjectiveDraftAction $
{ 
Unspecified 
= 
$num 
, 
SelectObjective 
= 
$num 
, 
Pass 
= 
$num 
} 
}		 ©
qC:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\Models\Match\State\MatchActionRequestBudget.cs
	namespace 	
Application
 
. 
Models 
{ 
public 

sealed 
record $
MatchActionRequestBudget 1
{ 
public 
long "
WindowStartedTimestamp *
{+ ,
get- 0
;0 1
init2 6
;6 7
}8 9
public

 
int

 
RequestsInWindow

 #
{

$ %
get

& )
;

) *
init

+ /
;

/ 0
}

1 2
} 
} ïÉ
áC:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\UseCases\Match\Transition\MatchUseCase.MissionTransitionExecution.cs
	namespace 	
Application
 
. 
UseCases 
{ 
public		 

sealed		 
partial		 
class		 
MatchUseCase		  ,
{

 
private 
const 
string .
"ScheduledTransitionFailureTemplate ?
=@ A
$str ]
;] ^
private 
const 
string 0
$ScheduledTransitionCompletedTemplate A
=B C
$str W
;W X
public ,
 MissionTransitionExecutionResult /-
!ExecuteScheduledMissionTransition0 Q
(Q R!
MissionTransitionWorkR g
transitionWorkh v
,v w
CancellationToken 
cancellationToken /
)/ 0
{ 	,
 MissionTransitionExecutionResult ,
result- 3
;3 4
try 
{ 
result 
= /
#PrepareAndCommitScheduledTransition <
(< =
transitionWork= K
,K L
cancellationTokenM ^
)^ _
;_ `
} 
catch 
( 
ArgumentException $
ex% '
)' (
{ 
result 
= ,
 HandleScheduledTransitionFailure 9
(9 :
transitionWork: H
,H I
exJ L
)L M
;M N
} 
catch 
( %
InvalidOperationException ,
ex- /
)/ 0
{ 
result 
= ,
 HandleScheduledTransitionFailure 9
(9 :
transitionWork: H
,H I
exJ L
)L M
;M N
} 
catch   
(   "
CryptographicException   )
ex  * ,
)  , -
{!! 
result"" 
="" ,
 HandleScheduledTransitionFailure"" 9
(""9 :
transitionWork"": H
,""H I
ex""J L
)""L M
;""M N
}## 
return$$ 
result$$ 
;$$ 
}%% 	
private'' ,
 MissionTransitionExecutionResult'' 0/
#PrepareAndCommitScheduledTransition''1 T
(''T U!
MissionTransitionWork(( !
transitionWork((" 0
,((0 1
CancellationToken)) 
cancellationToken)) /
)))/ 0
{** 	

MatchState++ 

matchState++ !
=++" #
_matchStateStore++$ 4
.++4 5
	FindMatch++5 >
(++> ?
transitionWork++? M
.++M N
	LobbyCode++N W
)++W X
;++X Y
MatchPresenceQuery,, 
query,, $
=,,% &
null,,' +
;,,+ ,,
 MissionAttemptPreparationContext-- ,
preparationContext--- ?
=--@ A
null--B F
;--F G
if.. 
(.. 

matchState.. 
!=.. 
null.. "
).." #
{// 
lock00 
(00 

matchState00  
)00  !
{11 
if22 
(22 *
IsCurrentTransitionReservation22 6
(226 7

matchState227 A
,22A B
transitionWork33 &
)33& '
&&33( *
!33+ ,

matchState33, 6
.336 7)
HasStartedTransitionExecution337 T
)33T U
{44 

matchState55 "
.55" #*
MarkTransitionExecutionStarted55# A
(55A B
)55B C
;55C D
query66 
=66 
CreatePresenceQuery66  3
(663 4
transitionWork664 B
.66B C
	LobbyCode66C L
,66L M

matchState66N X
)66X Y
;66Y Z
preparationContext77 *
=77+ ,
new77- 0,
 MissionAttemptPreparationContext771 Q
{88 
MissionNumber99 )
=99* +
transitionWork99, :
.99: ;$
DestinationMissionNumber99; S
,99S T
MissionAttemptId:: ,
=::- .

matchState::/ 9
.::9 :
MissionAttempt::: H
.::H I
MissionAttemptId::I Y
+::Z [
$num::\ ]
,::] ^
AttemptNumber;; )
=;;* +'
GetDestinationAttemptNumber;;, G
(;;G H

matchState;;H R
);;R S
,;;S T
ParticipantUserIds<< .
=<</ 0
(<<1 2
int<<2 5
[<<5 6
]<<6 7
)<<7 8

matchState<<8 B
.<<B C
ParticipantUserIds<<C U
.<<U V
Clone<<V [
(<<[ \
)<<\ ]
}== 
;== 
}>> 
}?? 
}@@ 
varAA 
resultAA 
=AA 
newAA ,
 MissionTransitionExecutionResultAA =
{AA> ?
	LobbyCodeAA@ I
=AAJ K
transitionWorkAAL Z
.AAZ [
	LobbyCodeAA[ d
}AAe f
;AAf g
ifBB 
(BB 
queryBB 
!=BB 
nullBB 
&&BB  
!BB! "
cancellationTokenBB" 3
.BB3 4#
IsCancellationRequestedBB4 K
&&BBL N 
_participantPresenceCC $
.CC$ %
ConfirmPresenceCC% 4
(CC4 5
queryCC5 :
)CC: ;
)CC; <
{DD "
PreparedMissionAttemptEE &
preparedAttemptEE' 6
=EE7 8%
MissionAttemptPreparationEE9 R
.EER S
PrepareEES Z
(EEZ [
preparationContextEE[ m
,EEm n
_missionDeckDealerFF &
)FF& '
;FF' (
resultGG 
=GG $
CommitReservedTransitionGG 1
(GG1 2
transitionWorkGG2 @
,GG@ A
preparedAttemptGGB Q
,GGQ R
cancellationTokenGGS d
)GGd e
;GGe f
}HH 
elseII 
ifII 
(II 
queryII 
!=II 
nullII "
)II" #
{JJ 
resultKK 
=KK /
#ReleaseMissionTransitionReservationKK <
(KK< =
transitionWorkKK= K
,KKK L
falseKKM R
)KKR S
;KKS T
}LL 
returnMM 
resultMM 
;MM 
}NN 	
privatePP ,
 MissionTransitionExecutionResultPP 0$
CommitReservedTransitionPP1 I
(PPI J!
MissionTransitionWorkPPJ _
transitionWorkPP` n
,PPn o"
PreparedMissionAttemptQQ "
preparedAttemptQQ# 2
,QQ2 3
CancellationTokenQQ4 E
cancellationTokenQQF W
)QQW X
{RR 	

MatchStateSS 

matchStateSS !
=SS" #
_matchStateStoreSS$ 4
.SS4 5
	FindMatchSS5 >
(SS> ?
transitionWorkSS? M
.SSM N
	LobbyCodeSSN W
)SSW X
;SSX Y
boolTT 
hasCommittedTT 
=TT 
falseTT  %
;TT% &
lockUU 
(UU 

matchStateUU 
)UU 
{VV $
MatchParticipantPresenceWW (
presenceWW) 1
=WW2 3 
_participantPresenceWW4 H
.WWH I
ReadPresenceWWI U
(WWU V
CreatePresenceQueryXX '
(XX' (
transitionWorkXX( 6
.XX6 7
	LobbyCodeXX7 @
,XX@ A

matchStateXXB L
)XXL M
)XXM N
;XXN O
boolYY 
hasSameConnectionsYY '
=YY( )
presenceYY* 2
.YY2 3
ConnectionVersionYY3 D
==YYE G
transitionWorkYYH V
.YYV W
ConnectionVersionYYW h
&&YYi k
presenceZZ 
.ZZ %
MissingParticipantUserIdsZZ 6
.ZZ6 7
LengthZZ7 =
==ZZ> @
$numZZA B
;ZZB C
if[[ 
([[ *
IsCurrentTransitionReservation[[ 2
([[2 3

matchState[[3 =
,[[= >
transitionWork[[? M
)[[M N
&&[[O Q
hasSameConnections[[R d
&&[[e g
!\\ 
cancellationToken\\ &
.\\& '#
IsCancellationRequested\\' >
)\\> ?
{]] 

matchState^^ 
.^^ ,
 CommitScheduledMissionTransition^^ ?
(^^? @
preparedAttempt^^@ O
)^^O P
;^^P Q
hasCommitted__  
=__! "
true__# '
;__' (
}`` 
}aa ,
 MissionTransitionExecutionResultbb ,
resultbb- 3
=bb4 5
hasCommittedbb6 B
?cc 
newcc ,
 MissionTransitionExecutionResultcc 6
{dd 
	LobbyCodeee 
=ee 
transitionWorkee  .
.ee. /
	LobbyCodeee/ 8
,ee8 9
HasStateChangedff #
=ff$ %
trueff& *
,ff* +'
HasAppliedMissionTransitiongg /
=gg0 1
truegg2 6
,gg6 7&
CommittedMatchStateVersionhh .
=hh/ 0

matchStatehh1 ;
.hh; <
MatchStateVersionhh< M
}ii 
:jj /
#ReleaseMissionTransitionReservationjj 5
(jj5 6
transitionWorkjj6 D
,jjD E
falsejjF K
)jjK L
;jjL M
ifkk 
(kk 
hasCommittedkk 
)kk 
{ll 
_loggermm 
.mm 
Informationmm #
(mm# $0
$ScheduledTransitionCompletedTemplatemm$ H
,mmH I
transitionWorkmmJ X
.mmX Y
MatchIdmmY `
,mm` a
preparedAttemptnn #
.nn# $
MissionAttemptnn$ 2
.nn2 3
MissionAttemptIdnn3 C
)nnC D
;nnD E
}oo 
returnpp 
resultpp 
;pp 
}qq 	
privatess ,
 MissionTransitionExecutionResultss 0,
 HandleScheduledTransitionFailuress1 Q
(ssQ R!
MissionTransitionWorktt !
transitionWorktt" 0
,tt0 1
	Exceptiontt2 ;
extt< >
)tt> ?
{uu 	
_loggervv 
.vv 
Errorvv 
(vv .
"ScheduledTransitionFailureTemplatevv <
,vv< =
exvv> @
.vv@ A
GetTypevvA H
(vvH I
)vvI J
.vvJ K
NamevvK O
)vvO P
;vvP Q
returnww /
#ReleaseMissionTransitionReservationww 6
(ww6 7
transitionWorkww7 E
,wwE F
truewwG K
)wwK L
;wwL M
}xx 	
publiczz ,
 MissionTransitionExecutionResultzz //
#ReleaseMissionTransitionReservationzz0 S
(zzS T!
MissionTransitionWork{{ !
transitionWork{{" 0
,{{0 1
bool||  
hasPreparationFailed|| %
)||% &
{}} 	
var~~ 
result~~ 
=~~ 
new~~ ,
 MissionTransitionExecutionResult~~ =
{~~> ?
	LobbyCode~~@ I
=~~J K
transitionWork~~L Z
.~~Z [
	LobbyCode~~[ d
}~~e f
;~~f g

MatchState 

matchState !
=" #
_matchStateStore$ 4
.4 5
	FindMatch5 >
(> ?
transitionWork? M
.M N
	LobbyCodeN W
)W X
;X Y
if
ÄÄ 
(
ÄÄ 

matchState
ÄÄ 
!=
ÄÄ 
null
ÄÄ "
)
ÄÄ" #
{
ÅÅ 
lock
ÇÇ 
(
ÇÇ 

matchState
ÇÇ  
)
ÇÇ  !
{
ÉÉ 
if
ÑÑ 
(
ÑÑ ,
IsCurrentTransitionReservation
ÑÑ 6
(
ÑÑ6 7

matchState
ÑÑ7 A
,
ÑÑA B
transitionWork
ÑÑC Q
)
ÑÑQ R
)
ÑÑR S
{
ÖÖ &
MatchParticipantPresence
ÜÜ 0
presence
ÜÜ1 9
=
ÜÜ: ;"
_participantPresence
ÜÜ< P
.
ÜÜP Q
ReadPresence
ÜÜQ ]
(
ÜÜ] ^!
CreatePresenceQuery
áá /
(
áá/ 0
transitionWork
áá0 >
.
áá> ?
	LobbyCode
áá? H
,
ááH I

matchState
ááJ T
)
ááT U
)
ááU V
;
ááV W-
MissionTransitionScheduleStatus
àà 7
status
àà8 >
=
àà? @"
hasPreparationFailed
ààA U
?
ââ -
MissionTransitionScheduleStatus
ââ =
.
ââ= >
PreparationFailed
ââ> O
:
ää -
MissionTransitionScheduleStatus
ää =
.
ää= >
CountingDown
ää> J
;
ääJ K
long
ãã 
deadline
ãã %
=
ãã& '
_matchClock
ãã( 3
.
ãã3 4&
GetTimestampMilliseconds
ãã4 L
(
ããL M
)
ããM N
+
ããO P%
MissionTransitionPolicy
åå 3
.
åå3 4,
PreparationBackoffMilliseconds
åå4 R
;
ååR S
if
çç 
(
çç 
presence
çç $
.
çç$ %'
MissingParticipantUserIds
çç% >
.
çç> ?
Length
çç? E
>
ççF G
$num
ççH I
)
ççI J
{
éé 
status
èè "
=
èè# $-
MissionTransitionScheduleStatus
èè% D
.
èèD E$
WaitingForParticipants
èèE [
;
èè[ \
deadline
êê $
=
êê% &
$num
êê' (
;
êê( )
}
ëë 

matchState
íí "
.
íí" #*
SetMissionTransitionSchedule
íí# ?
(
íí? @
status
íí@ F
,
ííF G
presence
ííH P
,
ííP Q
deadline
ííR Z
)
ííZ [
;
íí[ \
result
ìì 
=
ìì  
result
ìì! '
with
ìì( ,
{
îî 
HasStateChanged
ïï +
=
ïï, -
true
ïï. 2
,
ïï2 3(
CommittedMatchStateVersion
ññ 6
=
ññ7 8

matchState
ññ9 C
.
ññC D
MatchStateVersion
ññD U
}
óó 
;
óó 
}
òò 
}
ôô 
}
öö 
return
õõ 
result
õõ 
;
õõ 
}
úú 	
private
ûû 
static
ûû 
int
ûû )
GetDestinationAttemptNumber
ûû 6
(
ûû6 7

MatchState
ûû7 A

matchState
ûûB L
)
ûûL M
{
üü 	
return
†† 

matchState
†† 
.
†† 
TransitionAction
†† .
==
††/ 1%
MissionTransitionAction
††2 I
.
††I J"
AdvanceToNextMission
††J ^
?
°° %
MissionProgressionRules
°° )
.
°°) *"
InitialAttemptNumber
°°* >
:
¢¢ %
MissionProgressionRules
¢¢ )
.
¢¢) *
RestartAttempt
¢¢* 8
(
¢¢8 9

matchState
¢¢9 C
.
¢¢C D
MissionAttempt
¢¢D R
.
¢¢R S
AttemptNumber
¢¢S `
)
¢¢` a
;
¢¢a b
}
££ 	
private
•• 
static
•• 
bool
•• ,
IsCurrentTransitionReservation
•• :
(
••: ;

MatchState
••; E

matchState
••F P
,
••P Q#
MissionTransitionWork
••R g
transitionWork
••h v
)
••v w
{
¶¶ 	
return
ßß *
CanScheduleMissionTransition
ßß /
(
ßß/ 0

matchState
ßß0 :
)
ßß: ;
&&
ßß< >

matchState
ßß? I
.
ßßI J
MatchId
ßßJ Q
==
ßßR T
transitionWork
ßßU c
.
ßßc d
MatchId
ßßd k
&&
ßßl n

matchState
®® 
.
®® 
MissionAttempt
®® )
.
®®) *
MissionAttemptId
®®* :
==
®®; =
transitionWork
®®> L
.
®®L M
MissionAttemptId
®®M ]
&&
®®^ `

matchState
©© 
.
©© 
TransitionAction
©© +
==
©©, .
transitionWork
©©/ =
.
©©= >
TransitionAction
©©> N
&&
©©O Q

matchState
™™ 
.
™™ &
DestinationMissionNumber
™™ 3
==
™™4 6
transitionWork
™™7 E
.
™™E F&
DestinationMissionNumber
™™F ^
&&
™™_ a

matchState
´´ 
.
´´ )
MissionTransitionScheduleId
´´ 6
==
´´7 9
transitionWork
´´: H
.
´´H I)
MissionTransitionScheduleId
´´I d
&&
´´e g

matchState
¨¨ 
.
¨¨ %
MissionTransitionStatus
¨¨ 2
==
¨¨3 5-
MissionTransitionScheduleStatus
¨¨6 U
.
¨¨U V
	Preparing
¨¨V _
;
¨¨_ `
}
≠≠ 	
}
ÆÆ 
}ØØ ˘
pC:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\Models\Match\Draft\ProcessedObjectiveDraft.cs
	namespace 	
Application
 
. 
Models 
{ 
public 

sealed 
record #
ProcessedObjectiveDraft 0
{ 
public 
int 
ParticipantUserId $
{% &
get' *
;* +
init, 0
;0 1
}2 3
public

 $
ObjectiveDraftSubmission

 '$
ObjectiveDraftSubmission

( @
{

A B
get

C F
;

F G
init

H L
;

L M
}

N O
public "
ObjectiveDraftDecision %"
ObjectiveDraftDecision& <
{= >
get? B
;B C
initD H
;H I
}J K
} 
} ﬂ

oC:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\Models\Match\Draft\ObjectiveDraftDecision.cs
	namespace 	
Application
 
. 
Models 
{ 
public 

sealed 
record "
ObjectiveDraftDecision /
{ 
public 
Guid &
ObjectiveDraftSubmissionId .
{/ 0
get1 4
;4 5
init6 :
;: ;
}< =
public

 
bool

 

IsAccepted

 
{

  
get

! $
;

$ %
init

& *
;

* +
}

, -
public )
ObjectiveDraftRejectionReason ,
RejectionReason- <
{= >
get? B
;B C
initD H
;H I
}J K
public 
long &
CommittedMatchStateVersion .
{/ 0
get1 4
;4 5
init6 :
;: ;
}< =
public 
bool *
HasCompletedSelectionFreeCycle 2
{3 4
get5 8
;8 9
init: >
;> ?
}@ A
public 
bool 
HasStateChanged #
{$ %
get& )
;) *
init+ /
;/ 0
}1 2
} 
} Ñ
qC:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\Models\Match\Draft\ObjectiveDraftSubmission.cs
	namespace 	
Application
 
. 
Models 
{ 
public 

sealed 
record $
ObjectiveDraftSubmission 1
{ 
public 
string 
	LobbyCode 
{  !
get" %
;% &
init' +
;+ ,
}- .
public

 
Guid

 
MatchId

 
{

 
get

 !
;

! "
init

# '
;

' (
}

) *
public 
int 
MissionAttemptId #
{$ %
get& )
;) *
init+ /
;/ 0
}1 2
public 
Guid &
ObjectiveDraftSubmissionId .
{/ 0
get1 4
;4 5
init6 :
;: ;
}< =
public 
long %
ExpectedMatchStateVersion -
{. /
get0 3
;3 4
init5 9
;9 :
}; <
public  
ObjectiveDraftAction # 
ObjectiveDraftAction$ 8
{9 :
get; >
;> ?
init@ D
;D E
}F G
public 
Guid 
? &
SelectedMissionObjectiveId /
{0 1
get2 5
;5 6
init7 ;
;; <
}= >
} 
} úb
àC:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\UseCases\Match\Transition\MatchUseCase.MissionTransitionScheduling.cs
	namespace 	
Application
 
. 
UseCases 
{		 
public

 

sealed

 
partial

 
class

 
MatchUseCase

  ,
{ 
public 
IReadOnlyList 
< !
MissionTransitionWork 2
>2 3%
TakeDueMissionTransitions4 M
(M N
intN Q
maximumPreparationsR e
)e f
{ 	
var 
dueTransitions 
=  
new! $
List% )
<) *!
MissionTransitionWork* ?
>? @
(@ A
)A B
;B C
int 
preparationLimit  
=! "
Math# '
.' (
Min( +
(+ ,
Math, 0
.0 1
Max1 4
(4 5
maximumPreparations5 H
,H I
$numJ K
)K L
,L M#
MissionTransitionPolicy '
.' ()
MaximumConcurrentPreparations( E
)E F
;F G
foreach 
( 
KeyValuePair !
<! "
string" (
,( )

MatchState* 4
>4 5
storedMatch6 A
inB D
_matchStateStoreE U
.U V

GetMatchesV `
(` a
)a b
)b c
{ 
lock 
( 
storedMatch !
.! "
Value" '
)' (
{ !
MissionTransitionWork )
transitionWork* 8
=9 :,
 RefreshMissionTransitionSchedule; [
([ \
storedMatch\ g
,g h
dueTransitions &
.& '
Count' ,
<- .
preparationLimit/ ?
)? @
;@ A
if 
( 
transitionWork &
!=' )
null* .
). /
{ 
dueTransitions &
.& '
Add' *
(* +
transitionWork+ 9
)9 :
;: ;
} 
} 
} 
return 
dueTransitions !
;! "
} 	
private   !
MissionTransitionWork   %,
 RefreshMissionTransitionSchedule  & F
(  F G
KeyValuePair  G S
<  S T
string  T Z
,  Z [

MatchState  \ f
>  f g
storedMatch  h s
,  s t
bool!! 

canPrepare!! 
)!! 
{"" 	

MatchState## 

matchState## !
=##" #
storedMatch##$ /
.##/ 0
Value##0 5
;##5 6!
MissionTransitionWork$$ !
transitionWork$$" 0
=$$1 2
null$$3 7
;$$7 8
if%% 
(%% (
CanScheduleMissionTransition%% ,
(%%, -

matchState%%- 7
)%%7 8
&&%%9 ;$
ResolveMissionTransition%%< T
(%%T U

matchState%%U _
)%%_ `
)%%` a
{&& 
MatchPresenceQuery'' "
query''# (
='') *
CreatePresenceQuery''+ >
(''> ?
storedMatch''? J
.''J K
Key''K N
,''N O

matchState''P Z
)''Z [
;''[ \$
MatchParticipantPresence(( (
presence(() 1
=((2 3 
_participantPresence((4 H
.((H I
ReadPresence((I U
(((U V
query((V [
)(([ \
;((\ ])
RefreshTransitionConnectivity)) -
())- .

matchState)). 8
,))8 9
presence)): B
)))B C
;))C D
bool** 
isCountdownDue** #
=**$ %
(++ 

matchState++ 
.++  #
MissionTransitionStatus++  7
==++8 :+
MissionTransitionScheduleStatus++; Z
.++Z [
CountingDown++[ g
||++h j

matchState,, 
.,, #
MissionTransitionStatus,, 6
==,,7 9+
MissionTransitionScheduleStatus,,: Y
.,,Y Z
PreparationFailed,,Z k
),,k l
&&,,m o
_matchClock-- 
.--  $
GetTimestampMilliseconds--  8
(--8 9
)--9 :
>=--; =

matchState--> H
.--H I1
%MissionTransitionDeadlineMilliseconds--I n
;--n o
if.. 
(.. 
isCountdownDue.. "
&&..# %

canPrepare..& 0
)..0 1
{// 

matchState00 
.00 /
#ReserveMissionTransitionPreparation00 B
(00B C
)00C D
;00D E
transitionWork11 "
=11# $
new11% (!
MissionTransitionWork11) >
{22 
	LobbyCode33 !
=33" #
storedMatch33$ /
.33/ 0
Key330 3
,333 4
MatchId44 
=44  !

matchState44" ,
.44, -
MatchId44- 4
,444 5
MissionAttemptId55 (
=55) *

matchState55+ 5
.555 6
MissionAttempt556 D
.55D E
MissionAttemptId55E U
,55U V'
MissionTransitionScheduleId66 3
=664 5

matchState666 @
.66@ A'
MissionTransitionScheduleId66A \
,66\ ]
TransitionAction77 (
=77) *

matchState77+ 5
.775 6
TransitionAction776 F
,77F G$
DestinationMissionNumber88 0
=881 2

matchState883 =
.88= >$
DestinationMissionNumber88> V
,88V W
ConnectionVersion99 )
=99* +
presence99, 4
.994 5
ConnectionVersion995 F
}:: 
;:: 
};; 
}<< 
return== 
transitionWork== !
;==! "
}>> 	
private@@ 
static@@ 
bool@@ (
CanScheduleMissionTransition@@ 8
(@@8 9

MatchState@@9 C

matchState@@D N
)@@N O
{AA 	
returnBB 

matchStateBB 
.BB 
MissionAttemptBB ,
.BB, -
PhaseBB- 2
==BB3 5
MissionAttemptPhaseBB6 I
.BBI J
FinishedBBJ R
&&BBS U
(CC 

matchStateCC 
.CC 
MissionAttemptCC *
.CC* +
StatusCC+ 1
==CC2 4 
MissionAttemptStatusCC5 I
.CCI J
FailedCCJ P
||CCQ S

matchStateDD 
.DD 
MissionAttemptDD -
.DD- .
StatusDD. 4
==DD5 7 
MissionAttemptStatusDD8 L
.DDL M
	SucceededDDM V
)DDV W
;DDW X
}EE 	
privateGG 
voidGG )
RefreshTransitionConnectivityGG 2
(GG2 3

MatchStateGG3 =

matchStateGG> H
,GGH I$
MatchParticipantPresenceGGJ b
presenceGGc k
)GGk l
{HH 	
ifII 
(II 
presenceII 
.II %
MissingParticipantUserIdsII 2
.II2 3
LengthII3 9
>II: ;
$numII< =
)II= >
{JJ 
boolKK 
hasPresenceChangedKK '
=KK( )

matchStateLL 
.LL #
MissionTransitionStatusLL 6
!=LL7 9+
MissionTransitionScheduleStatusLL: Y
.LLY Z"
WaitingForParticipantsLLZ p
||LLq s

matchStateMM 
.MM .
"MissionTransitionConnectionVersionMM A
!=MMB D
presenceMME M
.MMM N
ConnectionVersionMMN _
||MM` b
!NN 

matchStateNN 
.NN  /
#MissingTransitionParticipantUserIdsNN  C
.NNC D
SequenceEqualNND Q
(NNQ R
presenceNNR Z
.NNZ [%
MissingParticipantUserIdsNN[ t
)NNt u
;NNu v
ifOO 
(OO 
hasPresenceChangedOO &
)OO& '
{PP 

matchStateQQ 
.QQ (
SetMissionTransitionScheduleQQ ;
(QQ; <+
MissionTransitionScheduleStatusQQ< [
.QQ[ \"
WaitingForParticipantsQQ\ r
,QQr s
presenceRR  
,RR  !
$numRR" #
)RR# $
;RR$ %
}SS 
}TT 
elseUU 
{VV &
RefreshConnectedTransitionWW *
(WW* +

matchStateWW+ 5
,WW5 6
presenceWW7 ?
)WW? @
;WW@ A
}XX 
}YY 	
private[[ 
void[[ &
RefreshConnectedTransition[[ /
([[/ 0

MatchState[[0 :

matchState[[; E
,[[E F$
MatchParticipantPresence[[G _
presence[[` h
)[[h i
{\\ 	
bool]] 
hasAttemptCapacity]] #
=]]$ %

matchState]]& 0
.]]0 1
MissionAttempt]]1 ?
.]]? @
MissionAttemptId]]@ P
<]]Q R
int]]S V
.]]V W
MaxValue]]W _
&&]]` b
(^^ 

matchState^^ 
.^^ 
TransitionAction^^ ,
==^^- /#
MissionTransitionAction^^0 G
.^^G H 
AdvanceToNextMission^^H \
||^^] _

matchState__ 
.__ 
MissionAttempt__ -
.__- .
AttemptNumber__. ;
<__< =
int__> A
.__A B
MaxValue__B J
)__J K
;__K L
if`` 
(`` 
!`` 
hasAttemptCapacity`` #
)``# $
{aa 
ifbb 
(bb 

matchStatebb 
.bb #
MissionTransitionStatusbb 6
!=bb7 9+
MissionTransitionScheduleStatusbb: Y
.bbY Z
AttemptLimitReachedbbZ m
)bbm n
{cc 

matchStatedd 
.dd (
SetMissionTransitionScheduledd ;
(dd; <+
MissionTransitionScheduleStatusdd< [
.dd[ \
AttemptLimitReacheddd\ o
,ddo p
presenceee  
,ee  !
$numee" #
)ee# $
;ee$ %
}ff 
}gg 
elsehh 
ifhh 
(hh 

matchStatehh 
.hh  #
MissionTransitionStatushh  7
==hh8 :+
MissionTransitionScheduleStatushh; Z
.hhZ [
Inactivehh[ c
||hhd f

matchStateii 
.ii #
MissionTransitionStatusii 2
==ii3 5+
MissionTransitionScheduleStatusii6 U
.iiU V"
WaitingForParticipantsiiV l
||iim o

matchStatejj 
.jj .
"MissionTransitionConnectionVersionjj =
!=jj> @
presencejjA I
.jjI J
ConnectionVersionjjJ [
)jj[ \
{kk 

matchStatell 
.ll (
SetMissionTransitionSchedulell 7
(ll7 8+
MissionTransitionScheduleStatusll8 W
.llW X
CountingDownllX d
,lld e
presencellf n
,lln o
_matchClockmm 
.mm  $
GetTimestampMillisecondsmm  8
(mm8 9
)mm9 :
+mm; <#
MissionTransitionPolicymm= T
.mmT U!
CountdownMillisecondsmmU j
)mmj k
;mmk l
}nn 
}oo 	
privateqq 
staticqq 
MatchPresenceQueryqq )
CreatePresenceQueryqq* =
(qq= >
stringqq> D
	lobbyCodeqqE N
,qqN O

MatchStateqqP Z

matchStateqq[ e
)qqe f
{rr 	
returnss 
newss 
MatchPresenceQueryss )
{tt 
	LobbyCodeuu 
=uu 
	lobbyCodeuu %
,uu% &
MatchIdvv 
=vv 

matchStatevv $
.vv$ %
MatchIdvv% ,
,vv, -
MissionAttemptIdww  
=ww! "

matchStateww# -
.ww- .
MissionAttemptww. <
.ww< =
MissionAttemptIdww= M
,wwM N
ParticipantUserIdsxx "
=xx# $
(xx% &
intxx& )
[xx) *
]xx* +
)xx+ ,

matchStatexx, 6
.xx6 7
ParticipantUserIdsxx7 I
.xxI J
ClonexxJ O
(xxO P
)xxP Q
,xxQ R%
ExpectedConnectionVersionyy )
=yy* +

matchStateyy, 6
.yy6 7.
"MissionTransitionConnectionVersionyy7 Y
}zz 
;zz 
}{{ 	
}|| 
}}} é
~C:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\Models\Match\Transition\MissionTransitionExecutionResult.cs
	namespace 	
Application
 
. 
Models 
{ 
public 

sealed 
record ,
 MissionTransitionExecutionResult 9
{ 
public 
string 
	LobbyCode 
{  !
get" %
;% &
init' +
;+ ,
}- .
public

 
bool

 
HasStateChanged

 #
{

$ %
get

& )
;

) *
init

+ /
;

/ 0
}

1 2
public 
bool '
HasAppliedMissionTransition /
{0 1
get2 5
;5 6
init7 ;
;; <
}= >
public 
long &
CommittedMatchStateVersion .
{/ 0
get1 4
;4 5
init6 :
;: ;
}< =
} 
} È
sC:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\Models\Match\Transition\MissionTransitionWork.cs
	namespace 	
Application
 
. 
Models 
{ 
public 

sealed 
record !
MissionTransitionWork .
{ 
public 
string 
	LobbyCode 
{  !
get" %
;% &
init' +
;+ ,
}- .
public

 
Guid

 
MatchId

 
{

 
get

 !
;

! "
init

# '
;

' (
}

) *
public 
int 
MissionAttemptId #
{$ %
get& )
;) *
init+ /
;/ 0
}1 2
public 
Guid '
MissionTransitionScheduleId /
{0 1
get2 5
;5 6
init7 ;
;; <
}= >
public #
MissionTransitionAction &
TransitionAction' 7
{8 9
get: =
;= >
init? C
;C D
}E F
public 
int $
DestinationMissionNumber +
{, -
get. 1
;1 2
init3 7
;7 8
}9 :
public 
long 
ConnectionVersion %
{& '
get( +
;+ ,
init- 1
;1 2
}3 4
} 
} À
qC:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\Models\Match\State\MatchParticipantPresence.cs
	namespace 	
Application
 
. 
Models 
{ 
public 

sealed 
record $
MatchParticipantPresence 1
{ 
public 
long 
ConnectionVersion %
{& '
get( +
;+ ,
init- 1
;1 2
}3 4
public

 
int

 
[

 
]

 %
MissingParticipantUserIds

 .
{

/ 0
get

1 4
;

4 5
init

6 :
;

: ;
}

< =
} 
} ö	
kC:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\Models\Match\State\MatchPresenceQuery.cs
	namespace 	
Application
 
. 
Models 
{ 
public 

sealed 
record 
MatchPresenceQuery +
{ 
public 
string 
	LobbyCode 
{  !
get" %
;% &
init' +
;+ ,
}- .
public

 
Guid

 
MatchId

 
{

 
get

 !
;

! "
init

# '
;

' (
}

) *
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
int 
[ 
] 
ParticipantUserIds '
{( )
get* -
;- .
init/ 3
;3 4
}5 6
public 
long %
ExpectedConnectionVersion -
{. /
get0 3
;3 4
init5 9
;9 :
}; <
} 
} ó	
sC:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\Models\Match\State\MatchExecutionDependencies.cs
	namespace 	
Application
 
. 
Models 
{ 
public 

sealed 
record &
MatchExecutionDependencies 3
{ 
public 
Application 
. 
Ports  
.  !
IMatchClock! ,

MatchClock- 7
{8 9
get: =
;= >
init? C
;C D
}E F
public

 
Application

 
.

 
Ports

  
.

  !%
IMatchParticipantPresence

! :
ParticipantPresence

; N
{

O P
get

Q T
;

T U
init

V Z
;

Z [
}

\ ]
public 
TrickTakingMissions "
." #
Logging# *
.* +
Abstractions+ 7
.7 8
Ports8 =
.= >
ILoggerService> L
LoggerM S
{T U
getV Y
;Y Z
init[ _
;_ `
}a b
} 
} ò
lC:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\Ports\Match\IMatchStateChangePublisher.cs
	namespace 	
Application
 
. 
Ports 
{ 
public 

	interface &
IMatchStateChangePublisher /
{ 
void #
PublishMatchStateChange $
($ %
string% +
	lobbyCode, 5
,5 6
long7 ;
matchStateVersion< M
)M N
;N O
} 
} ˆ
kC:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\Ports\Match\IMatchParticipantPresence.cs
	namespace 	
Application
 
. 
Ports 
{ 
public 

	interface %
IMatchParticipantPresence .
{ $
MatchParticipantPresence  
ReadPresence! -
(- .
MatchPresenceQuery. @
queryA F
)F G
;G H
bool		 
ConfirmPresence		 
(		 
MatchPresenceQuery		 /
query		0 5
)		5 6
;		6 7
}

 
} ê
]C:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\Ports\Match\IMatchClock.cs
	namespace 	
Application
 
. 
Ports 
{ 
public 

	interface 
IMatchClock  
{ 
long $
GetTimestampMilliseconds %
(% &
)& '
;' (
} 
} ∂
}C:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\Models\Match\Transition\MissionTransitionScheduleStatus.cs
	namespace 	
Application
 
. 
Models 
{ 
public 

enum +
MissionTransitionScheduleStatus /
{ 
Inactive 
= 
$num 
, "
WaitingForParticipants 
=  
$num! "
," #
CountingDown 
= 
$num 
, 
	Preparing		 
=		 
$num		 
,		 
PreparationFailed

 
=

 
$num

 
,

 
AttemptLimitReached 
= 
$num 
,  
CampaignCompleted 
= 
$num 
, 
MissionUnavailable 
= 
$num 
} 
} ≈	
uC:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\Models\Match\Transition\MissionTransitionPolicy.cs
	namespace 	
Application
 
. 
Models 
{ 
public 

static 
class #
MissionTransitionPolicy /
{ 
public 
const 
int !
CountdownMilliseconds .
=/ 0
$num1 5
;5 6
public 
const 
int *
PreparationBackoffMilliseconds 7
=8 9
$num: >
;> ?
public 
const 
int  
PresenceLeaseSeconds -
=. /
$num0 1
;1 2
public		 
const		 
int		 ,
 PresenceProbeTimeoutMilliseconds		 9
=		: ;
$num		< @
;		@ A
public

 
const

 
int

 )
SchedulerIntervalMilliseconds

 6
=

7 8
$num

9 <
;

< =
public 
const 
int )
MaximumConcurrentPreparations 6
=7 8
$num9 :
;: ;
} 
} ã"
C:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\UseCases\Match\Retry\MatchSnapshotProjection.MissionRetry.cs
	namespace 	
Application
 
. 
UseCases 
{ 
internal 
static 
partial 
class !#
MatchSnapshotProjection" 9
{ 
private		 
static		 
readonly		 
IReadOnlyDictionary		  3
<		3 4#
MissionTransitionStatus		4 K
,		K L
MissionRetryStatus		M _
>		_ `!
s_legacyRetryStatuses		a v
=		w x
new

 

Dictionary

 
<

 #
MissionTransitionStatus

 2
,

2 3
MissionRetryStatus

4 F
>

F G
{ 
{ #
MissionTransitionStatus )
.) *
Inactive* 2
,2 3
MissionRetryStatus4 F
.F G
InactiveG O
}P Q
,Q R
{ #
MissionTransitionStatus )
.) *"
WaitingForParticipants* @
,@ A
MissionRetryStatusB T
.T U"
WaitingForParticipantsU k
}l m
,m n
{ #
MissionTransitionStatus )
.) *
CountingDown* 6
,6 7
MissionRetryStatus8 J
.J K
CountingDownK W
}X Y
,Y Z
{ #
MissionTransitionStatus )
.) *
	Preparing* 3
,3 4
MissionRetryStatus5 G
.G H
	PreparingH Q
}R S
,S T
{ #
MissionTransitionStatus )
.) *
PreparationFailed* ;
,; <
MissionRetryStatus= O
.O P
PreparationFailedP a
}b c
,c d
{ #
MissionTransitionStatus )
.) *
AttemptLimitReached* =
,= >
MissionRetryStatus? Q
.Q R
AttemptLimitReachedR e
}f g
} 
; 
private 
static  
MissionRetrySnapshot +
CreateMissionRetry, >
(> ?%
MissionTransitionSnapshot? X

transitionY c
)c d
{ 	
bool 
isRetry 
= 

transition %
.% &
Kind& *
==+ -!
MissionTransitionKind. C
.C D
RetryCurrentMissionD W
;W X
return 
new  
MissionRetrySnapshot +
{ 
MissionAttemptId  
=! "

transition# -
.- .
MissionAttemptId. >
,> ?
AttemptNumber 
= 

transition  *
.* +
AttemptNumber+ 8
,8 9#
ReadyParticipantUserIds '
=( )
Array* /
./ 0
Empty0 5
<5 6
int6 9
>9 :
(: ;
); <
,< =
Status 
= 
isRetry  
?! "!
s_legacyRetryStatuses# 8
[8 9

transition9 C
.C D
StatusD J
]J K
:L M
MissionRetryStatusN `
.` a
Inactivea i
,i j"
MissionRetryScheduleId &
=' (
isRetry) 0
?1 2

transition3 =
.= >'
MissionTransitionScheduleId> Y
:Z [
Guid\ `
.` a
Emptya f
,f g&
RemainingDelayMilliseconds *
=+ ,
isRetry- 4
?5 6

transition7 A
.A B&
RemainingDelayMillisecondsB \
:] ^
$num_ `
,` a%
MissingParticipantUserIds )
=* +
isRetry, 3
?4 5
(6 7
int7 :
[: ;
]; <
)< =

transition= G
.G H%
MissingParticipantUserIdsH a
.a b
Cloneb g
(g h
)h i
:j k
Array   
.   
Empty   
<    
int    #
>  # $
(  $ %
)  % &
}!! 
;!! 
}"" 	
}## 
}$$ í
tC:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\UseCases\Match\Retry\MatchUseCase.MissionRetry.cs
	namespace 	
Application
 
. 
UseCases 
{ 
public 

sealed 
partial 
class 
MatchUseCase  ,
{ 
public

 $
MissionRetryConfirmation

 '
ConfirmMissionRetry

( ;
(

; <
MissionRetryRequest

< O
missionRetryRequest

P c
,

c d
int 
participantUserId !
)! "
{ 	
var 
confirmation 
= 
new "$
MissionRetryConfirmation# ;
{ $
MissionRetrySubmissionId (
=) *
missionRetryRequest+ >
?> ?
.? @$
MissionRetrySubmissionId@ X
??Y [
Guid\ `
.` a
Emptya f
,f g
RejectionReason 
=  !'
MissionRetryRejectionReason" =
.= >
RetryUnavailable> N
} 
; 
if 
( 
missionRetryRequest #
!=$ &
null' +
&&, .
!/ 0
string0 6
.6 7
IsNullOrWhiteSpace7 I
(I J
missionRetryRequestJ ]
.] ^
	LobbyCode^ g
)g h
)h i
{ 

MatchState 

matchState %
=& '
_matchStateStore( 8
.8 9
	FindMatch9 B
(B C
missionRetryRequestC V
.V W
	LobbyCodeW `
)` a
;a b
if 
( 

matchState 
!= !
null" &
&&' )

matchState* 4
.4 5
ParticipantUserIds5 G
.G H
ContainsH P
(P Q
participantUserIdQ b
)b c
&&d f
missionRetryRequest '
.' (
MatchId( /
==0 2

matchState3 =
.= >
MatchId> E
)E F
{ 
lock 
( 

matchState $
)$ %
{ 
confirmation $
=% &
confirmation' 3
with4 8
{ #
CurrentMissionAttemptId 3
=4 5

matchState6 @
.@ A
MissionAttemptA O
.O P
MissionAttemptIdP `
,` a&
CommittedMatchStateVersion 6
=7 8

matchState9 C
.C D
MatchStateVersionD U
} 
; 
} 
}   
}!! 
return"" 
confirmation"" 
;""  
}## 	
}$$ 
}%% àá
zC:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\UseCases\Match\Preparation\MissionAttemptPreparation.cs
	namespace 	
Application
 
. 
UseCases 
{ 
internal 
static 
class %
MissionAttemptPreparation 3
{ 
internal 
const 
int #
InitialMissionAttemptId 2
=3 4
$num5 6
;6 7
internal 
static "
PreparedMissionAttempt .
Prepare/ 6
(6 7,
 MissionAttemptPreparationContext7 W
preparationContextX j
,j k
IMissionDeckDealer 
missionDeckDealer 0
)0 1
{ 	
MissionDefinition 
missionDefinition /
=0 1
MissionCatalog2 @
.@ A

GetMissionA K
(K L
preparationContextL ^
.^ _
MissionNumber_ l
)l m
;m n
if 
( 
! 
CanPrepareMission "
(" #
preparationContext# 5
.5 6
MissionNumber6 C
)C D
)D E
{ 
throw 
new %
InvalidOperationException 3
(3 4
nameof4 :
(: ;
missionDefinition; L
.L M
SpecialRuleM X
)X Y
)Y Z
;Z [
} 
MissionDeal 
missionDeal #
=$ %
missionDeckDealer& 7
.7 8
CreateMissionDeal8 I
(I J
preparationContextJ \
.\ ]
ParticipantUserIds] o
.o p
Lengthp v
)v w
;w x
IReadOnlyList 
< 
MissionObjective *
>* +

objectives, 6
=7 8
missionDeckDealer9 J
.J K#
CreateMissionObjectivesK b
(b c
missionDefinitionc t
)t u
;u v 
ValidatePreparedDeal  
(  !
preparationContext! 3
,3 4
missionDeal5 @
)@ A
;A B&
ValidatePreparedObjectives &
(& '
missionDefinition' 8
,8 9

objectives: D
)D E
;E F
return   !
CreatePreparedAttempt   (
(  ( )
preparationContext  ) ;
,  ; <
missionDeal  = H
,  H I

objectives  J T
)  T U
;  U V
}!! 	
internal## 
static## 
bool## 
CanPrepareMission## .
(##. /
int##/ 2
missionNumber##3 @
)##@ A
{$$ 	
return%% '
MissionImplementationPolicy%% .
.%%. /

CanPrepare%%/ 9
(%%9 :
missionNumber%%: G
)%%G H
;%%H I
}&& 	
private(( 
static(( 
void((  
ValidatePreparedDeal(( 0
(((0 1,
 MissionAttemptPreparationContext((1 Q
preparationContext((R d
,((d e
MissionDeal)) 
missionDeal)) #
)))# $
{** 	
int++ 
participantCount++  
=++! "
preparationContext++# 5
.++5 6
ParticipantUserIds++6 H
.++H I
Length++I O
;++O P
if,, 
(,, 
missionDeal,, 
?,, 
.,, 
HandsBySeat,, (
==,,) +
null,,, 0
||,,1 3
missionDeal,,4 ?
.,,? @
HandsBySeat,,@ K
.,,K L
Count,,L Q
!=,,R T
participantCount,,U e
||,,f h
missionDeal-- 
.-- 
CaptainSeat-- '
>=--( *
participantCount--+ ;
||--< >
missionDeal--? J
.--J K
HandsBySeat--K V
.--V W
Any--W Z
(--Z [
hand--[ _
=>--` b
hand--c g
==--h j
null--k o
)--o p
)--p q
{.. 
throw// 
new// %
InvalidOperationException// 3
(//3 4
nameof//4 :
(//: ;
missionDeal//; F
)//F G
)//G H
;//H I
}00 
Card11 
[11 
]11 
cards11 
=11 
missionDeal11 &
.11& '
HandsBySeat11' 2
.112 3

SelectMany113 =
(11= >
hand11> B
=>11C E
hand11F J
)11J K
.11K L
ToArray11L S
(11S T
)11T U
;11U V!
ValidatePreparedCards22 !
(22! "
cards22" '
)22' (
;22( )
bool33 
hasValidTrickCount33 #
=33$ %
missionDeal33& 1
.331 2 
TotalTricksInMission332 F
==33G I
	DeckRules33J S
.33S T
TotalDeckSize33T a
/33b c
participantCount33d t
&&33u w
missionDeal44 
.44 
HandsBySeat44 '
.44' (
All44( +
(44+ ,
hand44, 0
=>441 3
hand444 8
.448 9
Count449 >
>=44? A
missionDeal44B M
.44M N 
TotalTricksInMission44N b
&&44c e
hand55 
.55 
Count55 
<=55 !
missionDeal55" -
.55- . 
TotalTricksInMission55. B
+55C D
$num55E F
)55F G
;55G H
if66 
(66 
!66 
hasValidTrickCount66 #
)66# $
{77 
throw88 
new88 %
InvalidOperationException88 3
(883 4
nameof884 :
(88: ;
missionDeal88; F
)88F G
)88G H
;88H I
}99 
}:: 	
private<< 
static<< 
void<< !
ValidatePreparedCards<< 1
(<<1 2
Card<<2 6
[<<6 7
]<<7 8
cards<<9 >
)<<> ?
{== 	
if>> 
(>> 
cards>> 
.>> 
Any>> 
(>> 
card>> 
=>>> !
card>>" &
==>>' )
null>>* .
)>>. /
)>>/ 0
{?? 
throw@@ 
new@@ %
InvalidOperationException@@ 3
(@@3 4
nameof@@4 :
(@@: ;
cards@@; @
)@@@ A
)@@A B
;@@B C
}AA 
foreachBB 
(BB 
CardBB 
cardBB 
inBB !
cardsBB" '
)BB' (
{CC 
	DeckRulesDD 
.DD 
GetCardByIdDD %
(DD% &
cardDD& *
.DD* +
IdCardDD+ 1
)DD1 2
;DD2 3
}EE 
boolFF 
hasCompleteDeckFF  
=FF! "
cardsFF# (
.FF( )
LengthFF) /
==FF0 2
	DeckRulesFF3 <
.FF< =
TotalDeckSizeFF= J
&&FFK M
cardsGG 
.GG 
SelectGG 
(GG 
cardGG !
=>GG" $
cardGG% )
.GG) *
IdCardGG* 0
)GG0 1
.GG1 2
DistinctGG2 :
(GG: ;
)GG; <
.GG< =
CountGG= B
(GGB C
)GGC D
==GGE G
	DeckRulesGGH Q
.GGQ R
TotalDeckSizeGGR _
;GG_ `
ifHH 
(HH 
!HH 
hasCompleteDeckHH  
)HH  !
{II 
throwJJ 
newJJ %
InvalidOperationExceptionJJ 3
(JJ3 4
nameofJJ4 :
(JJ: ;
cardsJJ; @
)JJ@ A
)JJA B
;JJB C
}KK 
}LL 	
privateNN 
staticNN 
voidNN &
ValidatePreparedObjectivesNN 6
(NN6 7
MissionDefinitionNN7 H
missionDefinitionNNI Z
,NNZ [
IReadOnlyListOO 
<OO 
MissionObjectiveOO *
>OO* +

objectivesOO, 6
)OO6 7
{PP 	
ifQQ 
(QQ 

objectivesQQ 
==QQ 
nullQQ "
||QQ# %

objectivesQQ& 0
.QQ0 1
CountQQ1 6
!=QQ7 9
missionDefinitionQQ: K
.QQK L
ObjectiveCardCountQQL ^
||QQ_ a

objectivesRR 
.RR 
AnyRR 
(RR 
	objectiveRR (
=>RR) +
	objectiveRR, 5
==RR6 8
nullRR9 =
)RR= >
)RR> ?
{SS 
throwTT 
newTT %
InvalidOperationExceptionTT 3
(TT3 4
nameofTT4 :
(TT: ;

objectivesTT; E
)TTE F
)TTF G
;TTG H
}UU 
boolVV 
hasUniqueCardsVV 
=VV  !

objectivesVV" ,
.VV, -
SelectVV- 3
(VV3 4
	objectiveVV4 =
=>VV> @
	objectiveVVA J
.VVJ K
CardIdVVK Q
)VVQ R
.VVR S
DistinctVVS [
(VV[ \
)VV\ ]
.VV] ^
CountVV^ c
(VVc d
)VVd e
==VVf h

objectivesWW 
.WW 
CountWW  
;WW  !
boolXX 
hasFreshObjectivesXX #
=XX$ %

objectivesXX& 0
.XX0 1
AllXX1 4
(XX4 5
	objectiveXX5 >
=>XX? A
!XXB C
	objectiveXXC L
.XXL M
AssignedSeatXXM Y
.XXY Z
HasValueXXZ b
&&XXc e
	objectiveYY 
.YY 
StatusYY  
==YY! #
ObjectiveStatusYY$ 3
.YY3 4
PendingYY4 ;
&&YY< >
	DeckRulesZZ 
.ZZ 
GetCardByIdZZ %
(ZZ% &
	objectiveZZ& /
.ZZ/ 0
CardIdZZ0 6
)ZZ6 7
.ZZ7 8
SuitZZ8 <
!=ZZ= ?
CardSuitZZ@ H
.ZZH I
SpecialZZI P
)ZZP Q
;ZZQ R
if[[ 
([[ 
![[ 
hasUniqueCards[[ 
||[[  "
![[# $
hasFreshObjectives[[$ 6
)[[6 7
{\\ 
throw]] 
new]] %
InvalidOperationException]] 3
(]]3 4
nameof]]4 :
(]]: ;

objectives]]; E
)]]E F
)]]F G
;]]G H
}^^ 
}__ 	
privateaa 
staticaa "
PreparedMissionAttemptaa -!
CreatePreparedAttemptaa. C
(aaC D,
 MissionAttemptPreparationContextaaD d
preparationContextaae w
,aaw x
MissionDealbb 
missionDealbb #
,bb# $
IReadOnlyListbb% 2
<bb2 3
MissionObjectivebb3 C
>bbC D

objectivesbbE O
)bbO P
{cc 	
returndd 
newdd "
PreparedMissionAttemptdd -
{ee 
MissionAttemptff 
=ff  
newff! $
MissionAttemptStateff% 8
{gg 
MissionAttemptIdhh $
=hh% &
preparationContexthh' 9
.hh9 :
MissionAttemptIdhh: J
,hhJ K
MissionNumberii !
=ii" #
preparationContextii$ 6
.ii6 7
MissionNumberii7 D
,iiD E
AttemptNumberjj !
=jj" #
preparationContextjj$ 6
.jj6 7
AttemptNumberjj7 D
,jjD E
CaptainSeatkk 
=kk  !
missionDealkk" -
.kk- .
CaptainSeatkk. 9
,kk9 :%
CurrentObjectiveDraftSeatll -
=ll. /
missionDealll0 ;
.ll; <
CaptainSeatll< G
,llG H
PlayerCountmm 
=mm  !
preparationContextmm" 4
.mm4 5
ParticipantUserIdsmm5 G
.mmG H
LengthmmH N
,mmN O
Phasenn 
=nn *
MissionSpecialPreparationRulesnn :
.nn: ;
GetInitialPhasenn; J
(nnJ K
MissionCatalogoo &
.oo& '

GetMissionoo' 1
(oo1 2
preparationContextoo2 D
.ooD E
MissionNumberooE R
)ooR S
)ooS T
,ooT U

RoleConfigpp 
=pp  %
CreateInitialMissionRolespp! :
(pp: ;
preparationContextpp; M
.ppM N
MissionNumberppN [
,pp[ \
missionDealpp] h
)pph i
,ppi j
Statusqq 
=qq  
MissionAttemptStatusqq 1
.qq1 2

InProgressqq2 <
,qq< =

Objectivesrr 
=rr  

objectivesrr! +
.rr+ ,
ToArrayrr, 3
(rr3 4
)rr4 5
,rr5 6!
HasUsedDistressSignalss )
=ss* +
falsess, 1
,ss1 2%
RadioCommunicationsBySeattt -
=tt. /

Enumerablett0 :
.tt: ;
Rangett; @
(tt@ A
$numttA B
,ttB C
preparationContextttD V
.ttV W
ParticipantUserIdsttW i
.tti j
Lengthttj p
)ttp q
.uu 
Selectuu 
(uu  
	seatIndexuu  )
=>uu* ,
newuu- 0)
PlayerRadioCommunicationStateuu1 N
{vv 
Seatww  
=ww! "
(ww# $
byteww$ (
)ww( )
	seatIndexww) 2
,ww2 3%
HasUsedCommunicationTokenxx 5
=xx6 7
falsexx8 =
,xx= >
IsSilencedByCaptainyy /
=yy0 1
falseyy2 7
,yy7 8
CommunicatedCardzz ,
=zz- .
nullzz/ 3
,zz3 4
TokenPosition{{ )
={{* +
RadioTokenPosition{{, >
.{{> ?
Highest{{? F
}|| 
)|| 
.|| 
ToArray|| "
(||" #
)||# $
}}} 
,}} #
PlayerHandCardIdsBySeat~~ '
=~~( )
missionDeal~~* 5
.~~5 6
HandsBySeat~~6 A
.~~A B
Select~~B H
(~~H I
hand~~I M
=>~~N P
hand 
. 
Select 
(  
card  $
=>% '
card( ,
., -
IdCard- 3
)3 4
.4 5
ToList5 ;
(; <
)< =
)= >
.> ?
ToArray? F
(F G
)G H
,H I
WonCardIdsBySeat
ÄÄ  
=
ÄÄ! " 
preparationContext
ÄÄ# 5
.
ÄÄ5 6 
ParticipantUserIds
ÄÄ6 H
.
ÄÄH I
Select
ÄÄI O
(
ÄÄO P
_
ÄÄP Q
=>
ÄÄR T
new
ÄÄU X
List
ÄÄY ]
<
ÄÄ] ^
int
ÄÄ^ a
>
ÄÄa b
(
ÄÄb c
)
ÄÄc d
)
ÄÄd e
.
ÄÄe f
ToArray
ÄÄf m
(
ÄÄm n
)
ÄÄn o
,
ÄÄo p"
WonTrickCountsBySeat
ÅÅ $
=
ÅÅ% &
new
ÅÅ' *
int
ÅÅ+ .
[
ÅÅ. / 
preparationContext
ÅÅ/ A
.
ÅÅA B 
ParticipantUserIds
ÅÅB T
.
ÅÅT U
Length
ÅÅU [
]
ÅÅ[ \
,
ÅÅ\ ]&
MaximumMissionTrickCount
ÇÇ (
=
ÇÇ) *
missionDeal
ÇÇ+ 6
.
ÇÇ6 7"
TotalTricksInMission
ÇÇ7 K
,
ÇÇK L+
ObjectiveCardIdsByObjectiveId
ÉÉ -
=
ÉÉ. /

objectives
ÉÉ0 :
.
ÉÉ: ;
ToDictionary
ÉÉ; G
(
ÉÉG H
_
ÉÉH I
=>
ÉÉJ L
Guid
ÉÉM Q
.
ÉÉQ R
NewGuid
ÉÉR Y
(
ÉÉY Z
)
ÉÉZ [
,
ÉÉ[ \
	objective
ÑÑ 
=>
ÑÑ  
	objective
ÑÑ! *
.
ÑÑ* +
CardId
ÑÑ+ 1
)
ÑÑ1 2
,
ÑÑ2 3(
ObjectiveDraftSubmissionId
ÖÖ *
=
ÖÖ+ ,
Guid
ÖÖ- 1
.
ÖÖ1 2
NewGuid
ÖÖ2 9
(
ÖÖ9 :
)
ÖÖ: ;
}
ÜÜ 
;
ÜÜ 
}
áá 	
private
àà 
static
àà &
MissionRoleConfiguration
àà /'
CreateInitialMissionRoles
àà0 I
(
ààI J
int
ààJ M
missionNumber
ààN [
,
àà[ \
MissionDeal
àà] h
missionDeal
àài t
)
ààt u
{
ââ 	&
MissionRoleConfiguration
ää $
roles
ää% *
=
ää+ ,&
MissionRoleConfiguration
ää- E
.
ääE F
Default
ääF M
;
ääM N
if
ãã 
(
ãã 
MissionCatalog
ãã 
.
ãã 

GetMission
ãã )
(
ãã) *
missionNumber
ãã* 7
)
ãã7 8
.
ãã8 9
SpecialRule
ãã9 D
==
ããE G$
SpecialMissionRuleType
åå &
.
åå& '2
$M46_SeatLeftOfHeartNineWinsAllHearts
åå' K
)
ååK L
{
çç 
roles
éé 
=
éé 
roles
éé 
with
éé "
{
éé# $ 
HeartNineOwnerSeat
éé% 7
=
éé8 9'
MissionObjectiveDealRules
èè -
.
èè- .#
GetHeartNineOwnerSeat
èè. C
(
èèC D
missionDeal
èèD O
.
èèO P
HandsBySeat
èèP [
)
èè[ \
}
èè] ^
;
èè^ _
}
êê 
return
ëë 
roles
ëë 
;
ëë 
}
íí 	
}
ìì 
}îî Ô
nC:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\Models\Match\Retry\ProcessedMissionRetry.cs
	namespace 	
Application
 
. 
Models 
{ 
public 

sealed 
record !
ProcessedMissionRetry .
{ 
public		 
int		 
ParticipantUserId		 $
{		% &
get		' *
;		* +
init		, 0
;		0 1
}		2 3
public 
MissionRetryRequest "
MissionRetryRequest# 6
{7 8
get9 <
;< =
init> B
;B C
}D E
public $
MissionRetryConfirmation '$
MissionRetryConfirmation( @
{A B
getC F
;F G
initH L
;L M
}N O
} 
} §	
tC:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\Models\Match\Retry\MissionRetryRejectionReason.cs
	namespace 	
Application
 
. 
Models 
{ 
public 

enum '
MissionRetryRejectionReason +
{ 
None 
= 
$num 
, 
MatchUnavailable 
= 
$num 
, !
ParticipantNotAllowed 
= 
$num  !
,! "
InvalidSubmission		 
=		 
$num		 
,		 $
SubmissionIdentityReused

  
=

! "
$num

# $
,

$ %
WrongMissionAttempt 
= 
$num 
,  
RetryUnavailable 
= 
$num 
, 
StaleMatchState 
= 
$num 
, 
SubmissionExpired 
= 
$num 
, 
RequestLimitReached 
= 
$num 
,  
AttemptLimitReached 
= 
$num  
} 
} ˝
qC:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\Models\Match\Retry\MissionRetryConfirmation.cs
	namespace 	
Application
 
. 
Models 
{ 
public 

sealed 
record $
MissionRetryConfirmation 1
{ 
public		 
Guid		 $
MissionRetrySubmissionId		 ,
{		- .
get		/ 2
;		2 3
init		4 8
;		8 9
}		: ;
public 
bool 

IsAccepted 
{  
get! $
;$ %
init& *
;* +
}, -
public 
bool 
HasStateChanged #
{$ %
get& )
;) *
init+ /
;/ 0
}1 2
public 
bool 
HasRestartedMission '
{( )
get* -
;- .
init/ 3
;3 4
}5 6
public 
long &
CommittedMatchStateVersion .
{/ 0
get1 4
;4 5
init6 :
;: ;
}< =
public 
int #
CurrentMissionAttemptId *
{+ ,
get- 0
;0 1
init2 6
;6 7
}8 9
public '
MissionRetryRejectionReason *
RejectionReason+ :
{; <
get= @
;@ A
initB F
;F G
}H I
} 
} Ö	
lC:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\Models\Match\Retry\MissionRetryRequest.cs
	namespace 	
Application
 
. 
Models 
{ 
public 

sealed 
record 
MissionRetryRequest ,
{ 
public		 
string		 
	LobbyCode		 
{		  !
get		" %
;		% &
init		' +
;		+ ,
}		- .
public 
Guid 
MatchId 
{ 
get !
;! "
init# '
;' (
}) *
public 
int 
MissionAttemptId #
{$ %
get& )
;) *
init+ /
;/ 0
}1 2
public 
Guid $
MissionRetrySubmissionId ,
{- .
get/ 2
;2 3
init4 8
;8 9
}: ;
public 
long %
ExpectedMatchStateVersion -
{. /
get0 3
;3 4
init5 9
;9 :
}; <
} 
} áS
zC:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\Models\Match\Transition\MatchState.MissionTransition.cs
	namespace 	
Application
 
. 
Models 
{ 
public 

sealed 
partial 
class 

MatchState  *
{ 
public		 +
MissionTransitionScheduleStatus		 .#
MissionTransitionStatus		/ F
{		G H
get		I L
;		L M
private		N U
set		V Y
;		Y Z
}		[ \
public #
MissionTransitionAction &
TransitionAction' 7
{8 9
get: =
;= >
private? F
setG J
;J K
}L M
public 
int $
DestinationMissionNumber +
{, -
get. 1
;1 2
private3 :
set; >
;> ?
}@ A
public 
bool )
HasStartedTransitionExecution 1
{2 3
get4 7
;7 8
private9 @
setA D
;D E
}F G
public 
Guid '
MissionTransitionScheduleId /
{0 1
get2 5
;5 6
private7 >
set? B
;B C
}D E
public 
long 1
%MissionTransitionDeadlineMilliseconds 9
{: ;
get< ?
;? @
privateA H
setI L
;L M
}N O
public 
long .
"MissionTransitionConnectionVersion 6
{7 8
get9 <
;< =
private> E
setF I
;I J
}K L
public 
int 
[ 
] /
#MissingTransitionParticipantUserIds 8
{9 :
get; >
;> ?
private@ G
setH K
;K L
}M N
=O P
ArrayQ V
.V W
EmptyW \
<\ ]
int] `
>` a
(a b
)b c
;c d
internal 
void ,
 InitializePreparedMissionAttempt 6
(6 7"
PreparedMissionAttempt7 M
preparedAttemptN ]
)] ^
{ 	
if 
( 
MissionAttempt 
!= !
null" &
)& '
{ 
throw 
new %
InvalidOperationException 3
(3 4
nameof4 :
(: ;
MissionAttempt; I
)I J
)J K
;K L
} '
ApplyPreparedMissionAttempt '
(' (
preparedAttempt( 7
)7 8
;8 9
}   	
internal"" 
void"" &
ConfigureMissionTransition"" 0
(""0 1#
MissionTransitionAction""1 H
transitionAction""I Y
,""Y Z
int""[ ^$
destinationMissionNumber""_ w
)""w x
{## 	
TransitionAction$$ 
=$$ 
transitionAction$$ /
;$$/ 0$
DestinationMissionNumber%% $
=%%% &$
destinationMissionNumber%%' ?
;%%? @
}&& 	
internal(( 
void(( (
SetMissionTransitionSchedule(( 2
(((2 3+
MissionTransitionScheduleStatus((3 R
status((S Y
,((Y Z$
MatchParticipantPresence)) $
presence))% -
,))- .
long**  
deadlineMilliseconds** %
)**% &
{++ 	#
MissionTransitionStatus,, #
=,,$ %
status,,& ,
;,,, -)
HasStartedTransitionExecution-- )
=--* +
false--, 1
;--1 2'
MissionTransitionScheduleId.. '
=..( )
Guid..* .
.... /
NewGuid../ 6
(..6 7
)..7 8
;..8 9.
"MissionTransitionConnectionVersion// .
=/// 0
presence//1 9
.//9 :
ConnectionVersion//: K
;//K L/
#MissingTransitionParticipantUserIds00 /
=000 1
(002 3
int003 6
[006 7
]007 8
)008 9
presence009 A
.00A B%
MissingParticipantUserIds00B [
.00[ \
Clone00\ a
(00a b
)00b c
;00c d1
%MissionTransitionDeadlineMilliseconds11 1
=112 3 
deadlineMilliseconds114 H
;11H I
MatchStateVersion22 
++22 
;22  
}33 	
internal55 
void55 /
#ReserveMissionTransitionPreparation55 9
(559 :
)55: ;
{66 	#
MissionTransitionStatus77 #
=77$ %+
MissionTransitionScheduleStatus77& E
.77E F
	Preparing77F O
;77O P
MatchStateVersion88 
++88 
;88  
}99 	
internal;; 
void;; *
MarkTransitionExecutionStarted;; 4
(;;4 5
);;5 6
{<< 	)
HasStartedTransitionExecution== )
===* +
true==, 0
;==0 1
}>> 	
internal@@ 
void@@ ,
 CommitScheduledMissionTransition@@ 6
(@@6 7"
PreparedMissionAttempt@@7 M
preparedAttempt@@N ]
)@@] ^
{AA 	'
ApplyPreparedMissionAttemptBB '
(BB' (
preparedAttemptBB( 7
)BB7 8
;BB8 9
MatchStateVersionCC 
++CC 
;CC  
}DD 	
privateFF 
voidFF '
ApplyPreparedMissionAttemptFF 0
(FF0 1"
PreparedMissionAttemptFF1 G
preparedAttemptFFH W
)FFW X
{GG 	
boolHH 
isInitialAttemptHH !
=HH" #
MissionAttemptHH$ 2
==HH3 5
nullHH6 :
;HH: ;
boolII 
isSameMissionRetryII #
=II$ %
!II& '
isInitialAttemptII' 7
&&II8 :
MissionAttemptJJ 
.JJ 
MissionNumberJJ ,
==JJ- /
preparedAttemptJJ0 ?
.JJ? @
MissionAttemptJJ@ N
.JJN O
MissionNumberJJO \
;JJ\ ]
ifKK 
(KK 
!KK 
isSameMissionRetryKK #
)KK# $
{LL 5
)HasAppliedDistressPenaltyInCurrentMissionMM 9
=MM: ;
falseMM< A
;MMA B
}NN 
MissionAttemptOO 
=OO 
preparedAttemptOO ,
.OO, -
MissionAttemptOO- ;
;OO; <(
ResetSpecialPreparationStatePP (
(PP( )
isInitialAttemptPP) 9
)PP9 :
;PP: ;#
PlayerHandCardIdsBySeatQQ #
=QQ$ %
preparedAttemptQQ& 5
.QQ5 6#
PlayerHandCardIdsBySeatQQ6 M
;QQM N
WonCardIdsBySeatRR 
=RR 
preparedAttemptRR .
.RR. /
WonCardIdsBySeatRR/ ?
;RR? @ 
WonTrickCountsBySeatSS  
=SS! "
preparedAttemptSS# 2
.SS2 3 
WonTrickCountsBySeatSS3 G
;SSG H)
ObjectiveCardIdsByObjectiveIdTT )
=TT* +
preparedAttemptTT, ;
.TT; <)
ObjectiveCardIdsByObjectiveIdTT< Y
;TTY Z-
!CurrentObjectiveDraftSubmissionIdUU -
=UU. /
preparedAttemptUU0 ?
.UU? @&
ObjectiveDraftSubmissionIdUU@ Z
;UUZ [$
MaximumMissionTrickCountVV $
=VV% &
preparedAttemptVV' 6
.VV6 7$
MaximumMissionTrickCountVV7 O
;VVO P
MissionCaptainSeatWW 
=WW  
preparedAttemptWW! 0
.WW0 1
MissionAttemptWW1 ?
.WW? @
CaptainSeatWW@ K
;WWK L!
CurrentTurnPlayerSeatXX !
=XX" #
MissionCaptainSeatXX$ 6
;XX6 7
CurrentTrickNumberYY 
=YY  
$numYY! "
;YY" #!
LastTrickWinnerUserIdZZ !
=ZZ" #
$numZZ$ %
;ZZ% &$
LastEvaluatedTrickNumber[[ $
=[[% &
$num[[' (
;[[( )!
LastMissionEvaluation\\ !
=\\" #
null\\$ (
;\\( )
IsDealCompleted]] 
=]] 
false]] #
;]]# $
TransitionAction^^ 
=^^ #
MissionTransitionAction^^ 6
.^^6 7
None^^7 ;
;^^; <$
DestinationMissionNumber__ $
=__% &
MissionAttempt__' 5
.__5 6
MissionNumber__6 C
;__C D#
MissionTransitionStatus`` #
=``$ %+
MissionTransitionScheduleStatus``& E
.``E F
Inactive``F N
;``N O)
HasStartedTransitionExecutionaa )
=aa* +
falseaa, 1
;aa1 2'
MissionTransitionScheduleIdbb '
=bb( )
Guidbb* .
.bb. /
Emptybb/ 4
;bb4 51
%MissionTransitionDeadlineMillisecondscc 1
=cc2 3
$numcc4 5
;cc5 6.
"MissionTransitionConnectionVersiondd .
=dd/ 0
$numdd1 2
;dd2 3/
#MissingTransitionParticipantUserIdsee /
=ee0 1
Arrayee2 7
.ee7 8
Emptyee8 =
<ee= >
intee> A
>eeA B
(eeB C
)eeC D
;eeD E'
LastCompletedTrickCardPlaysff '
=ff( )
Arrayff* /
.ff/ 0
Emptyff0 5
<ff5 6
Gameplayff6 >
.ff> ?
MatchCardPlayff? L
>ffL M
(ffM N
)ffN O
;ffO P!
CurrentTrickCardPlaysgg !
.gg! "
Cleargg" '
(gg' (
)gg( )
;gg) *
CapturedCardPlayshh 
.hh 
Clearhh #
(hh# $
)hh$ %
;hh% &4
(ProcessedCardPlayDecisionsBySubmissionIdii 4
.ii4 5
Clearii5 :
(ii: ;
)ii; <
;ii< =2
&RadioCommunicationsByParticipantUserIdjj 2
.jj2 3
Clearjj3 8
(jj8 9
)jj9 :
;jj: ;6
*ProcessedRadioCommunicationsBySubmissionIdkk 6
.kk6 7
Clearkk7 <
(kk< =
)kk= >
;kk> ?$
ProcessedObjectiveDraftsll $
.ll$ %
Clearll% *
(ll* +
)ll+ ,
;ll, -.
"ObjectiveDraftHistoryByParticipantmm .
.mm. /
Clearmm/ 4
(mm4 5
)mm5 6
;mm6 7
ResetDistressStatenn 
(nn 
)nn  
;nn  !#
HasDistressBeenRejectedoo #
=oo$ %
falseoo& +
;oo+ ,
}pp 	
}qq 
}rr ∑
oC:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\Models\Match\State\PreparedMissionAttempt.cs
	namespace 	
Application
 
. 
Models 
{ 
internal 
sealed 
record "
PreparedMissionAttempt 1
{ 
public		 
Domain		 
.		 
MissionAttemptState		 )
MissionAttempt		* 8
{		9 :
get		; >
;		> ?
init		@ D
;		D E
}		F G
public 
List 
< 
int 
> 
[ 
] #
PlayerHandCardIdsBySeat 2
{3 4
get5 8
;8 9
init: >
;> ?
}@ A
public 
List 
< 
int 
> 
[ 
] 
WonCardIdsBySeat +
{, -
get. 1
;1 2
init3 7
;7 8
}9 :
public 
int 
[ 
]  
WonTrickCountsBySeat )
{* +
get, /
;/ 0
init1 5
;5 6
}7 8
public 
int $
MaximumMissionTrickCount +
{, -
get. 1
;1 2
init3 7
;7 8
}9 :
public 

Dictionary 
< 
Guid 
, 
int  #
># $)
ObjectiveCardIdsByObjectiveId% B
{C D
getE H
;H I
initJ N
;N O
}P Q
public 
Guid &
ObjectiveDraftSubmissionId .
{/ 0
get1 4
;4 5
init6 :
;: ;
}< =
} 
} Ñ
âC:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\UseCases\Match\Evaluation\MatchSnapshotProjection.MissionEvaluation.cs
	namespace 	
Application
 
. 
UseCases 
{ 
internal 
static 
partial 
class !#
MatchSnapshotProjection" 9
{ 
private 
static %
MissionEvaluationSnapshot 0#
CreateMissionEvaluation1 H
(H I

MatchStateI S

matchStateT ^
)^ _
{		 	
return

 
new

 %
MissionEvaluationSnapshot

 0
{ 
MissionAttemptId  
=! "

matchState# -
.- .
MissionAttempt. <
.< =
MissionAttemptId= M
,M N$
LastEvaluatedTrickNumber (
=) *

matchState+ 5
.5 6$
LastEvaluatedTrickNumber6 N
,N O 
MissionAttemptStatus $
=% &

matchState' 1
.1 2!
LastMissionEvaluation2 G
==H J
nullK O
? *
MissionAttemptEvaluationStatus 4
.4 5
NotEvaluated5 A
: #
MissionEvaluationMapper -
.- .
MapAttemptStatus. >
(> ?

matchState? I
.I J
MissionAttemptJ X
.X Y
StatusY _
)_ `
,` a 
MissionFailureReason $
=% &

matchState' 1
.1 2!
LastMissionEvaluation2 G
==H J
nullK O
? *
MissionEvaluationFailureReason 4
.4 5
None5 9
: #
MissionEvaluationMapper -
.- .
MapFailureReason. >
(> ?

matchState? I
.I J!
LastMissionEvaluationJ _
._ `
FailureCode` k
)k l
} 
; 
} 	
} 
} í
yC:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\Models\Match\State\MissionAttemptPreparationContext.cs
	namespace 	
Application
 
. 
Models 
{ 
internal 
sealed 
record ,
 MissionAttemptPreparationContext ;
{ 
public		 
int		 
MissionNumber		  
{		! "
get		# &
;		& '
init		( ,
;		, -
}		. /
public 
int 
MissionAttemptId #
{$ %
get& )
;) *
init+ /
;/ 0
}1 2
public 
int 
AttemptNumber  
{! "
get# &
;& '
init( ,
;, -
}. /
public 
int 
[ 
] 
ParticipantUserIds '
{( )
get* -
;- .
init/ 3
;3 4
}5 6
} 
} Ô~
wC:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\UseCases\Match\Evaluation\MissionEvaluationMapper.cs
	namespace 	
Application
 
. 
UseCases 
{ 
internal

 
static

 
class

 #
MissionEvaluationMapper

 1
{ 
private 
static 
readonly 
IReadOnlyDictionary  3
<3 4
ObjectiveStatus4 C
,C D"
MissionObjectiveStatusE [
>[ \
s_objectiveStatuses] p
=q r
new 

Dictionary 
< 
ObjectiveStatus *
,* +"
MissionObjectiveStatus, B
>B C
{ 
{ 
ObjectiveStatus !
.! "
Pending" )
,) *"
MissionObjectiveStatus+ A
.A B
PendingB I
}J K
,K L
{ 
ObjectiveStatus !
.! "
	Completed" +
,+ ,"
MissionObjectiveStatus- C
.C D
	CompletedD M
}N O
,O P
{ 
ObjectiveStatus !
.! "
Failed" (
,( )"
MissionObjectiveStatus* @
.@ A
FailedA G
}H I
} 
; 
private 
static 
readonly 
IReadOnlyDictionary  3
<3 4 
MissionAttemptStatus4 H
,H I*
MissionAttemptEvaluationStatusJ h
>h i
s_attemptStatuses 
= 
new  #

Dictionary$ .
<. / 
MissionAttemptStatus/ C
,C D*
MissionAttemptEvaluationStatusE c
>c d
{ 
{  
MissionAttemptStatus &
.& '

InProgress' 1
,1 2*
MissionAttemptEvaluationStatus3 Q
.Q R

InProgressR \
}] ^
,^ _
{  
MissionAttemptStatus &
.& '
	Succeeded' 0
,0 1*
MissionAttemptEvaluationStatus2 P
.P Q
	SucceededQ Z
}[ \
,\ ]
{  
MissionAttemptStatus &
.& '
Failed' -
,- .*
MissionAttemptEvaluationStatus/ M
.M N
FailedN T
}U V
} 
; 
private 
static 
readonly 
IReadOnlyDictionary  3
<3 4(
MissionEvaluationFailureCode4 P
,P Q*
MissionEvaluationFailureReasonR p
>p q
s_failureReasons 
= 
new "

Dictionary# -
<- .(
MissionEvaluationFailureCode. J
,J K*
MissionEvaluationFailureReasonL j
>j k
{ 
{ (
MissionEvaluationFailureCode .
.. /
None/ 3
,3 4*
MissionEvaluationFailureReason   2
.  2 3
None  3 7
}  8 9
,  9 :
{!! (
MissionEvaluationFailureCode!! .
.!!. /(
ObjectiveCapturedByWrongSeat!!/ K
,!!K L*
MissionEvaluationFailureReason"" 2
.""2 3(
ObjectiveCapturedByWrongSeat""3 O
}""P Q
,""Q R
{## (
MissionEvaluationFailureCode## .
.##. /,
 MultipleOrderedTokensInSameTrick##/ O
,##O P*
MissionEvaluationFailureReason$$ 2
.$$2 3,
 MultipleOrderedTokensInSameTrick$$3 S
}$$T U
,$$U V
{%% (
MissionEvaluationFailureCode%% .
.%%. /*
MultipleArrowTokensInSameTrick%%/ M
,%%M N*
MissionEvaluationFailureReason&& 2
.&&2 3*
MultipleArrowTokensInSameTrick&&3 Q
}&&R S
,&&S T
{'' (
MissionEvaluationFailureCode'' .
.''. /'
OmegaSimultaneousCompletion''/ J
,''J K*
MissionEvaluationFailureReason(( 2
.((2 3'
OmegaSimultaneousCompletion((3 N
}((O P
,((P Q
{)) (
MissionEvaluationFailureCode)) .
.)). /+
PrecedingOrderTokenNotCompleted))/ N
,))N O*
MissionEvaluationFailureReason** 2
.**2 3+
PrecedingOrderTokenNotCompleted**3 R
}**S T
,**T U
{++ (
MissionEvaluationFailureCode++ .
.++. /+
PrecedingArrowTokenNotCompleted++/ N
,++N O*
MissionEvaluationFailureReason,, 2
.,,2 3+
PrecedingArrowTokenNotCompleted,,3 R
},,S T
,,,T U
{-- (
MissionEvaluationFailureCode-- .
.--. /*
OmegaObjectiveNotCompletedLast--/ M
,--M N*
MissionEvaluationFailureReason.. 2
...2 3*
OmegaObjectiveNotCompletedLast..3 Q
}..R S
,..S T
{// (
MissionEvaluationFailureCode// .
.//. /,
 ObjectivesIncompleteAtMissionEnd/// O
,//O P*
MissionEvaluationFailureReason00 2
.002 3,
 ObjectivesIncompleteAtMissionEnd003 S
}00T U
,00U V
{11 (
MissionEvaluationFailureCode11 .
.11. /(
Mission48OmegaNotInLastTrick11/ K
,11K L*
MissionEvaluationFailureReason22 2
.222 3(
Mission48OmegaNotInLastTrick223 O
}22P Q
,22Q R
{33 (
MissionEvaluationFailureCode33 .
.33. /3
'Mission48PendingNonOmegaBeforeLastTrick33/ V
,33V W*
MissionEvaluationFailureReason44 2
.442 33
'Mission48PendingNonOmegaBeforeLastTrick443 Z
}44[ \
,44\ ]
{55 (
MissionEvaluationFailureCode55 .
.55. /#
NormalOneDidNotWinTrick55/ F
,55F G*
MissionEvaluationFailureReason66 2
.662 3#
NormalOneDidNotWinTrick663 J
}66K L
,66L M
{77 (
MissionEvaluationFailureCode77 .
.77. / 
SpecialCardLostTrick77/ C
,77C D*
MissionEvaluationFailureReason88 2
.882 3 
SpecialCardLostTrick883 G
}88H I
,88I J
{99 (
MissionEvaluationFailureCode99 .
.99. /2
&SpecialCardsDidNotWinAllRequiredTricks99/ U
,99U V*
MissionEvaluationFailureReason:: 2
.::2 32
&SpecialCardsDidNotWinAllRequiredTricks::3 Y
}::Z [
,::[ \
{;; (
MissionEvaluationFailureCode;; .
.;;. /
NormalNineWonTrick;;/ A
,;;A B*
MissionEvaluationFailureReason;;C a
.;;a b
NormalNineWonTrick;;b t
};;u v
,;;v w
{<< (
MissionEvaluationFailureCode<< .
.<<. /-
!AllParticipantsWonAtLeastOneTrick<</ P
,<<P Q*
MissionEvaluationFailureReason== 2
.==2 3-
!AllParticipantsWonAtLeastOneTrick==3 T
}==U V
,==V W
{>> (
MissionEvaluationFailureCode>> .
.>>. /.
"InsufficientNormalOneWinningTricks>>/ Q
,>>Q R*
MissionEvaluationFailureReason?? 2
.??2 3.
"InsufficientNormalOneWinningTricks??3 U
}??V W
,??W X
{@@ (
MissionEvaluationFailureCode@@ .
.@@. /&
WonTrickDifferenceExceeded@@/ I
,@@I J*
MissionEvaluationFailureReasonAA 2
.AA2 3&
WonTrickDifferenceExceededAA3 M
}AAN O
,AAO P
{BB (
MissionEvaluationFailureCodeBB .
.BB. /'
SingleTrickWinnerUnassignedBB/ J
,BBJ K*
MissionEvaluationFailureReasonCC 2
.CC2 3'
SingleTrickWinnerUnassignedCC3 N
}CCO P
,CCP Q
{DD (
MissionEvaluationFailureCodeDD .
.DD. /1
%SelectedParticipantWonWithSpecialCardDD/ T
,DDT U*
MissionEvaluationFailureReasonEE 2
.EE2 31
%SelectedParticipantWonWithSpecialCardEE3 X
}EEY Z
,EEZ [
{FF (
MissionEvaluationFailureCodeFF .
.FF. /0
$SelectedParticipantWonMultipleTricksFF/ S
,FFS T*
MissionEvaluationFailureReasonGG 2
.GG2 30
$SelectedParticipantWonMultipleTricksGG3 W
}GGX Y
,GGY Z
{HH (
MissionEvaluationFailureCodeHH .
.HH. /7
+SelectedParticipantDidNotWinExactlyOneTrickHH/ Z
,HHZ [*
MissionEvaluationFailureReasonII 2
.II2 37
+SelectedParticipantDidNotWinExactlyOneTrickII3 ^
}II_ `
,II` a
{JJ (
MissionEvaluationFailureCodeJJ .
.JJ. /&
CaptainDidNotWinFirstTrickJJ/ I
,JJI J*
MissionEvaluationFailureReasonKK 2
.KK2 3&
CaptainDidNotWinFirstTrickKK3 M
}KKN O
,KKO P
{LL (
MissionEvaluationFailureCodeLL .
.LL. /%
CaptainDidNotWinLastTrickLL/ H
,LLH I*
MissionEvaluationFailureReasonMM 2
.MM2 3%
CaptainDidNotWinLastTrickMM3 L
}MMM N
,MMN O
{NN (
MissionEvaluationFailureCodeNN .
.NN. /(
FirstAndLastWinnerUnassignedNN/ K
,NNK L*
MissionEvaluationFailureReasonOO 2
.OO2 3(
FirstAndLastWinnerUnassignedOO3 O
}OOP Q
,OOQ R
{PP (
MissionEvaluationFailureCodePP .
.PP. /+
FirstTrickWonByWrongParticipantPP/ N
,PPN O*
MissionEvaluationFailureReasonQQ 2
.QQ2 3+
FirstTrickWonByWrongParticipantQQ3 R
}QQS T
,QQT U
{RR (
MissionEvaluationFailureCodeRR .
.RR. /(
FirstTrickWonWithSpecialCardRR/ K
,RRK L*
MissionEvaluationFailureReasonSS 2
.SS2 3(
FirstTrickWonWithSpecialCardSS3 O
}SSP Q
,SSQ R
{TT (
MissionEvaluationFailureCodeTT .
.TT. /5
)IntermediateTrickWonBySelectedParticipantTT/ X
,TTX Y*
MissionEvaluationFailureReasonUU 2
.UU2 35
)IntermediateTrickWonBySelectedParticipantUU3 \
}UU] ^
,UU^ _
{VV (
MissionEvaluationFailureCodeVV .
.VV. /*
LastTrickWonByWrongParticipantVV/ M
,VVM N*
MissionEvaluationFailureReasonWW 2
.WW2 3*
LastTrickWonByWrongParticipantWW3 Q
}WWR S
,WWS T
{XX (
MissionEvaluationFailureCodeXX .
.XX. /'
LastTrickWonWithSpecialCardXX/ J
,XXJ K*
MissionEvaluationFailureReasonYY 2
.YY2 3'
LastTrickWonWithSpecialCardYY3 N
}YYO P
,YYP Q
{ZZ (
MissionEvaluationFailureCodeZZ .
.ZZ. /+
SpecialCardWinningOrderViolatedZZ/ N
,ZZN O*
MissionEvaluationFailureReason[[ 2
.[[2 3+
SpecialCardWinningOrderViolated[[3 R
}[[S T
,[[T U
{\\ (
MissionEvaluationFailureCode\\ .
.\\. /&
HeartNineOwnerUnidentified\\/ I
,\\I J*
MissionEvaluationFailureReason]] 2
.]]2 3&
HeartNineOwnerUnidentified]]3 M
}]]N O
,]]O P
{^^ (
MissionEvaluationFailureCode^^ .
.^^. /+
HeartCapturedByWrongParticipant^^/ N
,^^N O*
MissionEvaluationFailureReason__ 2
.__2 3+
HeartCapturedByWrongParticipant__3 R
}__S T
,__T U
{`` (
MissionEvaluationFailureCode`` .
.``. /$
HeartCardsNotAllCaptured``/ G
,``G H*
MissionEvaluationFailureReasonaa 2
.aa2 3$
HeartCardsNotAllCapturedaa3 K
}aaL M
,aaM N
{bb (
MissionEvaluationFailureCodebb .
.bb. /'
TrickDistributionUnassignedbb/ J
,bbJ K*
MissionEvaluationFailureReasoncc 2
.cc2 3'
TrickDistributionUnassignedcc3 N
}ccO P
,ccP Q
{dd (
MissionEvaluationFailureCodedd .
.dd. /.
"InitialTricksWonByWrongParticipantdd/ Q
,ddQ R*
MissionEvaluationFailureReasonee 2
.ee2 3.
"InitialTricksWonByWrongParticipantee3 U
}eeV W
,eeW X
{ff (
MissionEvaluationFailureCodeff .
.ff. /&
InitialTrickWinnerWonExtraff/ I
,ffI J*
MissionEvaluationFailureReasongg 2
.gg2 3&
InitialTrickWinnerWonExtragg3 M
}ggN O
,ggO P
{hh (
MissionEvaluationFailureCodehh .
.hh. /$
FinalTrickWinnerWonEarlyhh/ G
,hhG H*
MissionEvaluationFailureReasonii 2
.ii2 3$
FinalTrickWinnerWonEarlyii3 K
}iiL M
,iiM N
{jj (
MissionEvaluationFailureCodejj .
.jj. /+
FinalTrickWonByWrongParticipantjj/ N
,jjN O*
MissionEvaluationFailureReasonkk 2
.kk2 3+
FinalTrickWonByWrongParticipantkk3 R
}kkS T
,kkT U
{ll (
MissionEvaluationFailureCodell .
.ll. /*
RemainingParticipantWonNoTrickll/ M
,llM N*
MissionEvaluationFailureReasonmm 2
.mm2 3*
RemainingParticipantWonNoTrickmm3 Q
}mmR S
,mmS T
{nn (
MissionEvaluationFailureCodenn .
.nn. /$
SpecialMissionConstraintnn/ G
,nnG H*
MissionEvaluationFailureReasonoo 2
.oo2 3$
SpecialMissionConstraintoo3 K
}ooL M
}pp 
;pp 
internalrr 
staticrr "
MissionObjectiveStatusrr .
MapObjectiveStatusrr/ A
(rrA B
ObjectiveStatusrrB Q
objectiveStatusrrR a
)rra b
{ss 	
iftt 
(tt 
!tt 
s_objectiveStatusestt $
.tt$ %
TryGetValuett% 0
(tt0 1
objectiveStatustt1 @
,tt@ A
outttB E"
MissionObjectiveStatusttF \
publicStatustt] i
)tti j
)ttj k
{uu 
throwvv 
newvv '
ArgumentOutOfRangeExceptionvv 5
(vv5 6
nameofvv6 <
(vv< =
objectiveStatusvv= L
)vvL M
)vvM N
;vvN O
}ww 
returnxx 
publicStatusxx 
;xx  
}yy 	
internal{{ 
static{{ *
MissionAttemptEvaluationStatus{{ 6
MapAttemptStatus{{7 G
({{G H 
MissionAttemptStatus{{H \
attemptStatus{{] j
){{j k
{|| 	
if}} 
(}} 
!}} 
s_attemptStatuses}} "
.}}" #
TryGetValue}}# .
(}}. /
attemptStatus}}/ <
,}}< =
out}}> A*
MissionAttemptEvaluationStatus}}B `
publicStatus}}a m
)}}m n
)}}n o
{~~ 
throw 
new '
ArgumentOutOfRangeException 5
(5 6
nameof6 <
(< =
attemptStatus= J
)J K
)K L
;L M
}
ÄÄ 
return
ÅÅ 
publicStatus
ÅÅ 
;
ÅÅ  
}
ÇÇ 	
internal
ÑÑ 
static
ÑÑ ,
MissionEvaluationFailureReason
ÑÑ 6
MapFailureReason
ÑÑ7 G
(
ÑÑG H*
MissionEvaluationFailureCode
ÑÑH d
failureCode
ÑÑe p
)
ÑÑp q
{
ÖÖ 	
if
ÜÜ 
(
ÜÜ 
!
ÜÜ 
s_failureReasons
ÜÜ !
.
ÜÜ! "
TryGetValue
ÜÜ" -
(
ÜÜ- .
failureCode
ÜÜ. 9
,
ÜÜ9 :
out
ÜÜ; >,
MissionEvaluationFailureReason
ÜÜ? ]
publicReason
ÜÜ^ j
)
ÜÜj k
)
ÜÜk l
{
áá 
throw
àà 
new
àà )
ArgumentOutOfRangeException
àà 5
(
àà5 6
nameof
àà6 <
(
àà< =
failureCode
àà= H
)
ààH I
)
ààI J
;
ààJ K
}
ââ 
return
ää 
publicReason
ää 
;
ää  
}
ãã 	
}
åå 
}çç ˆZ
~C:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\UseCases\Match\Evaluation\MatchUseCase.MissionEvaluation.cs
	namespace 	
Application
 
. 
UseCases 
{ 
public 

sealed 
partial 
class 
MatchUseCase  ,
{ 
private 
static $
CompletedTrickResolution /!
PrepareCompletedTrick0 E
(E F

MatchStateF P

matchStateQ [
,[ \
MatchCardPlay 
[ 
] 
completedTrickPlays /
)/ 0
{ 	
TrickCardPlay 
[ 
] 
domainTrickPlays ,
=- .
completedTrickPlays/ B
.B C
SelectC I
(I J
(J K
playK O
,O P
	playOrderQ Z
)Z [
=>\ ^
new_ b
TrickCardPlayc p
{ 
	PlayOrder 
= 
( 
byte !
)! "
	playOrder" +
,+ ,
Seat 
= 
( 
byte 
) 
Array "
." #
IndexOf# *
(* +

matchState+ 5
.5 6
ParticipantUserIds6 H
,H I
playJ N
.N O
PlayerUserIdO [
)[ \
,\ ]
Card 
= 
	DeckRules  
.  !
GetCardById! ,
(, -
play- 1
.1 2
CardId2 8
)8 9
} 
) 
. 
ToArray 
( 
) 
; 
TrickCardPlay 
winningTrickPlay *
=+ ,
TrickWinnerRules- =
.= > 
DetermineTrickWinner> R
(R S
domainTrickPlaysS c
)c d
;d e#
PreparedTrickEvaluation #
preparedEvaluation$ 6
=7 8*
CreateMissionEvaluationContext9 W
(W X

matchState 
, 
domainTrickPlays ,
,, -
winningTrickPlay. >
)> ?
;? @#
MissionEvaluationResult ##
missionEvaluationResult$ ;
=< ="
MissionEvaluationRules &
.& '"
EvaluateCompletedTrick' =
(= >
preparedEvaluation> P
.P Q
ContextQ X
)X Y
;Y Z
MissionAttemptState !
updatedMissionAttempt  5
=6 7

matchState8 B
.B C
MissionAttemptC Q
withR V
{ 

Objectives 
= #
missionEvaluationResult 4
.4 5
UpdatedObjectives5 F
.F G
ToArrayG N
(N O
)O P
,P Q
Status   
=   #
missionEvaluationResult   0
.  0 1
OverallStatus  1 >
,  > ?
Phase!! 
=!! #
missionEvaluationResult!! /
.!!/ 0
OverallStatus!!0 =
==!!> @ 
MissionAttemptStatus!!A U
.!!U V

InProgress!!V `
?"" 
MissionAttemptPhase"" )
."") *
PlayingTricks""* 7
:""8 9
MissionAttemptPhase"": M
.""M N
Finished""N V
}## 
;## 
return$$ 
new$$ $
CompletedTrickResolution$$ /
{%% #
CompletedTrickCardPlays&& '
=&&( )
completedTrickPlays&&* =
,&&= >"
WinningParticipantSeat'' &
=''' (
winningTrickPlay'') 9
.''9 :
Seat'': >
,''> ? 
CompletedTrickNumber(( $
=((% &

matchState((' 1
.((1 2
CurrentTrickNumber((2 D
,((D E
MissionEvaluation)) !
=))" ##
missionEvaluationResult))$ ;
,)); <
TrickStatistics** 
=**  !
preparedEvaluation**" 4
.**4 5

Statistics**5 ?
,**? @!
UpdatedMissionAttempt++ %
=++& '!
updatedMissionAttempt++( =
},, 
;,, 
}-- 	
private// 
static// #
PreparedTrickEvaluation// .*
CreateMissionEvaluationContext/// M
(//M N

MatchState//N X

matchState//Y c
,//c d
TrickCardPlay00 
[00 
]00 
completedTrickPlays00 /
,00/ 0
TrickCardPlay001 >
winningTrickPlay00? O
)00O P
{11 	
MissionDefinition22 
missionDefinition22 /
=220 1
MissionCatalog222 @
.22@ A

GetMission22A K
(22K L

matchState22L V
.22V W
MissionAttempt22W e
.22e f
MissionNumber22f s
)22s t
;22t u
if33 
(33 
!33 %
MissionAttemptPreparation33 *
.33* +
CanPrepareMission33+ <
(33< =
missionDefinition33= N
.33N O
MissionNumber33O \
)33\ ]
)33] ^
{44 
throw55 
new55 %
InvalidOperationException55 3
(553 4
nameof554 :
(55: ;
missionDefinition55; L
.55L M
SpecialRule55M X
)55X Y
)55Y Z
;55Z [
}66 "
MissionTrickStatistics77 "
candidateStatistics77# 6
=777 8

matchState88 
.88 
TrickStatistics88 *
.88* +
IncludeWinner88+ 8
(888 9
winningTrickPlay889 I
.88I J
Card88J N
)88N O
;88O P
var99 
context99 
=99 
new99 $
MissionEvaluationContext99 6
{:: 

Definition;; 
=;; 
missionDefinition;; .
,;;. / 
TotalTricksInMission<< $
=<<% &

matchState<<' 1
.<<1 2$
MaximumMissionTrickCount<<2 J
,<<J K
CurrentTrickNumber== "
===# $

matchState==% /
.==/ 0
CurrentTrickNumber==0 B
,==B C
WinningPlay>> 
=>> 
winningTrickPlay>> .
,>>. /
CompletedTrickPlays?? #
=??$ %
completedTrickPlays??& 9
,??9 :
CurrentObjectives@@ !
=@@" #

matchState@@$ .
.@@. /
MissionAttempt@@/ =
.@@= >

Objectives@@> H
,@@H I 
TotalTricksWonBySeatAA $
=AA% &)
CreateCandidateTrickWinCountsAA' D
(AAD E

matchStateAAE O
,AAO P
winningTrickPlayAAQ a
.AAa b
SeatAAb f
)AAf g
,AAg h
CaptainSeatBB 
=BB 
(BB 
byteBB #
)BB# $

matchStateBB$ .
.BB. /
MissionCaptainSeatBB/ A
,BBA B
PlayerCountCC 
=CC 

matchStateCC (
.CC( )
ParticipantUserIdsCC) ;
.CC; <
LengthCC< B
,CCB C

RoleConfigDD 
=DD 

matchStateDD '
.DD' (
MissionAttemptDD( 6
.DD6 7

RoleConfigDD7 A
,DDA B
HeartNineOwnerSeatEE "
=EE# $

matchStateEE% /
.EE/ 0
MissionAttemptEE0 >
.EE> ?

RoleConfigEE? I
?EEI J
.EEJ K
HeartNineOwnerSeatEEK ]
,EE] ^"
CapturedHeartCardCountFF &
=FF' (,
 CreateCandidateHeartCaptureCountFF) I
(FFI J

matchStateFFJ T
,FFT U
completedTrickPlaysGG '
,GG' (
winningTrickPlayGG) 9
)GG9 :
,GG: ;'
TricksWonWithNormalOneCountHH +
=HH, -
candidateStatisticsHH. A
.HHA B'
TricksWonWithNormalOneCountHHB ]
,HH] ^ 
SpecialCardsWonSoFarII $
=II% &
candidateStatisticsII' :
.II: ;!
SpecialWinningCardIdsII; P
.IIP Q
SelectIIQ W
(IIW X
	DeckRulesIIX a
.IIa b
GetCardByIdIIb m
)IIm n
.IIn o
ToArrayIIo v
(IIv w
)IIw x
}JJ 
;JJ 
returnKK 
newKK #
PreparedTrickEvaluationKK .
{KK/ 0
ContextKK1 8
=KK9 :
contextKK; B
,KKB C

StatisticsKKD N
=KKO P
candidateStatisticsKKQ d
}KKe f
;KKf g
}LL 	
privateMM 
staticMM 
IReadOnlyDictionaryMM *
<MM* +
intMM+ .
,MM. /
intMM0 3
>MM3 4)
CreateCandidateTrickWinCountsMM5 R
(MMR S

MatchStateMMS ]

matchStateMM^ h
,MMh i
intNN "
winningParticipantSeatNN &
)NN& '
{OO 	

DictionaryPP 
<PP 
intPP 
,PP 
intPP 
>PP  )
candidateTrickWinCountsBySeatPP! >
=PP? @

matchStatePPA K
.PPK L 
WonTrickCountsBySeatPPL `
.QQ 
SelectQQ 
(QQ 
(QQ 
trickWinCountQQ &
,QQ& '
participantSeatQQ( 7
)QQ7 8
=>QQ9 ;
newQQ< ?
{QQ@ A
participantSeatQQB Q
,QQQ R
trickWinCountQQS `
}QQa b
)QQb c
.RR 
ToDictionaryRR 
(RR 
entryRR #
=>RR$ &
entryRR' ,
.RR, -
participantSeatRR- <
,RR< =
entryRR> C
=>RRD F
entryRRG L
.RRL M
trickWinCountRRM Z
)RRZ [
;RR[ \)
candidateTrickWinCountsBySeatSS )
[SS) *"
winningParticipantSeatSS* @
]SS@ A
++SSA C
;SSC D
returnTT )
candidateTrickWinCountsBySeatTT 0
;TT0 1
}UU 	
privateVV 
staticVV 
intVV ,
 CreateCandidateHeartCaptureCountVV ;
(VV; <

MatchStateVV< F
stateVVG L
,VVL M
TrickCardPlayVVN [
[VV[ \
]VV\ ]
trickVV^ c
,VVc d
TrickCardPlayWW 
winningPlayWW %
)WW% &
{XX 	
intYY "
capturedHeartCardCountYY &
=YY' (
CountCapturedHeartsYY) <
(YY< =
stateYY= B
)YYB C
;YYC D
byteZZ 
?ZZ 
requiredSeatZZ 
=ZZ  *
MissionSpecialPreparationRulesZZ! ?
.ZZ? @'
GetRequiredHeartCaptureSeatZZ@ [
(ZZ[ \
state[[ 
.[[ 
MissionAttempt[[ $
.[[$ %

RoleConfig[[% /
,[[/ 0
state[[1 6
.[[6 7
ParticipantUserIds[[7 I
.[[I J
Length[[J P
)[[P Q
;[[Q R
if\\ 
(\\ 
requiredSeat\\ 
==\\ 
winningPlay\\  +
.\\+ ,
Seat\\, 0
)\\0 1
{]] "
capturedHeartCardCount^^ &
+=^^' )
trick^^* /
.^^/ 0
Count^^0 5
(^^5 6
play^^6 :
=>^^; =
play^^> B
.^^B C
Card^^C G
.^^G H
Suit^^H L
==^^M O
CardSuit^^P X
.^^X Y
Heart^^Y ^
)^^^ _
;^^_ `
}__ 
return`` "
capturedHeartCardCount`` )
;``) *
}aa 	
}bb 
}cc ¢
rC:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\Models\Match\Tricks\CompletedTrickResolution.cs
	namespace 	
Application
 
. 
Models 
{ 
internal 
sealed 
record $
CompletedTrickResolution 3
{ 
public		 
MatchCardPlay		 
[		 
]		 #
CompletedTrickCardPlays		 6
{		7 8
get		9 <
;		< =
init		> B
;		B C
}		D E
public 
int "
WinningParticipantSeat )
{* +
get, /
;/ 0
init1 5
;5 6
}7 8
public 
int  
CompletedTrickNumber '
{( )
get* -
;- .
init/ 3
;3 4
}5 6
public #
MissionEvaluationResult &
MissionEvaluation' 8
{9 :
get; >
;> ?
init@ D
;D E
}F G
public "
MissionTrickStatistics %
TrickStatistics& 5
{6 7
get8 ;
;; <
init= A
;A B
}C D
public 
MissionAttemptState "!
UpdatedMissionAttempt# 8
{9 :
get; >
;> ?
init@ D
;D E
}F G
} 
} î„
yC:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\UseCases\Match\Distress\MatchUseCase.DistressSignal.cs
	namespace 	
Application
 
. 
UseCases 
{ 
public 

sealed 
partial 
class 
MatchUseCase  ,
{ 
private 
const 
int *
MaximumDistressLobbyCodeLength 8
=9 :
$num; =
;= >
public  
DistressSignalCommit # 
SubmitDistressSignal$ 8
(8 9!
DistressSignalRequest9 N
requestO V
,V W
intX [
participantUserId\ m
)m n
{ 	 
DistressSignalCommit  
result! '
=( )
RejectDistress* 8
(8 9#
DistressSignalRejection9 P
.P Q
InvalidSubmissionQ b
,b c
$numd e
)e f
;f g
if 
( 
request 
!= 
null 
&&  "
!# $
string$ *
.* +
IsNullOrWhiteSpace+ =
(= >
request> E
.E F
	LobbyCodeF O
)O P
&&Q S
request 
. 
	LobbyCode !
.! "
Length" (
<=) +*
MaximumDistressLobbyCodeLength, J
)J K
{ 

MatchState 

matchState %
=& '
_matchStateStore( 8
.8 9
	FindMatch9 B
(B C
requestC J
.J K
	LobbyCodeK T
)T U
;U V
result 
= 
RejectDistress '
(' (#
DistressSignalRejection( ?
.? @
MatchUnavailable@ P
,P Q
$numR S
)S T
;T U
if 
( 

matchState 
!= !
null" &
)& '
{   
lock!! 
(!! 

matchState!! $
)!!$ %
{"" 
result## 
=##  *
ProcessDistressSignalUnderLock##! ?
(##? @

matchState##@ J
,##J K
request##L S
,##S T
participantUserId##U f
)##f g
;##g h
}$$ 
}%% 
}&& 
return'' 
result'' 
;'' 
}(( 	
private** 
static**  
DistressSignalCommit** +*
ProcessDistressSignalUnderLock**, J
(**J K

MatchState++ 

matchState++ !
,++! "!
DistressSignalRequest++# 8
request++9 @
,++@ A
int++B E
participantUserId++F W
)++W X
{,, 	
int-- 
participantSeat-- 
=--  !
Array--" '
.--' (
IndexOf--( /
(--/ 0

matchState--0 :
.--: ;
ParticipantUserIds--; M
,--M N
participantUserId--O `
)--` a
;--a b#
DistressSignalRejection.. #
	rejection..$ -
=... /.
"ValidateDistressIdentityAndAttempt..0 R
(..R S

matchState// 
,// 
request// #
,//# $
participantSeat//% 4
)//4 5
;//5 6 
DistressSignalCommit00  
result00! '
=00( )
RejectDistress00* 8
(008 9
	rejection009 B
,00B C

matchState00D N
.00N O
MatchStateVersion00O `
)00` a
;00a b
if11 
(11 
	rejection11 
==11 #
DistressSignalRejection11 4
.114 5
None115 9
)119 :
{22 
var33 
participantAction33 %
=33& '
new33( +%
DistressParticipantAction33, E
(33E F
request44 
,44 
(44 
byte44 "
)44" #
participantSeat44# 2
,442 3
participantUserId444 E
)44E F
;44F G
result55 
=55 "
DispatchDistressAction55 /
(55/ 0

matchState550 :
,55: ;
participantAction55< M
)55M N
;55N O
}66 
return77 
result77 
;77 
}88 	
private:: 
static:: #
DistressSignalRejection:: ..
"ValidateDistressIdentityAndAttempt::/ Q
(::Q R

MatchState;; 

matchState;; !
,;;! "!
DistressSignalRequest;;# 8
request;;9 @
,;;@ A
int;;B E
participantSeat;;F U
);;U V
{<< 	#
DistressSignalRejection== #
	rejection==$ -
;==- .
if>> 
(>> 
participantSeat>> 
<>>  !
$num>>" #
||>>$ &
request>>' .
.>>. /
MatchId>>/ 6
!=>>7 9

matchState>>: D
.>>D E
MatchId>>E L
)>>L M
{?? 
	rejection@@ 
=@@ #
DistressSignalRejection@@ 3
.@@3 4!
ParticipantNotAllowed@@4 I
;@@I J
}AA 
elseBB 
ifBB 
(BB 
!BB 
EnumBB 
.BB 
	IsDefinedBB $
(BB$ %
typeofBB% +
(BB+ ,$
DistressSignalActionTypeBB, D
)BBD E
,BBE F
requestBBG N
.BBN O

ActionTypeBBO Y
)BBY Z
||BB[ ]
requestCC 
.CC 

ActionTypeCC "
==CC# %$
DistressSignalActionTypeCC& >
.CC> ?
NoneCC? C
)CCC D
{DD 
	rejectionEE 
=EE #
DistressSignalRejectionEE 3
.EE3 4
InvalidSubmissionEE4 E
;EEE F
}FF 
elseGG 
{HH 
	rejectionII 
=II (
ValidateDistressAttemptStateII 8
(II8 9

matchStateII9 C
,IIC D
requestIIE L
)IIL M
;IIM N
}JJ 
returnKK 
	rejectionKK 
;KK 
}LL 	
privateNN 
staticNN #
DistressSignalRejectionNN .(
ValidateDistressAttemptStateNN/ K
(NNK L

MatchStateOO 

matchStateOO !
,OO! "!
DistressSignalRequestOO# 8
requestOO9 @
)OO@ A
{PP 	#
DistressSignalRejectionQQ #
	rejectionQQ$ -
=QQ. /#
DistressSignalRejectionQQ0 G
.QQG H
NoneQQH L
;QQL M
ifRR 
(RR 

matchStateRR 
.RR 
MissionAttemptRR )
==RR* ,
nullRR- 1
||RR2 4
requestSS 
.SS 
MissionAttemptIdSS (
!=SS) +

matchStateSS, 6
.SS6 7
MissionAttemptSS7 E
.SSE F
MissionAttemptIdSSF V
)SSV W
{TT 
	rejectionUU 
=UU #
DistressSignalRejectionUU 3
.UU3 4
WrongMissionAttemptUU4 G
;UUG H
}VV 
elseWW 
ifWW 
(WW 

matchStateWW 
.WW  
MissionAttemptWW  .
.WW. /
PhaseWW/ 4
==WW5 7
MissionAttemptPhaseWW8 K
.WWK L
FinishedWWL T
)WWT U
{XX 
	rejectionYY 
=YY #
DistressSignalRejectionYY 3
.YY3 4"
MissionAttemptFinishedYY4 J
;YYJ K
}ZZ 
else[[ 
if[[ 
([[ 

matchState[[ 
.[[  
MissionAttempt[[  .
.[[. /
Phase[[/ 4
!=[[5 7
MissionAttemptPhase[[8 K
.[[K L
PlayingTricks[[L Y
)[[Y Z
{\\ 
	rejection]] 
=]] #
DistressSignalRejection]] 3
.]]3 4&
MissionPreparationRequired]]4 N
;]]N O
}^^ 
else__ 
{`` 
	rejectionaa 
=aa *
ValidateDistressGameplayWindowaa :
(aa: ;

matchStateaa; E
)aaE F
;aaF G
}bb 
returncc 
	rejectioncc 
;cc 
}dd 	
privateff 
staticff #
DistressSignalRejectionff .*
ValidateDistressGameplayWindowff/ M
(ffM N

MatchStateffN X

matchStateffY c
)ffc d
{gg 	#
DistressSignalRejectionhh #
	rejectionhh$ -
=hh. /#
DistressSignalRejectionhh0 G
.hhG H
NonehhH L
;hhL M
ifii 
(ii 

matchStateii 
.ii 
MissionAttemptii )
.ii) *!
HasUsedDistressSignalii* ?
)ii? @
{jj 
	rejectionkk 
=kk #
DistressSignalRejectionkk 3
.kk3 4
DistressAlreadyUsedkk4 G
;kkG H
}ll 
elsemm 
ifmm 
(mm 

matchStatemm 
.mm  
CurrentTrickNumbermm  2
>mm3 4
$nummm5 6
||mm7 9

matchStatemm: D
.mmD E!
CurrentTrickCardPlaysmmE Z
.mmZ [
Countmm[ `
>mma b
$nummmc d
)mmd e
{nn 
	rejectionoo 
=oo #
DistressSignalRejectionoo 3
.oo3 4
TrickAlreadyStartedoo4 G
;ooG H
}pp 
elseqq 
ifqq 
(qq $
HasAnyPlayerCommunicatedqq -
(qq- .

matchStateqq. 8
)qq8 9
)qq9 :
{rr 
	rejectionss 
=ss #
DistressSignalRejectionss 3
.ss3 4
RadioAlreadyUsedss4 D
;ssD E
}tt 
returnuu 
	rejectionuu 
;uu 
}vv 	
privatexx 
staticxx 
boolxx $
HasAnyPlayerCommunicatedxx 4
(xx4 5

MatchStatexx5 ?

matchStatexx@ J
)xxJ K
{yy 	
boolzz 
hasCommittedRadiozz "
=zz# $

matchStatezz% /
.zz/ 02
&RadioCommunicationsByParticipantUserIdzz0 V
!=zzW Y
nullzzZ ^
&&zz_ a

matchState{{ 
.{{ 2
&RadioCommunicationsByParticipantUserId{{ A
.{{A B
Count{{B G
>{{H I
$num{{J K
;{{K L
bool|| 
hasAttemptSeatRadio|| $
=||% &

matchState||' 1
.||1 2
MissionAttempt||2 @
?||@ A
.||A B%
RadioCommunicationsBySeat||B [
!=||\ ^
null||_ c
&&||d f

matchState}} 
.}} 
MissionAttempt}} )
.}}) *%
RadioCommunicationsBySeat}}* C
.}}C D
Any}}D G
(}}G H
communication~~ !
=>~~" $
communication~~% 2
.~~2 3%
HasUsedCommunicationToken~~3 L
)~~L M
;~~M N
return 
hasCommittedRadio $
||% '
hasAttemptSeatRadio( ;
;; <
}
ÄÄ 	
private
ÇÇ 
static
ÇÇ "
DistressSignalCommit
ÇÇ +$
DispatchDistressAction
ÇÇ, B
(
ÇÇB C

MatchState
ÉÉ 

matchState
ÉÉ !
,
ÉÉ! "'
DistressParticipantAction
ÉÉ# <
participantAction
ÉÉ= N
)
ÉÉN O
{
ÑÑ 	"
DistressSignalCommit
ÖÖ  
result
ÖÖ! '
;
ÖÖ' (
switch
ÜÜ 
(
ÜÜ 
participantAction
ÜÜ %
.
ÜÜ% &
Request
ÜÜ& -
.
ÜÜ- .

ActionType
ÜÜ. 8
)
ÜÜ8 9
{
áá 
case
àà &
DistressSignalActionType
àà -
.
àà- .
ProposeUsage
àà. :
:
àà: ;
result
ââ 
=
ââ  
HandleProposeUsage
ââ /
(
ââ/ 0

matchState
ââ0 :
,
ââ: ;
participantAction
ââ< M
)
ââM N
;
ââN O
break
ää 
;
ää 
case
ãã &
DistressSignalActionType
ãã -
.
ãã- .
	VoteUsage
ãã. 7
:
ãã7 8
result
åå 
=
åå 
HandleVoteUsage
åå ,
(
åå, -

matchState
åå- 7
,
åå7 8
participantAction
åå9 J
)
ååJ K
;
ååK L
break
çç 
;
çç 
case
éé &
DistressSignalActionType
éé -
.
éé- .
VoteDirection
éé. ;
:
éé; <
result
èè 
=
èè !
HandleVoteDirection
èè 0
(
èè0 1

matchState
èè1 ;
,
èè; <
participantAction
èè= N
)
èèN O
;
èèO P
break
êê 
;
êê 
case
ëë &
DistressSignalActionType
ëë -
.
ëë- .
SubmitPassCard
ëë. <
:
ëë< =
result
íí 
=
íí "
HandleSubmitPassCard
íí 1
(
íí1 2

matchState
íí2 <
,
íí< =
participantAction
íí> O
)
ííO P
;
ííP Q
break
ìì 
;
ìì 
case
îî &
DistressSignalActionType
îî -
.
îî- .
CancelProposal
îî. <
:
îî< =
result
ïï 
=
ïï "
HandleCancelProposal
ïï 1
(
ïï1 2

matchState
ïï2 <
)
ïï< =
;
ïï= >
break
ññ 
;
ññ 
default
óó 
:
óó 
result
òò 
=
òò 
RejectDistress
òò +
(
òò+ ,%
DistressSignalRejection
òò, C
.
òòC D
InvalidSubmission
òòD U
,
òòU V

matchState
òòW a
.
òòa b
MatchStateVersion
òòb s
)
òòs t
;
òòt u
break
ôô 
;
ôô 
}
öö 
return
õõ 
result
õõ 
;
õõ 
}
úú 	
private
ûû 
static
ûû "
DistressSignalCommit
ûû + 
HandleProposeUsage
ûû, >
(
ûû> ?

MatchState
üü 

matchState
üü !
,
üü! "'
DistressParticipantAction
üü# <
participantAction
üü= N
)
üüN O
{
†† 	"
DistressSignalCommit
°°  
result
°°! '
;
°°' (
if
¢¢ 
(
¢¢ 
!
¢¢ 
participantAction
¢¢ "
.
¢¢" #
Request
¢¢# *
.
¢¢* +
IsVoteAccepted
¢¢+ 9
)
¢¢9 :
{
££ 
result
§§ 
=
§§ 
RejectDistress
§§ '
(
§§' (%
DistressSignalRejection
§§( ?
.
§§? @
InvalidSubmission
§§@ Q
,
§§Q R

matchState
§§S ]
.
§§] ^
MatchStateVersion
§§^ o
)
§§o p
;
§§p q
}
•• 
else
¶¶ 
if
¶¶ 
(
¶¶ 

matchState
¶¶ 
.
¶¶  
DistressStep
¶¶  ,
!=
¶¶- / 
DistressSignalStep
¶¶0 B
.
¶¶B C
None
¶¶C G
)
¶¶G H
{
ßß 
result
®® 
=
®® 
RejectDistress
®® '
(
®®' (%
DistressSignalRejection
®®( ?
.
®®? @#
InvalidStepTransition
®®@ U
,
®®U V

matchState
®®W a
.
®®a b
MatchStateVersion
®®b s
)
®®s t
;
®®t u
}
©© 
else
™™ 
{
´´ 

matchState
¨¨ 
.
¨¨ 
DistressStep
¨¨ '
=
¨¨( ) 
DistressSignalStep
¨¨* <
.
¨¨< =
VotingToUse
¨¨= H
;
¨¨H I

matchState
≠≠ 
.
≠≠ %
DistressInitiatorUserId
≠≠ 2
=
≠≠3 4
participantAction
≠≠5 F
.
≠≠F G
ParticipantUserId
≠≠G X
;
≠≠X Y

matchState
ÆÆ 
.
ÆÆ %
HasDistressBeenRejected
ÆÆ 2
=
ÆÆ3 4
false
ÆÆ5 :
;
ÆÆ: ;

matchState
ØØ 
.
ØØ )
DistressUsageYesVotesBySeat
ØØ 6
.
ØØ6 7
Clear
ØØ7 <
(
ØØ< =
)
ØØ= >
;
ØØ> ?

matchState
∞∞ 
.
∞∞ )
DistressUsageYesVotesBySeat
∞∞ 6
.
∞∞6 7
Add
∞∞7 :
(
∞∞: ;
participantAction
∞∞; L
.
∞∞L M
ParticipantSeat
∞∞M \
)
∞∞\ ]
;
∞∞] ^

matchState
±± 
.
±± 
MatchStateVersion
±± ,
++
±±, .
;
±±. /
result
≤≤ 
=
≤≤ "
CreateAcceptedCommit
≤≤ -
(
≤≤- .

matchState
≤≤. 8
,
≤≤8 9
false
≤≤: ?
)
≤≤? @
;
≤≤@ A
}
≥≥ 
return
¥¥ 
result
¥¥ 
;
¥¥ 
}
µµ 	
private
∑∑ 
static
∑∑ "
DistressSignalCommit
∑∑ +
HandleVoteUsage
∑∑, ;
(
∑∑; <

MatchState
∏∏ 

matchState
∏∏ !
,
∏∏! "'
DistressParticipantAction
∏∏# <
participantAction
∏∏= N
)
∏∏N O
{
ππ 	"
DistressSignalCommit
∫∫  
result
∫∫! '
;
∫∫' (
if
ªª 
(
ªª 

matchState
ªª 
.
ªª 
DistressStep
ªª '
!=
ªª( * 
DistressSignalStep
ªª+ =
.
ªª= >
VotingToUse
ªª> I
)
ªªI J
{
ºº 
result
ΩΩ 
=
ΩΩ 
RejectDistress
ΩΩ '
(
ΩΩ' (%
DistressSignalRejection
ΩΩ( ?
.
ΩΩ? @#
InvalidStepTransition
ΩΩ@ U
,
ΩΩU V

matchState
ΩΩW a
.
ΩΩa b
MatchStateVersion
ΩΩb s
)
ΩΩs t
;
ΩΩt u
}
ææ 
else
øø 
if
øø 
(
øø 
!
øø 
participantAction
øø '
.
øø' (
Request
øø( /
.
øø/ 0
IsVoteAccepted
øø0 >
)
øø> ?
{
¿¿ 
result
¡¡ 
=
¡¡ %
HandleDistressRejection
¡¡ 0
(
¡¡0 1

matchState
¡¡1 ;
)
¡¡; <
;
¡¡< =
}
¬¬ 
else
√√ 
{
ƒƒ 

matchState
≈≈ 
.
≈≈ )
DistressUsageYesVotesBySeat
≈≈ 6
.
≈≈6 7
Add
≈≈7 :
(
≈≈: ;
participantAction
≈≈; L
.
≈≈L M
ParticipantSeat
≈≈M \
)
≈≈\ ]
;
≈≈] ^
int
∆∆ 
requiredPlayers
∆∆ #
=
∆∆$ %

matchState
∆∆& 0
.
∆∆0 1 
ParticipantUserIds
∆∆1 C
.
∆∆C D
Length
∆∆D J
;
∆∆J K
if
«« 
(
«« 

matchState
«« 
.
«« )
DistressUsageYesVotesBySeat
«« :
.
««: ;
Count
««; @
>=
««A C
requiredPlayers
««D S
)
««S T
{
»» 

matchState
…… 
.
…… 
DistressStep
…… +
=
……, - 
DistressSignalStep
……. @
.
……@ A
VotingDirection
……A P
;
……P Q

matchState
   
.
   *
DistressDirectionVotesBySeat
   ;
.
  ; <
Clear
  < A
(
  A B
)
  B C
;
  C D
}
ÀÀ 

matchState
ÃÃ 
.
ÃÃ 
MatchStateVersion
ÃÃ ,
++
ÃÃ, .
;
ÃÃ. /
result
ÕÕ 
=
ÕÕ "
CreateAcceptedCommit
ÕÕ -
(
ÕÕ- .

matchState
ÕÕ. 8
,
ÕÕ8 9
false
ÕÕ: ?
)
ÕÕ? @
;
ÕÕ@ A
}
ŒŒ 
return
œœ 
result
œœ 
;
œœ 
}
–– 	
private
““ 
static
““ "
DistressSignalCommit
““ +!
HandleVoteDirection
““, ?
(
““? @

MatchState
”” 

matchState
”” !
,
””! "'
DistressParticipantAction
””# <
participantAction
””= N
)
””N O
{
‘‘ 	
PassDirection
’’ 
selectedDirection
’’ +
=
’’, -
participantAction
’’. ?
.
’’? @
Request
’’@ G
.
’’G H
SelectedDirection
’’H Y
;
’’Y Z
bool
÷÷ 
isDirectionValid
÷÷ !
=
÷÷" #
selectedDirection
÷÷$ 5
==
÷÷6 8
PassDirection
÷÷9 F
.
÷÷F G
Left
÷÷G K
||
÷÷L N
selectedDirection
◊◊ !
==
◊◊" $
PassDirection
◊◊% 2
.
◊◊2 3
Right
◊◊3 8
;
◊◊8 9"
DistressSignalCommit
ÿÿ  
result
ÿÿ! '
;
ÿÿ' (
if
ŸŸ 
(
ŸŸ 
!
ŸŸ 
participantAction
ŸŸ "
.
ŸŸ" #
Request
ŸŸ# *
.
ŸŸ* +
IsVoteAccepted
ŸŸ+ 9
||
ŸŸ: <
!
ŸŸ= >
isDirectionValid
ŸŸ> N
)
ŸŸN O
{
⁄⁄ 
result
€€ 
=
€€ 
RejectDistress
€€ '
(
€€' (%
DistressSignalRejection
€€( ?
.
€€? @
InvalidSubmission
€€@ Q
,
€€Q R

matchState
€€S ]
.
€€] ^
MatchStateVersion
€€^ o
)
€€o p
;
€€p q
}
‹‹ 
else
›› 
if
›› 
(
›› 

matchState
›› 
.
››  
DistressStep
››  ,
!=
››- / 
DistressSignalStep
››0 B
.
››B C
VotingDirection
››C R
)
››R S
{
ﬁﬁ 
result
ﬂﬂ 
=
ﬂﬂ 
RejectDistress
ﬂﬂ '
(
ﬂﬂ' (%
DistressSignalRejection
ﬂﬂ( ?
.
ﬂﬂ? @#
InvalidStepTransition
ﬂﬂ@ U
,
ﬂﬂU V

matchState
ﬂﬂW a
.
ﬂﬂa b
MatchStateVersion
ﬂﬂb s
)
ﬂﬂs t
;
ﬂﬂt u
}
‡‡ 
else
·· 
{
‚‚ 

matchState
„„ 
.
„„ *
DistressDirectionVotesBySeat
„„ 7
[
„„7 8
participantAction
„„8 I
.
„„I J
ParticipantSeat
„„J Y
]
„„Y Z
=
„„[ \
selectedDirection
„„] n
;
„„n o
result
‰‰ 
=
‰‰ #
ResolveDirectionVotes
‰‰ .
(
‰‰. /

matchState
‰‰/ 9
)
‰‰9 :
;
‰‰: ;
}
ÂÂ 
return
ÊÊ 
result
ÊÊ 
;
ÊÊ 
}
ÁÁ 	
private
ÈÈ 
static
ÈÈ "
DistressSignalCommit
ÈÈ +#
ResolveDirectionVotes
ÈÈ, A
(
ÈÈA B

MatchState
ÈÈB L

matchState
ÈÈM W
)
ÈÈW X
{
ÍÍ 	"
DistressSignalCommit
ÎÎ  
result
ÎÎ! '
;
ÎÎ' (
int
ÏÏ 
requiredPlayers
ÏÏ 
=
ÏÏ  !

matchState
ÏÏ" ,
.
ÏÏ, - 
ParticipantUserIds
ÏÏ- ?
.
ÏÏ? @
Length
ÏÏ@ F
;
ÏÏF G
if
ÌÌ 
(
ÌÌ 

matchState
ÌÌ 
.
ÌÌ *
DistressDirectionVotesBySeat
ÌÌ 7
.
ÌÌ7 8
Count
ÌÌ8 =
<
ÌÌ> ?
requiredPlayers
ÌÌ@ O
)
ÌÌO P
{
ÓÓ 

matchState
ÔÔ 
.
ÔÔ 
MatchStateVersion
ÔÔ ,
++
ÔÔ, .
;
ÔÔ. /
result
 
=
 "
CreateAcceptedCommit
 -
(
- .

matchState
. 8
,
8 9
false
: ?
)
? @
;
@ A
}
ÒÒ 
else
ÚÚ 
{
ÛÛ 
int
ÙÙ 
	leftCount
ÙÙ 
=
ÙÙ 

matchState
ÙÙ  *
.
ÙÙ* +*
DistressDirectionVotesBySeat
ÙÙ+ G
.
ÙÙG H
Values
ÙÙH N
.
ıı 
Count
ıı 
(
ıı 
	direction
ıı $
=>
ıı% '
	direction
ıı( 1
==
ıı2 4
PassDirection
ıı5 B
.
ııB C
Left
ııC G
)
ııG H
;
ııH I
int
ˆˆ 

rightCount
ˆˆ 
=
ˆˆ  

matchState
ˆˆ! +
.
ˆˆ+ ,*
DistressDirectionVotesBySeat
ˆˆ, H
.
ˆˆH I
Values
ˆˆI O
.
˜˜ 
Count
˜˜ 
(
˜˜ 
	direction
˜˜ $
=>
˜˜% '
	direction
˜˜( 1
==
˜˜2 4
PassDirection
˜˜5 B
.
˜˜B C
Right
˜˜C H
)
˜˜H I
;
˜˜I J
bool
¯¯ 
isUnanimousLeft
¯¯ $
=
¯¯% &
	leftCount
¯¯' 0
==
¯¯1 3
requiredPlayers
¯¯4 C
;
¯¯C D
bool
˘˘ 
isUnanimousRight
˘˘ %
=
˘˘& '

rightCount
˘˘( 2
==
˘˘3 5
requiredPlayers
˘˘6 E
;
˘˘E F
if
˙˙ 
(
˙˙ 
isUnanimousLeft
˙˙ #
||
˙˙$ &
isUnanimousRight
˙˙' 7
)
˙˙7 8
{
˚˚ 

matchState
¸¸ 
.
¸¸ %
DistressAgreedDirection
¸¸ 6
=
¸¸7 8
isUnanimousLeft
¸¸9 H
?
¸¸I J
PassDirection
¸¸K X
.
¸¸X Y
Left
¸¸Y ]
:
¸¸^ _
PassDirection
¸¸` m
.
¸¸m n
Right
¸¸n s
;
¸¸s t

matchState
˝˝ 
.
˝˝ 
DistressStep
˝˝ +
=
˝˝, - 
DistressSignalStep
˝˝. @
.
˝˝@ A
SelectingCard
˝˝A N
;
˝˝N O

matchState
˛˛ 
.
˛˛ .
 PendingDistressPassCardIdsBySeat
˛˛ ?
.
˛˛? @
Clear
˛˛@ E
(
˛˛E F
)
˛˛F G
;
˛˛G H

matchState
ˇˇ 
.
ˇˇ 
MatchStateVersion
ˇˇ 0
++
ˇˇ0 2
;
ˇˇ2 3
result
ÄÄ 
=
ÄÄ "
CreateAcceptedCommit
ÄÄ 1
(
ÄÄ1 2

matchState
ÄÄ2 <
,
ÄÄ< =
false
ÄÄ> C
)
ÄÄC D
;
ÄÄD E
}
ÅÅ 
else
ÇÇ 
{
ÉÉ 
result
ÑÑ 
=
ÑÑ %
HandleDistressRejection
ÑÑ 4
(
ÑÑ4 5

matchState
ÑÑ5 ?
)
ÑÑ? @
;
ÑÑ@ A
}
ÖÖ 
}
ÜÜ 
return
áá 
result
áá 
;
áá 
}
àà 	
private
ää 
static
ää "
DistressSignalCommit
ää +"
HandleSubmitPassCard
ää, @
(
ää@ A

MatchState
ãã 

matchState
ãã !
,
ãã! "'
DistressParticipantAction
ãã# <
participantAction
ãã= N
)
ããN O
{
åå 	"
DistressSignalCommit
çç  
result
çç! '
;
çç' (
if
éé 
(
éé 
!
éé 
participantAction
éé "
.
éé" #
Request
éé# *
.
éé* +
IsVoteAccepted
éé+ 9
)
éé9 :
{
èè 
result
êê 
=
êê 
RejectDistress
êê '
(
êê' (%
DistressSignalRejection
êê( ?
.
êê? @
InvalidSubmission
êê@ Q
,
êêQ R

matchState
êêS ]
.
êê] ^
MatchStateVersion
êê^ o
)
êêo p
;
êêp q
}
ëë 
else
íí 
if
íí 
(
íí 

matchState
íí 
.
íí  
DistressStep
íí  ,
!=
íí- / 
DistressSignalStep
íí0 B
.
ííB C
SelectingCard
ííC P
)
ííP Q
{
ìì 
result
îî 
=
îî 
RejectDistress
îî '
(
îî' (%
DistressSignalRejection
îî( ?
.
îî? @#
InvalidStepTransition
îî@ U
,
îîU V

matchState
îîW a
.
îîa b
MatchStateVersion
îîb s
)
îîs t
;
îît u
}
ïï 
else
ññ 
{
óó %
DistressSignalRejection
òò '
cardRejection
òò( 5
=
òò6 7"
ValidateDistressCard
òò8 L
(
òòL M

matchState
ôô 
,
ôô 
participantAction
ôô  1
.
ôô1 2
Request
ôô2 9
.
ôô9 :
CardIdToPass
ôô: F
,
ôôF G
participantAction
ôôH Y
.
ôôY Z
ParticipantSeat
ôôZ i
)
ôôi j
;
ôôj k
if
öö 
(
öö 
cardRejection
öö !
!=
öö" $%
DistressSignalRejection
öö% <
.
öö< =
None
öö= A
)
ööA B
{
õõ 
result
úú 
=
úú 
RejectDistress
úú +
(
úú+ ,
cardRejection
úú, 9
,
úú9 :

matchState
úú; E
.
úúE F
MatchStateVersion
úúF W
)
úúW X
;
úúX Y
}
ùù 
else
ûû 
{
üü 
result
†† 
=
†† ,
RecordCardAndExecuteIfComplete
†† ;
(
††; <

matchState
††< F
,
††F G
participantAction
††H Y
)
††Y Z
;
††Z [
}
°° 
}
¢¢ 
return
££ 
result
££ 
;
££ 
}
§§ 	
private
¶¶ 
static
¶¶ "
DistressSignalCommit
¶¶ +,
RecordCardAndExecuteIfComplete
¶¶, J
(
¶¶J K

MatchState
ßß 

matchState
ßß !
,
ßß! "'
DistressParticipantAction
ßß# <
participantAction
ßß= N
)
ßßN O
{
®® 	"
DistressSignalCommit
©©  
result
©©! '
;
©©' (
PassDirection
™™ 
	direction
™™ #
=
™™$ %

matchState
™™& 0
.
™™0 1%
DistressAgreedDirection
™™1 H
??
™™I K
PassDirection
™™L Y
.
™™Y Z
Left
™™Z ^
;
™™^ _

matchState
´´ 
.
´´ .
 PendingDistressPassCardIdsBySeat
´´ 7
[
´´7 8
participantAction
´´8 I
.
´´I J
ParticipantSeat
´´J Y
]
´´Y Z
=
´´[ \
participantAction
¨¨ !
.
¨¨! "
Request
¨¨" )
.
¨¨) *
CardIdToPass
¨¨* 6
;
¨¨6 7

matchState
≠≠ 
.
≠≠ -
PendingDistressDirectionsBySeat
≠≠ 6
[
≠≠6 7
participantAction
≠≠7 H
.
≠≠H I
ParticipantSeat
≠≠I X
]
≠≠X Y
=
≠≠Z [
	direction
≠≠\ e
;
≠≠e f
int
ÆÆ 
requiredPlayers
ÆÆ 
=
ÆÆ  !

matchState
ÆÆ" ,
.
ÆÆ, - 
ParticipantUserIds
ÆÆ- ?
.
ÆÆ? @
Length
ÆÆ@ F
;
ÆÆF G
if
ØØ 
(
ØØ 

matchState
ØØ 
.
ØØ .
 PendingDistressPassCardIdsBySeat
ØØ ;
.
ØØ; <
Count
ØØ< A
>=
ØØB D
requiredPlayers
ØØE T
)
ØØT U
{
∞∞ 
result
±± 
=
±± %
ExecuteDistressExchange
±± 0
(
±±0 1

matchState
±±1 ;
,
±±; <
	direction
±±= F
)
±±F G
;
±±G H
}
≤≤ 
else
≥≥ 
{
¥¥ 

matchState
µµ 
.
µµ 
MatchStateVersion
µµ ,
++
µµ, .
;
µµ. /
result
∂∂ 
=
∂∂ "
CreateAcceptedCommit
∂∂ -
(
∂∂- .

matchState
∂∂. 8
,
∂∂8 9
false
∂∂: ?
)
∂∂? @
;
∂∂@ A
}
∑∑ 
return
∏∏ 
result
∏∏ 
;
∏∏ 
}
ππ 	
private
ªª 
static
ªª "
DistressSignalCommit
ªª +"
HandleCancelProposal
ªª, @
(
ªª@ A

MatchState
ªªA K

matchState
ªªL V
)
ªªV W
{
ºº 	
bool
ΩΩ "
isDistressInProgress
ΩΩ %
=
ΩΩ& '

matchState
ΩΩ( 2
.
ΩΩ2 3
DistressStep
ΩΩ3 ?
!=
ΩΩ@ B 
DistressSignalStep
ΩΩC U
.
ΩΩU V
None
ΩΩV Z
&&
ΩΩ[ ]

matchState
ææ 
.
ææ 
DistressStep
ææ '
!=
ææ( * 
DistressSignalStep
ææ+ =
.
ææ= >
	Completed
ææ> G
;
ææG H
return
øø "
isDistressInProgress
øø '
?
¿¿ %
HandleDistressRejection
¿¿ )
(
¿¿) *

matchState
¿¿* 4
)
¿¿4 5
:
¡¡ 
RejectDistress
¡¡  
(
¡¡  !%
DistressSignalRejection
¡¡! 8
.
¡¡8 9#
InvalidStepTransition
¡¡9 N
,
¡¡N O

matchState
¡¡P Z
.
¡¡Z [
MatchStateVersion
¡¡[ l
)
¡¡l m
;
¡¡m n
}
¬¬ 	
private
ƒƒ 
static
ƒƒ "
DistressSignalCommit
ƒƒ +%
HandleDistressRejection
ƒƒ, C
(
ƒƒC D

MatchState
ƒƒD N

matchState
ƒƒO Y
)
ƒƒY Z
{
≈≈ 	

matchState
∆∆ 
.
∆∆  
ResetDistressState
∆∆ )
(
∆∆) *
)
∆∆* +
;
∆∆+ ,

matchState
«« 
.
«« %
HasDistressBeenRejected
«« .
=
««/ 0
true
««1 5
;
««5 6

matchState
»» 
.
»» 
MatchStateVersion
»» (
++
»»( *
;
»»* +
return
…… "
CreateAcceptedCommit
…… '
(
……' (

matchState
……( 2
,
……2 3
false
……4 9
)
……9 :
;
……: ;
}
   	
private
ÃÃ 
static
ÃÃ %
DistressSignalRejection
ÃÃ ."
ValidateDistressCard
ÃÃ/ C
(
ÃÃC D

MatchState
ÕÕ 

matchState
ÕÕ !
,
ÕÕ! "
int
ÕÕ# &
cardIdToPass
ÕÕ' 3
,
ÕÕ3 4
int
ÕÕ5 8
participantSeat
ÕÕ9 H
)
ÕÕH I
{
ŒŒ 	%
DistressSignalRejection
œœ #
	rejection
œœ$ -
=
œœ. /%
DistressSignalRejection
œœ0 G
.
œœG H
None
œœH L
;
œœL M
List
–– 
<
–– 
int
–– 
>
–– 

playerHand
––  
=
––! "

matchState
––# -
.
––- .%
PlayerHandCardIdsBySeat
––. E
[
––E F
participantSeat
––F U
]
––U V
;
––V W
if
—— 
(
—— 
cardIdToPass
—— 
<
—— 
$num
——  
||
——! #
cardIdToPass
——$ 0
>
——1 2
	DeckRules
——3 <
.
——< =
TotalDeckSize
——= J
||
——K M
!
——N O

playerHand
——O Y
.
——Y Z
Contains
——Z b
(
——b c
cardIdToPass
——c o
)
——o p
)
——p q
{
““ 
	rejection
”” 
=
”” %
DistressSignalRejection
”” 3
.
””3 4
CardNotInHand
””4 A
;
””A B
}
‘‘ 
else
’’ 
if
’’ 
(
’’ 
	DeckRules
’’ 
.
’’ 
GetCardById
’’ *
(
’’* +
cardIdToPass
’’+ 7
)
’’7 8
.
’’8 9
Suit
’’9 =
==
’’> @
CardSuit
’’A I
.
’’I J
Special
’’J Q
)
’’Q R
{
÷÷ 
	rejection
◊◊ 
=
◊◊ %
DistressSignalRejection
◊◊ 3
.
◊◊3 4#
SpecialCardNotAllowed
◊◊4 I
;
◊◊I J
}
ÿÿ 
return
ŸŸ 
	rejection
ŸŸ 
;
ŸŸ 
}
⁄⁄ 	
private
‹‹ 
static
‹‹ "
DistressSignalCommit
‹‹ +%
ExecuteDistressExchange
‹‹, C
(
‹‹C D

MatchState
›› 

matchState
›› !
,
››! "
PassDirection
››# 0
agreedDirection
››1 @
)
››@ A
{
ﬁﬁ 	#
DistressSignalContext
ﬂﬂ !
distressContext
ﬂﬂ" 1
=
ﬂﬂ2 3"
BuildDistressContext
ﬂﬂ4 H
(
ﬂﬂH I

matchState
ﬂﬂI S
,
ﬂﬂS T
agreedDirection
ﬂﬂU d
)
ﬂﬂd e
;
ﬂﬂe f"
DistressSignalCommit
‡‡  
result
‡‡! '
;
‡‡' (
if
·· 
(
·· 
!
·· !
DistressSignalRules
·· $
.
··$ %&
CanExecuteDistressSignal
··% =
(
··= >
distressContext
··> M
)
··M N
)
··N O
{
‚‚ 
result
„„ 
=
„„ 
RejectDistress
„„ '
(
„„' (%
DistressSignalRejection
„„( ?
.
„„? @
InvalidSubmission
„„@ Q
,
„„Q R

matchState
„„S ]
.
„„] ^
MatchStateVersion
„„^ o
)
„„o p
;
„„p q
}
‰‰ 
else
ÂÂ 
{
ÊÊ #
ApplyDistressExchange
ÁÁ %
(
ÁÁ% &

matchState
ÁÁ& 0
,
ÁÁ0 1
distressContext
ÁÁ2 A
)
ÁÁA B
;
ÁÁB C
result
ËË 
=
ËË "
CreateAcceptedCommit
ËË -
(
ËË- .

matchState
ËË. 8
,
ËË8 9
true
ËË: >
)
ËË> ?
;
ËË? @
}
ÈÈ 
return
ÍÍ 
result
ÍÍ 
;
ÍÍ 
}
ÎÎ 	
private
ÌÌ 
static
ÌÌ #
DistressSignalContext
ÌÌ ,"
BuildDistressContext
ÌÌ- A
(
ÌÌA B

MatchState
ÓÓ 

matchState
ÓÓ !
,
ÓÓ! "
PassDirection
ÓÓ# 0
agreedDirection
ÓÓ1 @
)
ÓÓ@ A
{
ÔÔ 	
int
 
requiredPlayers
 
=
  !

matchState
" ,
.
, - 
ParticipantUserIds
- ?
.
? @
Length
@ F
;
F G
var
ÒÒ 
hands
ÒÒ 
=
ÒÒ 
new
ÒÒ 
List
ÒÒ  
<
ÒÒ  !
IReadOnlyList
ÒÒ! .
<
ÒÒ. /
Card
ÒÒ/ 3
>
ÒÒ3 4
>
ÒÒ4 5
(
ÒÒ5 6
requiredPlayers
ÒÒ6 E
)
ÒÒE F
;
ÒÒF G
for
ÚÚ 
(
ÚÚ 
int
ÚÚ 
	seatIndex
ÚÚ 
=
ÚÚ  
$num
ÚÚ! "
;
ÚÚ" #
	seatIndex
ÚÚ$ -
<
ÚÚ. /
requiredPlayers
ÚÚ0 ?
;
ÚÚ? @
	seatIndex
ÚÚA J
++
ÚÚJ L
)
ÚÚL M
{
ÛÛ 
List
ÙÙ 
<
ÙÙ 
Card
ÙÙ 
>
ÙÙ 
seatHand
ÙÙ #
=
ÙÙ$ %

matchState
ÙÙ& 0
.
ÙÙ0 1%
PlayerHandCardIdsBySeat
ÙÙ1 H
[
ÙÙH I
	seatIndex
ÙÙI R
]
ÙÙR S
.
ıı 
Select
ıı 
(
ıı 
	DeckRules
ıı %
.
ıı% &
GetCardById
ıı& 1
)
ıı1 2
.
ˆˆ 
ToList
ˆˆ 
(
ˆˆ 
)
ˆˆ 
;
ˆˆ 
hands
˜˜ 
.
˜˜ 
Add
˜˜ 
(
˜˜ 
seatHand
˜˜ "
.
˜˜" #

AsReadOnly
˜˜# -
(
˜˜- .
)
˜˜. /
)
˜˜/ 0
;
˜˜0 1
}
¯¯ 
var
˘˘ 
selectedCards
˘˘ 
=
˘˘ 
new
˘˘  #

Dictionary
˘˘$ .
<
˘˘. /
byte
˘˘/ 3
,
˘˘3 4
Card
˘˘5 9
>
˘˘9 :
(
˘˘: ;
)
˘˘; <
;
˘˘< =
foreach
˙˙ 
(
˙˙ 
KeyValuePair
˙˙ !
<
˙˙! "
byte
˙˙" &
,
˙˙& '
int
˙˙( +
>
˙˙+ ,
entry
˙˙- 2
in
˙˙3 5

matchState
˙˙6 @
.
˙˙@ A.
 PendingDistressPassCardIdsBySeat
˙˙A a
)
˙˙a b
{
˚˚ 
selectedCards
¸¸ 
[
¸¸ 
entry
¸¸ #
.
¸¸# $
Key
¸¸$ '
]
¸¸' (
=
¸¸) *
	DeckRules
¸¸+ 4
.
¸¸4 5
GetCardById
¸¸5 @
(
¸¸@ A
entry
¸¸A F
.
¸¸F G
Value
¸¸G L
)
¸¸L M
;
¸¸M N
}
˝˝ 
return
˛˛ 
new
˛˛ #
DistressSignalContext
˛˛ ,
{
ˇˇ  
CurrentTrickNumber
ÄÄ "
=
ÄÄ# $

matchState
ÄÄ% /
.
ÄÄ/ 0 
CurrentTrickNumber
ÄÄ0 B
,
ÄÄB C
IsTrickInProgress
ÅÅ !
=
ÅÅ" #

matchState
ÅÅ$ .
.
ÅÅ. /#
CurrentTrickCardPlays
ÅÅ/ D
.
ÅÅD E
Count
ÅÅE J
>
ÅÅK L
$num
ÅÅM N
,
ÅÅN O#
HasUsedDistressSignal
ÇÇ %
=
ÇÇ& '

matchState
ÇÇ( 2
.
ÇÇ2 3
MissionAttempt
ÇÇ3 A
.
ÇÇA B#
HasUsedDistressSignal
ÇÇB W
,
ÇÇW X&
HasAnyPlayerCommunicated
ÉÉ (
=
ÉÉ) *&
HasAnyPlayerCommunicated
ÉÉ+ C
(
ÉÉC D

matchState
ÉÉD N
)
ÉÉN O
,
ÉÉO P
AgreedDirection
ÑÑ 
=
ÑÑ  !
agreedDirection
ÑÑ" 1
,
ÑÑ1 2
HandsBySeat
ÖÖ 
=
ÖÖ 
hands
ÖÖ #
.
ÖÖ# $

AsReadOnly
ÖÖ$ .
(
ÖÖ. /
)
ÖÖ/ 0
,
ÖÖ0 1$
SelectedPassCardBySeat
ÜÜ &
=
ÜÜ' (
selectedCards
ÜÜ) 6
}
áá 
;
áá 
}
àà 	
private
ää 
static
ää 
void
ää #
ApplyDistressExchange
ää 1
(
ää1 2

MatchState
ãã 

matchState
ãã !
,
ãã! "#
DistressSignalContext
ãã# 8
distressContext
ãã9 H
)
ããH I
{
åå 	
IReadOnlyList
çç 
<
çç 
IReadOnlyList
çç '
<
çç' (
Card
çç( ,
>
çç, -
>
çç- .
newHands
çç/ 7
=
çç8 9!
DistressSignalRules
éé #
.
éé# $
ExecuteCardPass
éé$ 3
(
éé3 4
distressContext
éé4 C
)
ééC D
;
ééD E
int
èè 
requiredPlayers
èè 
=
èè  !

matchState
èè" ,
.
èè, - 
ParticipantUserIds
èè- ?
.
èè? @
Length
èè@ F
;
èèF G
for
êê 
(
êê 
int
êê 
	seatIndex
êê 
=
êê  
$num
êê! "
;
êê" #
	seatIndex
êê$ -
<
êê. /
requiredPlayers
êê0 ?
;
êê? @
	seatIndex
êêA J
++
êêJ L
)
êêL M
{
ëë 

matchState
íí 
.
íí %
PlayerHandCardIdsBySeat
íí 2
[
íí2 3
	seatIndex
íí3 <
]
íí< =
=
íí> ?
newHands
íí@ H
[
ííH I
	seatIndex
ííI R
]
ííR S
.
ìì 
Select
ìì 
(
ìì 
card
ìì  
=>
ìì! #
card
ìì$ (
.
ìì( )
IdCard
ìì) /
)
ìì/ 0
.
îî 
ToList
îî 
(
îî 
)
îî 
;
îî 
}
ïï 
int
ññ "
updatedAttemptNumber
ññ $
=
ññ% &

matchState
ññ' 1
.
ññ1 27
)HasAppliedDistressPenaltyInCurrentMission
ññ2 [
?
óó 

matchState
óó 
.
óó 
MissionAttempt
óó +
.
óó+ ,
AttemptNumber
óó, 9
:
òò 

matchState
òò 
.
òò 
MissionAttempt
òò +
.
òò+ ,
AttemptNumber
òò, 9
+
òò: ;
$num
òò< =
;
òò= >

matchState
ôô 
.
ôô 7
)HasAppliedDistressPenaltyInCurrentMission
ôô @
=
ôôA B
true
ôôC G
;
ôôG H

matchState
öö 
.
öö (
CommitMissionAttemptUpdate
öö 1
(
öö1 2

matchState
öö2 <
.
öö< =
MissionAttempt
öö= K
with
ööL P
{
õõ #
HasUsedDistressSignal
úú %
=
úú& '
true
úú( ,
,
úú, -
AttemptNumber
ùù 
=
ùù "
updatedAttemptNumber
ùù  4
}
ûû 
)
ûû 
;
ûû 

matchState
üü 
.
üü  
ResetDistressState
üü )
(
üü) *
)
üü* +
;
üü+ ,

matchState
†† 
.
†† %
HasDistressBeenRejected
†† .
=
††/ 0
false
††1 6
;
††6 7
}
°° 	
private
££ 
static
££ "
DistressSignalCommit
££ +"
CreateAcceptedCommit
££, @
(
££@ A

MatchState
££A K

matchState
££L V
,
££V W
bool
££X \

isExecuted
££] g
)
££g h
{
§§ 	
return
•• 
new
•• "
DistressSignalCommit
•• +
{
¶¶ 
	Rejection
ßß 
=
ßß %
DistressSignalRejection
ßß 3
.
ßß3 4
None
ßß4 8
,
ßß8 9
HasStateChanged
®® 
=
®®  !
true
®®" &
,
®®& '

IsExecuted
©© 
=
©© 

isExecuted
©© '
,
©©' ((
CommittedMatchStateVersion
™™ *
=
™™+ ,

matchState
™™- 7
.
™™7 8
MatchStateVersion
™™8 I
}
´´ 
;
´´ 
}
¨¨ 	
private
ÆÆ 
static
ÆÆ "
DistressSignalCommit
ÆÆ +
RejectDistress
ÆÆ, :
(
ÆÆ: ;%
DistressSignalRejection
ØØ #
	rejection
ØØ$ -
,
ØØ- .
long
ØØ/ 3(
committedMatchStateVersion
ØØ4 N
)
ØØN O
{
∞∞ 	
return
±± 
new
±± "
DistressSignalCommit
±± +
{
≤≤ 
	Rejection
≥≥ 
=
≥≥ 
	rejection
≥≥ %
,
≥≥% &
HasStateChanged
¥¥ 
=
¥¥  !
false
¥¥" '
,
¥¥' (

IsExecuted
µµ 
=
µµ 
false
µµ "
,
µµ" #(
CommittedMatchStateVersion
∂∂ *
=
∂∂+ ,(
committedMatchStateVersion
∂∂- G
}
∑∑ 
;
∑∑ 
}
∏∏ 	
}
ππ 
}∫∫ ©
uC:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\Models\Match\Distress\DistressParticipantAction.cs
	namespace 	
Application
 
. 
Models 
{ 
internal 
sealed 
record %
DistressParticipantAction 4
(4 5!
DistressSignalRequest 
Request %
,% &
byte 
ParticipantSeat 
, 
int		 
ParticipantUserId		 
)		 
;		 
}

 Ù
pC:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\Models\Match\Distress\DistressSignalCommit.cs
	namespace 	
Application
 
. 
Models 
{ 
public 

sealed 
record  
DistressSignalCommit -
{ 
public 
long &
CommittedMatchStateVersion .
{/ 0
get1 4
;4 5
init6 :
;: ;
}< =
public

 
bool

 
HasStateChanged

 #
{

$ %
get

& )
;

) *
init

+ /
;

/ 0
}

1 2
public 
bool 

IsExecuted 
{  
get! $
;$ %
init& *
;* +
}, -
public #
DistressSignalRejection &
	Rejection' 0
{1 2
get3 6
;6 7
init8 <
;< =
}> ?
} 
} “
qC:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\Models\Match\Distress\DistressSignalRequest.cs
	namespace 	
Application
 
. 
Models 
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
DistressSignalRequest

 .
{ 
public 
Guid 
MatchId 
{ 
get !
;! "
init# '
;' (
}) *
public 
string 
	LobbyCode 
{  !
get" %
;% &
init' +
;+ ,
}- .
public 
int 
MissionAttemptId #
{$ %
get& )
;) *
init+ /
;/ 0
}1 2
public 
int 
CardIdToPass 
{  !
get" %
;% &
init' +
;+ ,
}- .
public 
PassDirection 
SelectedDirection .
{/ 0
get1 4
;4 5
init6 :
;: ;
}< =
public 
bool 
IsVoteAccepted "
{# $
get% (
;( )
init* .
;. /
}0 1
public $
DistressSignalActionType '

ActionType( 2
{3 4
get5 8
;8 9
init: >
;> ?
}@ A
} 
} ú
sC:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\Models\Match\Distress\DistressSignalRejection.cs
	namespace 	
Application
 
. 
Models 
{ 
public 

enum #
DistressSignalRejection '
{ 
None 
= 
$num 
, 
InvalidSubmission		 
=		 
$num		 
,		 
MatchUnavailable

 
=

 
$num

 
,

 !
ParticipantNotAllowed 
= 
$num  !
,! "
WrongMissionAttempt 
= 
$num 
,  &
MissionPreparationRequired "
=# $
$num% &
,& '"
MissionAttemptFinished 
=  
$num! "
," #
DistressAlreadyUsed 
= 
$num 
,  
TrickAlreadyStarted 
= 
$num 
,  
RadioAlreadyUsed 
= 
$num 
, 
CardNotInHand 
= 
$num 
, !
SpecialCardNotAllowed 
= 
$num  "
," #!
InvalidStepTransition 
= 
$num  "
," # 
OperationUnavailable 
= 
$num !
} 
} ∆O
mC:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\UseCases\Match\Core\MatchPlayValidation.cs
	namespace		 	
Application		
 
.		 
UseCases		 
{

 
internal 
static 
class 
MatchPlayValidation -
{ 
internal 
static  
MatchRejectionReason ,
GetRejection- 9
(9 :

MatchState: D

matchStateE O
,O P
CardPlaySubmissionQ c
cardPlaySubmissiond v
,v w
int 
participantSeat 
)  
{ 	 
MatchRejectionReason  
playRejectionReason! 4
=5 6 
MatchRejectionReason7 K
.K L
NoneL P
;P Q
if 
( 

matchState 
. 
MissionAttempt )
?) *
.* +
Phase+ 0
==1 3
MissionAttemptPhase4 G
.G H
FinishedH P
)P Q
{ 
playRejectionReason #
=$ % 
MatchRejectionReason& :
.: ;"
MissionAttemptFinished; Q
;Q R
} 
else 
if 
( 

matchState 
.  
MissionAttempt  .
?. /
./ 0
Phase0 5
!=6 8
TrickTakingMissions #
.# $
Rules$ )
.) *
Enums* /
./ 0
MissionAttemptPhase0 C
.C D
PlayingTricksD Q
)Q R
{ 
playRejectionReason #
=$ % 
MatchRejectionReason& :
.: ;&
MissionPreparationRequired; U
;U V
} 
if 
( 
playRejectionReason #
==$ & 
MatchRejectionReason' ;
.; <
None< @
)@ A
{ 
bool 
isDistressActive %
=& '
(( )

matchState) 3
.3 4
DistressStep4 @
!=A C
TrickTakingMissions '
.' (
Rules( -
.- .
Enums. 3
.3 4
DistressSignalStep4 F
.F G
NoneG K
&&L N

matchState 
. 
DistressStep +
!=, .
TrickTakingMissions   '
.  ' (
Rules  ( -
.  - .
Enums  . 3
.  3 4
DistressSignalStep  4 F
.  F G
	Completed  G P
)  P Q
||  R T

matchState!! 
.!! ,
 PendingDistressPassCardIdsBySeat!! ?
.!!? @
Count!!@ E
>!!F G
$num!!H I
;!!I J
if"" 
("" 
isDistressActive"" $
)""$ %
{## 
playRejectionReason$$ '
=$$( ) 
MatchRejectionReason$$* >
.$$> ?
InvalidSubmission$$? P
;$$P Q
}%% 
else&& 
{'' 
playRejectionReason(( '
=((( )"
GetActivePlayRejection((* @
(((@ A

matchState((A K
,((K L
cardPlaySubmission((M _
,((_ `
participantSeat((a p
)((p q
;((q r
})) 
}** 
return++ 
playRejectionReason++ &
;++& '
},, 	
private.. 
static..  
MatchRejectionReason.. +"
GetActivePlayRejection.., B
(..B C

MatchState..C M

matchState..N X
,..X Y
CardPlaySubmission// 
cardPlaySubmission// 1
,//1 2
int//3 6
participantSeat//7 F
)//F G
{00 	 
MatchRejectionReason11  
playRejectionReason11! 4
=115 6 
MatchRejectionReason117 K
.11K L
None11L P
;11P Q
if22 
(22 

matchState22 
.22 
IsDealCompleted22 *
)22* +
{33 
playRejectionReason44 #
=44$ % 
MatchRejectionReason44& :
.44: ;
DealCompleted44; H
;44H I
}55 
else66 
if66 
(66 
cardPlaySubmission66 '
.66' (%
ExpectedMatchStateVersion66( A
!=66B D

matchState66E O
.66O P
MatchStateVersion66P a
)66a b
{77 
playRejectionReason88 #
=88$ % 
MatchRejectionReason88& :
.88: ;
StaleMatchState88; J
;88J K
}99 
else:: 
{;; 
playRejectionReason<< #
=<<$ %#
GetTurnAndHandRejection<<& =
(<<= >

matchState<<> H
,<<H I
cardPlaySubmission<<J \
,<<\ ]
participantSeat<<^ m
)<<m n
;<<n o
}== 
return>> 
playRejectionReason>> &
;>>& '
}?? 	
privateAA 
staticAA  
MatchRejectionReasonAA +#
GetTurnAndHandRejectionAA, C
(AAC D

MatchStateAAD N

matchStateAAO Y
,AAY Z
CardPlaySubmissionBB 
cardPlaySubmissionBB 1
,BB1 2
intBB3 6
participantSeatBB7 F
)BBF G
{CC 	 
MatchRejectionReasonDD  
playRejectionReasonDD! 4
=DD5 6 
MatchRejectionReasonDD7 K
.DDK L
NoneDDL P
;DDP Q
ifEE 
(EE 
participantSeatEE 
!=EE  "

matchStateEE# -
.EE- .!
CurrentTurnPlayerSeatEE. C
)EEC D
{FF 
playRejectionReasonGG #
=GG$ % 
MatchRejectionReasonGG& :
.GG: ;
NotPlayerTurnGG; H
;GGH I
}HH 
elseII 
ifII 
(II 
cardPlaySubmissionII '
.II' (
CardIdII( .
<II/ 0
$numII1 2
||II3 5
cardPlaySubmissionII6 H
.IIH I
CardIdIII O
>IIP Q
	DeckRulesIIR [
.II[ \
TotalDeckSizeII\ i
||IIj l
!JJ 

matchStateJJ 
.JJ #
PlayerHandCardIdsBySeatJJ 3
[JJ3 4
participantSeatJJ4 C
]JJC D
.JJD E
ContainsJJE M
(JJM N
cardPlaySubmissionJJN `
.JJ` a
CardIdJJa g
)JJg h
)JJh i
{KK 
playRejectionReasonLL #
=LL$ % 
MatchRejectionReasonLL& :
.LL: ;
CardNotInHandLL; H
;LLH I
}MM 
elseNN 
{OO 
playRejectionReasonPP #
=PP$ %
GetRuleRejectionPP& 6
(PP6 7

matchStatePP7 A
,PPA B
cardPlaySubmissionPPC U
.PPU V
CardIdPPV \
,PP\ ]
participantSeatPP^ m
)PPm n
;PPn o
}QQ 
returnRR 
playRejectionReasonRR &
;RR& '
}SS 	
privateUU 
staticUU  
MatchRejectionReasonUU +
GetRuleRejectionUU, <
(UU< =

MatchStateUU= G

matchStateUUH R
,UUR S
intUUT W
candidateCardIdUUX g
,UUg h
intVV 
participantSeatVV 
)VV  
{WW 	
TrickPlayContextXX 
playContextXX (
=XX) *
newXX+ .
TrickPlayContextXX/ ?
{YY 

PlayerSeatZZ 
=ZZ 
(ZZ 
byteZZ "
)ZZ" #
participantSeatZZ# 2
,ZZ2 3
CurrentTurnSeat[[ 
=[[  !
([[" #
byte[[# '
)[[' (

matchState[[( 2
.[[2 3!
CurrentTurnPlayerSeat[[3 H
,[[H I
PlayerCount\\ 
=\\ 

matchState\\ (
.\\( )
ParticipantUserIds\\) ;
.\\; <
Length\\< B
,\\B C

PlayerHand]] 
=]] 

matchState]] '
.]]' (#
PlayerHandCardIdsBySeat]]( ?
[]]? @
participantSeat]]@ O
]]]O P
.^^ 
Select^^ 
(^^ 
	DeckRules^^ %
.^^% &
GetCardById^^& 1
)^^1 2
.^^2 3
ToArray^^3 :
(^^: ;
)^^; <
,^^< =
CandidateCard__ 
=__ 
	DeckRules__  )
.__) *
GetCardById__* 5
(__5 6
candidateCardId__6 E
)__E F
,__F G#
CurrentTrickPlayedCards`` '
=``( )

matchState``* 4
.``4 5!
CurrentTrickCardPlays``5 J
.``J K
Select``K Q
(``Q R
(``R S
play``S W
,``W X
	playOrder``Y b
)``b c
=>``d f
new``g j
TrickCardPlay``k x
{aa 
	PlayOrderbb 
=bb 
(bb  !
bytebb! %
)bb% &
	playOrderbb& /
,bb/ 0
Seatcc 
=cc 
(cc 
bytecc  
)cc  !
Arraycc! &
.cc& '
IndexOfcc' .
(cc. /

matchStatecc/ 9
.cc9 :
ParticipantUserIdscc: L
,ccL M
playccN R
.ccR S
PlayerUserIdccS _
)cc_ `
,cc` a
Carddd 
=dd 
	DeckRulesdd $
.dd$ %
GetCardByIddd% 0
(dd0 1
playdd1 5
.dd5 6
CardIddd6 <
)dd< =
}ee 
)ee 
.ee 
ToArrayee 
(ee 
)ee 
}ff 
;ff %
TrickPlayValidationResultgg %

validationgg& 0
=gg1 2 
TrickFollowSuitRulesgg3 G
.ggG H
ValidatePlayggH T
(ggT U
playContextggU `
)gg` a
;gga b
returnhh 

validationhh 
.hh 
IsLegalhh %
?hh& ' 
MatchRejectionReasonhh( <
.hh< =
Nonehh= A
:hhB C 
MatchRejectionReasonhhD X
.hhX Y
MustFollowLeadSuithhY k
;hhk l
}ii 	
}jj 
}kk ˘î
qC:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\UseCases\Match\Core\MatchSnapshotProjection.cs
	namespace 	
Application
 
. 
UseCases 
{ 
internal		 
static		 
partial		 
class		 !#
MatchSnapshotProjection		" 9
{

 
internal 
static 
PlayerMatchSnapshot +
CreateSnapshot, :
(: ;

MatchState; E

matchStateF P
,P Q
intR U
participantSeatV e
,e f
long '
serverTimestampMilliseconds ,
), -
{ 	%
MissionTransitionSnapshot %

transition& 0
=1 2#
CreateMissionTransition3 J
(J K

matchStateK U
,U V'
serverTimestampMillisecondsW r
)r s
;s t
return 
new 
PlayerMatchSnapshot *
{ 
MatchId 
= 

matchState $
.$ %
MatchId% ,
,, -
MatchStateVersion !
=" #

matchState$ .
.. /
MatchStateVersion/ @
,@ A
OwnHandCardIds 
=  

matchState! +
.+ ,#
PlayerHandCardIdsBySeat, C
[C D
participantSeatD S
]S T
.T U
ToArrayU \
(\ ]
)] ^
,^ _
ParticipantUserIds "
=# $
(% &
int& )
[) *
]* +
)+ ,

matchState, 6
.6 7
ParticipantUserIds7 I
.I J
CloneJ O
(O P
)P Q
,Q R#
RemainingHandCardCounts '
=( )

matchState* 4
.4 5#
PlayerHandCardIdsBySeat5 L
.L M
SelectM S
(S T
handT X
=>Y [
hand\ `
.` a
Counta f
)f g
.g h
ToArrayh o
(o p
)p q
,q r#
CurrentTurnPlayerUserId '
=( )

matchState* 4
.4 5
ParticipantUserIds5 G
[G H

matchStateH R
.R S!
CurrentTurnPlayerSeatS h
]h i
,i j 
MissionCaptainUserId $
=% &

matchState' 1
.1 2
ParticipantUserIds2 D
[D E

matchStateE O
.O P
MissionCaptainSeatP b
]b c
,c d
CurrentTrickNumber "
=# $

matchState% /
./ 0
CurrentTrickNumber0 B
,B C$
MaximumMissionTrickCount (
=) *

matchState+ 5
.5 6$
MaximumMissionTrickCount6 N
,N O
IsDealCompleted 
=  !

matchState" ,
., -
IsDealCompleted- <
,< =!
CurrentTrickCardPlays %
=& '

matchState( 2
.2 3!
CurrentTrickCardPlays3 H
.H I
SelectI O
(O P
	ClonePlayP Y
)Y Z
.Z [
ToArray[ b
(b c
)c d
,d e'
LastCompletedTrickCardPlays +
=, -

matchState. 8
.8 9'
LastCompletedTrickCardPlays9 T
.T U
SelectU [
([ \
	ClonePlay\ e
)e f
.f g
ToArrayg n
(n o
)o p
,p q!
LastTrickWinnerUserId %
=& '

matchState( 2
.2 3!
LastTrickWinnerUserId3 H
,H I!
CapturedCardsByPlayer %
=& '(
CreateCapturedCardsSnapshots( D
(D E

matchStateE O
)O P
,P Q
MissionTransition !
=" #

transition$ .
,. /
RadioCommunications   #
=  $ %%
CreateRadioCommunications  & ?
(  ? @

matchState  @ J
)  J K
,  K L
	RadioMode!! 
=!! 
GetRadioMode!! (
(!!( )

matchState!!) 3
)!!3 4
,!!4 5 
OwnRadioAvailability"" $
=""% &#
CreateRadioAvailability""' >
(""> ?

matchState""? I
,""I J
participantSeat""K Z
)""Z [
,""[ \$
MissionConditionProgress## (
=##) *
new##+ .,
 MissionConditionProgressSnapshot##/ O
{$$ '
TricksWonWithNormalOneCount%% /
=%%0 1

matchState%%2 <
.%%< =
TrickStatistics%%= L
.%%L M'
TricksWonWithNormalOneCount%%M h
,%%h i!
SpecialWinningCardIds&& )
=&&* +

matchState&&, 6
.&&6 7
TrickStatistics&&7 F
.&&F G!
SpecialWinningCardIds&&G \
.&&\ ]
ToArray&&] d
(&&d e
)&&e f
,&&f g"
CapturedHeartCardCount'' *
=''+ ,
MatchUseCase''- 9
.''9 :
CountCapturedHearts'': M
(''M N

matchState''N X
)''X Y
}(( 
,(( 
MissionRetry)) 
=)) 
CreateMissionRetry)) 1
())1 2

transition))2 <
)))< =
,))= >
MissionEvaluation** !
=**" ##
CreateMissionEvaluation**$ ;
(**; <

matchState**< F
)**F G
,**G H
MissionPreparation++ "
=++# $$
CreateMissionPreparation++% =
(++= >

matchState++> H
,++H I
participantSeat++J Y
)++Y Z
,++Z [
DistressSignal,, 
=,,  (
CreateDistressSignalSnapshot,,! =
(,,= >

matchState,,> H
),,H I
}-- 
;-- 
}.. 	
internal00 
static00 
MatchCardPlay00 %
	ClonePlay00& /
(00/ 0
MatchCardPlay000 =
confirmedPlay00> K
)00K L
{11 	
return22 
new22 
MatchCardPlay22 $
{22% &
PlayerUserId22' 3
=224 5
confirmedPlay226 C
.22C D
PlayerUserId22D P
,22P Q
CardId22R X
=22Y Z
confirmedPlay22[ h
.22h i
CardId22i o
}22p q
;22q r
}33 	
internal55 
static55 
CardPlayDecision55 (
CloneDecision55) 6
(556 7
CardPlayDecision557 G
playDecision55H T
)55T U
{66 	
return77 
new77 
CardPlayDecision77 '
{88  
CardPlaySubmissionId99 $
=99% &
playDecision99' 3
.993 4 
CardPlaySubmissionId994 H
,99H I

IsAccepted:: 
=:: 
playDecision:: )
.::) *

IsAccepted::* 4
,::4 5
RejectionReason;; 
=;;  !
playDecision;;" .
.;;. /
RejectionReason;;/ >
,;;> ?&
CommittedMatchStateVersion<< *
=<<+ ,
playDecision<<- 9
.<<9 :&
CommittedMatchStateVersion<<: T
}== 
;== 
}>> 	
private@@ 
static@@ '
PlayerCapturedCardsSnapshot@@ 2
[@@2 3
]@@3 4(
CreateCapturedCardsSnapshots@@5 Q
(@@Q R

MatchState@@R \

matchState@@] g
)@@g h
{AA 	
returnBB 

matchStateBB 
.BB 
ParticipantUserIdsBB 0
.BB0 1
SelectBB1 7
(BB7 8
(BB8 9
participantUserIdBB9 J
,BBJ K
participantSeatBBL [
)BB[ \
=>BB] _
newCC '
PlayerCapturedCardsSnapshotCC /
{DD 
PlayerUserIdEE  
=EE! "
participantUserIdEE# 4
,EE4 5
WonTrickCountFF !
=FF" #

matchStateFF$ .
.FF. / 
WonTrickCountsBySeatFF/ C
[FFC D
participantSeatFFD S
]FFS T
,FFT U

WonCardIdsGG 
=GG  

matchStateGG! +
.GG+ ,
WonCardIdsBySeatGG, <
[GG< =
participantSeatGG= L
]GGL M
.GGM N
ToArrayGGN U
(GGU V
)GGV W
}HH 
)HH 
.HH 
ToArrayHH 
(HH 
)HH 
;HH 
}II 	
privateKK 
staticKK "
DistressSignalSnapshotKK -(
CreateDistressSignalSnapshotKK. J
(KKJ K

MatchStateKKK U

matchStateKKV `
)KK` a
{LL 	
boolMM 
hasUsedMM 
=MM 

matchStateMM %
.MM% &
MissionAttemptMM& 4
?MM4 5
.MM5 6!
HasUsedDistressSignalMM6 K
??MML N
falseMMO T
;MMT U
boolNN 
isInProgressNN 
=NN 

matchStateNN  *
.NN* +
DistressStepNN+ 7
!=NN8 :
TrickTakingMissionsOO #
.OO# $
RulesOO$ )
.OO) *
EnumsOO* /
.OO/ 0
DistressSignalStepOO0 B
.OOB C
NoneOOC G
&&OOH J

matchStatePP 
.PP 
DistressStepPP '
!=PP( *
TrickTakingMissionsQQ #
.QQ# $
RulesQQ$ )
.QQ) *
EnumsQQ* /
.QQ/ 0
DistressSignalStepQQ0 B
.QQB C
	CompletedQQC L
&&QQM O
!QQP Q
hasUsedQQQ X
;QQX Y
TrickTakingMissionsSS 
.SS  
RulesSS  %
.SS% &
EnumsSS& +
.SS+ ,
PassDirectionSS, 9
agreedDirectionSS: I
=SSJ K

matchStateTT 
.TT #
DistressAgreedDirectionTT 2
??TT3 5

matchStateUU 
.UU +
PendingDistressDirectionsBySeatUU :
.UU: ;
ValuesUU; A
.UUA B
FirstOrDefaultUUB P
(UUP Q
)UUQ R
;UUR S
intWW 
[WW 
]WW  
submittedCardUserIdsWW &
=WW' (

matchStateWW) 3
.WW3 4,
 PendingDistressPassCardIdsBySeatWW4 T
.WWT U
KeysWWU Y
.XX 
WhereXX 
(XX 
seatXX 
=>XX 
seatXX #
<XX$ %

matchStateXX& 0
.XX0 1
ParticipantUserIdsXX1 C
.XXC D
LengthXXD J
)XXJ K
.YY 
SelectYY 
(YY 
seatYY 
=>YY 

matchStateYY  *
.YY* +
ParticipantUserIdsYY+ =
[YY= >
seatYY> B
]YYB C
)YYC D
.ZZ 
ToArrayZZ 
(ZZ 
)ZZ 
;ZZ 
int\\ 
[\\ 
]\\ 
votedYesUserIds\\ !
=\\" #

matchState\\$ .
.\\. /'
DistressUsageYesVotesBySeat\\/ J
.]] 
Where]] 
(]] 
seat]] 
=>]] 
seat]] #
<]]$ %

matchState]]& 0
.]]0 1
ParticipantUserIds]]1 C
.]]C D
Length]]D J
)]]J K
.^^ 
Select^^ 
(^^ 
seat^^ 
=>^^ 

matchState^^  *
.^^* +
ParticipantUserIds^^+ =
[^^= >
seat^^> B
]^^B C
)^^C D
.__ 
ToArray__ 
(__ 
)__ 
;__ 
intaa 
[aa 
]aa !
directionVotedUserIdsaa '
=aa( )

matchStateaa* 4
.aa4 5(
DistressDirectionVotesBySeataa5 Q
.aaQ R
KeysaaR V
.bb 
Wherebb 
(bb 
seatbb 
=>bb 
seatbb #
<bb$ %

matchStatebb& 0
.bb0 1
ParticipantUserIdsbb1 C
.bbC D
LengthbbD J
)bbJ K
.cc 
Selectcc 
(cc 
seatcc 
=>cc 

matchStatecc  *
.cc* +
ParticipantUserIdscc+ =
[cc= >
seatcc> B
]ccB C
)ccC D
.dd 
ToArraydd 
(dd 
)dd 
;dd 
intff 
	leftVotesff 
=ff 

matchStateff &
.ff& '(
DistressDirectionVotesBySeatff' C
.ffC D
ValuesffD J
.gg 
Countgg 
(gg 
	directiongg  
=>gg! #
	directiongg$ -
==gg. 0
TrickTakingMissionsgg1 D
.ggD E
RulesggE J
.ggJ K
EnumsggK P
.ggP Q
PassDirectionggQ ^
.gg^ _
Leftgg_ c
)ggc d
;ggd e
inthh 

rightVoteshh 
=hh 

matchStatehh '
.hh' ((
DistressDirectionVotesBySeathh( D
.hhD E
ValueshhE K
.ii 
Countii 
(ii 
	directionii  
=>ii! #
	directionii$ -
==ii. 0
TrickTakingMissionsii1 D
.iiD E
RulesiiE J
.iiJ K
EnumsiiK P
.iiP Q
PassDirectioniiQ ^
.ii^ _
Rightii_ d
)iid e
;iie f
returnkk 
newkk "
DistressSignalSnapshotkk -
{ll !
HasUsedDistressSignalmm %
=mm& '
hasUsedmm( /
,mm/ 0
IsInProgressnn 
=nn 
isInProgressnn +
,nn+ ,
AgreedDirectionoo 
=oo  !$
MapDistressPassDirectionoo" :
(oo: ;
agreedDirectionoo; J
)ooJ K
,ooK L'
SubmittedParticipantUserIdspp +
=pp, - 
submittedCardUserIdspp. B
,ppB C
InitiatorUserIdqq 
=qq  !

matchStateqq" ,
.qq, -#
DistressInitiatorUserIdqq- D
??qqE G
$numqqH I
,qqI J
HasBeenRejectedrr 
=rr  !

matchStaterr" ,
.rr, -#
HasDistressBeenRejectedrr- D
,rrD E
CurrentStepss 
=ss "
MapDistressSignalPhasess 4
(ss4 5

matchStatess5 ?
.ss? @
DistressStepss@ L
)ssL M
,ssM N
VotedYesUserIdstt 
=tt  !
votedYesUserIdstt" 1
,tt1 2!
DirectionVotedUserIdsuu %
=uu& '!
directionVotedUserIdsuu( =
,uu= >#
LeftDirectionVotesCountvv '
=vv( )
	leftVotesvv* 3
,vv3 4$
RightDirectionVotesCountww (
=ww) *

rightVotesww+ 5
}xx 
;xx 
}yy 	
private{{ 
static{{ !
DistressPassDirection{{ ,$
MapDistressPassDirection{{- E
({{E F
TrickTakingMissions|| 
.||  
Rules||  %
.||% &
Enums||& +
.||+ ,
PassDirection||, 9
	direction||: C
)||C D
{}} 	!
DistressPassDirection~~ !
mappedDirection~~" 1
=~~2 3!
DistressPassDirection~~4 I
.~~I J
None~~J N
;~~N O
if 
( 
	direction 
== 
TrickTakingMissions 0
.0 1
Rules1 6
.6 7
Enums7 <
.< =
PassDirection= J
.J K
LeftK O
)O P
{
ÄÄ 
mappedDirection
ÅÅ 
=
ÅÅ  !#
DistressPassDirection
ÅÅ" 7
.
ÅÅ7 8
Left
ÅÅ8 <
;
ÅÅ< =
}
ÇÇ 
else
ÉÉ 
if
ÉÉ 
(
ÉÉ 
	direction
ÉÉ 
==
ÉÉ !!
TrickTakingMissions
ÉÉ" 5
.
ÉÉ5 6
Rules
ÉÉ6 ;
.
ÉÉ; <
Enums
ÉÉ< A
.
ÉÉA B
PassDirection
ÉÉB O
.
ÉÉO P
Right
ÉÉP U
)
ÉÉU V
{
ÑÑ 
mappedDirection
ÖÖ 
=
ÖÖ  !#
DistressPassDirection
ÖÖ" 7
.
ÖÖ7 8
Right
ÖÖ8 =
;
ÖÖ= >
}
ÜÜ 
return
áá 
mappedDirection
áá "
;
áá" #
}
àà 	
private
ää 
static
ää !
DistressSignalPhase
ää *$
MapDistressSignalPhase
ää+ A
(
ääA B!
TrickTakingMissions
ãã 
.
ãã  
Rules
ãã  %
.
ãã% &
Enums
ãã& +
.
ãã+ , 
DistressSignalStep
ãã, >
step
ãã? C
)
ããC D
{
åå 	!
DistressSignalPhase
çç 
mappedPhase
çç  +
;
çç+ ,
switch
éé 
(
éé 
step
éé 
)
éé 
{
èè 
case
êê !
TrickTakingMissions
êê (
.
êê( )
Rules
êê) .
.
êê. /
Enums
êê/ 4
.
êê4 5 
DistressSignalStep
êê5 G
.
êêG H
VotingToUse
êêH S
:
êêS T
mappedPhase
ëë 
=
ëë  !!
DistressSignalPhase
ëë" 5
.
ëë5 6
VotingToUse
ëë6 A
;
ëëA B
break
íí 
;
íí 
case
ìì !
TrickTakingMissions
ìì (
.
ìì( )
Rules
ìì) .
.
ìì. /
Enums
ìì/ 4
.
ìì4 5 
DistressSignalStep
ìì5 G
.
ììG H
VotingDirection
ììH W
:
ììW X
mappedPhase
îî 
=
îî  !!
DistressSignalPhase
îî" 5
.
îî5 6
VotingDirection
îî6 E
;
îîE F
break
ïï 
;
ïï 
case
ññ !
TrickTakingMissions
ññ (
.
ññ( )
Rules
ññ) .
.
ññ. /
Enums
ññ/ 4
.
ññ4 5 
DistressSignalStep
ññ5 G
.
ññG H
SelectingCard
ññH U
:
ññU V
mappedPhase
óó 
=
óó  !!
DistressSignalPhase
óó" 5
.
óó5 6
SelectingCard
óó6 C
;
óóC D
break
òò 
;
òò 
case
ôô !
TrickTakingMissions
ôô (
.
ôô( )
Rules
ôô) .
.
ôô. /
Enums
ôô/ 4
.
ôô4 5 
DistressSignalStep
ôô5 G
.
ôôG H
	Completed
ôôH Q
:
ôôQ R
mappedPhase
öö 
=
öö  !!
DistressSignalPhase
öö" 5
.
öö5 6
	Completed
öö6 ?
;
öö? @
break
õõ 
;
õõ 
case
úú !
TrickTakingMissions
úú (
.
úú( )
Rules
úú) .
.
úú. /
Enums
úú/ 4
.
úú4 5 
DistressSignalStep
úú5 G
.
úúG H
None
úúH L
:
úúL M
default
ùù 
:
ùù 
mappedPhase
ûû 
=
ûû  !!
DistressSignalPhase
ûû" 5
.
ûû5 6
None
ûû6 :
;
ûû: ;
break
üü 
;
üü 
}
†† 
return
°° 
mappedPhase
°° 
;
°° 
}
¢¢ 	
}
££ 
}§§ ˚
kC:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\Models\Match\Tricks\ProcessedCardPlay.cs
	namespace 	
Application
 
. 
Models 
{ 
public 

sealed 
class 
ProcessedCardPlay )
{ 
public 
int 
ParticipantUserId $
{% &
get' *
;* +
set, /
;/ 0
}1 2
public		 
int		 
MissionAttemptId		 #
{		$ %
get		& )
;		) *
set		+ .
;		. /
}		0 1
public 
int 
CardId 
{ 
get 
;  
set! $
;$ %
}& '
public 
long %
ExpectedMatchStateVersion -
{. /
get0 3
;3 4
set5 8
;8 9
}: ;
public 
CardPlayDecision 
Decision  (
{) *
get+ .
;. /
set0 3
;3 4
}5 6
} 
} â	
bC:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\Ports\Match\IMatchStateStore.cs
	namespace 	
Application
 
. 
Ports 
{ 
public 

	interface 
IMatchStateStore %
{ 

MatchState		 
GetOrCreateMatch		 #
(		# $
string		$ *
	lobbyCode		+ 4
,		4 5
Func		6 :
<		: ;

MatchState		; E
>		E F
createMatch		G R
)		R S
;		S T

MatchState

 
	FindMatch

 
(

 
string

 #
	lobbyCode

$ -
)

- .
;

. /
System 
. 
Collections 
. 
Generic "
." #
IReadOnlyList# 0
<0 1
System1 7
.7 8
Collections8 C
.C D
GenericD K
.K L
KeyValuePairL X
<X Y
stringY _
,_ `

MatchStatea k
>k l
>l m

GetMatches 
( 
) 
; 
} 
} Ü
dC:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\Ports\Match\IMissionDeckDealer.cs
	namespace 	
Application
 
. 
Ports 
{ 
public 

	interface 
IMissionDeckDealer '
{ 
MissionDeal 
CreateMissionDeal %
(% &
int& )
participantCount* :
): ;
;; <
System		 
.		 
Collections		 
.		 
Generic		 "
.		" #
IReadOnlyList		# 0
<		0 1
TrickTakingMissions		1 D
.		D E
Rules		E J
.		J K
Models		K Q
.		Q R
MissionObjective		R b
>		b c#
CreateMissionObjectives

 #
(

# $
TrickTakingMissions

$ 7
.

7 8
Rules

8 =
.

= >
Models

> D
.

D E
MissionDefinition

E V

definition

W a
)

a b
;

b c
} 
} Ïﬂ
fC:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\UseCases\Match\Core\MatchUseCase.cs
	namespace 	
Application
 
. 
UseCases 
{ 
public 

sealed 
partial 
class 
MatchUseCase  ,
:- .
IMatchUseCase/ <
{ 
private 
const 
int '
MaximumProcessedSubmissions 5
=6 7
$num8 <
;< =
private 
const 
string (
MatchIdentityConflictMessage 9
=: ;
$str< S
;S T
private 
const 
string  
MatchStartedTemplate 1
=2 3
$str a
;a b
private 
const 
string )
MatchIdentityConflictTemplate :
=; <
$str c
;c d
private 
const 
string 2
&MatchSubmissionCapacityReachedTemplate C
=D E
$str S
;S T
private 
readonly 
IMatchStateStore )
_matchStateStore* :
;: ;
private 
readonly 
IMissionDeckDealer +
_missionDeckDealer, >
;> ?
private 
readonly 
ILoggerService '
_logger( /
;/ 0
private 
readonly 
IMatchClock $
_matchClock% 0
;0 1
private   
readonly   %
IMatchParticipantPresence   2 
_participantPresence  3 G
;  G H
public"" 
MatchUseCase"" 
("" 
IMatchStateStore"" ,
matchStateStore""- <
,""< =
IMissionDeckDealer""> P
missionDeckDealer""Q b
,""b c&
MatchExecutionDependencies## &!
executionDependencies##' <
)##< =
{$$ 	
_matchStateStore%% 
=%% 
matchStateStore%% .
??%%/ 1
throw%%2 7
new%%8 ;!
ArgumentNullException%%< Q
(%%Q R
nameof%%R X
(%%X Y
matchStateStore%%Y h
)%%h i
)%%i j
;%%j k
_missionDeckDealer&& 
=&&  
missionDeckDealer&&! 2
??&&3 5
throw&&6 ;
new&&< ?!
ArgumentNullException&&@ U
(&&U V
nameof&&V \
(&&\ ]
missionDeckDealer&&] n
)&&n o
)&&o p
;&&p q
if'' 
('' !
executionDependencies'' %
==''& (
null'') -
)''- .
{(( 
throw)) 
new)) !
ArgumentNullException)) /
())/ 0
nameof))0 6
())6 7!
executionDependencies))7 L
)))L M
)))M N
;))N O
}** 
_logger++ 
=++ !
executionDependencies++ +
.+++ ,
Logger++, 2
??++3 5
throw,, 
new,, !
ArgumentNullException,, /
(,,/ 0
nameof,,0 6
(,,6 7!
executionDependencies,,7 L
.,,L M
Logger,,M S
),,S T
),,T U
;,,U V
_matchClock-- 
=-- !
executionDependencies-- /
.--/ 0

MatchClock--0 :
??--; =
throw.. 
new.. !
ArgumentNullException.. /
(../ 0
nameof..0 6
(..6 7!
executionDependencies..7 L
...L M

MatchClock..M W
)..W X
)..X Y
;..Y Z 
_participantPresence//  
=//! "!
executionDependencies//# 8
.//8 9
ParticipantPresence//9 L
??//M O
throw00 
new00 !
ArgumentNullException00 /
(00/ 0
nameof000 6
(006 7!
executionDependencies007 L
.00L M
ParticipantPresence00M `
)00` a
)00a b
;00b c
}11 	
public33 
Guid33 

StartMatch33 
(33 
MatchStartContext33 0
startContext331 =
)33= >
{44 	
ValidateMatchStart55 
(55 
startContext55 +
)55+ ,
;55, -
int66 
[66 
]66 
participantUserIds66 $
=66% &
startContext66' 3
.663 4
ParticipantUserIds664 F
;66F G

MatchState77 

matchState77 !
=77" #
_matchStateStore77$ 4
.774 5
GetOrCreateMatch775 E
(77E F
startContext77F R
.77R S
	LobbyCode77S \
,77\ ]
(88 
)88 
=>88 
CreateMatchState88 &
(88& '
startContext88' 3
)883 4
)884 5
;885 6
if99 
(99 

matchState99 
.99 
LobbyInstanceId99 *
!=99+ -
startContext99. :
.99: ;
LobbyInstanceId99; J
||99K M

matchState:: 
.:: 
TargetMissionCount:: -
!=::. 0
startContext::1 =
.::= >
TargetMissionCount::> P
||::Q S
!;; 

matchState;; 
.;; 
ParticipantUserIds;; .
.;;. /
SequenceEqual;;/ <
(;;< =
participantUserIds;;= O
);;O P
);;P Q
{<< 
_logger== 
.== 
Warning== 
(==  )
MatchIdentityConflictTemplate==  =
,=== >
startContext==? K
.==K L
	LobbyCode==L U
,==U V
startContext==W c
.==c d
LobbyInstanceId==d s
)==s t
;==t u
throw>> 
new>> %
InvalidOperationException>> 3
(>>3 4(
MatchIdentityConflictMessage>>4 P
)>>P Q
;>>Q R
}?? 
_loggerAA 
.AA 
InformationAA 
(AA   
MatchStartedTemplateAA  4
,AA4 5

matchStateAA6 @
.AA@ A
MatchIdAAA H
,AAH I
startContextAAJ V
.AAV W
	LobbyCodeAAW `
,AA` a
participantUserIdsBB "
.BB" #
LengthBB# )
)BB) *
;BB* +
returnCC 

matchStateCC 
.CC 
MatchIdCC %
;CC% &
}DD 	
privateFF 
staticFF 
voidFF 
ValidateMatchStartFF .
(FF. /
MatchStartContextFF/ @
startContextFFA M
)FFM N
{GG 	
ifHH 
(HH 
startContextHH 
==HH 
nullHH  $
||HH% '
stringHH( .
.HH. /
IsNullOrWhiteSpaceHH/ A
(HHA B
startContextHHB N
.HHN O
	LobbyCodeHHO X
)HHX Y
||HHZ \
startContextII 
.II 
TargetMissionCountII /
<II0 1#
MissionProgressionRulesII2 I
.III J 
MinimumMissionNumberIIJ ^
||II_ a
startContextJJ 
.JJ 
TargetMissionCountJJ /
>JJ0 1#
MissionProgressionRulesJJ2 I
.JJI J 
MaximumMissionNumberJJJ ^
)JJ^ _
{KK 
throwLL 
newLL 
ArgumentExceptionLL +
(LL+ ,
nameofLL, 2
(LL2 3
startContextLL3 ?
)LL? @
)LL@ A
;LLA B
}MM %
ValidateMatchParticipantsNN %
(NN% &
startContextNN& 2
.NN2 3
ParticipantUserIdsNN3 E
)NNE F
;NNF G
}OO 	
privateQQ 
staticQQ 
voidQQ %
ValidateMatchParticipantsQQ 5
(QQ5 6
intQQ6 9
[QQ9 :
]QQ: ;
participantUserIdsQQ< N
)QQN O
{RR 	
ifSS 
(SS 
participantUserIdsSS "
==SS# %
nullSS& *
||SS+ -
participantUserIdsTT "
.TT" #
LengthTT# )
<TT* +
LobbyRoomRulesTT, :
.TT: ;
MinimumPlayerLimitTT; M
||TTN P
participantUserIdsUU "
.UU" #
LengthUU# )
>UU* +
LobbyRoomRulesUU, :
.UU: ;
MaximumPlayerLimitUU; M
||UUN P
participantUserIdsVV "
.VV" #
AnyVV# &
(VV& '
participantIdVV' 4
=>VV5 7
participantIdVV8 E
==VVF H
$numVVI J
)VVJ K
||VVL N
participantUserIdsWW "
.WW" #
DistinctWW# +
(WW+ ,
)WW, -
.WW- .
CountWW. 3
(WW3 4
)WW4 5
!=WW6 8
participantUserIdsWW9 K
.WWK L
LengthWWL R
)WWR S
{XX 
throwYY 
newYY 
ArgumentExceptionYY +
(YY+ ,
nameofYY, 2
(YY2 3
participantUserIdsYY3 E
)YYE F
)YYF G
;YYG H
}ZZ 
}[[ 	
public]] 
PlayerMatchSnapshot]] "
GetPlayerMatch]]# 1
(]]1 2
string]]2 8
	lobbyCode]]9 B
,]]B C
int]]D G
participantUserId]]H Y
)]]Y Z
{^^ 	
PlayerMatchSnapshot__ 
playerSnapshot__  .
=__/ 0
null__1 5
;__5 6

MatchState`` 

matchState`` !
=``" #
_matchStateStore``$ 4
.``4 5
	FindMatch``5 >
(``> ?
	lobbyCode``? H
)``H I
;``I J
ifaa 
(aa 

matchStateaa 
!=aa 
nullaa "
)aa" #
{bb 
lockcc 
(cc 

matchStatecc  
)cc  !
{dd 
intee 
participantSeatee '
=ee( )
Arrayee* /
.ee/ 0
IndexOfee0 7
(ee7 8

matchStateee8 B
.eeB C
ParticipantUserIdseeC U
,eeU V
participantUserIdeeW h
)eeh i
;eei j
ifff 
(ff 
participantSeatff '
>=ff( *
$numff+ ,
)ff, -
{gg 
playerSnapshothh &
=hh' (#
MatchSnapshotProjectionhh) @
.hh@ A
CreateSnapshothhA O
(hhO P

matchStatehhP Z
,hhZ [
participantSeathh\ k
,hhk l
_matchClockii '
.ii' ($
GetTimestampMillisecondsii( @
(ii@ A
)iiA B
)iiB C
;iiC D
}jj 
}kk 
}ll 
returnmm 
playerSnapshotmm !
;mm! "
}nn 	
publicpp 
CardPlayDecisionpp 
PlayCardpp  (
(pp( )
CardPlaySubmissionpp) ;
cardPlaySubmissionpp< N
,ppN O
intppP S
participantUserIdppT e
)ppe f
{qq 	
varrr 
playDecisionrr 
=rr 
newrr "
CardPlayDecisionrr# 3
{ss  
CardPlaySubmissionIdtt $
=tt% &
cardPlaySubmissiontt' 9
?tt9 :
.tt: ; 
CardPlaySubmissionIdtt; O
??ttP R
GuidttS W
.ttW X
EmptyttX ]
,tt] ^
RejectionReasonuu 
=uu  ! 
MatchRejectionReasonuu" 6
.uu6 7
MatchUnavailableuu7 G
}vv 
;vv 
ifww 
(ww 
cardPlaySubmissionww "
!=ww# %
nullww& *
&&ww+ -
!ww. /
stringww/ 5
.ww5 6
IsNullOrWhiteSpaceww6 H
(wwH I
cardPlaySubmissionwwI [
.ww[ \
	LobbyCodeww\ e
)wwe f
)wwf g
{xx 

MatchStateyy 

matchStateyy %
=yy& '
_matchStateStoreyy( 8
.yy8 9
	FindMatchyy9 B
(yyB C
cardPlaySubmissionyyC U
.yyU V
	LobbyCodeyyV _
)yy_ `
;yy` a
ifzz 
(zz 

matchStatezz 
!=zz !
nullzz" &
)zz& '
{{{ 
lock|| 
(|| 

matchState|| $
)||$ %
{}} 
playDecision~~ $
=~~% & 
ProcessPlayUnderLock~~' ;
(~~; <

matchState~~< F
,~~F G
cardPlaySubmission~~H Z
,~~Z [
participantUserId~~\ m
)~~m n
;~~n o
} 
}
ÄÄ 
}
ÅÅ 
return
ÇÇ 
playDecision
ÇÇ 
;
ÇÇ  
}
ÉÉ 	
private
ÖÖ 

MatchState
ÖÖ 
CreateMatchState
ÖÖ +
(
ÖÖ+ ,
MatchStartContext
ÖÖ, =
startContext
ÖÖ> J
)
ÖÖJ K
{
ÜÜ 	
var
áá 

matchState
áá 
=
áá 
new
áá  

MatchState
áá! +
{
àà 
LobbyInstanceId
ââ 
=
ââ  !
startContext
ââ" .
.
ââ. /
LobbyInstanceId
ââ/ >
,
ââ> ? 
TargetMissionCount
ää "
=
ää# $
startContext
ää% 1
.
ää1 2 
TargetMissionCount
ää2 D
,
ääD E 
ParticipantUserIds
ãã "
=
ãã# $
(
ãã% &
int
ãã& )
[
ãã) *
]
ãã* +
)
ãã+ ,
startContext
ãã, 8
.
ãã8 9 
ParticipantUserIds
ãã9 K
.
ããK L
Clone
ããL Q
(
ããQ R
)
ããR S
}
åå 
;
åå $
PreparedMissionAttempt
çç "
preparedAttempt
çç# 2
=
çç3 4'
MissionAttemptPreparation
çç5 N
.
ççN O
Prepare
ççO V
(
ççV W
new
éé .
 MissionAttemptPreparationContext
éé 4
{
èè 
MissionNumber
êê !
=
êê" #
MissionCatalog
êê$ 2
.
êê2 3"
MinimumMissionNumber
êê3 G
,
êêG H
MissionAttemptId
ëë $
=
ëë% &'
MissionAttemptPreparation
ëë' @
.
ëë@ A%
InitialMissionAttemptId
ëëA X
,
ëëX Y
AttemptNumber
íí !
=
íí" #
Domain
íí$ *
.
íí* +%
MissionProgressionRules
íí+ B
.
ííB C"
InitialAttemptNumber
ííC W
,
ííW X 
ParticipantUserIds
ìì &
=
ìì' (

matchState
ìì) 3
.
ìì3 4 
ParticipantUserIds
ìì4 F
}
îî 
,
îî  
_missionDeckDealer
îî %
)
îî% &
;
îî& '

matchState
ïï 
.
ïï .
 InitializePreparedMissionAttempt
ïï 7
(
ïï7 8
preparedAttempt
ïï8 G
)
ïïG H
;
ïïH I
return
ññ 

matchState
ññ 
;
ññ 
}
óó 	
private
ôô 
CardPlayDecision
ôô  "
ProcessPlayUnderLock
ôô! 5
(
ôô5 6

MatchState
ôô6 @

matchState
ôôA K
,
ôôK L 
CardPlaySubmission
öö  
cardPlaySubmission
öö 1
,
öö1 2
int
öö3 6
participantUserId
öö7 H
)
ööH I
{
õõ 	
int
úú 
participantSeat
úú 
=
úú  !
Array
úú" '
.
úú' (
IndexOf
úú( /
(
úú/ 0

matchState
úú0 :
.
úú: ; 
ParticipantUserIds
úú; M
,
úúM N
participantUserId
úúO `
)
úú` a
;
úúa b
var
ùù 
playDecision
ùù 
=
ùù 
new
ùù "
CardPlayDecision
ùù# 3
{
ûû "
CardPlaySubmissionId
üü $
=
üü% & 
cardPlaySubmission
üü' 9
.
üü9 :"
CardPlaySubmissionId
üü: N
,
üüN O(
CommittedMatchStateVersion
†† *
=
††+ ,

matchState
††- 7
.
††7 8
MatchStateVersion
††8 I
}
°° 
;
°° 
if
¢¢ 
(
¢¢ 
participantSeat
¢¢ 
<
¢¢  !
$num
¢¢" #
)
¢¢# $
{
££ 
playDecision
§§ 
.
§§ 
RejectionReason
§§ ,
=
§§- ."
MatchRejectionReason
§§/ C
.
§§C D#
ParticipantNotAllowed
§§D Y
;
§§Y Z
}
•• 
else
¶¶ 
if
¶¶ 
(
¶¶  
cardPlaySubmission
¶¶ '
.
¶¶' (
MatchId
¶¶( /
!=
¶¶0 2

matchState
¶¶3 =
.
¶¶= >
MatchId
¶¶> E
||
¶¶F H 
cardPlaySubmission
ßß "
.
ßß" #"
CardPlaySubmissionId
ßß# 7
==
ßß8 :
Guid
ßß; ?
.
ßß? @
Empty
ßß@ E
)
ßßE F
{
®® 
playDecision
©© 
.
©© 
RejectionReason
©© ,
=
©©- ."
MatchRejectionReason
©©/ C
.
©©C D
InvalidSubmission
©©D U
;
©©U V
}
™™ 
else
´´ 
if
´´ 
(
´´  
cardPlaySubmission
´´ '
.
´´' (
MissionAttemptId
´´( 8
!=
´´9 ;

matchState
´´< F
.
´´F G
MissionAttempt
´´G U
.
´´U V
MissionAttemptId
´´V f
)
´´f g
{
¨¨ 
playDecision
≠≠ 
.
≠≠ 
RejectionReason
≠≠ ,
=
≠≠- ."
MatchRejectionReason
≠≠/ C
.
≠≠C D!
WrongMissionAttempt
≠≠D W
;
≠≠W X
}
ÆÆ 
else
ØØ 
{
∞∞ 
playDecision
±± 
=
±± #
ProcessIdentifiedPlay
±± 4
(
±±4 5

matchState
±±5 ?
,
±±? @ 
cardPlaySubmission
±±A S
,
±±S T
participantSeat
±±U d
)
±±d e
;
±±e f
}
≤≤ 
return
≥≥ 
playDecision
≥≥ 
;
≥≥  
}
¥¥ 	
private
∂∂ 
CardPlayDecision
∂∂  #
ProcessIdentifiedPlay
∂∂! 6
(
∂∂6 7

MatchState
∂∂7 A

matchState
∂∂B L
,
∂∂L M 
CardPlaySubmission
∑∑  
cardPlaySubmission
∑∑ 1
,
∑∑1 2
int
∑∑3 6
participantSeat
∑∑7 F
)
∑∑F G
{
∏∏ 	
CardPlayDecision
ππ 
playDecision
ππ )
;
ππ) *
if
∫∫ 
(
∫∫ 

matchState
∫∫ 
.
∫∫ 6
(ProcessedCardPlayDecisionsBySubmissionId
∫∫ C
.
∫∫C D
TryGetValue
∫∫D O
(
∫∫O P 
cardPlaySubmission
∫∫P b
.
∫∫b c"
CardPlaySubmissionId
∫∫c w
,
∫∫w x
out
ªª 
ProcessedCardPlay
ªª %
processedPlay
ªª& 3
)
ªª3 4
)
ªª4 5
{
ºº 
playDecision
ΩΩ 
=
ΩΩ !
ResolveRepeatedPlay
ΩΩ 2
(
ΩΩ2 3
processedPlay
ΩΩ3 @
,
ΩΩ@ A 
cardPlaySubmission
ΩΩB T
,
ΩΩT U

matchState
ææ 
.
ææ  
ParticipantUserIds
ææ 1
[
ææ1 2
participantSeat
ææ2 A
]
ææA B
)
ææB C
;
ææC D
}
øø 
else
¿¿ 
{
¡¡ 
playDecision
¬¬ 
=
¬¬ 
ProcessNewPlay
¬¬ -
(
¬¬- .

matchState
¬¬. 8
,
¬¬8 9 
cardPlaySubmission
¬¬: L
,
¬¬L M
participantSeat
¬¬N ]
)
¬¬] ^
;
¬¬^ _
}
√√ 
return
ƒƒ 
playDecision
ƒƒ 
;
ƒƒ  
}
≈≈ 	
private
«« 
static
«« 
CardPlayDecision
«« '!
ResolveRepeatedPlay
««( ;
(
««; <
ProcessedCardPlay
««< M
processedPlay
««N [
,
««[ \ 
CardPlaySubmission
»»  
cardPlaySubmission
»» 1
,
»»1 2
int
»»3 6
participantUserId
»»7 H
)
»»H I
{
…… 	
bool
   
isSameSubmission
   !
=
  " #
processedPlay
  $ 1
.
  1 2
ParticipantUserId
  2 C
==
  D F
participantUserId
  G X
&&
  Y [
processedPlay
ÀÀ 
.
ÀÀ 
CardId
ÀÀ $
==
ÀÀ% ' 
cardPlaySubmission
ÀÀ( :
.
ÀÀ: ;
CardId
ÀÀ; A
&&
ÀÀB D
processedPlay
ÃÃ 
.
ÃÃ '
ExpectedMatchStateVersion
ÃÃ 7
==
ÃÃ8 : 
cardPlaySubmission
ÃÃ; M
.
ÃÃM N'
ExpectedMatchStateVersion
ÃÃN g
&&
ÃÃh j
processedPlay
ÕÕ 
.
ÕÕ 
MissionAttemptId
ÕÕ .
==
ÕÕ/ 1 
cardPlaySubmission
ÕÕ2 D
.
ÕÕD E
MissionAttemptId
ÕÕE U
;
ÕÕU V
return
ŒŒ 
isSameSubmission
ŒŒ #
?
ŒŒ$ %%
MatchSnapshotProjection
ŒŒ& =
.
ŒŒ= >
CloneDecision
ŒŒ> K
(
ŒŒK L
processedPlay
ŒŒL Y
.
ŒŒY Z
Decision
ŒŒZ b
)
ŒŒb c
:
ŒŒd e
new
œœ 
CardPlayDecision
œœ $
{
–– "
CardPlaySubmissionId
—— (
=
——) * 
cardPlaySubmission
——+ =
.
——= >"
CardPlaySubmissionId
——> R
,
——R S
RejectionReason
““ #
=
““$ %"
MatchRejectionReason
““& :
.
““: ;&
SubmissionIdentityReused
““; S
}
”” 
;
”” 
}
‘‘ 	
private
÷÷ 
CardPlayDecision
÷÷  
ProcessNewPlay
÷÷! /
(
÷÷/ 0

MatchState
÷÷0 :

matchState
÷÷; E
,
÷÷E F 
CardPlaySubmission
÷÷G Y 
cardPlaySubmission
÷÷Z l
,
÷÷l m
int
◊◊ 
participantSeat
◊◊ 
)
◊◊  
{
ÿÿ 	
var
ŸŸ 
playDecision
ŸŸ 
=
ŸŸ 
new
ŸŸ "
CardPlayDecision
ŸŸ# 3
{
ŸŸ4 5"
CardPlaySubmissionId
ŸŸ6 J
=
ŸŸK L 
cardPlaySubmission
ŸŸM _
.
ŸŸ_ `"
CardPlaySubmissionId
ŸŸ` t
}
ŸŸu v
;
ŸŸv w
if
⁄⁄ 
(
⁄⁄ 

matchState
⁄⁄ 
.
⁄⁄ 6
(ProcessedCardPlayDecisionsBySubmissionId
⁄⁄ C
.
⁄⁄C D
Count
⁄⁄D I
>=
⁄⁄J L)
MaximumProcessedSubmissions
⁄⁄M h
)
⁄⁄h i
{
€€ 
_logger
‹‹ 
.
‹‹ 
Warning
‹‹ 
(
‹‹  4
&MatchSubmissionCapacityReachedTemplate
‹‹  F
,
‹‹F G

matchState
‹‹H R
.
‹‹R S
MatchId
‹‹S Z
,
‹‹Z [)
MaximumProcessedSubmissions
›› /
)
››/ 0
;
››0 1
playDecision
ﬁﬁ 
.
ﬁﬁ 
RejectionReason
ﬁﬁ ,
=
ﬁﬁ- ."
MatchRejectionReason
ﬁﬁ/ C
.
ﬁﬁC D'
SubmissionCapacityReached
ﬁﬁD ]
;
ﬁﬁ] ^
}
ﬂﬂ 
else
‡‡ 
{
·· 
playDecision
‚‚ 
.
‚‚ 
RejectionReason
‚‚ ,
=
‚‚- .!
MatchPlayValidation
‚‚/ B
.
‚‚B C
GetRejection
‚‚C O
(
‚‚O P

matchState
„„ 
,
„„  
cardPlaySubmission
„„  2
,
„„2 3
participantSeat
„„4 C
)
„„C D
;
„„D E
if
‰‰ 
(
‰‰ 
playDecision
‰‰  
.
‰‰  !
RejectionReason
‰‰! 0
==
‰‰1 3"
MatchRejectionReason
‰‰4 H
.
‰‰H I
None
‰‰I M
)
‰‰M N
{
ÂÂ 
ApplyAcceptedPlay
ÊÊ %
(
ÊÊ% &

matchState
ÊÊ& 0
,
ÊÊ0 1 
cardPlaySubmission
ÊÊ2 D
.
ÊÊD E
CardId
ÊÊE K
,
ÊÊK L
participantSeat
ÊÊM \
)
ÊÊ\ ]
;
ÊÊ] ^
playDecision
ÁÁ  
.
ÁÁ  !

IsAccepted
ÁÁ! +
=
ÁÁ, -
true
ÁÁ. 2
;
ÁÁ2 3
}
ËË 
playDecision
ÈÈ 
.
ÈÈ (
CommittedMatchStateVersion
ÈÈ 7
=
ÈÈ8 9

matchState
ÈÈ: D
.
ÈÈD E
MatchStateVersion
ÈÈE V
;
ÈÈV W

matchState
ÍÍ 
.
ÍÍ 6
(ProcessedCardPlayDecisionsBySubmissionId
ÍÍ C
.
ÍÍC D
Add
ÍÍD G
(
ÍÍG H 
cardPlaySubmission
ÍÍH Z
.
ÍÍZ ["
CardPlaySubmissionId
ÍÍ[ o
,
ÍÍo p
new
ÎÎ 
ProcessedCardPlay
ÎÎ )
{
ÏÏ 
ParticipantUserId
ÌÌ )
=
ÌÌ* +

matchState
ÌÌ, 6
.
ÌÌ6 7 
ParticipantUserIds
ÌÌ7 I
[
ÌÌI J
participantSeat
ÌÌJ Y
]
ÌÌY Z
,
ÌÌZ [
CardId
ÓÓ 
=
ÓÓ   
cardPlaySubmission
ÓÓ! 3
.
ÓÓ3 4
CardId
ÓÓ4 :
,
ÓÓ: ;
MissionAttemptId
ÔÔ (
=
ÔÔ) * 
cardPlaySubmission
ÔÔ+ =
.
ÔÔ= >
MissionAttemptId
ÔÔ> N
,
ÔÔN O'
ExpectedMatchStateVersion
 1
=
2 3 
cardPlaySubmission
4 F
.
F G'
ExpectedMatchStateVersion
G `
,
` a
Decision
ÒÒ  
=
ÒÒ! "%
MatchSnapshotProjection
ÒÒ# :
.
ÒÒ: ;
CloneDecision
ÒÒ; H
(
ÒÒH I
playDecision
ÒÒI U
)
ÒÒU V
}
ÚÚ 
)
ÚÚ 
;
ÚÚ 
}
ÛÛ 
return
ÙÙ 
playDecision
ÙÙ 
;
ÙÙ  
}
ıı 	
private
˜˜ 
static
˜˜ 
void
˜˜ 
ApplyAcceptedPlay
˜˜ -
(
˜˜- .

MatchState
˜˜. 8

matchState
˜˜9 C
,
˜˜C D
int
˜˜E H
playedCardId
˜˜I U
,
˜˜U V
int
˜˜W Z
participantSeat
˜˜[ j
)
˜˜j k
{
¯¯ 	
var
˘˘ 
acceptedPlay
˘˘ 
=
˘˘ 
new
˘˘ "
MatchCardPlay
˘˘# 0
{
˙˙ 
PlayerUserId
˚˚ 
=
˚˚ 

matchState
˚˚ )
.
˚˚) * 
ParticipantUserIds
˚˚* <
[
˚˚< =
participantSeat
˚˚= L
]
˚˚L M
,
˚˚M N
CardId
¸¸ 
=
¸¸ 
playedCardId
¸¸ %
}
˝˝ 
;
˝˝ 
MatchCardPlay
˛˛ 
[
˛˛ 
]
˛˛ !
candidateTrickPlays
˛˛ /
=
˛˛0 1

matchState
˛˛2 <
.
˛˛< =#
CurrentTrickCardPlays
˛˛= R
.
˛˛R S
Concat
˛˛S Y
(
˛˛Y Z
new
˛˛Z ]
[
˛˛] ^
]
˛˛^ _
{
˛˛` a
acceptedPlay
˛˛b n
}
˛˛o p
)
˛˛p q
.
ˇˇ 
ToArray
ˇˇ 
(
ˇˇ 
)
ˇˇ 
;
ˇˇ &
CompletedTrickResolution
ÄÄ $
completedTrick
ÄÄ% 3
=
ÄÄ4 5
null
ÄÄ6 :
;
ÄÄ: ;
if
ÅÅ 
(
ÅÅ !
candidateTrickPlays
ÅÅ #
.
ÅÅ# $
Length
ÅÅ$ *
==
ÅÅ+ -

matchState
ÅÅ. 8
.
ÅÅ8 9 
ParticipantUserIds
ÅÅ9 K
.
ÅÅK L
Length
ÅÅL R
)
ÅÅR S
{
ÇÇ 
completedTrick
ÉÉ 
=
ÉÉ  #
PrepareCompletedTrick
ÉÉ! 6
(
ÉÉ6 7

matchState
ÉÉ7 A
,
ÉÉA B!
candidateTrickPlays
ÉÉC V
)
ÉÉV W
;
ÉÉW X
}
ÑÑ 

matchState
ÖÖ 
.
ÖÖ %
PlayerHandCardIdsBySeat
ÖÖ .
[
ÖÖ. /
participantSeat
ÖÖ/ >
]
ÖÖ> ?
.
ÖÖ? @
Remove
ÖÖ@ F
(
ÖÖF G
playedCardId
ÖÖG S
)
ÖÖS T
;
ÖÖT U
if
ÜÜ 
(
ÜÜ 
completedTrick
ÜÜ 
!=
ÜÜ !
null
ÜÜ" &
)
ÜÜ& '
{
áá 

matchState
àà 
.
àà "
CommitCompletedTrick
àà /
(
àà/ 0
completedTrick
àà0 >
)
àà> ?
;
àà? @
}
ââ 
else
ää 
{
ãã 

matchState
åå 
.
åå #
CurrentTrickCardPlays
åå 0
.
åå0 1
Add
åå1 4
(
åå4 5
acceptedPlay
åå5 A
)
ååA B
;
ååB C

matchState
çç 
.
çç #
CurrentTurnPlayerSeat
çç 0
=
çç1 2
TrickTurnRules
çç3 A
.
ççA B
GetNextTurnSeat
ççB Q
(
ççQ R
(
ççR S
byte
ççS W
)
ççW X
participantSeat
ççX g
,
ççg h

matchState
éé 
.
éé  
ParticipantUserIds
éé 1
.
éé1 2
Length
éé2 8
)
éé8 9
;
éé9 :
}
èè 

matchState
êê 
.
êê 
MatchStateVersion
êê (
++
êê( *
;
êê* +
}
ëë 	
}
íí 
}ìì û!
_C:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\Ports\Match\IMatchUseCase.cs
	namespace 	
Application
 
. 
Ports 
{ 
public 

	interface 
IMatchUseCase "
{ 
Application		 
.		 
Models		 
.		 "
ObjectiveDraftDecision		 1'
ProcessObjectiveDraftAction		2 M
(		M N
Application

 
.

 
Models

 
.

 $
ObjectiveDraftSubmission

 7

submission

8 B
,

B C
int

D G
participantUserId

H Y
)

Y Z
;

Z [
Application 
. 
Models 
. $
MissionRetryConfirmation 3
ConfirmMissionRetry4 G
(G H
Application 
. 
Models 
. 
MissionRetryRequest 2
missionRetryRequest3 F
,F G
intH K
participantUserIdL ]
)] ^
;^ _
System 
. 
Collections 
. 
Generic "
." #
IReadOnlyList# 0
<0 1
Application1 <
.< =
Models= C
.C D!
MissionTransitionWorkD Y
>Y Z%
TakeDueMissionTransitions[ t
(t u
int 
maximumPreparations #
)# $
;$ %
Application 
. 
Models 
. ,
 MissionTransitionExecutionResult ;-
!ExecuteScheduledMissionTransition< ]
(] ^
Application 
. 
Models 
. !
MissionTransitionWork 4
transitionWork5 C
,C D
System 
. 
	Threading 
. 
CancellationToken .
cancellationToken/ @
)@ A
;A B
Application 
. 
Models 
. ,
 MissionTransitionExecutionResult ;/
#ReleaseMissionTransitionReservation< _
(_ `
Application 
. 
Models 
. !
MissionTransitionWork 4
transitionWork5 C
,C D
boolE I 
hasPreparationFailedJ ^
)^ _
;_ `
Application 
. 
Models 
. $
RadioCommunicationCommit 3$
SubmitRadioCommunication4 L
(L M
Application 
. 
Models 
. %
RadioCommunicationRequest 8
request9 @
,@ A
intB E
participantUserIdF W
)W X
;X Y
Application 
. 
Models 
. $
MissionPreparationCommit 3%
ProcessMissionPreparation4 M
(M N
Application 
. 
Models 
. %
MissionPreparationRequest 8
request9 @
,@ A
intB E
participantUserIdF W
)W X
;X Y
Guid 

StartMatch 
( 
Application #
.# $
Models$ *
.* +
MatchStartContext+ <
startContext= I
)I J
;J K
PlayerMatchSnapshot 
GetPlayerMatch *
(* +
string+ 1
	lobbyCode2 ;
,; <
int= @
participantUserIdA R
)R S
;S T
CardPlayDecision 
PlayCard !
(! "
CardPlaySubmission" 4
cardPlaySubmission5 G
,G H
intI L
participantUserIdM ^
)^ _
;_ `
Application!! 
.!! 
Models!! 
.!!  
DistressSignalCommit!! / 
SubmitDistressSignal!!0 D
(!!D E
Application"" 
."" 
Models"" 
."" !
DistressSignalRequest"" 4
request""5 <
,""< =
int""> A
participantUserId""B S
)""S T
;""T U
}## 
}$$ …Ñ
cC:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\Models\Match\State\MatchState.cs
	namespace 	
Application
 
. 
Models 
{ 
public 

sealed 
partial 
class 

MatchState  *
{ 
public		 
Domain		 
.		 
MissionAttemptState		 )
MissionAttempt		* 8
{		9 :
get		; >
;		> ?
private		@ G
set		H K
;		K L
}		M N
public

 
Domain

 
.

 #
MissionEvaluationResult

 -!
LastMissionEvaluation

. C
{

D E
get

F I
;

I J
private

K R
set

S V
;

V W
}

X Y
public "
MissionTrickStatistics %
TrickStatistics& 5
{6 7
get8 ;
;; <
private= D
setE H
;H I
}J K
=L M
newN Q"
MissionTrickStatisticsR h
(h i
)i j
;j k
public 
int $
LastEvaluatedTrickNumber +
{, -
get. 1
;1 2
private3 :
set; >
;> ?
}@ A
public 
Guid -
!CurrentObjectiveDraftSubmissionId 5
{6 7
get8 ;
;; <
private= D
setE H
;H I
}J K
public 

Dictionary 
< 
int 
, 
Queue $
<$ %
Guid% )
>) *
>* +.
"ObjectiveDraftHistoryByParticipant, N
{O P
getQ T
;T U
}V W
=X Y
new 

Dictionary 
< 
int 
, 
Queue  %
<% &
Guid& *
>* +
>+ ,
(, -
)- .
;. /
public 

Dictionary 
< 
Guid 
, 
int  #
># $)
ObjectiveCardIdsByObjectiveId% B
{C D
getE H
;H I
privateJ Q
setR U
;U V
}W X
=Y Z
new[ ^

Dictionary_ i
<i j
Guidj n
,n o
intp s
>s t
(t u
)u v
;v w
public 

Dictionary 
< 
Guid 
, #
ProcessedObjectiveDraft  7
>7 8$
ProcessedObjectiveDrafts9 Q
{R S
getT W
;W X
}Y Z
=[ \
new 

Dictionary 
< 
Guid 
,  #
ProcessedObjectiveDraft! 8
>8 9
(9 :
): ;
;; <
public 

Dictionary 
< 
int 
, $
MatchActionRequestBudget 7
>7 8.
"ObjectiveDraftBudgetsByParticipant9 [
{\ ]
get^ a
;a b
}c d
=e f
new 

Dictionary 
< 
int 
, $
MatchActionRequestBudget  8
>8 9
(9 :
): ;
;; <
public 
Guid 
LobbyInstanceId #
{$ %
get& )
;) *
set+ .
;. /
}0 1
public 
int 
TargetMissionCount %
{& '
get( +
;+ ,
init- 1
;1 2
}3 4
public 
Guid 
MatchId 
{ 
get !
;! "
}# $
=% &
Guid' +
.+ ,
NewGuid, 3
(3 4
)4 5
;5 6
public 
long 
MatchStateVersion %
{& '
get( +
;+ ,
set- 0
;0 1
}2 3
=4 5
$num6 7
;7 8
public 
int 
[ 
] 
ParticipantUserIds '
{( )
get* -
;- .
set/ 2
;2 3
}4 5
public 
List 
< 
int 
> 
[ 
] #
PlayerHandCardIdsBySeat 2
{3 4
get5 8
;8 9
set: =
;= >
}? @
public 
List 
< 
int 
> 
[ 
] 
WonCardIdsBySeat +
{, -
get. 1
;1 2
set3 6
;6 7
}8 9
public   
int   
[   
]    
WonTrickCountsBySeat   )
{  * +
get  , /
;  / 0
set  1 4
;  4 5
}  6 7
public!! 
int!! !
CurrentTurnPlayerSeat!! (
{!!) *
get!!+ .
;!!. /
set!!0 3
;!!3 4
}!!5 6
public"" 
int"" 
MissionCaptainSeat"" %
{""& '
get""( +
;""+ ,
set""- 0
;""0 1
}""2 3
public## 
int## 
CurrentTrickNumber## %
{##& '
get##( +
;##+ ,
set##- 0
;##0 1
}##2 3
=##4 5
$num##6 7
;##7 8
public$$ 
int$$ $
MaximumMissionTrickCount$$ +
{$$, -
get$$. 1
;$$1 2
set$$3 6
;$$6 7
}$$8 9
public%% 
bool%% 
IsDealCompleted%% #
{%%$ %
get%%& )
;%%) *
set%%+ .
;%%. /
}%%0 1
public&& 
List&& 
<&& 
MatchCardPlay&& !
>&&! "!
CurrentTrickCardPlays&&# 8
{&&9 :
get&&; >
;&&> ?
}&&@ A
=&&B C
new&&D G
List&&H L
<&&L M
MatchCardPlay&&M Z
>&&Z [
(&&[ \
)&&\ ]
;&&] ^
public'' 
MatchCardPlay'' 
['' 
]'' '
LastCompletedTrickCardPlays'' :
{''; <
get''= @
;''@ A
set''B E
;''E F
}''G H
=''I J
new''K N
MatchCardPlay''O \
[''\ ]
$num''] ^
]''^ _
;''_ `
public(( 
int(( !
LastTrickWinnerUserId(( (
{(() *
get((+ .
;((. /
set((0 3
;((3 4
}((5 6
public)) 
List)) 
<)) 
MatchCardPlay)) !
>))! "
CapturedCardPlays))# 4
{))5 6
get))7 :
;)): ;
}))< =
=))> ?
new))@ C
List))D H
<))H I
MatchCardPlay))I V
>))V W
())W X
)))X Y
;))Y Z
public** 

Dictionary** 
<** 
Guid** 
,** 
ProcessedCardPlay**  1
>**1 24
(ProcessedCardPlayDecisionsBySubmissionId**3 [
{**\ ]
get**^ a
;**a b
}**c d
=**e f
new++ 

Dictionary++ 
<++ 
Guid++ 
,++  
ProcessedCardPlay++! 2
>++2 3
(++3 4
)++4 5
;++5 6
public,, 

Dictionary,, 
<,, 
byte,, 
,,, 
int,,  #
>,,# $,
 PendingDistressPassCardIdsBySeat,,% E
{,,F G
get,,H K
;,,K L
},,M N
=,,O P
new-- 

Dictionary-- 
<-- 
byte-- 
,--  
int--! $
>--$ %
(--% &
)--& '
;--' (
public.. 

Dictionary.. 
<.. 
byte.. 
,.. 
TrickTakingMissions..  3
...3 4
Rules..4 9
...9 :
Enums..: ?
...? @
PassDirection..@ M
>..M N+
PendingDistressDirectionsBySeat// +
{//, -
get//. 1
;//1 2
}//3 4
=//5 6
new00 

Dictionary00 
<00 
byte00 
,00  
TrickTakingMissions00! 4
.004 5
Rules005 :
.00: ;
Enums00; @
.00@ A
PassDirection00A N
>00N O
(00O P
)00P Q
;00Q R
public11 
TrickTakingMissions11 "
.11" #
Rules11# (
.11( )
Enums11) .
.11. /
DistressSignalStep11/ A
DistressStep11B N
{11O P
get11Q T
;11T U
set11V Y
;11Y Z
}11[ \
public22 
HashSet22 
<22 
byte22 
>22 '
DistressUsageYesVotesBySeat22 8
{229 :
get22; >
;22> ?
}22@ A
=22B C
new33 
HashSet33 
<33 
byte33 
>33 
(33 
)33 
;33  
public44 

Dictionary44 
<44 
byte44 
,44 
TrickTakingMissions44  3
.443 4
Rules444 9
.449 :
Enums44: ?
.44? @
PassDirection44@ M
>44M N(
DistressDirectionVotesBySeat55 (
{55) *
get55+ .
;55. /
}550 1
=552 3
new66 

Dictionary66 
<66 
byte66 
,66  
TrickTakingMissions66! 4
.664 5
Rules665 :
.66: ;
Enums66; @
.66@ A
PassDirection66A N
>66N O
(66O P
)66P Q
;66Q R
public77 
int77 
?77 #
DistressInitiatorUserId77 +
{77, -
get77. 1
;771 2
set773 6
;776 7
}778 9
public88 
TrickTakingMissions88 "
.88" #
Rules88# (
.88( )
Enums88) .
.88. /
PassDirection88/ <
?88< =#
DistressAgreedDirection88> U
{88V W
get88X [
;88[ \
set88] `
;88` a
}88b c
public99 
bool99 #
HasDistressBeenRejected99 +
{99, -
get99. 1
;991 2
set993 6
;996 7
}998 9
public:: 
bool:: 5
)HasAppliedDistressPenaltyInCurrentMission:: =
{::> ?
get::@ C
;::C D
set::E H
;::H I
}::J K
public<< 
void<< 
ResetDistressState<< &
(<<& '
)<<' (
{== 	
DistressStep>> 
=>> 
TrickTakingMissions>> .
.>>. /
Rules>>/ 4
.>>4 5
Enums>>5 :
.>>: ;
DistressSignalStep>>; M
.>>M N
None>>N R
;>>R S,
 PendingDistressPassCardIdsBySeat?? ,
.??, -
Clear??- 2
(??2 3
)??3 4
;??4 5+
PendingDistressDirectionsBySeat@@ +
.@@+ ,
Clear@@, 1
(@@1 2
)@@2 3
;@@3 4'
DistressUsageYesVotesBySeatAA '
.AA' (
ClearAA( -
(AA- .
)AA. /
;AA/ 0(
DistressDirectionVotesBySeatBB (
.BB( )
ClearBB) .
(BB. /
)BB/ 0
;BB0 1#
DistressInitiatorUserIdCC #
=CC$ %
nullCC& *
;CC* +#
DistressAgreedDirectionDD #
=DD$ %
nullDD& *
;DD* +
}EE 	
publicGG 
voidGG &
CommitMissionAttemptUpdateGG .
(GG. /
DomainGG/ 5
.GG5 6
MissionAttemptStateGG6 I
missionAttemptGGJ X
)GGX Y
{HH 	
ifII 
(II 
missionAttemptII 
==II !
nullII" &
||II' )
missionAttemptII* 8
.II8 9
PlayerCountII9 D
!=IIE G
ParticipantUserIdsIIH Z
.IIZ [
LengthII[ a
)IIa b
{JJ 
throwKK 
newKK 
ArgumentExceptionKK +
(KK+ ,
nameofKK, 2
(KK2 3
missionAttemptKK3 A
)KKA B
)KKB C
;KKC D
}LL 
MissionAttemptMM 
=MM 
missionAttemptMM +
;MM+ ,
MatchStateVersionNN 
++NN 
;NN  
}OO 	
publicQQ 
voidQQ  
CommitObjectiveDraftQQ (
(QQ( )
DomainQQ) /
.QQ/ 0
MissionAttemptStateQQ0 C
missionAttemptQQD R
)QQR S
{RR 	
SetMissionAttemptSS 
(SS 
missionAttemptSS ,
)SS, -
;SS- .
MatchStateVersionTT 
++TT 
;TT  
}UU 	
internalWW 
voidWW  
CommitCompletedTrickWW *
(WW* +$
CompletedTrickResolutionWW+ C
completedTrickWWD R
)WWR S
{XX 	
TrickStatisticsYY 
=YY 
completedTrickYY ,
.YY, -
TrickStatisticsYY- <
;YY< =!
CurrentTurnPlayerSeatZZ !
=ZZ" #
completedTrickZZ$ 2
.ZZ2 3"
WinningParticipantSeatZZ3 I
;ZZI J!
LastTrickWinnerUserId[[ !
=[[" #
ParticipantUserIds[[$ 6
[[[6 7
completedTrick[[7 E
.[[E F"
WinningParticipantSeat[[F \
][[\ ]
;[[] ^ 
WonTrickCountsBySeat\\  
[\\  !
completedTrick\\! /
.\\/ 0"
WinningParticipantSeat\\0 F
]\\F G
++\\G I
;\\I J
WonCardIdsBySeat]] 
[]] 
completedTrick]] +
.]]+ ,"
WinningParticipantSeat]], B
]]]B C
.]]C D
AddRange]]D L
(]]L M
System^^ 
.^^ 
Linq^^ 
.^^ 

Enumerable^^ &
.^^& '
Select^^' -
(^^- .
completedTrick^^. <
.^^< =#
CompletedTrickCardPlays^^= T
,^^T U
play^^V Z
=>^^[ ]
play^^^ b
.^^b c
CardId^^c i
)^^i j
)^^j k
;^^k l'
LastCompletedTrickCardPlays__ '
=__( )
completedTrick__* 8
.__8 9#
CompletedTrickCardPlays__9 P
;__P Q
CapturedCardPlays`` 
.`` 
AddRange`` &
(``& '
completedTrick``' 5
.``5 6#
CompletedTrickCardPlays``6 M
)``M N
;``N O!
CurrentTrickCardPlaysaa !
.aa! "
Clearaa" '
(aa' (
)aa( )
;aa) *
MissionAttemptbb 
=bb 
completedTrickbb +
.bb+ ,!
UpdatedMissionAttemptbb, A
;bbA B!
LastMissionEvaluationcc !
=cc" #
completedTrickcc$ 2
.cc2 3
MissionEvaluationcc3 D
;ccD E$
LastEvaluatedTrickNumberdd $
=dd% &
completedTrickdd' 5
.dd5 6 
CompletedTrickNumberdd6 J
;ddJ K
IsDealCompletedee 
=ee 
completedTrickee ,
.ee, - 
CompletedTrickNumberee- A
==eeB D$
MaximumMissionTrickCounteeE ]
;ee] ^
ifff 
(ff 
!ff 
IsDealCompletedff  
&&ff! #
MissionAttemptff$ 2
.ff2 3
Statusff3 9
==ff: <
TrickTakingMissionsgg #
.gg# $
Rulesgg$ )
.gg) *
Enumsgg* /
.gg/ 0 
MissionAttemptStatusgg0 D
.ggD E

InProgressggE O
)ggO P
{hh 
CurrentTrickNumberii "
++ii" $
;ii$ %
}jj 
}kk 	
privatemm 
voidmm 
SetMissionAttemptmm &
(mm& '
Domainmm' -
.mm- .
MissionAttemptStatemm. A
missionAttemptmmB P
)mmP Q
{nn 	
ifoo 
(oo 
missionAttemptoo 
==oo !
nulloo" &
||oo' )
missionAttemptoo* 8
.oo8 9
PlayerCountoo9 D
!=ooE G
ParticipantUserIdsooH Z
.ooZ [
Lengthoo[ a
)ooa b
{pp 
throwqq 
newqq 
ArgumentExceptionqq +
(qq+ ,
nameofqq, 2
(qq2 3
missionAttemptqq3 A
)qqA B
)qqB C
;qqC D
}rr 
MissionAttemptss 
=ss 
missionAttemptss +
;ss+ ,-
!CurrentObjectiveDraftSubmissionIdtt -
=tt. /
Guidtt0 4
.tt4 5
NewGuidtt5 <
(tt< =
)tt= >
;tt> ?
}uu 	
}vv 
}ww ÷
yC:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\..\..\Shared\ProfileImages\ProfileImageFailureCodes.cs
	namespace 	
ProfileImages
 
{ 
public 

static 
class $
ProfileImageFailureCodes 0
{ 
public 
const 
string 
OperationFailed +
=, -
$str. ?
;? @
public 
const 
string "
AuthenticationRequired 2
=3 4
$str5 M
;M N
public 
const 
string 
ImageServiceBusy ,
=- .
$str/ A
;A B
public		 
const		 
string		 
InvalidImageRequest		 /
=		0 1
$str		2 G
;		G H
public

 
const

 
string

 
ImageSizeExceeded

 -
=

. /
$str

0 C
;

C D
public 
const 
string 
InvalidImageFormat .
=/ 0
$str1 E
;E F
public 
const 
string #
ImageDimensionsExceeded 3
=4 5
$str6 O
;O P
public 
const 
string 
ImageNotFound )
=* +
$str, ;
;; <
public 
const 
string 
InvalidStoredImage .
=/ 0
$str1 E
;E F
public 
const 
string #
ImageStorageUnavailable 3
=4 5
$str6 O
;O P
public 
const 
string &
ImageConnectionUnavailable 6
=7 8
$str9 U
;U V
public 
const 
string  
ImageFileUnavailable 0
=1 2
$str3 I
;I J
} 
} Ö

sC:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\..\..\Shared\ProfileImages\ProfileImageLimits.cs
	namespace 	
ProfileImages
 
{ 
public 

static 
class 
ProfileImageLimits *
{		 
public

 
const

 
int

 (
MaximumTransportMessageBytes

 5
=

6 7
$num

8 ?
;

? @
public 
const 
int 
MaximumUploadBytes +
=, -
$num. 5
;5 6
public 
const 
long 
MaximumPixelCount +
=, -
$num. 5
;5 6
public 
const 
int "
MaximumSourceDimension /
=0 1
$num2 6
;6 7
public 
const 
int 
OutputPixelSize (
=) *
$num+ .
;. /
public 
const 
int #
MaximumStoredImageBytes 0
=1 2
$num3 9
;9 :
public 
const 
int #
MaximumRequestedPlayers 0
=1 2
$num3 5
;5 6
} 
} ‚L
pC:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\UseCases\ProfileImages\ProfileImageUseCase.cs
	namespace

 	
Application


 
.

 
UseCases

 
{ 
public 

sealed 
class 
ProfileImageUseCase +
{ 
private 
const 
string 3
'ProfileImageUpdatedSuccessfullyTemplate D
=E F
$str b
;b c
private 
const 
string +
ProfileImageServiceBusyTemplate <
== >
$str `
;` a
private 
const 
string =
1ProfileImageReplacementPersistenceFailureTemplate N
=O P
$str	 Ü
;
Ü á
private 
readonly "
IProfileImageProcessor /"
_profileImageProcessor0 F
;F G
private 
readonly  
IProfileImageStorage - 
_profileImageStorage. B
;B C
private 
readonly $
IPlayerProfileRepository 1$
_playerProfileRepository2 J
;J K
private 
readonly 
ILoggerService '
_logger( /
;/ 0
private 
readonly 
object 
[  
]  !
_accountUpdateLocks" 5
=6 7

Enumerable8 B
.B C
RangeC H
(H I
$numI J
,J K
$numL N
)N O
.O P
SelectP V
(V W
_W X
=>Y [
new\ _
object` f
(f g
)g h
)h i
.i j
ToArrayj q
(q r
)r s
;s t
private 
readonly 
SemaphoreSlim &
_uploadSlots' 3
=4 5
new6 9
SemaphoreSlim: G
(G H
$numH I
,I J
$numK L
)L M
;M N
public 
ProfileImageUseCase "
(" #"
IProfileImageProcessor# 9!
profileImageProcessor: O
,O P 
IProfileImageStorage    
profileImageStorage  ! 4
,  4 5$
IPlayerProfileRepository  6 N#
playerProfileRepository  O f
,  f g
ILoggerService!! 
logger!! !
=!!" #
null!!$ (
)!!( )
{"" 	"
_profileImageProcessor## "
=### $!
profileImageProcessor##% :
;##: ; 
_profileImageStorage$$  
=$$! "
profileImageStorage$$# 6
;$$6 7$
_playerProfileRepository%% $
=%%% &#
playerProfileRepository%%' >
;%%> ?
_logger&& 
=&& 
logger&& 
??&& 
NullLoggerService&&  1
.&&1 2
Instance&&2 :
;&&: ;
}'' 	
public)) "
PlayerProfileImageData)) %!
ChangeOwnProfileImage))& ;
()); <
int))< ?&
authenticatedAccountUserId))@ Z
,))Z [
byte))\ `
[))` a
]))a b

imageBytes))c m
)))m n
{** 	
if++ 
(++ &
authenticatedAccountUserId++ *
<=+++ -
$num++. /
)++/ 0
{,, 
throw-- 
new-- !
ProfileImageException-- /
(--/ 0$
ProfileImageFailureCodes--0 H
.--H I"
AuthenticationRequired--I _
)--_ `
;--` a
}.. 
if// 
(// 
!// 
_uploadSlots// 
.// 
Wait// "
(//" #
$num//# $
)//$ %
)//% &
{00 
_logger11 
.11 
Warning11 
(11  +
ProfileImageServiceBusyTemplate11  ?
,11? @&
authenticatedAccountUserId11A [
)11[ \
;11\ ]
throw22 
new22 !
ProfileImageException22 /
(22/ 0$
ProfileImageFailureCodes220 H
.22H I
ImageServiceBusy22I Y
)22Y Z
;22Z [
}33 "
PlayerProfileImageData44 "
updatedProfileImage44# 6
;446 7
try55 
{66 
byte77 
[77 
]77 '
normalizedProfileImageBytes77 2
=773 4"
_profileImageProcessor775 K
.77K L!
NormalizeProfileImage77L a
(77a b

imageBytes77b l
)77l m
;77m n
lock88 
(88 
_accountUpdateLocks88 )
[88) *&
authenticatedAccountUserId88* D
%88E F
_accountUpdateLocks88G Z
.88Z [
Length88[ a
]88a b
)88b c
{99 
updatedProfileImage:: '
=::( )
PersistProfileImage::* =
(::= >&
authenticatedAccountUserId::> X
,::X Y'
normalizedProfileImageBytes::Z u
)::u v
;::v w
_logger;; 
.;; 
Information;; '
(;;' (3
'ProfileImageUpdatedSuccessfullyTemplate;;( O
,;;O P&
authenticatedAccountUserId;;Q k
,;;k l
updatedProfileImage<< +
.<<+ ,
ProfileImageId<<, :
)<<: ;
;<<; <
}== 
}>> 
finally?? 
{@@ 
_uploadSlotsAA 
.AA 
ReleaseAA $
(AA$ %
)AA% &
;AA& '
}BB 
returnCC 
updatedProfileImageCC &
;CC& '
}DD 	
privateFF "
PlayerProfileImageDataFF &
PersistProfileImageFF' :
(FF: ;
intFF; >
accountUserIdFF? L
,FFL M
byteFFN R
[FFR S
]FFS T 
normalizedImageBytesFFU i
)FFi j
{GG 	
GuidHH 
profileImageIdHH 
=HH  !
GuidHH" &
.HH& '
NewGuidHH' .
(HH. /
)HH/ 0
;HH0 1 
_profileImageStorageII  
.II  !
SaveProfileImageII! 1
(II1 2
profileImageIdII2 @
,II@ A 
normalizedImageBytesIIB V
)IIV W
;IIW X
GuidJJ "
previousProfileImageIdJJ '
;JJ' (
tryKK 
{LL "
previousProfileImageIdMM &
=MM' ($
_playerProfileRepositoryMM) A
.MMA B
ReplaceProfileImageMMB U
(MMU V
accountUserIdMMV c
,MMc d
profileImageIdMMe s
)MMs t
;MMt u
}NN 
catchOO 
(OO %
InvalidOperationExceptionOO ,
)OO, -
{PP 
_loggerQQ 
.QQ 
WarningQQ 
(QQ  =
1ProfileImageReplacementPersistenceFailureTemplateQQ  Q
,QQQ R
accountUserIdQQS `
,QQ` a
profileImageIdQQb p
)QQp q
;QQq r 
_profileImageStorageRR $
.RR$ %
DeleteProfileImageRR% 7
(RR7 8
profileImageIdRR8 F
)RRF G
;RRG H
throwSS 
;SS 
}TT  
_profileImageStorageUU  
.UU  !
DeleteProfileImageUU! 3
(UU3 4"
previousProfileImageIdUU4 J
)UUJ K
;UUK L
returnVV 
newVV "
PlayerProfileImageDataVV -
{VV. /
ProfileOwnerUserIdVV0 B
=VVC D
accountUserIdVVE R
,VVR S
ProfileImageIdVVT b
=VVc d
profileImageIdVVe s
}VVt u
;VVu v
}WW 	
publicYY "
PlayerProfileImageDataYY %
[YY% &
]YY& '"
GetPlayerProfileImagesYY( >
(YY> ?
intYY? B
[YYB C
]YYC D
profileOwnerUserIdsYYE X
)YYX Y
{ZZ 	
if[[ 
([[ 
profileOwnerUserIds[[ #
==[[$ &
null[[' +
||[[, .
profileOwnerUserIds[[/ B
.[[B C
Length[[C I
>[[J K
ProfileImageLimits[[L ^
.[[^ _#
MaximumRequestedPlayers[[_ v
)[[v w
{\\ 
throw]] 
new]] !
ProfileImageException]] /
(]]/ 0$
ProfileImageFailureCodes]]0 H
.]]H I
InvalidImageRequest]]I \
)]]\ ]
;]]] ^
}^^ 
int__ 
[__ 
]__ 
distinctOwnerIds__ "
=__# $
profileOwnerUserIds__% 8
.__8 9
Where__9 >
(__> ?
ownerId__? F
=>__G I
ownerId__J Q
>__R S
$num__T U
)__U V
.__V W
Distinct__W _
(___ `
)__` a
.__a b
ToArray__b i
(__i j
)__j k
;__k l
return`` $
_playerProfileRepository`` +
.``+ ,
GetProfileImages``, <
(``< =
distinctOwnerIds``= M
)``M N
;``N O
}aa 	
publiccc 
bytecc 
[cc 
]cc 
GetProfileImagecc %
(cc% &
Guidcc& *
profileImageIdcc+ 9
)cc9 :
{dd 	
ifee 
(ee 
profileImageIdee 
==ee !
Guidee" &
.ee& '
Emptyee' ,
)ee, -
{ff 
throwgg 
newgg !
ProfileImageExceptiongg /
(gg/ 0$
ProfileImageFailureCodesgg0 H
.ggH I
ImageNotFoundggI V
)ggV W
;ggW X
}hh 
returnii  
_profileImageStorageii '
.ii' (
ReadProfileImageii( 8
(ii8 9
profileImageIdii9 G
)iiG H
;iiH I
}jj 	
}kk 
}ll ˙
lC:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\Ports\Account\IPlayerProfileRepository.cs
	namespace 	
Application
 
. 
Ports 
{ 
public		 

	interface		 $
IPlayerProfileRepository		 -
{

 "
PlayerProfileImageData 
[ 
]  
GetProfileImages! 1
(1 2
int2 5
[5 6
]6 7
profileOwnerUserIds8 K
)K L
;L M
Guid 
ReplaceProfileImage  
(  !
int! $&
authenticatedAccountUserId% ?
,? @
GuidA E
profileImageIdF T
)T U
;U V
} 
} Ó
nC:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\Ports\ProfileImages\IProfileImageStorage.cs
	namespace 	
Application
 
. 
Ports 
{ 
public 

	interface  
IProfileImageStorage )
{		 
void

 
SaveProfileImage

 
(

 
Guid

 "
profileImageId

# 1
,

1 2
byte

3 7
[

7 8
]

8 9'
normalizedProfileImageBytes

: U
)

U V
;

V W
byte 
[ 
] 
ReadProfileImage 
(  
Guid  $
profileImageId% 3
)3 4
;4 5
void 
DeleteProfileImage 
(  
Guid  $
profileImageId% 3
)3 4
;4 5
} 
} †
pC:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\Ports\ProfileImages\IProfileImageProcessor.cs
	namespace 	
Application
 
. 
Ports 
{ 
public 

	interface "
IProfileImageProcessor +
{		 
byte

 
[

 
]

 !
NormalizeProfileImage

 $
(

$ %
byte

% )
[

) *
]

* +%
selectedProfileImageBytes

, E
)

E F
;

F G
} 
} –
pC:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\Models\ProfileImages\ProfileImageException.cs
	namespace 	
Application
 
. 
Models 
{ 
public		 

sealed		 
class		 !
ProfileImageException		 -
:		. /
	Exception		0 9
{

 
public !
ProfileImageException $
($ %
)% &
:' (
this) -
(- .$
ProfileImageFailureCodes. F
.F G
OperationFailedG V
)V W
{ 	
} 	
public !
ProfileImageException $
($ %
string% +
failureCode, 7
)7 8
:9 :
this; ?
(? @
failureCode@ K
,K L
nullM Q
)Q R
{ 	
} 	
public !
ProfileImageException $
($ %
string% +
failureCode, 7
,7 8
	Exception9 B
innerExceptionC Q
)Q R
: 
base 
( 
failureCode 
, 
innerException  .
). /
{ 	
FailureCode 
= 
failureCode %
;% &
} 	
public 
string 
FailureCode !
{" #
get$ '
;' (
}) *
} 
} ¸-
gC:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\UseCases\Account\UserLoginUseCase.cs
	namespace 	
Application
 
{ 
public 

sealed 
class 
UserLoginUseCase (
:) *
IUserLoginUseCase+ <
{ 
private 
const 
string 2
&LoginRejectedInvalidParametersTemplate C
=D E
$str J
;J K
private 
const 
string -
!LoginRejectedUserNotFoundTemplate >
=? @
$str J
;J K
private 
const 
string 3
'LoginRejectedInvalidCredentialsTemplate D
=E F
$str ]
;] ^
private 
const 
string 1
%UserAuthenticatedSuccessfullyTemplate B
=C D
$str G
;G H
private 
readonly 
IUserRepository (
_userRepository) 8
;8 9
private 
readonly 
ILoggerService '
_logger( /
;/ 0
public 
UserLoginUseCase 
(  
IUserRepository  /
userRepository0 >
,> ?
ILoggerService@ N
loggerO U
)U V
{ 	
if 
( 
userRepository 
== !
null" &
)& '
{ 
throw 
new !
ArgumentNullException /
(/ 0
nameof0 6
(6 7
userRepository7 E
)E F
)F G
;G H
} 
_userRepository!! 
=!! 
userRepository!! ,
;!!, -
_logger"" 
="" 
logger"" 
??"" 
throw""  %
new""& )!
ArgumentNullException""* ?
(""? @
nameof""@ F
(""F G
logger""G M
)""M N
)""N O
;""O P
}## 	
public%% !
AuthenticatedUserData%% $
AuthenticateUser%%% 5
(%%5 6
string%%6 <
email%%= B
,%%B C
string%%D J
passwordHash%%K W
)%%W X
{&& 	!
AuthenticatedUserData'' !
authenticatedUser''" 3
=''4 5
null''6 :
;'': ;
if)) 
()) 
IsValidParameter))  
())  !
email))! &
)))& '
&&))( *
IsValidParameter))+ ;
()); <
passwordHash))< H
)))H I
)))I J
{** 
UserAccount++ 
user++  
=++! "
_userRepository++# 2
.++2 3
GetUserByEmail++3 A
(++A B
email++B G
)++G H
;++H I
if,, 
(,, 
user,, 
==,, 
null,,  
),,  !
{-- 
_logger.. 
... 
Warning.. #
(..# $-
!LoginRejectedUserNotFoundTemplate..$ E
,..E F
email..G L
)..L M
;..M N
}// 
else00 
if00 
(00 
!00 
string00  
.00  !
Equals00! '
(00' (
user00( ,
.00, -
PasswordHash00- 9
,009 :
passwordHash00; G
,00G H
StringComparison00I Y
.00Y Z
OrdinalIgnoreCase00Z k
)00k l
)00l m
{11 
_logger22 
.22 
Warning22 #
(22# $3
'LoginRejectedInvalidCredentialsTemplate22$ K
,22K L
email22M R
)22R S
;22S T
}33 
else44 
{55 
_userRepository66 #
.66# $
UpdateLastLogin66$ 3
(663 4
user664 8
.668 9
IdUser669 ?
)66? @
;66@ A
_logger77 
.77 
Information77 '
(77' (1
%UserAuthenticatedSuccessfullyTemplate77( M
,77M N
user77O S
.77S T
Username77T \
,77\ ]
user77^ b
.77b c
IdUser77c i
)77i j
;77j k
authenticatedUser88 %
=88& '
new88( +!
AuthenticatedUserData88, A
{99 
IdUser:: 
=::  
user::! %
.::% &
IdUser::& ,
,::, -
Username;;  
=;;! "
user;;# '
.;;' (
Username;;( 0
,;;0 1
Email<< 
=<< 
user<<  $
.<<$ %
Email<<% *
}== 
;== 
}>> 
}?? 
else@@ 
{AA 
_loggerBB 
.BB 
WarningBB 
(BB  2
&LoginRejectedInvalidParametersTemplateBB  F
)BBF G
;BBG H
}CC 
returnEE 
authenticatedUserEE $
;EE$ %
}FF 	
publicHH 
boolHH 
IsLoginSuccessfulHH %
(HH% &
stringHH& ,
emailHH- 2
,HH2 3
stringHH4 :
passwordHashHH; G
)HHG H
{II 	!
AuthenticatedUserDataJJ !
userJJ" &
=JJ' (
AuthenticateUserJJ) 9
(JJ9 :
emailJJ: ?
,JJ? @
passwordHashJJA M
)JJM N
;JJN O
returnKK 
userKK 
!=KK 
nullKK 
;KK  
}LL 	
privateNN 
boolNN 
IsValidParameterNN %
(NN% &
stringNN& ,
	parameterNN- 6
)NN6 7
{OO 	
returnPP 
!PP 
stringPP 
.PP 
IsNullOrWhiteSpacePP -
(PP- .
	parameterPP. 7
)PP7 8
;PP8 9
}QQ 	
}RR 
}SS çÖ
aC:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\UseCases\Lobby\LobbyUseCase.cs
	namespace 	
Application
 
{ 
public 

sealed 
class 
LobbyUseCase $
:% &
ILobbyUseCase' 4
{ 
private 
const 
int 
ErrorCodeSuccess *
=+ ,
$num- .
;. /
private 
const 
int !
ErrorCodeHostRequired /
=0 1
$num2 5
;5 6
private 
const 
int 3
'ErrorCodeKickedParticipantReentryDenied A
=B C
$numD G
;G H
private 
const 
int %
ErrorCodeValidationFailed 3
=4 5
$num6 9
;9 :
private 
const 
int !
ErrorCodeUserNotFound /
=0 1
$num2 5
;5 6
private 
const 
int "
ErrorCodeLobbyNotFound 0
=1 2
$num3 6
;6 7
private 
const 
int 
ErrorCodeLobbyFull ,
=- .
$num/ 2
;2 3
private 
const 
int $
ErrorCodeLobbyInProgress 2
=3 4
$num5 8
;8 9
private 
const 
int '
ErrorCodePersistenceFailure 5
=6 7
$num8 ;
;; <
private 
const 
string 
MessageLobbyCreated 0
=1 2
$str3 P
;P Q
private 
const 
string 
MessageJoinedLobby /
=0 1
$str2 N
;N O
private 
const 
string  
MessageRejoinedLobby 1
=2 3
$str4 R
;R S
private   
const   
string   
MessagePlayerLeft   .
=  / 0
$str  1 I
;  I J
private!! 
const!! 
string!! 
MessagePlayerKicked!! 0
=!!1 2
$str!!3 V
;!!V W
private"" 
const"" 
string"" #
MessageReadinessUpdated"" 4
=""5 6
$str""7 R
;""R S
private$$ 
const$$ 
string$$ 0
$ErrorMessageDatabaseHostVerification$$ A
=$$B C
$str$$D o
;$$o p
private%% 
const%% 
string%% 2
&ErrorMessageDatabasePlayerVerification%% C
=%%D E
$str%%F n
;%%n o
private&& 
const&& 
string&& $
ErrorMessageHostNotFound&& 5
=&&6 7
$str&&8 [
;&&[ \
private'' 
const'' 
string'' &
ErrorMessagePlayerNotFound'' 7
=''8 9
$str'': Y
;''Y Z
private(( 
const(( 
string(( .
"ErrorMessageInvalidLobbyCodeFormat(( ?
=((@ A
$str((B a
;((a b
private)) 
const)) 
string)) %
ErrorMessageLobbyNotFound)) 6
=))7 8
$str))9 T
;))T U
private** 
const** 
string** *
ErrorMessageUnableToKickPlayer** ;
=**< =
$str**> V
;**V W
private++ 
const++ 
string++ -
!ErrorMessageParticipantNotInLobby++ >
=++? @
$str++A b
;++b c
private,, 
const,, 
string,, ,
 ErrorMessageLobbyMatchInProgress,, =
=,,> ?
$str,,@ n
;,,n o
private-- 
const-- 
string-- !
ErrorMessageLobbyFull-- 2
=--3 4
$str--5 N
;--N O
private// 
const// 
string// %
MatchNotConfiguredMessage// 6
=//7 8
$str//9 M
;//M N
private00 
const00 
string00 
MessageHostRequired00 0
=001 2
$str003 F
;00F G
private11 
const11 
string11 '
MessageConfigurationInvalid11 8
=119 :
$str11; V
;11V W
private22 
const22 
string22 '
MessageReentryTargetInvalid22 8
=229 :
$str22; V
;22V W
private33 
const33 
string33 $
MessageReentryAuthorized33 5
=336 7
$str338 \
;33\ ]
private44 
const44 
string44 1
%MessageKickedParticipantReentryDenied44 B
=44C D
$str44E j
;44j k
private55 
const55 
string55 "
MessageMatchInProgress55 3
=554 5
$str556 L
;55L M
private77 
const77 
string77 ,
 LobbyCreatedSuccessfullyTemplate77 =
=77> ?
$str88 B
;88B C
private99 
const99 
string99 +
LobbyTransitionedToGameTemplate99 <
=99= >
$str:: Q
;::Q R
private;; 
const;; 
string;; "
LobbyDisbandedTemplate;; 3
=;;4 5
$str<< 5
;<<5 6
private== 
const== 
string== +
CreateLobbyHostNotFoundTemplate== <
==== >
$str>> C
;>>C D
private?? 
const?? 
string?? 1
%CreateLobbyPersistenceFailureTemplate?? B
=??C D
$str@@ X
;@@X Y
privateAA 
constAA 
stringAA /
#JoinLobbyPersistenceFailureTemplateAA @
=AAA B
$strBB Z
;BBZ [
privateCC 
constCC 
stringCC .
"ParticipantKickedFromLobbyTemplateCC ?
=CC@ A
$strDD [
;DD[ \
privateFF 
readonlyFF 
IUserRepositoryFF (
_userRepositoryFF) 8
;FF8 9
privateGG 
readonlyGG 
ILobbyHostSelectionGG ,
_lobbyHostSelectionGG- @
;GG@ A
privateHH 
readonlyHH 
ILoggerServiceHH '
_loggerHH( /
;HH/ 0
privateII 
readonlyII  
ConcurrentDictionaryII -
<II- .
stringII. 4
,II4 5
LobbyRoomDataII6 C
>IIC D
_activeLobbiesIIE S
;IIS T
publicKK 
LobbyUseCaseKK 
(KK 
IUserRepositoryKK +
userRepositoryKK, :
,KK: ;
ILobbyHostSelectionKK< O
lobbyHostSelectionKKP b
,KKb c
IMatchUseCaseLL 
matchUseCaseLL &
=LL' (
nullLL) -
,LL- .
ILoggerServiceLL/ =
loggerLL> D
=LLE F
nullLLG K
)LLK L
{MM 	
ifNN 
(NN 
userRepositoryNN 
==NN !
nullNN" &
)NN& '
{OO 
throwPP 
newPP !
ArgumentNullExceptionPP /
(PP/ 0
nameofPP0 6
(PP6 7
userRepositoryPP7 E
)PPE F
)PPF G
;PPG H
}QQ 
MatchSS 
=SS 
matchUseCaseSS  
;SS  !
_userRepositoryTT 
=TT 
userRepositoryTT ,
;TT, -
_lobbyHostSelectionUU 
=UU  !
lobbyHostSelectionUU" 4
;UU4 5
_loggerVV 
=VV 
loggerVV 
??VV 
throwVV  %
newVV& )!
ArgumentNullExceptionVV* ?
(VV? @
nameofVV@ F
(VVF G
loggerVVG M
)VVM N
)VVN O
;VVO P
_activeLobbiesWW 
=WW 
newWW   
ConcurrentDictionaryWW! 5
<WW5 6
stringWW6 <
,WW< =
LobbyRoomDataWW> K
>WWK L
(WWL M
StringComparerWWM [
.WW[ \
OrdinalIgnoreCaseWW\ m
)WWm n
;WWn o
}XX 	
publicZZ 
IMatchUseCaseZZ 
MatchZZ "
{ZZ# $
getZZ% (
;ZZ( )
}ZZ* +
public\\ 
LobbyActionOutcome\\ !
CreateLobby\\" -
(\\- .
int\\. 1

hostUserId\\2 <
,\\< =
LobbyConfiguration\\> P
lobbyConfiguration\\Q c
)\\c d
{]] 	
LobbyActionOutcome^^ 
outcome^^ &
;^^& '
UserAccount__ 
hostAccount__ #
=__$ %
TryFindUser__& 1
(__1 2

hostUserId__2 <
,__< =
out__> A
bool__B F
hasDatabaseError__G W
)__W X
;__X Y
ifaa 
(aa 
hasDatabaseErroraa  
)aa  !
{bb 
_loggercc 
.cc 
Warningcc 
(cc  1
%CreateLobbyPersistenceFailureTemplatecc  E
,ccE F

hostUserIdccG Q
)ccQ R
;ccR S
outcomedd 
=dd 
CreateErrorOutcomedd ,
(dd, -'
ErrorCodePersistenceFailuredd- H
,ddH I0
$ErrorMessageDatabaseHostVerificationddJ n
)ddn o
;ddo p
}ee 
elseff 
ifff 
(ff 
hostAccountff  
==ff! #
nullff$ (
)ff( )
{gg 
_loggerhh 
.hh 
Warninghh 
(hh  +
CreateLobbyHostNotFoundTemplatehh  ?
,hh? @

hostUserIdhhA K
)hhK L
;hhL M
outcomeii 
=ii 
CreateErrorOutcomeii ,
(ii, -!
ErrorCodeUserNotFoundii- B
,iiB C$
ErrorMessageHostNotFoundiiD \
)ii\ ]
;ii] ^
}jj 
elsekk 
{ll 
outcomemm 
=mm 
InitializeNewLobbymm ,
(mm, -
hostAccountmm- 8
,mm8 9
lobbyConfigurationmm: L
)mmL M
;mmM N
}nn 
returnpp 
outcomepp 
;pp 
}qq 	
publicss 
LobbyActionOutcomess !
	JoinLobbyss" +
(ss+ ,
stringss, 2
	lobbyCodess3 <
,ss< =
intss> A
userIdssB H
)ssH I
{tt 	
LobbyActionOutcomeuu 
outcomeuu &
;uu& '
stringvv 
normalizedCodevv !
=vv" #
LobbyCodeRulesvv$ 2
.vv2 3
NormalizeCodevv3 @
(vv@ A
	lobbyCodevvA J
)vvJ K
;vvK L
ifxx 
(xx 
!xx 
LobbyCodeRulesxx 
.xx  
IsCodeFormatValidxx  1
(xx1 2
normalizedCodexx2 @
)xx@ A
)xxA B
{yy 
outcomezz 
=zz 
CreateErrorOutcomezz ,
(zz, -%
ErrorCodeValidationFailedzz- F
,zzF G.
"ErrorMessageInvalidLobbyCodeFormatzzH j
)zzj k
;zzk l
}{{ 
else|| 
if|| 
(|| 
!|| 
_activeLobbies|| $
.||$ %
TryGetValue||% 0
(||0 1
normalizedCode||1 ?
,||? @
out||A D
LobbyRoomData||E R
lobby||S X
)||X Y
)||Y Z
{}} 
outcome~~ 
=~~ 
CreateErrorOutcome~~ ,
(~~, -"
ErrorCodeLobbyNotFound~~- C
,~~C D%
ErrorMessageLobbyNotFound~~E ^
)~~^ _
;~~_ `
} 
else
ÄÄ 
{
ÅÅ 
outcome
ÇÇ 
=
ÇÇ &
TryAddParticipantToLobby
ÇÇ 2
(
ÇÇ2 3
lobby
ÇÇ3 8
,
ÇÇ8 9
userId
ÇÇ: @
)
ÇÇ@ A
;
ÇÇA B
}
ÉÉ 
return
ÖÖ 
outcome
ÖÖ 
;
ÖÖ 
}
ÜÜ 	
public
àà  
LobbyActionOutcome
àà !

LeaveLobby
àà" ,
(
àà, -
string
àà- 3
	lobbyCode
àà4 =
,
àà= >
int
àà? B
userId
ààC I
)
ààI J
{
ââ 	 
LobbyActionOutcome
ää 
outcome
ää &
=
ää' ( 
CreateErrorOutcome
ää) ;
(
ää; <$
ErrorCodeLobbyNotFound
ää< R
,
ääR S'
ErrorMessageLobbyNotFound
ääT m
)
ääm n
;
ään o
string
ãã 
normalizedCode
ãã !
=
ãã" #
LobbyCodeRules
ãã$ 2
.
ãã2 3
NormalizeCode
ãã3 @
(
ãã@ A
	lobbyCode
ããA J
)
ããJ K
;
ããK L
if
çç 
(
çç 
_activeLobbies
çç 
.
çç 
TryGetValue
çç *
(
çç* +
normalizedCode
çç+ 9
,
çç9 :
out
çç; >
LobbyRoomData
çç? L
lobby
ççM R
)
ççR S
)
ççS T
{
éé 
outcome
èè 
=
èè '
RemoveParticipantFromRoom
èè 3
(
èè3 4
lobby
èè4 9
,
èè9 :
userId
èè; A
)
èèA B
;
èèB C
if
êê 
(
êê 
outcome
êê 
.
êê 
IsRoomDisbanded
êê +
||
êê, .
(
êê/ 0
outcome
êê0 7
.
êê7 8
Lobby
êê8 =
!=
êê> @
null
êêA E
&&
êêF H
outcome
êêI P
.
êêP Q
Lobby
êêQ V
.
êêV W
Players
êêW ^
.
êê^ _
Count
êê_ d
==
êêe g
$num
êêh i
)
êêi j
)
êêj k
{
ëë 
_activeLobbies
íí "
.
íí" #
	TryRemove
íí# ,
(
íí, -
normalizedCode
íí- ;
,
íí; <
out
íí= @
LobbyRoomData
ííA N
_
ííO P
)
ííP Q
;
ííQ R
_logger
ìì 
.
ìì 
Information
ìì '
(
ìì' ($
LobbyDisbandedTemplate
ìì( >
,
ìì> ?
normalizedCode
ìì@ N
)
ììN O
;
ììO P
}
îî 
}
ïï 
return
óó 
outcome
óó 
;
óó 
}
òò 	
public
öö  
LobbyActionOutcome
öö !

KickPlayer
öö" ,
(
öö, -
string
öö- 3
	lobbyCode
öö4 =
,
öö= >
int
öö? B

hostUserId
ööC M
,
ööM N
int
ööO R
targetUserId
ööS _
)
öö_ `
{
õõ 	 
LobbyActionOutcome
úú 
outcome
úú &
=
úú' ( 
CreateErrorOutcome
úú) ;
(
úú; <'
ErrorCodeValidationFailed
úú< U
,
úúU V,
ErrorMessageUnableToKickPlayer
úúW u
)
úúu v
;
úúv w
string
ùù 
normalizedCode
ùù !
=
ùù" #
LobbyCodeRules
ùù$ 2
.
ùù2 3
NormalizeCode
ùù3 @
(
ùù@ A
	lobbyCode
ùùA J
)
ùùJ K
;
ùùK L
if
üü 
(
üü 

hostUserId
üü 
!=
üü 
targetUserId
üü *
&&
üü+ -
_activeLobbies
üü. <
.
üü< =
TryGetValue
üü= H
(
üüH I
normalizedCode
üüI W
,
üüW X
out
üüY \
LobbyRoomData
üü] j
lobby
üük p
)
üüp q
)
üüq r
{
†† 
outcome
°° 
=
°° )
TryKickParticipantUnderLock
°° 5
(
°°5 6
lobby
°°6 ;
,
°°; <

hostUserId
°°= G
,
°°G H
targetUserId
°°I U
)
°°U V
;
°°V W
}
¢¢ 
return
§§ 
outcome
§§ 
;
§§ 
}
•• 	
public
®®  
LobbyActionOutcome
®® !*
AuthorizeKickedPlayerReentry
®®" >
(
®®> ?
string
®®? E
	lobbyCode
®®F O
,
®®O P
int
®®Q T

hostUserId
®®U _
,
®®_ `
int
®®a d
targetUserId
®®e q
)
®®q r
{
©© 	 
LobbyActionOutcome
™™ "
reentryAuthorization
™™ 3
=
™™4 5 
CreateErrorOutcome
™™6 H
(
™™H I$
ErrorCodeLobbyNotFound
™™I _
,
™™_ `'
ErrorMessageLobbyNotFound
´´ )
)
´´) *
;
´´* +
string
¨¨ 
normalizedCode
¨¨ !
=
¨¨" #
LobbyCodeRules
¨¨$ 2
.
¨¨2 3
NormalizeCode
¨¨3 @
(
¨¨@ A
	lobbyCode
¨¨A J
)
¨¨J K
;
¨¨K L
if
≠≠ 
(
≠≠ 
_activeLobbies
≠≠ 
.
≠≠ 
TryGetValue
≠≠ *
(
≠≠* +
normalizedCode
≠≠+ 9
,
≠≠9 :
out
≠≠; >
LobbyRoomData
≠≠? L
lobby
≠≠M R
)
≠≠R S
)
≠≠S T
{
ÆÆ "
reentryAuthorization
ØØ $
=
ØØ% &'
AuthorizeReentryUnderLock
ØØ' @
(
ØØ@ A
lobby
ØØA F
,
ØØF G

hostUserId
ØØH R
,
ØØR S
targetUserId
ØØT `
)
ØØ` a
;
ØØa b
}
∞∞ 
return
≤≤ "
reentryAuthorization
≤≤ '
;
≤≤' (
}
≥≥ 	
public
µµ  
LobbyActionOutcome
µµ !#
UpdatePlayerReadiness
µµ" 7
(
µµ7 8
string
µµ8 >
	lobbyCode
µµ? H
,
µµH I
int
µµJ M
userId
µµN T
,
µµT U
bool
µµV Z
isReady
µµ[ b
)
µµb c
{
∂∂ 	 
LobbyActionOutcome
∑∑ 
outcome
∑∑ &
=
∑∑' ( 
CreateErrorOutcome
∑∑) ;
(
∑∑; <$
ErrorCodeLobbyNotFound
∏∏ &
,
∏∏& '/
!ErrorMessageParticipantNotInLobby
ππ 1
)
ππ1 2
;
ππ2 3
string
∫∫ 
normalizedCode
∫∫ !
=
∫∫" #
LobbyCodeRules
∫∫$ 2
.
∫∫2 3
NormalizeCode
∫∫3 @
(
∫∫@ A
	lobbyCode
∫∫A J
)
∫∫J K
;
∫∫K L
if
ºº 
(
ºº 
_activeLobbies
ºº 
.
ºº 
TryGetValue
ºº *
(
ºº* +
normalizedCode
ºº+ 9
,
ºº9 :
out
ºº; >
LobbyRoomData
ºº? L
lobby
ººM R
)
ººR S
)
ººS T
{
ΩΩ 
outcome
ææ 
=
ææ )
TryUpdateReadinessUnderLock
ææ 5
(
ææ5 6
lobby
ææ6 ;
,
ææ; <
userId
ææ= C
,
ææC D
isReady
ææE L
)
ææL M
;
ææM N
}
øø 
return
¡¡ 
outcome
¡¡ 
;
¡¡ 
}
¬¬ 	
public
ƒƒ 
string
ƒƒ $
GetParticipantUsername
ƒƒ ,
(
ƒƒ, -
string
ƒƒ- 3
	lobbyCode
ƒƒ4 =
,
ƒƒ= >
int
ƒƒ? B
userId
ƒƒC I
)
ƒƒI J
{
≈≈ 	
string
∆∆ 
username
∆∆ 
=
∆∆ 
null
∆∆ "
;
∆∆" #
string
«« 
normalizedCode
«« !
=
««" #
LobbyCodeRules
««$ 2
.
««2 3
NormalizeCode
««3 @
(
««@ A
	lobbyCode
««A J
)
««J K
;
««K L
if
…… 
(
…… 
_activeLobbies
…… 
.
…… 
TryGetValue
…… *
(
……* +
normalizedCode
……+ 9
,
……9 :
out
……; >
LobbyRoomData
……? L
lobby
……M R
)
……R S
)
……S T
{
   
lock
ÀÀ 
(
ÀÀ 
lobby
ÀÀ 
)
ÀÀ 
{
ÃÃ "
LobbyParticipantData
ÕÕ (
participant
ÕÕ) 4
=
ÕÕ5 6!
FindParticipantById
ÕÕ7 J
(
ÕÕJ K
lobby
ÕÕK P
,
ÕÕP Q
userId
ÕÕR X
)
ÕÕX Y
;
ÕÕY Z
if
ŒŒ 
(
ŒŒ 
participant
ŒŒ #
!=
ŒŒ$ &
null
ŒŒ' +
)
ŒŒ+ ,
{
œœ 
username
––  
=
––! "
participant
––# .
.
––. /
Username
––/ 7
;
––7 8
}
—— 
}
““ 
}
”” 
return
’’ 
username
’’ 
;
’’ 
}
÷÷ 	
public
ÿÿ 
bool
ÿÿ &
CanTransitionLobbyToGame
ÿÿ ,
(
ÿÿ, -
string
ÿÿ- 3
	lobbyCode
ÿÿ4 =
,
ÿÿ= >
int
ÿÿ? B

hostUserId
ÿÿC M
)
ÿÿM N
{
ŸŸ 	
bool
⁄⁄ 
canStart
⁄⁄ 
=
⁄⁄ 
false
⁄⁄ !
;
⁄⁄! "
string
€€ 
normalizedCode
€€ !
=
€€" #
LobbyCodeRules
€€$ 2
.
€€2 3
NormalizeCode
€€3 @
(
€€@ A
	lobbyCode
€€A J
)
€€J K
;
€€K L
if
›› 
(
›› 
_activeLobbies
›› 
.
›› 
TryGetValue
›› *
(
››* +
normalizedCode
››+ 9
,
››9 :
out
››; >
LobbyRoomData
››? L
lobby
››M R
)
››R S
)
››S T
{
ﬁﬁ 
lock
ﬂﬂ 
(
ﬂﬂ 
lobby
ﬂﬂ 
)
ﬂﬂ 
{
‡‡ 
bool
·· 
isRequestedByHost
·· *
=
··+ ,
lobby
··- 2
.
··2 3

HostUserId
··3 =
==
··> @

hostUserId
··A K
;
··K L
if
‚‚ 
(
‚‚ 
isRequestedByHost
‚‚ )
&&
‚‚* ,
lobby
‚‚- 2
.
‚‚2 3
Status
‚‚3 9
==
‚‚: <
LobbyRoomRules
‚‚= K
.
‚‚K L
StatusInGame
‚‚L X
)
‚‚X Y
{
„„ 
canStart
‰‰  
=
‰‰! "
true
‰‰# '
;
‰‰' (
}
ÂÂ 
bool
ÊÊ  
isEveryPlayerReady
ÊÊ +
=
ÊÊ, -
lobby
ÊÊ. 3
.
ÊÊ3 4
Players
ÊÊ4 ;
.
ÊÊ; <
All
ÊÊ< ?
(
ÊÊ? @
player
ÊÊ@ F
=>
ÊÊG I
player
ÊÊJ P
.
ÊÊP Q
IsReady
ÊÊQ X
||
ÊÊY [
player
ÊÊ\ b
.
ÊÊb c
IsHost
ÊÊc i
)
ÊÊi j
;
ÊÊj k
if
ËË 
(
ËË 
isRequestedByHost
ËË )
&&
ËË* ,
LobbyRoomRules
ÈÈ &
.
ÈÈ& '
CanLaunchMatch
ÈÈ' 5
(
ÈÈ5 6
lobby
ÈÈ6 ;
.
ÈÈ; <
Players
ÈÈ< C
.
ÈÈC D
Count
ÈÈD I
,
ÈÈI J 
isEveryPlayerReady
ÈÈK ]
,
ÈÈ] ^
lobby
ÈÈ_ d
.
ÈÈd e
Status
ÈÈe k
)
ÈÈk l
)
ÈÈl m
{
ÍÍ 
if
ÎÎ 
(
ÎÎ 
Match
ÎÎ !
==
ÎÎ" $
null
ÎÎ% )
)
ÎÎ) *
{
ÏÏ 
throw
ÌÌ !
new
ÌÌ" %'
InvalidOperationException
ÌÌ& ?
(
ÌÌ? @'
MatchNotConfiguredMessage
ÌÌ@ Y
)
ÌÌY Z
;
ÌÌZ [
}
ÓÓ 
Match
ÔÔ 
.
ÔÔ 

StartMatch
ÔÔ (
(
ÔÔ( )
new
ÔÔ) ,
MatchStartContext
ÔÔ- >
{
 
	LobbyCode
ÒÒ %
=
ÒÒ& '
lobby
ÒÒ( -
.
ÒÒ- .
	LobbyCode
ÒÒ. 7
,
ÒÒ7 8
LobbyInstanceId
ÚÚ +
=
ÚÚ, -
lobby
ÚÚ. 3
.
ÚÚ3 4
LobbyInstanceId
ÚÚ4 C
,
ÚÚC D 
ParticipantUserIds
ÛÛ .
=
ÛÛ/ 0
lobby
ÛÛ1 6
.
ÛÛ6 7
Players
ÛÛ7 >
.
ÛÛ> ?
Select
ÛÛ? E
(
ÛÛE F
player
ÛÛF L
=>
ÛÛM O
player
ÛÛP V
.
ÛÛV W
IdUser
ÛÛW ]
)
ÛÛ] ^
.
ÛÛ^ _
ToArray
ÛÛ_ f
(
ÛÛf g
)
ÛÛg h
,
ÛÛh i 
TargetMissionCount
ÙÙ .
=
ÙÙ/ 0
lobby
ÙÙ1 6
.
ÙÙ6 7 
TargetMissionCount
ÙÙ7 I
}
ıı 
)
ıı 
;
ıı 
lobby
ˆˆ 
.
ˆˆ 
Status
ˆˆ $
=
ˆˆ% &
LobbyRoomRules
ˆˆ' 5
.
ˆˆ5 6
StatusInGame
ˆˆ6 B
;
ˆˆB C
lobby
˜˜ 
.
˜˜ 
StateVersion
˜˜ *
++
˜˜* ,
;
˜˜, -
_logger
¯¯ 
.
¯¯  
Information
¯¯  +
(
¯¯+ ,-
LobbyTransitionedToGameTemplate
¯¯, K
,
¯¯K L
lobby
¯¯M R
.
¯¯R S
	LobbyCode
¯¯S \
,
¯¯\ ]
lobby
¯¯^ c
.
¯¯c d
Players
¯¯d k
.
¯¯k l
Count
¯¯l q
)
¯¯q r
;
¯¯r s
canStart
˘˘  
=
˘˘! "
true
˘˘# '
;
˘˘' (
}
˙˙ 
}
˚˚ 
}
¸¸ 
return
˛˛ 
canStart
˛˛ 
;
˛˛ 
}
ˇˇ 	
public
ÅÅ  
LobbyActionOutcome
ÅÅ !!
UpdateLobbySettings
ÅÅ" 5
(
ÅÅ5 6
string
ÅÅ6 <
	lobbyCode
ÅÅ= F
,
ÅÅF G
int
ÅÅH K
requesterUserId
ÅÅL [
,
ÅÅ[ \ 
LobbyConfiguration
ÇÇ  
lobbyConfiguration
ÇÇ 1
)
ÇÇ1 2
{
ÉÉ 	 
LobbyActionOutcome
ÑÑ !
configurationUpdate
ÑÑ 2
=
ÑÑ3 4 
CreateErrorOutcome
ÑÑ5 G
(
ÑÑG H$
ErrorCodeLobbyNotFound
ÖÖ &
,
ÖÖ& ''
ErrorMessageLobbyNotFound
ÖÖ( A
)
ÖÖA B
;
ÖÖB C
if
ÜÜ 
(
ÜÜ 
_activeLobbies
ÜÜ 
.
ÜÜ 
TryGetValue
ÜÜ *
(
ÜÜ* +
LobbyCodeRules
ÜÜ+ 9
.
ÜÜ9 :
NormalizeCode
ÜÜ: G
(
ÜÜG H
	lobbyCode
ÜÜH Q
)
ÜÜQ R
,
ÜÜR S
out
ÜÜT W
LobbyRoomData
ÜÜX e
lobby
ÜÜf k
)
ÜÜk l
)
ÜÜl m
{
áá 
lock
àà 
(
àà 
lobby
àà 
)
àà 
{
ââ !
configurationUpdate
ää '
=
ää( )%
ApplyLobbyConfiguration
ää* A
(
ääA B
lobby
ääB G
,
ääG H
requesterUserId
ääI X
,
ääX Y 
lobbyConfiguration
ääZ l
)
ääl m
;
ääm n
}
ãã 
}
åå 
return
éé !
configurationUpdate
éé &
;
éé& '
}
èè 	
public
ëë  
LobbyActionOutcome
ëë !(
DisconnectLobbyParticipant
ëë" <
(
ëë< =
string
ëë= C
	lobbyCode
ëëD M
,
ëëM N
int
ëëO R
participantUserId
ëëS d
)
ëëd e
{
íí 	 
LobbyActionOutcome
ìì "
participantDeparture
ìì 3
=
ìì4 5 
CreateErrorOutcome
ìì6 H
(
ììH I&
ErrorCodeLobbyInProgress
îî (
,
îî( ).
 ErrorMessageLobbyMatchInProgress
îî* J
)
îîJ K
;
îîK L
if
ïï 
(
ïï 
_activeLobbies
ïï 
.
ïï 
TryGetValue
ïï *
(
ïï* +
LobbyCodeRules
ïï+ 9
.
ïï9 :
NormalizeCode
ïï: G
(
ïïG H
	lobbyCode
ïïH Q
)
ïïQ R
,
ïïR S
out
ïïT W
LobbyRoomData
ïïX e
lobby
ïïf k
)
ïïk l
)
ïïl m
{
ññ "
participantDeparture
óó $
=
óó% &2
$RemoveDisconnectedWaitingParticipant
óó' K
(
óóK L
lobby
óóL Q
,
óóQ R
participantUserId
óóS d
)
óód e
;
óóe f
}
òò 
return
öö "
participantDeparture
öö '
;
öö' (
}
õõ 	
private
ùù  
LobbyActionOutcome
ùù "2
$RemoveDisconnectedWaitingParticipant
ùù# G
(
ùùG H
LobbyRoomData
ùùH U
lobby
ùùV [
,
ùù[ \
int
ùù] `
participantUserId
ùùa r
)
ùùr s
{
ûû 	 
LobbyActionOutcome
üü "
participantDeparture
üü 3
=
üü4 5 
CreateErrorOutcome
üü6 H
(
üüH I&
ErrorCodeLobbyInProgress
†† (
,
††( ).
 ErrorMessageLobbyMatchInProgress
††* J
)
††J K
;
††K L
lock
°° 
(
°° 
lobby
°° 
)
°° 
{
¢¢ 
if
££ 
(
££ 
LobbyRoomRules
££ "
.
££" #%
IsRoomWaitingForPlayers
££# :
(
££: ;
lobby
££; @
.
££@ A
Status
££A G
)
££G H
)
££H I
{
§§ "
participantDeparture
•• (
=
••) *

LeaveLobby
••+ 5
(
••5 6
lobby
••6 ;
.
••; <
	LobbyCode
••< E
,
••E F
participantUserId
••G X
)
••X Y
;
••Y Z
}
¶¶ 
}
ßß 
return
©© "
participantDeparture
©© '
;
©©' (
}
™™ 	
private
¨¨ 
static
¨¨  
LobbyActionOutcome
¨¨ )%
ApplyLobbyConfiguration
¨¨* A
(
¨¨A B
LobbyRoomData
¨¨B O
lobby
¨¨P U
,
¨¨U V
int
¨¨W Z
requesterUserId
¨¨[ j
,
¨¨j k 
LobbyConfiguration
≠≠  
lobbyConfiguration
≠≠ 1
)
≠≠1 2
{
ÆÆ 	 
LobbyActionOutcome
ØØ !
configurationUpdate
ØØ 2
=
ØØ3 4(
ValidateLobbyConfiguration
ØØ5 O
(
ØØO P
lobby
ØØP U
,
ØØU V
requesterUserId
ØØW f
,
ØØf g 
lobbyConfiguration
∞∞ "
)
∞∞" #
;
∞∞# $
if
±± 
(
±± !
configurationUpdate
±± #
.
±±# $
	IsSuccess
±±$ -
)
±±- .
{
≤≤ $
ApplyChangedLobbyRules
≥≥ &
(
≥≥& '
lobby
≥≥' ,
,
≥≥, - 
lobbyConfiguration
≥≥. @
)
≥≥@ A
;
≥≥A B!
configurationUpdate
¥¥ #
.
¥¥# $
Lobby
¥¥$ )
=
¥¥* + 
CreateRoomSnapshot
¥¥, >
(
¥¥> ?
lobby
¥¥? D
)
¥¥D E
;
¥¥E F
}
µµ 
return
∑∑ !
configurationUpdate
∑∑ &
;
∑∑& '
}
∏∏ 	
private
∫∫ 
static
∫∫  
LobbyActionOutcome
∫∫ )(
ValidateLobbyConfiguration
∫∫* D
(
∫∫D E
LobbyRoomData
∫∫E R
lobby
∫∫S X
,
∫∫X Y
int
∫∫Z ]
requesterUserId
∫∫^ m
,
∫∫m n 
LobbyConfiguration
ªª  
lobbyConfiguration
ªª 1
)
ªª1 2
{
ºº 	 
LobbyActionOutcome
ΩΩ %
configurationValidation
ΩΩ 6
=
ΩΩ7 8
new
ΩΩ9 < 
LobbyActionOutcome
ΩΩ= O
{
ΩΩP Q
	IsSuccess
ΩΩR [
=
ΩΩ\ ]
true
ΩΩ^ b
}
ΩΩc d
;
ΩΩd e
if
ææ 
(
ææ 
lobby
ææ 
.
ææ 

HostUserId
ææ  
!=
ææ! #
requesterUserId
ææ$ 3
)
ææ3 4
{
øø %
configurationValidation
¿¿ '
=
¿¿( ) 
CreateErrorOutcome
¿¿* <
(
¿¿< =#
ErrorCodeHostRequired
¿¿= R
,
¿¿R S!
MessageHostRequired
¿¿T g
)
¿¿g h
;
¿¿h i
}
¡¡ 
else
¬¬ 
if
¬¬ 
(
¬¬ 
!
¬¬ 
LobbyRoomRules
¬¬ $
.
¬¬$ %%
IsRoomWaitingForPlayers
¬¬% <
(
¬¬< =
lobby
¬¬= B
.
¬¬B C
Status
¬¬C I
)
¬¬I J
)
¬¬J K
{
√√ %
configurationValidation
ƒƒ '
=
ƒƒ( ) 
CreateErrorOutcome
ƒƒ* <
(
ƒƒ< =&
ErrorCodeLobbyInProgress
ƒƒ= U
,
ƒƒU V$
MessageMatchInProgress
ƒƒW m
)
ƒƒm n
;
ƒƒn o
}
≈≈ 
else
∆∆ 
if
∆∆ 
(
∆∆  
lobbyConfiguration
∆∆ '
==
∆∆( *
null
∆∆+ /
||
∆∆0 2
!
∆∆3 4
LobbyRoomRules
∆∆4 B
.
∆∆B C"
IsConfigurationValid
∆∆C W
(
∆∆W X 
lobbyConfiguration
«« "
.
««" # 
TargetMissionCount
««# 5
,
««5 6 
lobbyConfiguration
««7 I
.
««I J
PlayerLimit
««J U
,
««U V
lobby
««W \
.
««\ ]
Players
««] d
.
««d e
Count
««e j
)
««j k
)
««k l
{
»» %
configurationValidation
…… '
=
……( ) 
CreateErrorOutcome
……* <
(
……< ='
ErrorCodeValidationFailed
……= V
,
……V W)
MessageConfigurationInvalid
……X s
)
……s t
;
……t u
}
   
return
ÃÃ %
configurationValidation
ÃÃ *
;
ÃÃ* +
}
ÕÕ 	
private
œœ 
static
œœ 
void
œœ $
ApplyChangedLobbyRules
œœ 2
(
œœ2 3
LobbyRoomData
œœ3 @
lobby
œœA F
,
œœF G 
LobbyConfiguration
œœH Z 
lobbyConfiguration
œœ[ m
)
œœm n
{
–– 	
bool
—— %
hasConfigurationChanged
—— (
=
——) *
lobby
——+ 0
.
——0 1 
TargetMissionCount
——1 C
!=
——D F 
lobbyConfiguration
——G Y
.
——Y Z 
TargetMissionCount
——Z l
||
——m o
lobby
““ 
.
““ 
PlayerLimit
““ !
!=
““" $ 
lobbyConfiguration
““% 7
.
““7 8
PlayerLimit
““8 C
||
““D F
lobby
““G L
.
““L M
	IsPrivate
““M V
!=
““W Y 
lobbyConfiguration
““Z l
.
““l m
	IsPrivate
““m v
;
““v w
if
”” 
(
”” %
hasConfigurationChanged
”” '
)
””' (
{
‘‘ 
lobby
’’ 
.
’’  
TargetMissionCount
’’ (
=
’’) * 
lobbyConfiguration
’’+ =
.
’’= > 
TargetMissionCount
’’> P
;
’’P Q
lobby
÷÷ 
.
÷÷ 
PlayerLimit
÷÷ !
=
÷÷" # 
lobbyConfiguration
÷÷$ 6
.
÷÷6 7
PlayerLimit
÷÷7 B
;
÷÷B C
lobby
◊◊ 
.
◊◊ 
	IsPrivate
◊◊ 
=
◊◊  ! 
lobbyConfiguration
◊◊" 4
.
◊◊4 5
	IsPrivate
◊◊5 >
;
◊◊> ?
lobby
ÿÿ 
.
ÿÿ 
Players
ÿÿ 
.
ÿÿ 
ForEach
ÿÿ %
(
ÿÿ% &'
ResetParticipantReadiness
ÿÿ& ?
)
ÿÿ? @
;
ÿÿ@ A
lobby
ŸŸ 
.
ŸŸ 
StateVersion
ŸŸ "
++
ŸŸ" $
;
ŸŸ$ %
}
⁄⁄ 
}
€€ 	
private
›› 
static
›› 
void
›› '
ResetParticipantReadiness
›› 5
(
››5 6"
LobbyParticipantData
››6 J
participant
››K V
)
››V W
{
ﬁﬁ 	
participant
ﬂﬂ 
.
ﬂﬂ 
IsReady
ﬂﬂ 
=
ﬂﬂ  !
false
ﬂﬂ" '
;
ﬂﬂ' (
}
‡‡ 	
private
‚‚ 
void
‚‚ 
TransferLobbyHost
‚‚ &
(
‚‚& '
LobbyRoomData
‚‚' 4
lobby
‚‚5 :
)
‚‚: ;
{
„„ 	
int
‰‰  
selectedHostUserId
‰‰ "
=
‰‰# $!
_lobbyHostSelection
‰‰% 8
.
‰‰8 9
SelectHostUserId
‰‰9 I
(
‰‰I J
lobby
ÂÂ 
.
ÂÂ 
Players
ÂÂ 
.
ÂÂ 
Select
ÂÂ $
(
ÂÂ$ %
participant
ÂÂ% 0
=>
ÂÂ1 3
participant
ÂÂ4 ?
.
ÂÂ? @
IdUser
ÂÂ@ F
)
ÂÂF G
.
ÂÂG H
ToList
ÂÂH N
(
ÂÂN O
)
ÂÂO P
)
ÂÂP Q
;
ÂÂQ R
lobby
ÊÊ 
.
ÊÊ 

HostUserId
ÊÊ 
=
ÊÊ  
selectedHostUserId
ÊÊ 1
;
ÊÊ1 2
foreach
ÁÁ 
(
ÁÁ "
LobbyParticipantData
ÁÁ )
participant
ÁÁ* 5
in
ÁÁ6 8
lobby
ÁÁ9 >
.
ÁÁ> ?
Players
ÁÁ? F
)
ÁÁF G
{
ËË 
participant
ÈÈ 
.
ÈÈ 
IsHost
ÈÈ "
=
ÈÈ# $
participant
ÈÈ% 0
.
ÈÈ0 1
IdUser
ÈÈ1 7
==
ÈÈ8 : 
selectedHostUserId
ÈÈ; M
;
ÈÈM N
}
ÍÍ 
}
ÎÎ 	
private
ÌÌ  
LobbyActionOutcome
ÌÌ " 
InitializeNewLobby
ÌÌ# 5
(
ÌÌ5 6
UserAccount
ÓÓ 
hostAccount
ÓÓ #
,
ÓÓ# $ 
LobbyConfiguration
ÔÔ  
lobbyConfiguration
ÔÔ 1
)
ÔÔ1 2
{
 	
byte
ÒÒ 
sanitizedMissions
ÒÒ "
=
ÒÒ# $
LobbyRoomRules
ÒÒ% 3
.
ÒÒ3 4'
ResolveTargetMissionCount
ÒÒ4 M
(
ÒÒM N 
lobbyConfiguration
ÒÒN `
.
ÒÒ` a 
TargetMissionCount
ÒÒa s
)
ÒÒs t
;
ÒÒt u
byte
ÚÚ 
sanitizedLimit
ÚÚ 
=
ÚÚ  !
LobbyRoomRules
ÚÚ" 0
.
ÚÚ0 1 
ResolvePlayerLimit
ÚÚ1 C
(
ÚÚC D 
lobbyConfiguration
ÚÚD V
.
ÚÚV W
PlayerLimit
ÚÚW b
)
ÚÚb c
;
ÚÚc d
string
ÛÛ 
generatedCode
ÛÛ  
=
ÛÛ! "%
GenerateUniqueLobbyCode
ÛÛ# :
(
ÛÛ: ;
)
ÛÛ; <
;
ÛÛ< ="
LobbyParticipantData
ıı  
hostParticipant
ıı! 0
=
ıı1 2
new
ıı3 6"
LobbyParticipantData
ıı7 K
{
ˆˆ 
IdUser
˜˜ 
=
˜˜ 
hostAccount
˜˜ $
.
˜˜$ %
IdUser
˜˜% +
,
˜˜+ ,
Username
¯¯ 
=
¯¯ 
hostAccount
¯¯ &
.
¯¯& '
Username
¯¯' /
,
¯¯/ 0
IsHost
˘˘ 
=
˘˘ 
true
˘˘ 
,
˘˘ 
IsReady
˙˙ 
=
˙˙ 
true
˙˙ 
}
˚˚ 
;
˚˚ 
LobbyRoomData
˝˝ 
newLobby
˝˝ "
=
˝˝# $
new
˝˝% (
LobbyRoomData
˝˝) 6
{
˛˛ 
	LobbyCode
ˇˇ 
=
ˇˇ 
generatedCode
ˇˇ )
,
ˇˇ) *

HostUserId
ÄÄ 
=
ÄÄ 
hostAccount
ÄÄ (
.
ÄÄ( )
IdUser
ÄÄ) /
,
ÄÄ/ 0 
TargetMissionCount
ÅÅ "
=
ÅÅ# $
sanitizedMissions
ÅÅ% 6
,
ÅÅ6 7
PlayerLimit
ÇÇ 
=
ÇÇ 
sanitizedLimit
ÇÇ ,
,
ÇÇ, -
Status
ÉÉ 
=
ÉÉ 
LobbyRoomRules
ÉÉ '
.
ÉÉ' (
StatusWaiting
ÉÉ( 5
,
ÉÉ5 6
	IsPrivate
ÑÑ 
=
ÑÑ  
lobbyConfiguration
ÑÑ .
.
ÑÑ. /
	IsPrivate
ÑÑ/ 8
,
ÑÑ8 9
StateVersion
ÖÖ 
=
ÖÖ 
$num
ÖÖ  
,
ÖÖ  !
Players
ÜÜ 
=
ÜÜ 
new
ÜÜ 
List
ÜÜ "
<
ÜÜ" #"
LobbyParticipantData
ÜÜ# 7
>
ÜÜ7 8
{
ÜÜ9 :
hostParticipant
ÜÜ; J
}
ÜÜK L
}
áá 
;
áá 
_activeLobbies
ââ 
[
ââ 
generatedCode
ââ (
]
ââ( )
=
ââ* +
newLobby
ââ, 4
;
ââ4 5
_logger
ää 
.
ää 
Information
ää 
(
ää  .
 LobbyCreatedSuccessfullyTemplate
ää  @
,
ää@ A
generatedCode
ääB O
,
ääO P
hostAccount
ääQ \
.
ää\ ]
IdUser
ää] c
)
ääc d
;
ääd e
return
åå 
new
åå  
LobbyActionOutcome
åå )
{
çç 
	IsSuccess
éé 
=
éé 
true
éé  
,
éé  !
	ErrorCode
èè 
=
èè 
ErrorCodeSuccess
èè ,
,
èè, -
Message
êê 
=
êê !
MessageLobbyCreated
êê -
,
êê- .
Lobby
ëë 
=
ëë  
CreateRoomSnapshot
ëë *
(
ëë* +
newLobby
ëë+ 3
)
ëë3 4
,
ëë4 5
AffectedPlayer
íí 
=
íí  
CloneParticipant
íí! 1
(
íí1 2
hostParticipant
íí2 A
)
ííA B
}
ìì 
;
ìì 
}
îî 	
private
ññ 
static
ññ  
LobbyActionOutcome
ññ )'
AuthorizeReentryUnderLock
ññ* C
(
ññC D
LobbyRoomData
óó 
lobby
óó 
,
óó  
int
óó! $

hostUserId
óó% /
,
óó/ 0
int
óó1 4
targetUserId
óó5 A
)
óóA B
{
òò 	 
LobbyActionOutcome
ôô "
reentryAuthorization
ôô 3
;
ôô3 4
lock
öö 
(
öö 
lobby
öö 
)
öö 
{
õõ "
reentryAuthorization
úú $
=
úú% &*
ValidateReentryAuthorization
úú' C
(
úúC D
lobby
úúD I
,
úúI J

hostUserId
úúK U
,
úúU V
targetUserId
úúW c
)
úúc d
;
úúd e
if
ùù 
(
ùù "
reentryAuthorization
ùù (
.
ùù( )
	IsSuccess
ùù) 2
)
ùù2 3
{
ûû 
lobby
üü 
.
üü &
KickedParticipantUserIds
üü 2
.
üü2 3
Remove
üü3 9
(
üü9 :
targetUserId
üü: F
)
üüF G
;
üüG H"
reentryAuthorization
†† (
.
††( )
Lobby
††) .
=
††/ 0 
CreateRoomSnapshot
††1 C
(
††C D
lobby
††D I
)
††I J
;
††J K
}
°° 
}
¢¢ 
return
§§ "
reentryAuthorization
§§ '
;
§§' (
}
•• 	
private
ßß 
static
ßß  
LobbyActionOutcome
ßß )*
ValidateReentryAuthorization
ßß* F
(
ßßF G
LobbyRoomData
®® 
lobby
®® 
,
®®  
int
®®! $

hostUserId
®®% /
,
®®/ 0
int
®®1 4
targetUserId
®®5 A
)
®®A B
{
©© 	 
LobbyActionOutcome
™™ "
reentryAuthorization
™™ 3
;
™™3 4
if
´´ 
(
´´ 
lobby
´´ 
.
´´ 

HostUserId
´´  
!=
´´! #

hostUserId
´´$ .
)
´´. /
{
¨¨ "
reentryAuthorization
≠≠ $
=
≠≠% & 
CreateErrorOutcome
≠≠' 9
(
≠≠9 :#
ErrorCodeHostRequired
≠≠: O
,
≠≠O P!
MessageHostRequired
≠≠Q d
)
≠≠d e
;
≠≠e f
}
ÆÆ 
else
ØØ 
if
ØØ 
(
ØØ 
!
ØØ 
LobbyRoomRules
ØØ $
.
ØØ$ %%
IsRoomWaitingForPlayers
ØØ% <
(
ØØ< =
lobby
ØØ= B
.
ØØB C
Status
ØØC I
)
ØØI J
)
ØØJ K
{
∞∞ "
reentryAuthorization
±± $
=
±±% & 
CreateErrorOutcome
±±' 9
(
±±9 :&
ErrorCodeLobbyInProgress
±±: R
,
±±R S$
MessageMatchInProgress
±±T j
)
±±j k
;
±±k l
}
≤≤ 
else
≥≥ 
if
≥≥ 
(
≥≥ 
targetUserId
≥≥ !
==
≥≥" $

hostUserId
≥≥% /
||
≥≥0 2
targetUserId
≥≥3 ?
==
≥≥@ B
$num
≥≥C D
)
≥≥D E
{
¥¥ "
reentryAuthorization
µµ $
=
µµ% & 
CreateErrorOutcome
µµ' 9
(
µµ9 :'
ErrorCodeValidationFailed
µµ: S
,
µµS T)
MessageReentryTargetInvalid
µµU p
)
µµp q
;
µµq r
}
∂∂ 
else
∑∑ 
{
∏∏ "
reentryAuthorization
ππ $
=
ππ% &
new
ππ' * 
LobbyActionOutcome
ππ+ =
{
∫∫ 
	IsSuccess
ªª 
=
ªª 
true
ªª  $
,
ªª$ %
	ErrorCode
ºº 
=
ºº 
ErrorCodeSuccess
ºº  0
,
ºº0 1
Message
ΩΩ 
=
ΩΩ &
MessageReentryAuthorized
ΩΩ 6
}
ææ 
;
ææ 
}
øø 
return
¡¡ "
reentryAuthorization
¡¡ '
;
¡¡' (
}
¬¬ 	
private
ƒƒ  
LobbyActionOutcome
ƒƒ "&
TryAddParticipantToLobby
ƒƒ# ;
(
ƒƒ; <
LobbyRoomData
ƒƒ< I
lobby
ƒƒJ O
,
ƒƒO P
int
ƒƒQ T
userId
ƒƒU [
)
ƒƒ[ \
{
≈≈ 	 
LobbyActionOutcome
∆∆ 
outcome
∆∆ &
;
∆∆& '
UserAccount
«« 
userAccount
«« #
=
««$ %
TryFindUser
««& 1
(
««1 2
userId
««2 8
,
««8 9
out
««: =
bool
««> B
hasDatabaseError
««C S
)
««S T
;
««T U
if
…… 
(
…… 
hasDatabaseError
……  
)
……  !
{
   
_logger
ÀÀ 
.
ÀÀ 
Warning
ÀÀ 
(
ÀÀ  1
#JoinLobbyPersistenceFailureTemplate
ÀÀ  C
,
ÀÀC D
lobby
ÀÀE J
.
ÀÀJ K
	LobbyCode
ÀÀK T
,
ÀÀT U
userId
ÀÀV \
)
ÀÀ\ ]
;
ÀÀ] ^
outcome
ÃÃ 
=
ÃÃ  
CreateErrorOutcome
ÃÃ ,
(
ÃÃ, -)
ErrorCodePersistenceFailure
ÃÃ- H
,
ÃÃH I4
&ErrorMessageDatabasePlayerVerification
ÃÃJ p
)
ÃÃp q
;
ÃÃq r
}
ÕÕ 
else
ŒŒ 
if
ŒŒ 
(
ŒŒ 
userAccount
ŒŒ  
==
ŒŒ! #
null
ŒŒ$ (
)
ŒŒ( )
{
œœ 
outcome
–– 
=
––  
CreateErrorOutcome
–– ,
(
––, -#
ErrorCodeUserNotFound
––- B
,
––B C(
ErrorMessagePlayerNotFound
––D ^
)
––^ _
;
––_ `
}
—— 
else
““ 
{
”” 
lock
‘‘ 
(
‘‘ 
lobby
‘‘ 
)
‘‘ 
{
’’ 
outcome
÷÷ 
=
÷÷ .
 AddOrRefreshParticipantUnderLock
÷÷ >
(
÷÷> ?
lobby
÷÷? D
,
÷÷D E
userAccount
÷÷F Q
)
÷÷Q R
;
÷÷R S
}
◊◊ 
}
ÿÿ 
return
⁄⁄ 
outcome
⁄⁄ 
;
⁄⁄ 
}
€€ 	
private
›› 
static
››  
LobbyActionOutcome
›› ).
 AddOrRefreshParticipantUnderLock
››* J
(
››J K
LobbyRoomData
ﬁﬁ 
lobby
ﬁﬁ 
,
ﬁﬁ  
UserAccount
ﬁﬁ! ,
userAccount
ﬁﬁ- 8
)
ﬁﬁ8 9
{
ﬂﬂ 	 
LobbyActionOutcome
‡‡  
lobbyEntryDecision
‡‡ 1
;
‡‡1 2
if
·· 
(
·· 
lobby
·· 
.
·· &
KickedParticipantUserIds
·· .
.
··. /
Contains
··/ 7
(
··7 8
userAccount
··8 C
.
··C D
IdUser
··D J
)
··J K
)
··K L
{
‚‚  
lobbyEntryDecision
„„ "
=
„„# $ 
CreateErrorOutcome
„„% 7
(
„„7 85
'ErrorCodeKickedParticipantReentryDenied
„„8 _
,
„„_ `3
%MessageKickedParticipantReentryDenied
‰‰ 9
)
‰‰9 :
;
‰‰: ;
}
ÂÂ 
else
ÊÊ 
{
ÁÁ  
lobbyEntryDecision
ËË "
=
ËË# $1
#AddUnrestrictedParticipantUnderLock
ËË% H
(
ËËH I
lobby
ËËI N
,
ËËN O
userAccount
ËËP [
)
ËË[ \
;
ËË\ ]
}
ÈÈ 
return
ÎÎ  
lobbyEntryDecision
ÎÎ %
;
ÎÎ% &
}
ÏÏ 	
private
ÓÓ 
static
ÓÓ  
LobbyActionOutcome
ÓÓ )1
#AddUnrestrictedParticipantUnderLock
ÓÓ* M
(
ÓÓM N
LobbyRoomData
ÔÔ 
lobby
ÔÔ 
,
ÔÔ  
UserAccount
 
userAccount
 #
)
# $
{
ÒÒ 	 
LobbyActionOutcome
ÚÚ 
outcome
ÚÚ &
;
ÚÚ& '"
LobbyParticipantData
ÛÛ  
existing
ÛÛ! )
=
ÛÛ* +!
FindParticipantById
ÛÛ, ?
(
ÛÛ? @
lobby
ÛÛ@ E
,
ÛÛE F
userAccount
ÛÛG R
.
ÛÛR S
IdUser
ÛÛS Y
)
ÛÛY Z
;
ÛÛZ [
if
ıı 
(
ıı 
existing
ıı 
!=
ıı 
null
ıı  
)
ıı  !
{
ˆˆ 
outcome
˜˜ 
=
˜˜ 
new
˜˜  
LobbyActionOutcome
˜˜ 0
{
¯¯ 
	IsSuccess
˘˘ 
=
˘˘ 
true
˘˘  $
,
˘˘$ %
	ErrorCode
˙˙ 
=
˙˙ 
ErrorCodeSuccess
˙˙  0
,
˙˙0 1
Message
˚˚ 
=
˚˚ "
MessageRejoinedLobby
˚˚ 2
,
˚˚2 3
Lobby
¸¸ 
=
¸¸  
CreateRoomSnapshot
¸¸ .
(
¸¸. /
lobby
¸¸/ 4
)
¸¸4 5
,
¸¸5 6
AffectedPlayer
˝˝ "
=
˝˝# $
CloneParticipant
˝˝% 5
(
˝˝5 6
existing
˝˝6 >
)
˝˝> ?
}
˛˛ 
;
˛˛ 
}
ˇˇ 
else
ÄÄ 
if
ÄÄ 
(
ÄÄ 
!
ÄÄ 
LobbyRoomRules
ÄÄ $
.
ÄÄ$ %%
IsRoomWaitingForPlayers
ÄÄ% <
(
ÄÄ< =
lobby
ÄÄ= B
.
ÄÄB C
Status
ÄÄC I
)
ÄÄI J
)
ÄÄJ K
{
ÅÅ 
outcome
ÇÇ 
=
ÇÇ  
CreateErrorOutcome
ÇÇ ,
(
ÇÇ, -&
ErrorCodeLobbyInProgress
ÇÇ- E
,
ÇÇE F.
 ErrorMessageLobbyMatchInProgress
ÇÇG g
)
ÇÇg h
;
ÇÇh i
}
ÉÉ 
else
ÑÑ 
if
ÑÑ 
(
ÑÑ 
!
ÑÑ 
LobbyRoomRules
ÑÑ $
.
ÑÑ$ %
HasAvailableSlot
ÑÑ% 5
(
ÑÑ5 6
lobby
ÑÑ6 ;
.
ÑÑ; <
Players
ÑÑ< C
.
ÑÑC D
Count
ÑÑD I
,
ÑÑI J
lobby
ÑÑK P
.
ÑÑP Q
PlayerLimit
ÑÑQ \
)
ÑÑ\ ]
)
ÑÑ] ^
{
ÖÖ 
outcome
ÜÜ 
=
ÜÜ  
CreateErrorOutcome
ÜÜ ,
(
ÜÜ, - 
ErrorCodeLobbyFull
ÜÜ- ?
,
ÜÜ? @#
ErrorMessageLobbyFull
ÜÜA V
)
ÜÜV W
;
ÜÜW X
}
áá 
else
àà 
{
ââ "
LobbyParticipantData
ää $
newParticipant
ää% 3
=
ää4 5
new
ää6 9"
LobbyParticipantData
ää: N
{
ãã 
IdUser
åå 
=
åå 
userAccount
åå (
.
åå( )
IdUser
åå) /
,
åå/ 0
Username
çç 
=
çç 
userAccount
çç *
.
çç* +
Username
çç+ 3
,
çç3 4
IsHost
éé 
=
éé 
false
éé "
,
éé" #
IsReady
èè 
=
èè 
false
èè #
}
êê 
;
êê 
lobby
íí 
.
íí 
Players
íí 
.
íí 
Add
íí !
(
íí! "
newParticipant
íí" 0
)
íí0 1
;
íí1 2
lobby
ìì 
.
ìì 
StateVersion
ìì "
++
ìì" $
;
ìì$ %
outcome
ïï 
=
ïï 
new
ïï  
LobbyActionOutcome
ïï 0
{
ññ 
	IsSuccess
óó 
=
óó 
true
óó  $
,
óó$ %
	ErrorCode
òò 
=
òò 
ErrorCodeSuccess
òò  0
,
òò0 1
Message
ôô 
=
ôô  
MessageJoinedLobby
ôô 0
,
ôô0 1
Lobby
öö 
=
öö  
CreateRoomSnapshot
öö .
(
öö. /
lobby
öö/ 4
)
öö4 5
,
öö5 6
AffectedPlayer
õõ "
=
õõ# $
CloneParticipant
õõ% 5
(
õõ5 6
newParticipant
õõ6 D
)
õõD E
}
úú 
;
úú 
}
ùù 
return
üü 
outcome
üü 
;
üü 
}
†† 	
private
¢¢  
LobbyActionOutcome
¢¢ "'
RemoveParticipantFromRoom
¢¢# <
(
¢¢< =
LobbyRoomData
¢¢= J
lobby
¢¢K P
,
¢¢P Q
int
¢¢R U
userId
¢¢V \
)
¢¢\ ]
{
££ 	 
LobbyActionOutcome
§§ 
outcome
§§ &
=
§§' ( 
CreateErrorOutcome
§§) ;
(
§§; <#
ErrorCodeUserNotFound
•• %
,
••% &/
!ErrorMessageParticipantNotInLobby
¶¶ 1
)
¶¶1 2
;
¶¶2 3
lock
®® 
(
®® 
lobby
®® 
)
®® 
{
©© "
LobbyParticipantData
™™ $
existing
™™% -
=
™™. /!
FindParticipantById
™™0 C
(
™™C D
lobby
™™D I
,
™™I J
userId
™™K Q
)
™™Q R
;
™™R S
if
´´ 
(
´´ 
existing
´´ 
!=
´´ 
null
´´  $
)
´´$ %
{
¨¨ 
lobby
≠≠ 
.
≠≠ 
Players
≠≠ !
.
≠≠! "
Remove
≠≠" (
(
≠≠( )
existing
≠≠) 1
)
≠≠1 2
;
≠≠2 3
bool
ÆÆ 
isDisbanded
ÆÆ $
=
ÆÆ% &
lobby
ÆÆ' ,
.
ÆÆ, -
Players
ÆÆ- 4
.
ÆÆ4 5
Count
ÆÆ5 :
==
ÆÆ; =
$num
ÆÆ> ?
;
ÆÆ? @
if
ØØ 
(
ØØ 
isDisbanded
ØØ #
)
ØØ# $
{
∞∞ 
lobby
±± 
.
±± 
Status
±± $
=
±±% &
LobbyRoomRules
±±' 5
.
±±5 6
StatusClosed
±±6 B
;
±±B C
}
≤≤ 
if
≥≥ 
(
≥≥ 
existing
≥≥  
.
≥≥  !
IsHost
≥≥! '
&&
≥≥( *
!
≥≥+ ,
isDisbanded
≥≥, 7
)
≥≥7 8
{
¥¥ 
TransferLobbyHost
µµ )
(
µµ) *
lobby
µµ* /
)
µµ/ 0
;
µµ0 1
}
∂∂ 
lobby
∏∏ 
.
∏∏ 
StateVersion
∏∏ &
++
∏∏& (
;
∏∏( )
outcome
∫∫ 
=
∫∫ 
new
∫∫ ! 
LobbyActionOutcome
∫∫" 4
{
ªª 
	IsSuccess
ºº !
=
ºº" #
true
ºº$ (
,
ºº( )
	ErrorCode
ΩΩ !
=
ΩΩ" #
ErrorCodeSuccess
ΩΩ$ 4
,
ΩΩ4 5
Message
ææ 
=
ææ  !
MessagePlayerLeft
ææ" 3
,
ææ3 4
IsRoomDisbanded
øø '
=
øø( )
isDisbanded
øø* 5
,
øø5 6
Lobby
¿¿ 
=
¿¿  
CreateRoomSnapshot
¿¿  2
(
¿¿2 3
lobby
¿¿3 8
)
¿¿8 9
,
¿¿9 :
AffectedPlayer
¡¡ &
=
¡¡' (
CloneParticipant
¡¡) 9
(
¡¡9 :
existing
¡¡: B
)
¡¡B C
}
¬¬ 
;
¬¬ 
}
√√ 
}
ƒƒ 
return
∆∆ 
outcome
∆∆ 
;
∆∆ 
}
«« 	
private
……  
LobbyActionOutcome
…… ")
TryKickParticipantUnderLock
……# >
(
……> ?
LobbyRoomData
   
lobby
   
,
    
int
ÀÀ 

hostUserId
ÀÀ 
,
ÀÀ 
int
ÃÃ 
targetUserId
ÃÃ 
)
ÃÃ 
{
ÕÕ 	 
LobbyActionOutcome
ŒŒ 
outcome
ŒŒ &
=
ŒŒ' ( 
CreateErrorOutcome
ŒŒ) ;
(
ŒŒ; <'
ErrorCodeValidationFailed
œœ )
,
œœ) *,
ErrorMessageUnableToKickPlayer
–– .
)
––. /
;
––/ 0
lock
““ 
(
““ 
lobby
““ 
)
““ 
{
”” "
LobbyParticipantData
‘‘ $
target
‘‘% +
=
‘‘, -!
FindParticipantById
‘‘. A
(
‘‘A B
lobby
‘‘B G
,
‘‘G H
targetUserId
‘‘I U
)
‘‘U V
;
‘‘V W
if
’’ 
(
’’ 
lobby
’’ 
.
’’ 

HostUserId
’’ $
==
’’% '

hostUserId
’’( 2
&&
’’3 5
target
’’6 <
!=
’’= ?
null
’’@ D
&&
’’E G
lobby
’’H M
.
’’M N
Status
’’N T
==
’’U W
LobbyRoomRules
’’X f
.
’’f g
StatusWaiting
’’g t
)
’’t u
{
÷÷ 
lobby
◊◊ 
.
◊◊ &
KickedParticipantUserIds
◊◊ 2
.
◊◊2 3
Add
◊◊3 6
(
◊◊6 7
targetUserId
◊◊7 C
)
◊◊C D
;
◊◊D E
lobby
ÿÿ 
.
ÿÿ 
Players
ÿÿ !
.
ÿÿ! "
Remove
ÿÿ" (
(
ÿÿ( )
target
ÿÿ) /
)
ÿÿ/ 0
;
ÿÿ0 1
lobby
ŸŸ 
.
ŸŸ 
StateVersion
ŸŸ &
++
ŸŸ& (
;
ŸŸ( )
_logger
⁄⁄ 
.
⁄⁄ 
Warning
⁄⁄ #
(
⁄⁄# $0
"ParticipantKickedFromLobbyTemplate
⁄⁄$ F
,
⁄⁄F G
targetUserId
⁄⁄H T
,
⁄⁄T U
lobby
⁄⁄V [
.
⁄⁄[ \
	LobbyCode
⁄⁄\ e
,
⁄⁄e f

hostUserId
⁄⁄g q
)
⁄⁄q r
;
⁄⁄r s
outcome
€€ 
=
€€ 
new
€€ ! 
LobbyActionOutcome
€€" 4
{
‹‹ 
	IsSuccess
›› !
=
››" #
true
››$ (
,
››( )
	ErrorCode
ﬁﬁ !
=
ﬁﬁ" #
ErrorCodeSuccess
ﬁﬁ$ 4
,
ﬁﬁ4 5
Message
ﬂﬂ 
=
ﬂﬂ  !!
MessagePlayerKicked
ﬂﬂ" 5
,
ﬂﬂ5 6
Lobby
‡‡ 
=
‡‡  
CreateRoomSnapshot
‡‡  2
(
‡‡2 3
lobby
‡‡3 8
)
‡‡8 9
,
‡‡9 :
AffectedPlayer
·· &
=
··' (
CloneParticipant
··) 9
(
··9 :
target
··: @
)
··@ A
}
‚‚ 
;
‚‚ 
}
„„ 
}
‰‰ 
return
ÊÊ 
outcome
ÊÊ 
;
ÊÊ 
}
ÁÁ 	
private
ÈÈ 
static
ÈÈ  
LobbyActionOutcome
ÈÈ ))
TryUpdateReadinessUnderLock
ÈÈ* E
(
ÈÈE F
LobbyRoomData
ÍÍ 
lobby
ÍÍ 
,
ÍÍ  
int
ÍÍ! $
userId
ÍÍ% +
,
ÍÍ+ ,
bool
ÍÍ- 1
isReady
ÍÍ2 9
)
ÍÍ9 :
{
ÎÎ 	 
LobbyActionOutcome
ÏÏ 
outcome
ÏÏ &
=
ÏÏ' ( 
CreateErrorOutcome
ÏÏ) ;
(
ÏÏ; <#
ErrorCodeUserNotFound
ÌÌ %
,
ÌÌ% &/
!ErrorMessageParticipantNotInLobby
ÓÓ 1
)
ÓÓ1 2
;
ÓÓ2 3
lock
 
(
 
lobby
 
)
 
{
ÒÒ "
LobbyParticipantData
ÚÚ $
participant
ÚÚ% 0
=
ÚÚ1 2!
FindParticipantById
ÚÚ3 F
(
ÚÚF G
lobby
ÚÚG L
,
ÚÚL M
userId
ÚÚN T
)
ÚÚT U
;
ÚÚU V
if
ÛÛ 
(
ÛÛ 
participant
ÛÛ 
!=
ÛÛ  "
null
ÛÛ# '
)
ÛÛ' (
{
ÙÙ 
participant
ıı 
.
ıı  
IsReady
ıı  '
=
ıı( )
isReady
ıı* 1
;
ıı1 2
lobby
ˆˆ 
.
ˆˆ 
StateVersion
ˆˆ &
++
ˆˆ& (
;
ˆˆ( )
outcome
˜˜ 
=
˜˜ 
new
˜˜ ! 
LobbyActionOutcome
˜˜" 4
{
¯¯ 
	IsSuccess
˘˘ !
=
˘˘" #
true
˘˘$ (
,
˘˘( )
	ErrorCode
˙˙ !
=
˙˙" #
ErrorCodeSuccess
˙˙$ 4
,
˙˙4 5
Message
˚˚ 
=
˚˚  !%
MessageReadinessUpdated
˚˚" 9
,
˚˚9 :
Lobby
¸¸ 
=
¸¸  
CreateRoomSnapshot
¸¸  2
(
¸¸2 3
lobby
¸¸3 8
)
¸¸8 9
,
¸¸9 :
AffectedPlayer
˝˝ &
=
˝˝' (
CloneParticipant
˝˝) 9
(
˝˝9 :
participant
˝˝: E
)
˝˝E F
}
˛˛ 
;
˛˛ 
}
ˇˇ 
}
ÄÄ 
return
ÇÇ 
outcome
ÇÇ 
;
ÇÇ 
}
ÉÉ 	
private
ÖÖ 
static
ÖÖ "
LobbyParticipantData
ÖÖ +!
FindParticipantById
ÖÖ, ?
(
ÖÖ? @
LobbyRoomData
ÖÖ@ M
lobby
ÖÖN S
,
ÖÖS T
int
ÖÖU X
userId
ÖÖY _
)
ÖÖ_ `
{
ÜÜ 	
return
áá 
lobby
áá 
.
áá 
Players
áá  
.
áá  !
FirstOrDefault
áá! /
(
áá/ 0
player
áá0 6
=>
áá7 9
player
áá: @
.
áá@ A
IdUser
ááA G
==
ááH J
userId
ááK Q
)
ááQ R
;
ááR S
}
àà 	
private
ää 
UserAccount
ää 
TryFindUser
ää '
(
ää' (
int
ää( +
userId
ää, 2
,
ää2 3
out
ää4 7
bool
ää8 <
hasDatabaseError
ää= M
)
ääM N
{
ãã 	
UserAccount
åå 
account
åå 
=
åå  !
null
åå" &
;
åå& '
hasDatabaseError
çç 
=
çç 
false
çç $
;
çç$ %
if
èè 
(
èè 
userId
èè 
>
èè 
$num
èè 
)
èè 
{
êê 
try
ëë 
{
íí 
account
ìì 
=
ìì 
_userRepository
ìì -
.
ìì- .
GetUserById
ìì. 9
(
ìì9 :
userId
ìì: @
)
ìì@ A
;
ììA B
}
îî 
catch
ïï 
(
ïï '
InvalidOperationException
ïï 0
)
ïï0 1
{
ññ 
hasDatabaseError
óó $
=
óó% &
true
óó' +
;
óó+ ,
}
òò 
}
ôô 
else
öö 
if
öö 
(
öö  
GuestIdentityRules
öö '
.
öö' (
IsGuestUserId
öö( 5
(
öö5 6
userId
öö6 <
)
öö< =
)
öö= >
{
õõ 
account
úú 
=
úú 
new
úú 
UserAccount
úú )
{
ùù 
IdUser
ûû 
=
ûû 
userId
ûû #
,
ûû# $
Username
üü 
=
üü  
GuestIdentityRules
üü 1
.
üü1 2 
BuildGuestUsername
üü2 D
(
üüD E
userId
üüE K
)
üüK L
,
üüL M
Email
†† 
=
†† 
string
†† "
.
††" #
Empty
††# (
}
°° 
;
°° 
}
¢¢ 
return
§§ 
account
§§ 
;
§§ 
}
•• 	
private
ßß 
string
ßß %
GenerateUniqueLobbyCode
ßß .
(
ßß. /
)
ßß/ 0
{
®® 	
string
©© 
candidateCode
©©  
;
©©  !
do
™™ 
{
´´ 
candidateCode
¨¨ 
=
¨¨ 
LobbyCodeRules
¨¨  .
.
¨¨. /
GenerateCode
¨¨/ ;
(
¨¨; <
)
¨¨< =
;
¨¨= >
}
≠≠ 
while
ÆÆ 
(
ÆÆ 
_activeLobbies
ÆÆ !
.
ÆÆ! "
ContainsKey
ÆÆ" -
(
ÆÆ- .
candidateCode
ÆÆ. ;
)
ÆÆ; <
)
ÆÆ< =
;
ÆÆ= >
return
∞∞ 
candidateCode
∞∞  
;
∞∞  !
}
±± 	
private
≥≥ 
static
≥≥ 
LobbyRoomData
≥≥ $ 
CreateRoomSnapshot
≥≥% 7
(
≥≥7 8
LobbyRoomData
≥≥8 E
source
≥≥F L
)
≥≥L M
{
¥¥ 	
List
µµ 
<
µµ "
LobbyParticipantData
µµ %
>
µµ% &
clonedPlayers
µµ' 4
=
µµ5 6
source
µµ7 =
.
µµ= >
Players
µµ> E
.
∂∂ 
Select
∂∂ 
(
∂∂ 
CloneParticipant
∂∂ (
)
∂∂( )
.
∑∑ 
ToList
∑∑ 
(
∑∑ 
)
∑∑ 
;
∑∑ 
return
ππ 
new
ππ 
LobbyRoomData
ππ $
{
∫∫ 
	LobbyCode
ªª 
=
ªª 
source
ªª "
.
ªª" #
	LobbyCode
ªª# ,
,
ªª, -

HostUserId
ºº 
=
ºº 
source
ºº #
.
ºº# $

HostUserId
ºº$ .
,
ºº. / 
TargetMissionCount
ΩΩ "
=
ΩΩ# $
source
ΩΩ% +
.
ΩΩ+ , 
TargetMissionCount
ΩΩ, >
,
ΩΩ> ?
PlayerLimit
ææ 
=
ææ 
source
ææ $
.
ææ$ %
PlayerLimit
ææ% 0
,
ææ0 1
Status
øø 
=
øø 
source
øø 
.
øø  
Status
øø  &
,
øø& '
	IsPrivate
¿¿ 
=
¿¿ 
source
¿¿ "
.
¿¿" #
	IsPrivate
¿¿# ,
,
¿¿, -
StateVersion
¡¡ 
=
¡¡ 
source
¡¡ %
.
¡¡% &
StateVersion
¡¡& 2
,
¡¡2 3
Players
¬¬ 
=
¬¬ 
clonedPlayers
¬¬ '
}
√√ 
;
√√ 
}
ƒƒ 	
private
∆∆ 
static
∆∆ "
LobbyParticipantData
∆∆ +
CloneParticipant
∆∆, <
(
∆∆< ="
LobbyParticipantData
∆∆= Q
source
∆∆R X
)
∆∆X Y
{
«« 	
return
»» 
new
»» "
LobbyParticipantData
»» +
{
…… 
IdUser
   
=
   
source
   
.
    
IdUser
    &
,
  & '
Username
ÀÀ 
=
ÀÀ 
source
ÀÀ !
.
ÀÀ! "
Username
ÀÀ" *
,
ÀÀ* +
IsHost
ÃÃ 
=
ÃÃ 
source
ÃÃ 
.
ÃÃ  
IsHost
ÃÃ  &
,
ÃÃ& '
IsReady
ÕÕ 
=
ÕÕ 
source
ÕÕ  
.
ÕÕ  !
IsReady
ÕÕ! (
}
ŒŒ 
;
ŒŒ 
}
œœ 	
private
—— 
static
——  
LobbyActionOutcome
—— ) 
CreateErrorOutcome
——* <
(
——< =
int
——= @
	errorCode
——A J
,
——J K
string
——L R
message
——S Z
)
——Z [
{
““ 	
return
”” 
new
””  
LobbyActionOutcome
”” )
{
‘‘ 
	IsSuccess
’’ 
=
’’ 
false
’’ !
,
’’! "
	ErrorCode
÷÷ 
=
÷÷ 
	errorCode
÷÷ %
,
÷÷% &
Message
◊◊ 
=
◊◊ 
message
◊◊ !
,
◊◊! "
IsRoomDisbanded
ÿÿ 
=
ÿÿ  !
false
ÿÿ" '
,
ÿÿ' (
Lobby
ŸŸ 
=
ŸŸ 
null
ŸŸ 
,
ŸŸ 
AffectedPlayer
⁄⁄ 
=
⁄⁄  
null
⁄⁄! %
}
€€ 
;
€€ 
}
‹‹ 	
}
›› 
}ﬁﬁ û
qC:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\Models\ProfileImages\PlayerProfileImageData.cs
	namespace 	
Application
 
. 
Models 
{ 
public 

sealed 
class "
PlayerProfileImageData .
{		 
public

 
int

 
ProfileOwnerUserId

 %
{

& '
get

( +
;

+ ,
set

- 0
;

0 1
}

2 3
public 
Guid 
ProfileImageId "
{# $
get% (
;( )
set* -
;- .
}/ 0
} 
} ˘r
oC:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\UseCases\Account\AccountManagementUseCase.cs
	namespace 	
Application
 
. 
UseCases 
{		 
public 

sealed 
class $
AccountManagementUseCase 0
:1 2%
IAccountManagementUseCase3 L
{ 
private 
const 
int 
ErrorCodeSuccess *
=+ ,
$num- .
;. /
private 
const 
int ,
 ErrorCodePermanentlyBlockedEmail :
=; <
$num= A
;A B
private 
const 
int %
ErrorCodeValidationFailed 3
=4 5
$num6 9
;9 :
private 
const 
int +
ErrorCodeEmailAlreadyRegistered 9
=: ;
$num< @
;@ A
private 
const 
int .
"ErrorCodeUsernameAlreadyRegistered <
== >
$num? C
;C D
private 
const 
int '
ErrorCodePersistenceFailure 5
=6 7
$num8 ;
;; <
private 
const 
byte 
ActiveUserStatus +
=, -
$num. /
;/ 0
private 
const 
string 
MessageSuccess +
=, -
$str. M
;M N
private 
const 
string #
MessageValidationFailed 4
=5 6
$str7 k
;k l
private 
const 
string )
MessageEmailAlreadyRegistered :
=; <
$str= h
;h i
private 
const 
string ,
 MessageUsernameAlreadyRegistered =
=> ?
$str@ n
;n o
private 
const 
string %
MessagePersistenceFailure 6
=7 8
$str9 p
;p q
private 
const 
string *
MessageEmailPermanentlyBlocked ;
=< =
$str> ^
;^ _
private 
const 
string 0
$RegistrationValidationFailedTemplate A
=B C
$str   `
;  ` a
private!! 
const!! 
string!! ?
3RegistrationRejectedPermanentlyBlockedEmailTemplate!! P
=!!Q R
$str"" \
;""\ ]
private## 
const## 
string## >
2RegistrationRejectedEmailAlreadyRegisteredTemplate## O
=##P Q
$str$$ X
;$$X Y
private%% 
const%% 
string%% A
5RegistrationRejectedUsernameAlreadyRegisteredTemplate%% R
=%%S T
$str&& ^
;&&^ _
private'' 
const'' 
string'' 9
-RegistrationAbortedPersistenceFailureTemplate'' J
=''K L
$str(( l
;((l m
private)) 
const)) 
string)) .
"UserRegisteredSuccessfullyTemplate)) ?
=))@ A
$str** W
;**W X
private,, 
readonly,, 
IUserRepository,, (
_userRepository,,) 8
;,,8 9
private-- 
readonly-- *
IBlockedAccountEmailRepository-- 7*
_blockedAccountEmailRepository--8 V
;--V W
private.. 
readonly.. 
ILoggerService.. '
_logger..( /
;../ 0
public77 $
AccountManagementUseCase77 '
(77' (
IUserRepository77( 7
userRepository778 F
,77F G*
IBlockedAccountEmailRepository88 *)
blockedAccountEmailRepository88+ H
,88H I
ILoggerService99 
logger99 !
)99! "
{:: 	
_userRepository;; 
=;; 
userRepository;; ,
??;;- /
throw;;0 5
new;;6 9!
ArgumentNullException;;: O
(;;O P
nameof;;P V
(;;V W
userRepository;;W e
);;e f
);;f g
;;;g h*
_blockedAccountEmailRepository<< *
=<<+ ,)
blockedAccountEmailRepository<<- J
;<<J K
_logger== 
=== 
logger== 
??== 
throw==  %
new==& )!
ArgumentNullException==* ?
(==? @
nameof==@ F
(==F G
logger==G M
)==M N
)==N O
;==O P
}>> 	
publicAA #
UserRegistrationOutcomeAA &
RegisterUserAA' 3
(AA3 4
stringAA4 :
usernameAA; C
,AAC D
stringAAE K
emailAAL Q
,AAQ R
stringAAS Y
passwordHashAAZ f
)AAf g
{BB 	#
UserRegistrationOutcomeCC #
registrationOutcomeCC$ 7
;CC7 8
stringEE 
normalizedUsernameEE %
=EE& '
usernameEE( 0
?EE0 1
.EE1 2
TrimEE2 6
(EE6 7
)EE7 8
??EE9 ;
stringEE< B
.EEB C
EmptyEEC H
;EEH I
stringFF 
normalizedEmailFF "
=FF# $
emailFF% *
?FF* +
.FF+ ,
TrimFF, 0
(FF0 1
)FF1 2
??FF3 5
stringFF6 <
.FF< =
EmptyFF= B
;FFB C
stringGG "
normalizedPasswordHashGG )
=GG* +
passwordHashGG, 8
?GG8 9
.GG9 :
TrimGG: >
(GG> ?
)GG? @
??GGA C
stringGGD J
.GGJ K
EmptyGGK P
;GGP Q
ifII 
(II 
!II 
IsInputValidII 
(II 
normalizedUsernameII 0
,II0 1
normalizedEmailII2 A
,IIA B"
normalizedPasswordHashIIC Y
)IIY Z
)IIZ [
{JJ 
_loggerKK 
.KK 
WarningKK 
(KK  0
$RegistrationValidationFailedTemplateKK  D
,KKD E
normalizedUsernameKKF X
)KKX Y
;KKY Z
registrationOutcomeLL #
=LL$ %%
CreateRegistrationOutcomeLL& ?
(LL? @
falseMM 
,MM %
ErrorCodeValidationFailedMM 4
,MM4 5#
MessageValidationFailedMM6 M
)MMM N
;MMN O
}NN 
elseOO 
{PP 
registrationOutcomeQQ #
=QQ$ %
ProcessRegistrationQQ& 9
(QQ9 :
normalizedUsernameQQ: L
,QQL M
normalizedEmailQQN ]
,QQ] ^"
normalizedPasswordHashQQ_ u
)QQu v
;QQv w
}RR 
returnTT 
registrationOutcomeTT &
;TT& '
}UU 	
privateWW 
boolWW 
IsInputValidWW !
(WW! "
stringWW" (
usernameWW) 1
,WW1 2
stringWW3 9
emailWW: ?
,WW? @
stringWWA G
passwordHashWWH T
)WWT U
{XX 	
returnYY 
UserAccountRulesYY #
.YY# $
IsUsernameValidYY$ 3
(YY3 4
usernameYY4 <
)YY< =
&&YY> @
UserAccountRulesZZ #
.ZZ# $
IsEmailValidZZ$ 0
(ZZ0 1
emailZZ1 6
)ZZ6 7
&&ZZ8 :
UserAccountRules[[ #
.[[# $
IsPasswordHashValid[[$ 7
([[7 8
passwordHash[[8 D
)[[D E
;[[E F
}\\ 	
private^^ #
UserRegistrationOutcome^^ '
ProcessRegistration^^( ;
(^^; <
string^^< B
username^^C K
,^^K L
string^^M S
email^^T Y
,^^Y Z
string^^[ a
passwordHash^^b n
)^^n o
{__ 	#
UserRegistrationOutcome`` #
registrationOutcome``$ 7
;``7 8
trybb 
{cc 
ifdd 
(dd *
_blockedAccountEmailRepositorydd 2
.dd2 3,
 IsAccountEmailPermanentlyBlockeddd3 S
(ddS T
emailddT Y
)ddY Z
)ddZ [
{ee 
_loggerff 
.ff 
Warningff #
(ff# $?
3RegistrationRejectedPermanentlyBlockedEmailTemplateff$ W
,ffW X
emailffY ^
)ff^ _
;ff_ `
registrationOutcomegg '
=gg( )%
CreateRegistrationOutcomegg* C
(ggC D
falsehh 
,hh ,
 ErrorCodePermanentlyBlockedEmailhh ?
,hh? @*
MessageEmailPermanentlyBlockedhhA _
)hh_ `
;hh` a
}ii 
elsejj 
{kk 
registrationOutcomell '
=ll( )"
RegisterUnblockedEmailll* @
(ll@ A
usernamellA I
,llI J
emailllK P
,llP Q
passwordHashllR ^
)ll^ _
;ll_ `
}mm 
}nn 
catchoo 
(oo %
InvalidOperationExceptionoo ,
)oo, -
{pp 
_loggerqq 
.qq 
Warningqq 
(qq  9
-RegistrationAbortedPersistenceFailureTemplateqq  M
,qqM N
usernameqqO W
,qqW X
emailqqY ^
)qq^ _
;qq_ `
registrationOutcomerr #
=rr$ %%
CreateRegistrationOutcomerr& ?
(rr? @
falsess 
,ss '
ErrorCodePersistenceFailuress 6
,ss6 7%
MessagePersistenceFailuress8 Q
)ssQ R
;ssR S
}tt 
returnvv 
registrationOutcomevv &
;vv& '
}ww 	
privateyy #
UserRegistrationOutcomeyy '"
RegisterUnblockedEmailyy( >
(yy> ?
stringyy? E
usernameyyF N
,yyN O
stringyyP V
emailyyW \
,yy\ ]
stringyy^ d
passwordHashyye q
)yyq r
{zz 	#
UserRegistrationOutcome{{ #
registrationOutcome{{$ 7
;{{7 8
if|| 
(|| 
_userRepository|| 
.||  
GetUserByEmail||  .
(||. /
email||/ 4
)||4 5
!=||6 8
null||9 =
)||= >
{}} 
_logger~~ 
.~~ 
Warning~~ 
(~~  >
2RegistrationRejectedEmailAlreadyRegisteredTemplate~~  R
,~~R S
email~~T Y
)~~Y Z
;~~Z [
registrationOutcome #
=$ %%
CreateRegistrationOutcome& ?
(? @
false
ÄÄ 
,
ÄÄ -
ErrorCodeEmailAlreadyRegistered
ÄÄ :
,
ÄÄ: ;+
MessageEmailAlreadyRegistered
ÄÄ< Y
)
ÄÄY Z
;
ÄÄZ [
}
ÅÅ 
else
ÇÇ 
if
ÇÇ 
(
ÇÇ 
_userRepository
ÇÇ $
.
ÇÇ$ %
GetUserByUsername
ÇÇ% 6
(
ÇÇ6 7
username
ÇÇ7 ?
)
ÇÇ? @
!=
ÇÇA C
null
ÇÇD H
)
ÇÇH I
{
ÉÉ 
_logger
ÑÑ 
.
ÑÑ 
Warning
ÑÑ 
(
ÑÑ  C
5RegistrationRejectedUsernameAlreadyRegisteredTemplate
ÑÑ  U
,
ÑÑU V
username
ÑÑW _
)
ÑÑ_ `
;
ÑÑ` a!
registrationOutcome
ÖÖ #
=
ÖÖ$ %'
CreateRegistrationOutcome
ÖÖ& ?
(
ÖÖ? @
false
ÖÖ@ E
,
ÖÖE F0
"ErrorCodeUsernameAlreadyRegistered
ÖÖG i
,
ÖÖi j.
 MessageUsernameAlreadyRegistered
ÜÜ 4
)
ÜÜ4 5
;
ÜÜ5 6
}
áá 
else
àà 
{
ââ !
registrationOutcome
ää #
=
ää$ %
PersistNewUser
ää& 4
(
ää4 5
username
ää5 =
,
ää= >
email
ää? D
,
ääD E
passwordHash
ääF R
)
ääR S
;
ääS T
}
ãã 
return
çç !
registrationOutcome
çç &
;
çç& '
}
éé 	
private
êê %
UserRegistrationOutcome
êê '
PersistNewUser
êê( 6
(
êê6 7
string
êê7 =
username
êê> F
,
êêF G
string
êêH N
email
êêO T
,
êêT U
string
êêV \
passwordHash
êê] i
)
êêi j
{
ëë 	
UserAccount
íí 
newUser
íí 
=
íí  !
new
íí" %
UserAccount
íí& 1
{
ìì 
Username
îî 
=
îî 
username
îî #
,
îî# $
Email
ïï 
=
ïï 
email
ïï 
,
ïï 
PasswordHash
ññ 
=
ññ 
passwordHash
ññ +
,
ññ+ ,
Status
óó 
=
óó 
ActiveUserStatus
óó )
,
óó) *
	CreatedAt
òò 
=
òò 
DateTime
òò $
.
òò$ %
UtcNow
òò% +
}
ôô 
;
ôô 
int
õõ 
createdUserId
õõ 
=
õõ 
_userRepository
õõ  /
.
õõ/ 0

CreateUser
õõ0 :
(
õõ: ;
newUser
õõ; B
,
õõB C
username
õõD L
)
õõL M
;
õõM N
_logger
úú 
.
úú 
Information
úú 
(
úú  0
"UserRegisteredSuccessfullyTemplate
úú  B
,
úúB C
username
úúD L
,
úúL M
createdUserId
úúN [
)
úú[ \
;
úú\ ]%
UserRegistrationOutcome
ùù #!
registrationOutcome
ùù$ 7
=
ùù8 9'
CreateRegistrationOutcome
ùù: S
(
ùùS T
true
ûû 
,
ûû 
ErrorCodeSuccess
ûû &
,
ûû& '
MessageSuccess
ûû( 6
)
ûû6 7
;
ûû7 8!
registrationOutcome
üü 
.
üü  
CreatedUserId
üü  -
=
üü. /
createdUserId
üü0 =
;
üü= >
return
†† !
registrationOutcome
†† &
;
††& '
}
°° 	
private
££ 
static
££ %
UserRegistrationOutcome
££ .'
CreateRegistrationOutcome
££/ H
(
££H I
bool
££I M
	isSuccess
££N W
,
££W X
int
££Y \
	errorCode
££] f
,
££f g
string
££h n
message
££o v
)
££v w
{
§§ 	
return
•• 
new
•• %
UserRegistrationOutcome
•• .
{
¶¶ 
	IsSuccess
ßß 
=
ßß 
	isSuccess
ßß %
,
ßß% &
	ErrorCode
®® 
=
®® 
	errorCode
®® %
,
®®% &
Message
©© 
=
©© 
message
©© !
}
™™ 
;
™™ 
}
´´ 	
}
¨¨ 
}≠≠ à
]C:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\Properties\AssemblyInfo.cs
[ 
assembly 	
:	 

AssemblyTitle 
( 
$str &
)& '
]' (
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
$str (
)( )
]) *
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
]!!) *ÖÌ
hC:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\UseCases\Friends\FriendshipUseCase.cs
	namespace		 	
Application		
 
.		 
UseCases		 
{

 
public 

sealed 
class 
FriendshipUseCase )
:* +
IFriendshipUseCase, >
{ 
private 
const 
byte #
PendingFriendshipStatus 2
=3 4
$num5 6
;6 7
private 
const 
byte $
AcceptedFriendshipStatus 3
=4 5
$num6 7
;7 8
private 
const 
int 
ErrorCodeSuccess *
=+ ,
$num- .
;. /
private 
const 
int %
ErrorCodeValidationFailed 3
=4 5
$num6 9
;9 :
private 
const 
int !
ErrorCodeUserNotFound /
=0 1
$num2 5
;5 6
private 
const 
int ,
 ErrorCodeDuplicateOrInvalidState :
=; <
$num= @
;@ A
private 
const 
int "
ErrorCodePlayerBlocked 0
=1 2
$num3 6
;6 7
private 
const 
int '
ErrorCodePersistenceFailure 5
=6 7
$num8 ;
;; <
private 
const 
string $
MessageFriendRequestSent 5
=6 7
$str8 [
;[ \
private 
const 
string (
MessageFriendRequestAccepted 9
=: ;
$str< V
;V W
private 
const 
string (
MessageFriendRequestRejected 9
=: ;
$str< V
;V W
private 
const 
string )
MessageFriendRequestCancelled :
=; <
$str= X
;X Y
private 
const 
string  
MessageFriendRemoved 1
=2 3
$str4 R
;R S
private 
const 
string  
MessagePlayerBlocked 1
=2 3
$str4 R
;R S
private 
const 
string "
MessagePlayerUnblocked 3
=4 5
$str6 V
;V W
private 
const 
string )
ErrorMessageInvalidParameters :
=; <
$str= W
;W X
private 
const 
string *
ErrorMessageTargetUserNotFound ;
=< =
$str> \
;\ ]
private   
const   
string   %
ErrorMessagePlayerBlocked   6
=  7 8
$str  9 o
;  o p
private!! 
const!! 
string!! /
#ErrorMessageAlreadyFriendsOrPending!! @
=!!A B
$str!!C t
;!!t u
private"" 
const"" 
string"" '
ErrorMessageRequestNotFound"" 8
=""9 :
$str""; b
;""b c
private## 
const## 
string## *
ErrorMessagePersistenceFailure## ;
=##< =
$str##> u
;##u v
private%% 
const%% 
string%% .
"FriendshipValidationFailedTemplate%% ?
=%%@ A
$str&& m
;&&m n
private'' 
const'' 
string'' 6
*SendFriendRequestInvalidParametersTemplate'' G
=''H I
$str(( i
;((i j
private)) 
const)) 
string)) 3
'FriendRequestTargetUserNotFoundTemplate)) D
=))E F
$str** o
;**o p
private++ 
const++ 
string++ +
FriendRequestSelfTargetTemplate++ <
=++= >
$str,, M
;,,M N
private-- 
const-- 
string-- .
"FriendRequestBlockedPlayerTemplate-- ?
=--@ A
$str.. o
;..o p
private// 
const// 
string// .
"FriendRequestAlreadyExistsTemplate// ?
=//@ A
$str00 p
+00q r
$str11 (
;11( )
private22 
const22 
string22 0
$FriendRequestNotFoundWarningTemplate22 A
=22B C
$str33 o
;33o p
private55 
const55 
string55 1
%FriendRequestSentSuccessfullyTemplate55 B
=55C D
$str66 a
;66a b
private77 
const77 
string77 )
FriendRequestAcceptedTemplate77 :
=77; <
$str88 X
;88X Y
private99 
const99 
string99 )
FriendRequestRejectedTemplate99 :
=99; <
$str:: X
;::X Y
private;; 
const;; 
string;; *
FriendRequestCancelledTemplate;; ;
=;;< =
$str<< ^
;<<^ _
private== 
const== 
string== -
!FriendRemovedSuccessfullyTemplate== >
===? @
$str>> U
;>>U V
private?? 
const?? 
string?? -
!PlayerBlockedSuccessfullyTemplate?? >
=??? @
$str@@ H
;@@H I
privateAA 
constAA 
stringAA /
#PlayerUnblockedSuccessfullyTemplateAA @
=AAA B
$strBB J
;BBJ K
privateCC 
constCC 
stringCC 6
*FriendshipActionPersistenceFailureTemplateCC G
=CCH I
$strDD {
;DD{ |
privateEE 
constEE 
stringEE 7
+SendFriendRequestPersistenceFailureTemplateEE H
=EEI J
$strFF q
;FFq r
privateGG 
constGG 
stringGG 5
)FriendshipQueryPersistenceFailureTemplateGG F
=GGG H
$strHH X
;HHX Y
privateJJ 
constJJ 
stringJJ 
ActionAcceptJJ )
=JJ* +
$strJJ, 4
;JJ4 5
privateKK 
constKK 
stringKK 
ActionBlockKK (
=KK) *
$strKK+ 2
;KK2 3
privateLL 
constLL 
stringLL 
ActionCancelLL )
=LL* +
$strLL, 4
;LL4 5
privateMM 
constMM 
stringMM 
ActionRejectMM )
=MM* +
$strMM, 4
;MM4 5
privateNN 
constNN 
stringNN 
ActionRemoveNN )
=NN* +
$strNN, 4
;NN4 5
privateOO 
constOO 
stringOO 
ActionUnblockOO *
=OO+ ,
$strOO- 6
;OO6 7
privateQQ 
constQQ 
stringQQ 
QueryFriendsListQQ -
=QQ. /
$strQQ0 =
;QQ= >
privateRR 
constRR 
stringRR  
QueryPendingRequestsRR 1
=RR2 3
$strRR4 E
;RRE F
privateSS 
constSS 
stringSS 
QuerySentRequestsSS .
=SS/ 0
$strSS1 ?
;SS? @
privateUU 
readonlyUU !
IFriendshipRepositoryUU .!
_friendshipRepositoryUU/ D
;UUD E
privateVV 
readonlyVV 
IUserRepositoryVV (
_userRepositoryVV) 8
;VV8 9
privateWW 
readonlyWW 
ILoggerServiceWW '
_loggerWW( /
;WW/ 0
publicYY 
FriendshipUseCaseYY  
(YY  !!
IFriendshipRepositoryYY! 6 
friendshipRepositoryYY7 K
,YYK L
IUserRepositoryYYM \
userRepositoryYY] k
,YYk l
ILoggerServiceZZ 
loggerZZ !
)ZZ! "
{[[ 	
if\\ 
(\\  
friendshipRepository\\ $
==\\% '
null\\( ,
)\\, -
{]] 
throw^^ 
new^^ !
ArgumentNullException^^ /
(^^/ 0
nameof^^0 6
(^^6 7 
friendshipRepository^^7 K
)^^K L
)^^L M
;^^M N
}__ 
if`` 
(`` 
userRepository`` 
==`` !
null``" &
)``& '
{aa 
throwbb 
newbb !
ArgumentNullExceptionbb /
(bb/ 0
nameofbb0 6
(bb6 7
userRepositorybb7 E
)bbE F
)bbF G
;bbG H
}cc !
_friendshipRepositoryee !
=ee" # 
friendshipRepositoryee$ 8
;ee8 9
_userRepositoryff 
=ff 
userRepositoryff ,
;ff, -
_loggergg 
=gg 
loggergg 
??gg 
throwgg  %
newgg& )!
ArgumentNullExceptiongg* ?
(gg? @
nameofgg@ F
(ggF G
loggerggG M
)ggM N
)ggN O
;ggO P
}hh 	
publicjj 
asyncjj 
Taskjj 
<jj #
FriendshipActionOutcomejj 1
>jj1 2$
AcceptFriendRequestAsyncjj3 K
(jjK L
intjjL O
receiverUserIdjjP ^
,jj^ _
intjj` c
senderUserIdjjd p
)jjp q
{kk 	#
FriendshipActionOutcomell ##
friendshipActionOutcomell$ ;
;ll; <
ifnn 
(nn 
IsValidUserIdnn 
(nn 
receiverUserIdnn ,
)nn, -
&&nn. 0
IsValidUserIdnn1 >
(nn> ?
senderUserIdnn? K
)nnK L
&&oo 
AreDistinctUserIdsoo %
(oo% &
receiverUserIdoo& 4
,oo4 5
senderUserIdoo6 B
)ooB C
)ooC D
{pp 
tryqq 
{rr #
friendshipActionOutcomess +
=ss, -
awaitss. 3%
ProcessAcceptRequestAsynctt 1
(tt1 2
receiverUserIdtt2 @
,tt@ A
senderUserIdttB N
)ttN O
;ttO P
}uu 
catchvv 
(vv %
InvalidOperationExceptionvv 0
)vv0 1
{ww 
_loggerxx 
.xx 
Warningxx #
(xx# $6
*FriendshipActionPersistenceFailureTemplatexx$ N
,xxN O
ActionAcceptxxP \
,xx\ ]
senderUserIdxx^ j
,xxj k
receiverUserIdxxl z
)xxz {
;xx{ |#
friendshipActionOutcomeyy +
=yy, -)
CreateFriendshipActionOutcomeyy. K
(yyK L
falseyyL Q
,yyQ R'
ErrorCodePersistenceFailurezz 3
,zz3 4*
ErrorMessagePersistenceFailurezz5 S
)zzS T
;zzT U
}{{ 
}|| 
else}} 
{~~ 
_logger 
. 
Warning 
(  .
"FriendshipValidationFailedTemplate  B
,B C
receiverUserIdD R
,R S
senderUserIdT `
)` a
;a b%
friendshipActionOutcome
ÄÄ '
=
ÄÄ( )+
CreateFriendshipActionOutcome
ÄÄ* G
(
ÄÄG H
false
ÄÄH M
,
ÄÄM N'
ErrorCodeValidationFailed
ÅÅ -
,
ÅÅ- .+
ErrorMessageInvalidParameters
ÅÅ/ L
)
ÅÅL M
;
ÅÅM N
}
ÇÇ 
return
ÑÑ %
friendshipActionOutcome
ÑÑ *
;
ÑÑ* +
}
ÖÖ 	
public
áá %
FriendshipActionOutcome
áá &
BlockPlayer
áá' 2
(
áá2 3
int
áá3 6
blockerUserId
áá7 D
,
ááD E
int
ááF I
targetUserId
ááJ V
)
ááV W
{
àà 	%
FriendshipActionOutcome
ââ #%
friendshipActionOutcome
ââ$ ;
;
ââ; <
if
ãã 
(
ãã 
IsValidUserId
ãã 
(
ãã 
blockerUserId
ãã +
)
ãã+ ,
&&
ãã- /
IsValidUserId
ãã0 =
(
ãã= >
targetUserId
ãã> J
)
ããJ K
&&
åå  
AreDistinctUserIds
åå %
(
åå% &
blockerUserId
åå& 3
,
åå3 4
targetUserId
åå5 A
)
ååA B
)
ååB C
{
çç 
try
éé 
{
èè #
_friendshipRepository
êê )
.
êê) *
BlockPlayer
êê* 5
(
êê5 6
blockerUserId
êê6 C
,
êêC D
targetUserId
êêE Q
)
êêQ R
;
êêR S
_logger
ëë 
.
ëë 
Information
ëë '
(
ëë' (/
!PlayerBlockedSuccessfullyTemplate
ëë( I
,
ëëI J
targetUserId
ëëK W
,
ëëW X
blockerUserId
ëëY f
)
ëëf g
;
ëëg h%
friendshipActionOutcome
íí +
=
íí, -+
CreateFriendshipActionOutcome
íí. K
(
ííK L
true
ííL P
,
ííP Q
ErrorCodeSuccess
ìì (
,
ìì( )"
MessagePlayerBlocked
ìì* >
)
ìì> ?
;
ìì? @
}
îî 
catch
ïï 
(
ïï '
InvalidOperationException
ïï 0
)
ïï0 1
{
ññ 
_logger
óó 
.
óó 
Warning
óó #
(
óó# $8
*FriendshipActionPersistenceFailureTemplate
óó$ N
,
óóN O
ActionBlock
óóP [
,
óó[ \
blockerUserId
óó] j
,
óój k
targetUserId
óól x
)
óóx y
;
óóy z%
friendshipActionOutcome
òò +
=
òò, -+
CreateFriendshipActionOutcome
òò. K
(
òòK L
false
òòL Q
,
òòQ R)
ErrorCodePersistenceFailure
ôô 3
,
ôô3 4,
ErrorMessagePersistenceFailure
ôô5 S
)
ôôS T
;
ôôT U
}
öö 
}
õõ 
else
úú 
{
ùù 
_logger
ûû 
.
ûû 
Warning
ûû 
(
ûû  0
"FriendshipValidationFailedTemplate
ûû  B
,
ûûB C
blockerUserId
ûûD Q
,
ûûQ R
targetUserId
ûûS _
)
ûû_ `
;
ûû` a%
friendshipActionOutcome
üü '
=
üü( )+
CreateFriendshipActionOutcome
üü* G
(
üüG H
false
üüH M
,
üüM N'
ErrorCodeValidationFailed
†† -
,
††- .+
ErrorMessageInvalidParameters
††/ L
)
††L M
;
††M N
}
°° 
return
££ %
friendshipActionOutcome
££ *
;
££* +
}
§§ 	
public
¶¶ 
async
¶¶ 
Task
¶¶ 
<
¶¶ %
FriendshipActionOutcome
¶¶ 1
>
¶¶1 2&
CancelFriendRequestAsync
¶¶3 K
(
¶¶K L
int
¶¶L O
senderUserId
¶¶P \
,
¶¶\ ]
int
¶¶^ a
receiverUserId
¶¶b p
)
¶¶p q
{
ßß 	%
FriendshipActionOutcome
®® #%
friendshipActionOutcome
®®$ ;
;
®®; <
if
™™ 
(
™™ 
IsValidUserId
™™ 
(
™™ 
senderUserId
™™ *
)
™™* +
&&
™™, .
IsValidUserId
™™/ <
(
™™< =
receiverUserId
™™= K
)
™™K L
&&
´´  
AreDistinctUserIds
´´ %
(
´´% &
senderUserId
´´& 2
,
´´2 3
receiverUserId
´´4 B
)
´´B C
)
´´C D
{
¨¨ 
try
≠≠ 
{
ÆÆ %
friendshipActionOutcome
ØØ +
=
ØØ, -
await
ØØ. 3.
 ProcessRemovePendingRequestAsync
ØØ4 T
(
ØØT U
receiverUserId
∞∞ &
,
∞∞& '
senderUserId
±± $
,
±±$ %+
MessageFriendRequestCancelled
≤≤ 5
)
≤≤5 6
;
≤≤6 7
if
≥≥ 
(
≥≥ %
friendshipActionOutcome
≥≥ /
.
≥≥/ 0
	IsSuccess
≥≥0 9
)
≥≥9 :
{
¥¥ 
_logger
µµ 
.
µµ  
Information
µµ  +
(
µµ+ ,,
FriendRequestCancelledTemplate
µµ, J
,
µµJ K
senderUserId
µµL X
,
µµX Y
receiverUserId
µµZ h
)
µµh i
;
µµi j
}
∂∂ 
}
∑∑ 
catch
∏∏ 
(
∏∏ '
InvalidOperationException
∏∏ 0
)
∏∏0 1
{
ππ 
_logger
∫∫ 
.
∫∫ 
Warning
∫∫ #
(
∫∫# $8
*FriendshipActionPersistenceFailureTemplate
∫∫$ N
,
∫∫N O
ActionCancel
∫∫P \
,
∫∫\ ]
senderUserId
∫∫^ j
,
∫∫j k
receiverUserId
∫∫l z
)
∫∫z {
;
∫∫{ |%
friendshipActionOutcome
ªª +
=
ªª, -+
CreateFriendshipActionOutcome
ªª. K
(
ªªK L
false
ªªL Q
,
ªªQ R)
ErrorCodePersistenceFailure
ºº 3
,
ºº3 4,
ErrorMessagePersistenceFailure
ºº5 S
)
ººS T
;
ººT U
}
ΩΩ 
}
ææ 
else
øø 
{
¿¿ 
_logger
¡¡ 
.
¡¡ 
Warning
¡¡ 
(
¡¡  0
"FriendshipValidationFailedTemplate
¡¡  B
,
¡¡B C
senderUserId
¡¡D P
,
¡¡P Q
receiverUserId
¡¡R `
)
¡¡` a
;
¡¡a b%
friendshipActionOutcome
¬¬ '
=
¬¬( )+
CreateFriendshipActionOutcome
¬¬* G
(
¬¬G H
false
¬¬H M
,
¬¬M N'
ErrorCodeValidationFailed
√√ -
,
√√- .+
ErrorMessageInvalidParameters
√√/ L
)
√√L M
;
√√M N
}
ƒƒ 
return
∆∆ %
friendshipActionOutcome
∆∆ *
;
∆∆* +
}
«« 	
public
…… 
List
…… 
<
…… 
FriendSummaryData
…… %
>
……% &$
GetFriendsListByUserId
……' =
(
……= >
int
……> A
userId
……B H
)
……H I
{
   	
List
ÀÀ 
<
ÀÀ 
FriendSummaryData
ÀÀ "
>
ÀÀ" #
friends
ÀÀ$ +
=
ÀÀ, -
new
ÀÀ. 1
List
ÀÀ2 6
<
ÀÀ6 7
FriendSummaryData
ÀÀ7 H
>
ÀÀH I
(
ÀÀI J
)
ÀÀJ K
;
ÀÀK L
if
ÕÕ 
(
ÕÕ 
IsValidUserId
ÕÕ 
(
ÕÕ 
userId
ÕÕ $
)
ÕÕ$ %
)
ÕÕ% &
{
ŒŒ 
try
œœ 
{
–– 
friends
—— 
=
—— #
_friendshipRepository
—— 3
.
——3 4$
GetFriendsListByUserId
——4 J
(
——J K
userId
——K Q
)
——Q R
;
——R S
}
““ 
catch
”” 
(
”” '
InvalidOperationException
”” 0
)
””0 1
{
‘‘ 
_logger
’’ 
.
’’ 
Warning
’’ #
(
’’# $7
)FriendshipQueryPersistenceFailureTemplate
’’$ M
,
’’M N
QueryFriendsList
’’O _
,
’’_ `
userId
’’a g
)
’’g h
;
’’h i
}
÷÷ 
}
◊◊ 
return
ŸŸ 
friends
ŸŸ 
;
ŸŸ 
}
⁄⁄ 	
public
‹‹ 
async
‹‹ 
Task
‹‹ 
<
‹‹ 
List
‹‹ 
<
‹‹ 
FriendRequestData
‹‹ 0
>
‹‹0 1
>
‹‹1 23
%GetPendingFriendRequestsByUserIdAsync
‹‹3 X
(
‹‹X Y
int
‹‹Y \
userId
‹‹] c
)
‹‹c d
{
›› 	
List
ﬁﬁ 
<
ﬁﬁ 
FriendRequestData
ﬁﬁ "
>
ﬁﬁ" ##
pendingFriendRequests
ﬁﬁ$ 9
=
ﬁﬁ: ;
new
ﬁﬁ< ?
List
ﬁﬁ@ D
<
ﬁﬁD E
FriendRequestData
ﬁﬁE V
>
ﬁﬁV W
(
ﬁﬁW X
)
ﬁﬁX Y
;
ﬁﬁY Z
if
‡‡ 
(
‡‡ 
IsValidUserId
‡‡ 
(
‡‡ 
userId
‡‡ $
)
‡‡$ %
)
‡‡% &
{
·· 
try
‚‚ 
{
„„ #
pendingFriendRequests
‰‰ )
=
‰‰* +
await
‰‰, 1#
_friendshipRepository
ÂÂ -
.
ÂÂ- .3
%GetPendingFriendRequestsByUserIdAsync
ÂÂ. S
(
ÂÂS T
userId
ÂÂT Z
)
ÂÂZ [
;
ÂÂ[ \
}
ÊÊ 
catch
ÁÁ 
(
ÁÁ '
InvalidOperationException
ÁÁ 0
)
ÁÁ0 1
{
ËË 
_logger
ÈÈ 
.
ÈÈ 
Warning
ÈÈ #
(
ÈÈ# $7
)FriendshipQueryPersistenceFailureTemplate
ÈÈ$ M
,
ÈÈM N"
QueryPendingRequests
ÈÈO c
,
ÈÈc d
userId
ÈÈe k
)
ÈÈk l
;
ÈÈl m
}
ÍÍ 
}
ÎÎ 
return
ÌÌ #
pendingFriendRequests
ÌÌ (
;
ÌÌ( )
}
ÓÓ 	
public
 
async
 
Task
 
<
 
List
 
<
 
FriendRequestData
 0
>
0 1
>
1 20
"GetSentFriendRequestsByUserIdAsync
3 U
(
U V
int
V Y
userId
Z `
)
` a
{
ÒÒ 	
List
ÚÚ 
<
ÚÚ 
FriendRequestData
ÚÚ "
>
ÚÚ" # 
sentFriendRequests
ÚÚ$ 6
=
ÚÚ7 8
new
ÚÚ9 <
List
ÚÚ= A
<
ÚÚA B
FriendRequestData
ÚÚB S
>
ÚÚS T
(
ÚÚT U
)
ÚÚU V
;
ÚÚV W
if
ÙÙ 
(
ÙÙ 
IsValidUserId
ÙÙ 
(
ÙÙ 
userId
ÙÙ $
)
ÙÙ$ %
)
ÙÙ% &
{
ıı 
try
ˆˆ 
{
˜˜  
sentFriendRequests
¯¯ &
=
¯¯' (
await
¯¯) .#
_friendshipRepository
˘˘ -
.
˘˘- .0
"GetSentFriendRequestsByUserIdAsync
˘˘. P
(
˘˘P Q
userId
˘˘Q W
)
˘˘W X
;
˘˘X Y
}
˙˙ 
catch
˚˚ 
(
˚˚ '
InvalidOperationException
˚˚ 0
)
˚˚0 1
{
¸¸ 
_logger
˝˝ 
.
˝˝ 
Warning
˝˝ #
(
˝˝# $7
)FriendshipQueryPersistenceFailureTemplate
˝˝$ M
,
˝˝M N
QuerySentRequests
˝˝O `
,
˝˝` a
userId
˝˝b h
)
˝˝h i
;
˝˝i j
}
˛˛ 
}
ˇˇ 
return
ÅÅ  
sentFriendRequests
ÅÅ %
;
ÅÅ% &
}
ÇÇ 	
public
ÑÑ 
async
ÑÑ 
Task
ÑÑ 
<
ÑÑ %
FriendshipActionOutcome
ÑÑ 1
>
ÑÑ1 2&
RejectFriendRequestAsync
ÑÑ3 K
(
ÑÑK L
int
ÑÑL O
receiverUserId
ÑÑP ^
,
ÑÑ^ _
int
ÑÑ` c
senderUserId
ÑÑd p
)
ÑÑp q
{
ÖÖ 	%
FriendshipActionOutcome
ÜÜ #%
friendshipActionOutcome
ÜÜ$ ;
;
ÜÜ; <
if
àà 
(
àà 
IsValidUserId
àà 
(
àà 
receiverUserId
àà ,
)
àà, -
&&
àà. 0
IsValidUserId
àà1 >
(
àà> ?
senderUserId
àà? K
)
ààK L
&&
ââ  
AreDistinctUserIds
ââ %
(
ââ% &
receiverUserId
ââ& 4
,
ââ4 5
senderUserId
ââ6 B
)
ââB C
)
ââC D
{
ää 
try
ãã 
{
åå %
friendshipActionOutcome
çç +
=
çç, -
await
çç. 3.
 ProcessRemovePendingRequestAsync
çç4 T
(
ççT U
receiverUserId
éé &
,
éé& '
senderUserId
èè $
,
èè$ %*
MessageFriendRequestRejected
êê 4
)
êê4 5
;
êê5 6
if
ëë 
(
ëë %
friendshipActionOutcome
ëë /
.
ëë/ 0
	IsSuccess
ëë0 9
)
ëë9 :
{
íí 
_logger
ìì 
.
ìì  
Information
ìì  +
(
ìì+ ,+
FriendRequestRejectedTemplate
ìì, I
,
ììI J
receiverUserId
ììK Y
,
ììY Z
senderUserId
ìì[ g
)
ììg h
;
ììh i
}
îî 
}
ïï 
catch
ññ 
(
ññ '
InvalidOperationException
ññ 0
)
ññ0 1
{
óó 
_logger
òò 
.
òò 
Warning
òò #
(
òò# $8
*FriendshipActionPersistenceFailureTemplate
òò$ N
,
òòN O
ActionReject
òòP \
,
òò\ ]
senderUserId
òò^ j
,
òòj k
receiverUserId
òòl z
)
òòz {
;
òò{ |%
friendshipActionOutcome
ôô +
=
ôô, -+
CreateFriendshipActionOutcome
ôô. K
(
ôôK L
false
ôôL Q
,
ôôQ R)
ErrorCodePersistenceFailure
öö 3
,
öö3 4,
ErrorMessagePersistenceFailure
öö5 S
)
ööS T
;
ööT U
}
õõ 
}
úú 
else
ùù 
{
ûû 
_logger
üü 
.
üü 
Warning
üü 
(
üü  0
"FriendshipValidationFailedTemplate
üü  B
,
üüB C
receiverUserId
üüD R
,
üüR S
senderUserId
üüT `
)
üü` a
;
üüa b%
friendshipActionOutcome
†† '
=
††( )+
CreateFriendshipActionOutcome
††* G
(
††G H
false
††H M
,
††M N'
ErrorCodeValidationFailed
°° -
,
°°- .+
ErrorMessageInvalidParameters
°°/ L
)
°°L M
;
°°M N
}
¢¢ 
return
§§ %
friendshipActionOutcome
§§ *
;
§§* +
}
•• 	
public
ßß %
FriendshipActionOutcome
ßß &
RemoveFriend
ßß' 3
(
ßß3 4
int
ßß4 7
userId
ßß8 >
,
ßß> ?
int
ßß@ C
friendUserId
ßßD P
)
ßßP Q
{
®® 	%
FriendshipActionOutcome
©© #%
friendshipActionOutcome
©©$ ;
;
©©; <
if
´´ 
(
´´ 
IsValidUserId
´´ 
(
´´ 
userId
´´ $
)
´´$ %
&&
´´& (
IsValidUserId
´´) 6
(
´´6 7
friendUserId
´´7 C
)
´´C D
&&
¨¨  
AreDistinctUserIds
¨¨ %
(
¨¨% &
userId
¨¨& ,
,
¨¨, -
friendUserId
¨¨. :
)
¨¨: ;
)
¨¨; <
{
≠≠ 
try
ÆÆ 
{
ØØ #
_friendshipRepository
∞∞ )
.
∞∞) *
RemoveFriendship
∞∞* :
(
∞∞: ;
userId
∞∞; A
,
∞∞A B
friendUserId
∞∞C O
)
∞∞O P
;
∞∞P Q
_logger
±± 
.
±± 
Information
±± '
(
±±' (/
!FriendRemovedSuccessfullyTemplate
±±( I
,
±±I J
userId
±±K Q
,
±±Q R
friendUserId
±±S _
)
±±_ `
;
±±` a%
friendshipActionOutcome
≤≤ +
=
≤≤, -+
CreateFriendshipActionOutcome
≤≤. K
(
≤≤K L
true
≤≤L P
,
≤≤P Q
ErrorCodeSuccess
≥≥ (
,
≥≥( )"
MessageFriendRemoved
≥≥* >
)
≥≥> ?
;
≥≥? @
}
¥¥ 
catch
µµ 
(
µµ '
InvalidOperationException
µµ 0
)
µµ0 1
{
∂∂ 
_logger
∑∑ 
.
∑∑ 
Warning
∑∑ #
(
∑∑# $8
*FriendshipActionPersistenceFailureTemplate
∑∑$ N
,
∑∑N O
ActionRemove
∑∑P \
,
∑∑\ ]
userId
∑∑^ d
,
∑∑d e
friendUserId
∑∑f r
)
∑∑r s
;
∑∑s t%
friendshipActionOutcome
∏∏ +
=
∏∏, -+
CreateFriendshipActionOutcome
∏∏. K
(
∏∏K L
false
∏∏L Q
,
∏∏Q R)
ErrorCodePersistenceFailure
ππ 3
,
ππ3 4,
ErrorMessagePersistenceFailure
ππ5 S
)
ππS T
;
ππT U
}
∫∫ 
}
ªª 
else
ºº 
{
ΩΩ 
_logger
ææ 
.
ææ 
Warning
ææ 
(
ææ  0
"FriendshipValidationFailedTemplate
ææ  B
,
ææB C
userId
ææD J
,
ææJ K
friendUserId
ææL X
)
ææX Y
;
ææY Z%
friendshipActionOutcome
øø '
=
øø( )+
CreateFriendshipActionOutcome
øø* G
(
øøG H
false
øøH M
,
øøM N'
ErrorCodeValidationFailed
¿¿ -
,
¿¿- .+
ErrorMessageInvalidParameters
¿¿/ L
)
¿¿L M
;
¿¿M N
}
¡¡ 
return
√√ %
friendshipActionOutcome
√√ *
;
√√* +
}
ƒƒ 	
public
∆∆ 
async
∆∆ 
Task
∆∆ 
<
∆∆ %
FriendshipActionOutcome
∆∆ 1
>
∆∆1 2$
SendFriendRequestAsync
∆∆3 I
(
∆∆I J
int
∆∆J M
senderUserId
∆∆N Z
,
∆∆Z [
string
∆∆\ b
targetUsername
∆∆c q
)
∆∆q r
{
«« 	%
FriendshipActionOutcome
»» #%
friendshipActionOutcome
»»$ ;
;
»»; <
if
   
(
   
IsValidUserId
   
(
   
senderUserId
   *
)
  * +
&&
  , .
!
  / 0
string
  0 6
.
  6 7 
IsNullOrWhiteSpace
  7 I
(
  I J
targetUsername
  J X
)
  X Y
)
  Y Z
{
ÀÀ 
try
ÃÃ 
{
ÕÕ %
friendshipActionOutcome
ŒŒ +
=
ŒŒ, -
await
ŒŒ. 3+
ProcessSendFriendRequestAsync
ŒŒ4 Q
(
ŒŒQ R
senderUserId
ŒŒR ^
,
ŒŒ^ _
targetUsername
œœ &
.
œœ& '
Trim
œœ' +
(
œœ+ ,
)
œœ, -
)
œœ- .
;
œœ. /
}
–– 
catch
—— 
(
—— '
InvalidOperationException
—— 0
)
——0 1
{
““ 
_logger
”” 
.
”” 
Warning
”” #
(
””# $9
+SendFriendRequestPersistenceFailureTemplate
””$ O
,
””O P
senderUserId
””Q ]
,
””] ^
targetUsername
””_ m
.
””m n
Trim
””n r
(
””r s
)
””s t
)
””t u
;
””u v%
friendshipActionOutcome
‘‘ +
=
‘‘, -+
CreateFriendshipActionOutcome
‘‘. K
(
‘‘K L
false
‘‘L Q
,
‘‘Q R)
ErrorCodePersistenceFailure
‘‘S n
,
‘‘n o,
ErrorMessagePersistenceFailure
’’ 6
)
’’6 7
;
’’7 8
}
÷÷ 
}
◊◊ 
else
ÿÿ 
{
ŸŸ 
_logger
⁄⁄ 
.
⁄⁄ 
Warning
⁄⁄ 
(
⁄⁄  8
*SendFriendRequestInvalidParametersTemplate
⁄⁄  J
,
⁄⁄J K
senderUserId
⁄⁄L X
)
⁄⁄X Y
;
⁄⁄Y Z%
friendshipActionOutcome
€€ '
=
€€( )+
CreateFriendshipActionOutcome
€€* G
(
€€G H
false
€€H M
,
€€M N'
ErrorCodeValidationFailed
€€O h
,
€€h i+
ErrorMessageInvalidParameters
‹‹ 1
)
‹‹1 2
;
‹‹2 3
}
›› 
return
ﬂﬂ %
friendshipActionOutcome
ﬂﬂ *
;
ﬂﬂ* +
}
‡‡ 	
public
‚‚ %
FriendshipActionOutcome
‚‚ &
UnblockPlayer
‚‚' 4
(
‚‚4 5
int
‚‚5 8
blockerUserId
‚‚9 F
,
‚‚F G
int
‚‚H K
targetUserId
‚‚L X
)
‚‚X Y
{
„„ 	%
FriendshipActionOutcome
‰‰ #%
friendshipActionOutcome
‰‰$ ;
;
‰‰; <
if
ÊÊ 
(
ÊÊ 
IsValidUserId
ÊÊ 
(
ÊÊ 
blockerUserId
ÊÊ +
)
ÊÊ+ ,
&&
ÊÊ- /
IsValidUserId
ÊÊ0 =
(
ÊÊ= >
targetUserId
ÊÊ> J
)
ÊÊJ K
&&
ÁÁ  
AreDistinctUserIds
ÁÁ %
(
ÁÁ% &
blockerUserId
ÁÁ& 3
,
ÁÁ3 4
targetUserId
ÁÁ5 A
)
ÁÁA B
)
ÁÁB C
{
ËË 
try
ÈÈ 
{
ÍÍ #
_friendshipRepository
ÎÎ )
.
ÎÎ) *
UnblockPlayer
ÎÎ* 7
(
ÎÎ7 8
blockerUserId
ÎÎ8 E
,
ÎÎE F
targetUserId
ÎÎG S
)
ÎÎS T
;
ÎÎT U
_logger
ÏÏ 
.
ÏÏ 
Information
ÏÏ '
(
ÏÏ' (1
#PlayerUnblockedSuccessfullyTemplate
ÏÏ( K
,
ÏÏK L
targetUserId
ÏÏM Y
,
ÏÏY Z
blockerUserId
ÏÏ[ h
)
ÏÏh i
;
ÏÏi j%
friendshipActionOutcome
ÌÌ +
=
ÌÌ, -+
CreateFriendshipActionOutcome
ÌÌ. K
(
ÌÌK L
true
ÌÌL P
,
ÌÌP Q
ErrorCodeSuccess
ÓÓ (
,
ÓÓ( )$
MessagePlayerUnblocked
ÓÓ* @
)
ÓÓ@ A
;
ÓÓA B
}
ÔÔ 
catch
 
(
 '
InvalidOperationException
 0
)
0 1
{
ÒÒ 
_logger
ÚÚ 
.
ÚÚ 
Warning
ÚÚ #
(
ÚÚ# $8
*FriendshipActionPersistenceFailureTemplate
ÚÚ$ N
,
ÚÚN O
ActionUnblock
ÚÚP ]
,
ÚÚ] ^
blockerUserId
ÚÚ_ l
,
ÚÚl m
targetUserId
ÚÚn z
)
ÚÚz {
;
ÚÚ{ |%
friendshipActionOutcome
ÛÛ +
=
ÛÛ, -+
CreateFriendshipActionOutcome
ÛÛ. K
(
ÛÛK L
false
ÛÛL Q
,
ÛÛQ R)
ErrorCodePersistenceFailure
ÙÙ 3
,
ÙÙ3 4,
ErrorMessagePersistenceFailure
ÙÙ5 S
)
ÙÙS T
;
ÙÙT U
}
ıı 
}
ˆˆ 
else
˜˜ 
{
¯¯ 
_logger
˘˘ 
.
˘˘ 
Warning
˘˘ 
(
˘˘  0
"FriendshipValidationFailedTemplate
˘˘  B
,
˘˘B C
blockerUserId
˘˘D Q
,
˘˘Q R
targetUserId
˘˘S _
)
˘˘_ `
;
˘˘` a%
friendshipActionOutcome
˙˙ '
=
˙˙( )+
CreateFriendshipActionOutcome
˙˙* G
(
˙˙G H
false
˙˙H M
,
˙˙M N'
ErrorCodeValidationFailed
˚˚ -
,
˚˚- .+
ErrorMessageInvalidParameters
˚˚/ L
)
˚˚L M
;
˚˚M N
}
¸¸ 
return
˛˛ %
friendshipActionOutcome
˛˛ *
;
˛˛* +
}
ˇˇ 	
private
ÅÅ 
static
ÅÅ 
bool
ÅÅ "
IsPendingForReceiver
ÅÅ 0
(
ÅÅ0 1"
FriendshipRecordData
ÅÅ1 E"
friendshipRecordData
ÅÅF Z
,
ÅÅZ [
int
ÅÅ\ _
receiverUserId
ÅÅ` n
)
ÅÅn o
{
ÇÇ 	
bool
ÉÉ "
isPendingForReceiver
ÉÉ %
=
ÉÉ& '
false
ÉÉ( -
;
ÉÉ- .
if
ÖÖ 
(
ÖÖ "
friendshipRecordData
ÖÖ $
!=
ÖÖ% '
null
ÖÖ( ,
&&
ÖÖ- /"
friendshipRecordData
ÖÖ0 D
.
ÖÖD E
Status
ÖÖE K
==
ÖÖL N%
PendingFriendshipStatus
ÖÖO f
)
ÖÖf g
{
ÜÜ 
int
áá $
expectedReceiverUserId
áá *
=
áá+ ,"
friendshipRecordData
áá- A
.
ááA B
IsRequestedByLow
ááB R
?
àà "
friendshipRecordData
àà *
.
àà* +

IdUserHigh
àà+ 5
:
ââ "
friendshipRecordData
ââ *
.
ââ* +
	IdUserLow
ââ+ 4
;
ââ4 5"
isPendingForReceiver
ãã $
=
ãã% &$
expectedReceiverUserId
ãã' =
==
ãã> @
receiverUserId
ããA O
;
ããO P
}
åå 
return
éé "
isPendingForReceiver
éé '
;
éé' (
}
èè 	
private
ëë 
async
ëë 
Task
ëë 
<
ëë %
FriendshipActionOutcome
ëë 2
>
ëë2 3'
ProcessAcceptRequestAsync
ëë4 M
(
ëëM N
int
ëëN Q
receiverUserId
ëëR `
,
ëë` a
int
ëëb e
senderUserId
ëëf r
)
ëër s
{
íí 	%
FriendshipActionOutcome
ìì #%
friendshipActionOutcome
ìì$ ;
;
ìì; <"
FriendshipRecordData
îî  "
friendshipRecordData
îî! 5
=
îî6 7
await
îî8 =#
_friendshipRepository
îî> S
.
ïï  
GetFriendshipAsync
ïï #
(
ïï# $
receiverUserId
ïï$ 2
,
ïï2 3
senderUserId
ïï4 @
)
ïï@ A
;
ïïA B
if
óó 
(
óó "
IsPendingForReceiver
óó $
(
óó$ %"
friendshipRecordData
óó% 9
,
óó9 :
receiverUserId
óó; I
)
óóI J
)
óóJ K
{
òò 
await
ôô #
_friendshipRepository
ôô +
.
ôô+ ,)
UpdateFriendshipStatusAsync
ôô, G
(
ôôG H
receiverUserId
ôôH V
,
ôôV W
senderUserId
ôôX d
,
ôôd e&
AcceptedFriendshipStatus
öö ,
)
öö, -
;
öö- .
_logger
õõ 
.
õõ 
Information
õõ #
(
õõ# $+
FriendRequestAcceptedTemplate
õõ$ A
,
õõA B
receiverUserId
õõC Q
,
õõQ R
senderUserId
õõS _
)
õõ_ `
;
õõ` a%
friendshipActionOutcome
úú '
=
úú( )+
CreateFriendshipActionOutcome
úú* G
(
úúG H
true
úúH L
,
úúL M
ErrorCodeSuccess
úúN ^
,
úú^ _*
MessageFriendRequestAccepted
ùù 0
)
ùù0 1
;
ùù1 2
}
ûû 
else
üü 
{
†† 
_logger
°° 
.
°° 
Warning
°° 
(
°°  2
$FriendRequestNotFoundWarningTemplate
°°  D
,
°°D E
receiverUserId
°°F T
,
°°T U
senderUserId
°°V b
)
°°b c
;
°°c d%
friendshipActionOutcome
¢¢ '
=
¢¢( )+
CreateFriendshipActionOutcome
¢¢* G
(
¢¢G H
false
¢¢H M
,
¢¢M N.
 ErrorCodeDuplicateOrInvalidState
¢¢O o
,
¢¢o p)
ErrorMessageRequestNotFound
££ /
)
££/ 0
;
££0 1
}
§§ 
return
¶¶ %
friendshipActionOutcome
¶¶ *
;
¶¶* +
}
ßß 	
private
©© 
async
©© 
Task
©© 
<
©© %
FriendshipActionOutcome
©© 2
>
©©2 3.
 ProcessRemovePendingRequestAsync
©©4 T
(
©©T U
int
™™ 
receiverUserId
™™ 
,
™™ 
int
´´ 
senderUserId
´´ 
,
´´ 
string
¨¨ 
successMessage
¨¨ !
)
¨¨! "
{
≠≠ 	%
FriendshipActionOutcome
ÆÆ #%
friendshipActionOutcome
ÆÆ$ ;
;
ÆÆ; <"
FriendshipRecordData
ØØ  "
friendshipRecordData
ØØ! 5
=
ØØ6 7
await
ØØ8 =#
_friendshipRepository
∞∞ %
.
∞∞% & 
GetFriendshipAsync
∞∞& 8
(
∞∞8 9
receiverUserId
∞∞9 G
,
∞∞G H
senderUserId
∞∞I U
)
∞∞U V
;
∞∞V W
if
≤≤ 
(
≤≤ "
IsPendingForReceiver
≤≤ $
(
≤≤$ %"
friendshipRecordData
≤≤% 9
,
≤≤9 :
receiverUserId
≤≤; I
)
≤≤I J
)
≤≤J K
{
≥≥ 
await
¥¥ #
_friendshipRepository
¥¥ +
.
¥¥+ ,#
DeleteFriendshipAsync
¥¥, A
(
¥¥A B
receiverUserId
¥¥B P
,
¥¥P Q
senderUserId
¥¥R ^
)
¥¥^ _
;
¥¥_ `%
friendshipActionOutcome
µµ '
=
µµ( )+
CreateFriendshipActionOutcome
µµ* G
(
µµG H
true
µµH L
,
µµL M
ErrorCodeSuccess
µµN ^
,
µµ^ _
successMessage
∂∂ "
)
∂∂" #
;
∂∂# $
}
∑∑ 
else
∏∏ 
{
ππ 
_logger
∫∫ 
.
∫∫ 
Warning
∫∫ 
(
∫∫  2
$FriendRequestNotFoundWarningTemplate
∫∫  D
,
∫∫D E
receiverUserId
∫∫F T
,
∫∫T U
senderUserId
∫∫V b
)
∫∫b c
;
∫∫c d%
friendshipActionOutcome
ªª '
=
ªª( )+
CreateFriendshipActionOutcome
ªª* G
(
ªªG H
false
ªªH M
,
ªªM N.
 ErrorCodeDuplicateOrInvalidState
ªªO o
,
ªªo p)
ErrorMessageRequestNotFound
ºº /
)
ºº/ 0
;
ºº0 1
}
ΩΩ 
return
øø %
friendshipActionOutcome
øø *
;
øø* +
}
¿¿ 	
private
¬¬ 
async
¬¬ 
Task
¬¬ 
<
¬¬ %
FriendshipActionOutcome
¬¬ 2
>
¬¬2 3+
ProcessSendFriendRequestAsync
¬¬4 Q
(
¬¬Q R
int
¬¬R U
senderUserId
¬¬V b
,
¬¬b c
string
√√ 
targetUsername
√√ !
)
√√! "
{
ƒƒ 	%
FriendshipActionOutcome
≈≈ #%
friendshipActionOutcome
≈≈$ ;
;
≈≈; <
UserAccount
∆∆ 

targetUser
∆∆ "
=
∆∆# $
_userRepository
∆∆% 4
.
∆∆4 5
GetUserByUsername
∆∆5 F
(
∆∆F G
targetUsername
∆∆G U
)
∆∆U V
;
∆∆V W
if
»» 
(
»» 

targetUser
»» 
==
»» 
null
»» "
)
»»" #
{
…… 
_logger
   
.
   
Warning
   
(
    5
'FriendRequestTargetUserNotFoundTemplate
    G
,
  G H
targetUsername
  I W
,
  W X
senderUserId
  Y e
)
  e f
;
  f g%
friendshipActionOutcome
ÀÀ '
=
ÀÀ( )+
CreateFriendshipActionOutcome
ÀÀ* G
(
ÀÀG H
false
ÀÀH M
,
ÀÀM N#
ErrorCodeUserNotFound
ÀÀO d
,
ÀÀd e,
ErrorMessageTargetUserNotFound
ÃÃ 2
)
ÃÃ2 3
;
ÃÃ3 4
}
ÕÕ 
else
ŒŒ 
if
ŒŒ 
(
ŒŒ 

targetUser
ŒŒ 
.
ŒŒ  
IdUser
ŒŒ  &
==
ŒŒ' )
senderUserId
ŒŒ* 6
)
ŒŒ6 7
{
œœ 
_logger
–– 
.
–– 
Warning
–– 
(
––  -
FriendRequestSelfTargetTemplate
––  ?
,
––? @
senderUserId
––A M
)
––M N
;
––N O%
friendshipActionOutcome
—— '
=
——( )+
CreateFriendshipActionOutcome
——* G
(
——G H
false
——H M
,
——M N'
ErrorCodeValidationFailed
——O h
,
——h i+
ErrorMessageInvalidParameters
““ 1
)
““1 2
;
““2 3
}
”” 
else
‘‘ 
if
‘‘ 
(
‘‘ #
_friendshipRepository
‘‘ *
.
‘‘* +&
IsPlayerBlockedByPlayerA
‘‘+ C
(
‘‘C D
senderUserId
‘‘D P
,
‘‘P Q

targetUser
‘‘R \
.
‘‘\ ]
IdUser
‘‘] c
)
‘‘c d
)
‘‘d e
{
’’ 
_logger
÷÷ 
.
÷÷ 
Warning
÷÷ 
(
÷÷  0
"FriendRequestBlockedPlayerTemplate
÷÷  B
,
÷÷B C
senderUserId
÷÷D P
,
÷÷P Q

targetUser
÷÷R \
.
÷÷\ ]
IdUser
÷÷] c
)
÷÷c d
;
÷÷d e%
friendshipActionOutcome
◊◊ '
=
◊◊( )+
CreateFriendshipActionOutcome
◊◊* G
(
◊◊G H
false
◊◊H M
,
◊◊M N$
ErrorCodePlayerBlocked
◊◊O e
,
◊◊e f'
ErrorMessagePlayerBlocked
ÿÿ -
)
ÿÿ- .
;
ÿÿ. /
}
ŸŸ 
else
⁄⁄ 
{
€€ "
FriendshipRecordData
‹‹ $ 
existingFriendship
‹‹% 7
=
‹‹8 9
await
‹‹: ?#
_friendshipRepository
‹‹@ U
.
‹‹U V 
GetFriendshipAsync
‹‹V h
(
‹‹h i
senderUserId
››  
,
››  !

targetUser
››" ,
.
››, -
IdUser
››- 3
)
››3 4
;
››4 5
if
ﬂﬂ 
(
ﬂﬂ  
existingFriendship
ﬂﬂ &
!=
ﬂﬂ' )
null
ﬂﬂ* .
)
ﬂﬂ. /
{
‡‡ 
_logger
·· 
.
·· 
Warning
·· #
(
··# $0
"FriendRequestAlreadyExistsTemplate
··$ F
,
··F G
senderUserId
··H T
,
··T U

targetUser
··V `
.
··` a
IdUser
··a g
)
··g h
;
··h i%
friendshipActionOutcome
‚‚ +
=
‚‚, -+
CreateFriendshipActionOutcome
‚‚. K
(
‚‚K L
false
‚‚L Q
,
‚‚Q R.
 ErrorCodeDuplicateOrInvalidState
‚‚S s
,
‚‚s t1
#ErrorMessageAlreadyFriendsOrPending
„„ ;
)
„„; <
;
„„< =
}
‰‰ 
else
ÂÂ 
{
ÊÊ 
await
ÁÁ #
_friendshipRepository
ÁÁ /
.
ÁÁ/ 0&
CreateFriendRequestAsync
ÁÁ0 H
(
ÁÁH I
senderUserId
ÁÁI U
,
ÁÁU V

targetUser
ÁÁW a
.
ÁÁa b
IdUser
ÁÁb h
)
ÁÁh i
;
ÁÁi j
_logger
ËË 
.
ËË 
Information
ËË '
(
ËË' (3
%FriendRequestSentSuccessfullyTemplate
ËË( M
,
ËËM N
senderUserId
ËËO [
,
ËË[ \

targetUser
ËË] g
.
ËËg h
IdUser
ËËh n
)
ËËn o
;
ËËo p%
friendshipActionOutcome
ÈÈ +
=
ÈÈ, -+
CreateFriendshipActionOutcome
ÈÈ. K
(
ÈÈK L
true
ÈÈL P
,
ÈÈP Q
ErrorCodeSuccess
ÈÈR b
,
ÈÈb c&
MessageFriendRequestSent
ÍÍ 0
)
ÍÍ0 1
;
ÍÍ1 2
}
ÎÎ 
}
ÏÏ 
return
ÓÓ %
friendshipActionOutcome
ÓÓ *
;
ÓÓ* +
}
ÔÔ 	
private
ÒÒ 
static
ÒÒ 
bool
ÒÒ 
IsValidUserId
ÒÒ )
(
ÒÒ) *
int
ÒÒ* -
userId
ÒÒ. 4
)
ÒÒ4 5
{
ÚÚ 	
return
ÛÛ 
userId
ÛÛ 
>
ÛÛ 
$num
ÛÛ 
;
ÛÛ 
}
ÙÙ 	
private
ˆˆ 
static
ˆˆ 
bool
ˆˆ  
AreDistinctUserIds
ˆˆ .
(
ˆˆ. /
int
ˆˆ/ 2
userId1
ˆˆ3 :
,
ˆˆ: ;
int
ˆˆ< ?
userId2
ˆˆ@ G
)
ˆˆG H
{
˜˜ 	
return
¯¯ 
userId1
¯¯ 
!=
¯¯ 
userId2
¯¯ %
;
¯¯% &
}
˘˘ 	
private
˚˚ 
static
˚˚ %
FriendshipActionOutcome
˚˚ .+
CreateFriendshipActionOutcome
˚˚/ L
(
˚˚L M
bool
˚˚M Q
	isSuccess
˚˚R [
,
˚˚[ \
int
¸¸ 
	errorCode
¸¸ 
,
¸¸ 
string
¸¸ !
message
¸¸" )
)
¸¸) *
{
˝˝ 	
return
˛˛ 
new
˛˛ %
FriendshipActionOutcome
˛˛ .
{
ˇˇ 
	IsSuccess
ÄÄ 
=
ÄÄ 
	isSuccess
ÄÄ %
,
ÄÄ% &
	ErrorCode
ÅÅ 
=
ÅÅ 
	errorCode
ÅÅ %
,
ÅÅ% &
Message
ÇÇ 
=
ÇÇ 
message
ÇÇ !
}
ÉÉ 
;
ÉÉ 
}
ÑÑ 	
}
ÖÖ 
}ÜÜ è
cC:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\Ports\Account\IUserRepository.cs
	namespace 	
Application
 
. 
Ports 
{ 
public		 

	interface		 
IUserRepository		 $
{

 
UserAccount 
GetUserByEmail "
(" #
string# )
email* /
)/ 0
;0 1
UserAccount 
GetUserById 
(  
int  #
userId$ *
)* +
;+ ,
UserAccount!! 
GetUserByUsername!! %
(!!% &
string!!& ,
username!!- 5
)!!5 6
;!!6 7
void(( 
UpdateLastLogin(( 
((( 
int((  
userId((! '
)((' (
;((( )
int11 

CreateUser11 
(11 
UserAccount11 "
user11# '
,11' (
string11) /
displayName110 ;
)11; <
;11< =
}22 
}33 “
mC:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\Ports\Account\IAccountManagementUseCase.cs
	namespace 	
Application
 
. 
Ports 
{ 
public 

	interface %
IAccountManagementUseCase .
{		 #
UserRegistrationOutcome 
RegisterUser  ,
(, -
string- 3
username4 <
,< =
string> D
emailE J
,J K
stringL R
passwordHashS _
)_ `
;` a
} 
} Õ
eC:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\Ports\Account\IUserLoginUseCase.cs
	namespace 	
Application
 
. 
Ports 
{ 
public 

	interface 
IUserLoginUseCase &
{		 !
AuthenticatedUserData 
AuthenticateUser .
(. /
string/ 5
email6 ;
,; <
string= C
passwordHashD P
)P Q
;Q R
bool 
IsLoginSuccessful 
( 
string %
email& +
,+ ,
string- 3
passwordHash4 @
)@ A
;A B
} 
} ´
_C:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\Ports\Lobby\ILobbyUseCase.cs
	namespace 	
Application
 
. 
Ports 
{ 
public 

	interface 
ILobbyUseCase "
{		 
IMatchUseCase 
Match 
{ 
get !
;! "
}# $
LobbyActionOutcome 
CreateLobby &
(& '
int' *

hostUserId+ 5
,5 6
LobbyConfiguration7 I
lobbyConfigurationJ \
)\ ]
;] ^
LobbyActionOutcome 
UpdateLobbySettings .
(. /
string/ 5
	lobbyCode6 ?
,? @
intA D
requesterUserIdE T
,T U
LobbyConfiguration 
lobbyConfiguration 1
)1 2
;2 3
LobbyActionOutcome!! &
DisconnectLobbyParticipant!! 5
(!!5 6
string!!6 <
	lobbyCode!!= F
,!!F G
int!!H K
participantUserId!!L ]
)!!] ^
;!!^ _
LobbyActionOutcome)) 
	JoinLobby)) $
())$ %
string))% +
	lobbyCode)), 5
,))5 6
int))7 :
userId)); A
)))A B
;))B C
LobbyActionOutcome11 

LeaveLobby11 %
(11% &
string11& ,
	lobbyCode11- 6
,116 7
int118 ;
userId11< B
)11B C
;11C D
LobbyActionOutcome:: 

KickPlayer:: %
(::% &
string::& ,
	lobbyCode::- 6
,::6 7
int::8 ;

hostUserId::< F
,::F G
int::H K
targetUserId::L X
)::X Y
;::Y Z
LobbyActionOutcomeAA (
AuthorizeKickedPlayerReentryAA 7
(AA7 8
stringAA8 >
	lobbyCodeAA? H
,AAH I
intAAJ M

hostUserIdAAN X
,AAX Y
intAAZ ]
targetUserIdAA^ j
)AAj k
;AAk l
LobbyActionOutcomeJJ !
UpdatePlayerReadinessJJ 0
(JJ0 1
stringJJ1 7
	lobbyCodeJJ8 A
,JJA B
intJJC F
userIdJJG M
,JJM N
boolJJO S
isReadyJJT [
)JJ[ \
;JJ\ ]
stringRR "
GetParticipantUsernameRR %
(RR% &
stringRR& ,
	lobbyCodeRR- 6
,RR6 7
intRR8 ;
userIdRR< B
)RRB C
;RRC D
boolZZ $
CanTransitionLobbyToGameZZ %
(ZZ% &
stringZZ& ,
	lobbyCodeZZ- 6
,ZZ6 7
intZZ8 ;

hostUserIdZZ< F
)ZZF G
;ZZG H
}[[ 
}\\ ±
fC:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\Ports\Friends\IFriendshipUseCase.cs
	namespace 	
Application
 
. 
Ports 
{		 
public

 

	interface

 
IFriendshipUseCase

 '
{ 
List 
< 
FriendSummaryData 
> "
GetFriendsListByUserId  6
(6 7
int7 :
userId; A
)A B
;B C#
FriendshipActionOutcome 
BlockPlayer  +
(+ ,
int, /
blockerUserId0 =
,= >
int? B
targetUserIdC O
)O P
;P Q#
FriendshipActionOutcome 
UnblockPlayer  -
(- .
int. 1
blockerUserId2 ?
,? @
intA D
targetUserIdE Q
)Q R
;R S#
FriendshipActionOutcome 
RemoveFriend  ,
(, -
int- 0
userId1 7
,7 8
int9 <
friendUserId= I
)I J
;J K
Task 
< #
FriendshipActionOutcome $
>$ %"
SendFriendRequestAsync& <
(< =
int= @
senderUserIdA M
,M N
stringO U
targetUsernameV d
)d e
;e f
Task 
< #
FriendshipActionOutcome $
>$ %$
AcceptFriendRequestAsync& >
(> ?
int? B
receiverUserIdC Q
,Q R
intS V
senderUserIdW c
)c d
;d e
Task 
< #
FriendshipActionOutcome $
>$ %$
RejectFriendRequestAsync& >
(> ?
int? B
receiverUserIdC Q
,Q R
intS V
senderUserIdW c
)c d
;d e
Task 
< #
FriendshipActionOutcome $
>$ %$
CancelFriendRequestAsync& >
(> ?
int? B
senderUserIdC O
,O P
intQ T
receiverUserIdU c
)c d
;d e
Task 
< 
List 
< 
FriendRequestData #
># $
>$ %1
%GetPendingFriendRequestsByUserIdAsync& K
(K L
intL O
userIdP V
)V W
;W X
Task 
< 
List 
< 
FriendRequestData #
># $
>$ %.
"GetSentFriendRequestsByUserIdAsync& H
(H I
intI L
userIdM S
)S T
;T U
} 
}   ñ
iC:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\Ports\Friends\IFriendshipRepository.cs
	namespace 	
Application
 
. 
Ports 
{ 
public 

	interface !
IFriendshipRepository *
{ 
List		 
<		 
FriendSummaryData		 
>		 "
GetFriendsListByUserId		  6
(		6 7
int		7 :
userId		; A
)		A B
;		B C
bool $
IsPlayerBlockedByPlayerA %
(% &
int& )
	playerAId* 3
,3 4
int5 8
	playerBId9 B
)B C
;C D
void 
BlockPlayer 
( 
int 
	blockerId &
,& '
int( +
	blockedId, 5
)5 6
;6 7
void 
UnblockPlayer 
( 
int 
	blockerId (
,( )
int* -
	blockedId. 7
)7 8
;8 9
void 
RemoveFriendship 
( 
int !
firstUserId" -
,- .
int/ 2
secondUserId3 ?
)? @
;@ A
Task 
<  
FriendshipRecordData !
>! "
GetFriendshipAsync# 5
(5 6
int6 9
firstUserId: E
,E F
intG J
secondUserIdK W
)W X
;X Y
Task $
CreateFriendRequestAsync %
(% &
int& )
senderUserId* 6
,6 7
int8 ;
receiverUserId< J
)J K
;K L
Task '
UpdateFriendshipStatusAsync (
(( )
int) ,
firstUserId- 8
,8 9
int: =
secondUserId> J
,J K
byteL P
statusQ W
)W X
;X Y
Task !
DeleteFriendshipAsync "
(" #
int# &
firstUserId' 2
,2 3
int4 7
secondUserId8 D
)D E
;E F
Task 
< 
List 
< 
FriendRequestData #
># $
>$ %1
%GetPendingFriendRequestsByUserIdAsync& K
(K L
intL O
userIdP V
)V W
;W X
Task 
< 
List 
< 
FriendRequestData #
># $
>$ %.
"GetSentFriendRequestsByUserIdAsync& H
(H I
intI L
userIdM S
)S T
;T U
} 
} ∏

iC:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\Models\Friends\FriendshipRecordData.cs
	namespace 	
Application
 
. 
Models 
. 

Friendship '
{ 
public 

sealed 
class  
FriendshipRecordData ,
{ 
public 
int 
	IdUserLow 
{ 
get "
;" #
set$ '
;' (
}) *
public		 
int		 

IdUserHigh		 
{		 
get		  #
;		# $
set		% (
;		( )
}		* +
public 
bool 
IsRequestedByLow $
{% &
get' *
;* +
set, /
;/ 0
}1 2
public 
byte 
Status 
{ 
get  
;  !
set" %
;% &
}' (
public 
DateTime 
RequestedAt #
{$ %
get& )
;) *
set+ .
;. /
}0 1
public 
DateTime 
? 
RespondedAt $
{% &
get' *
;* +
set, /
;/ 0
}1 2
} 
} Œ
lC:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\Models\Friends\FriendshipActionOutcome.cs
	namespace 	
Application
 
. 
Models 
. 

Friendship '
{ 
public 

sealed 
class #
FriendshipActionOutcome /
{ 
public 
bool 
	IsSuccess 
{ 
get  #
;# $
set% (
;( )
}* +
public 
string 
Message 
{ 
get  #
;# $
set% (
;( )
}* +
public		 
int		 
	ErrorCode		 
{		 
get		 "
;		" #
set		$ '
;		' (
}		) *
}

 
} ø
fC:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\Models\Friends\FriendSummaryData.cs
	namespace 	
Application
 
. 
Models 
. 

Friendship '
{ 
public 

sealed 
class 
FriendSummaryData )
{ 
public 
int 
IdUser 
{ 
get 
;  
set! $
;$ %
}& '
public 
string 
Username 
{  
get! $
;$ %
set& )
;) *
}+ ,
public		 
bool		 
IsOnline		 
{		 
get		 "
;		" #
set		$ '
;		' (
}		) *
}

 
} ≠

fC:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\Models\Friends\FriendRequestData.cs
	namespace 	
Application
 
. 
Models 
. 

Friendship '
{ 
public 

sealed 
class 
FriendRequestData )
{ 
public 
int 
SenderIdUser 
{  !
get" %
;% &
set' *
;* +
}, -
public		 
string		 
SenderUsername		 $
{		% &
get		' *
;		* +
set		, /
;		/ 0
}		1 2
public 
int 
ReceiverIdUser !
{" #
get$ '
;' (
set) ,
;, -
}. /
public 
string 
ReceiverUsername &
{' (
get) ,
;, -
set. 1
;1 2
}3 4
public 
byte 
Status 
{ 
get  
;  !
set" %
;% &
}' (
public 
DateTime 
RequestDate #
{$ %
get& )
;) *
set+ .
;. /
}0 1
} 
} Ø
_C:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\Ports\Email\IEmailService.cs
	namespace 	
Application
 
. 
Ports 
{ 
public 

	interface 
IEmailService "
{ 
} 
}		 ‘
lC:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\Models\Account\UserRegistrationOutcome.cs
	namespace 	
Application
 
. 
Models 
{ 
public 

sealed 
class #
UserRegistrationOutcome /
{ 
public 
bool 
	IsSuccess 
{ 
get  #
;# $
set% (
;( )
}* +
public

 
string

 
Message

 
{

 
get

  #
;

# $
set

% (
;

( )
}

* +
public 
int 
	ErrorCode 
{ 
get "
;" #
set$ '
;' (
}) *
public 
int 
? 
CreatedUserId !
{" #
get$ '
;' (
set) ,
;, -
}. /
} 
} í
`C:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\Models\Account\UserAccount.cs
	namespace 	
Application
 
. 
Models 
{ 
public 

sealed 
class 
UserAccount #
{		 
public

 
int

 
IdUser

 
{

 
get

 
;

  
set

! $
;

$ %
}

& '
public 
string 
Username 
{  
get! $
;$ %
set& )
;) *
}+ ,
public 
string 
Email 
{ 
get !
;! "
set# &
;& '
}( )
public 
string 
PasswordHash "
{# $
get% (
;( )
set* -
;- .
}/ 0
public 
byte 
Status 
{ 
get  
;  !
set" %
;% &
}' (
public 
DateTime 
	CreatedAt !
{" #
get$ '
;' (
set) ,
;, -
}. /
public 
DateTime 
? 
LastLoginAt $
{% &
get' *
;* +
set, /
;/ 0
}1 2
} 
} Û
`C:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\Models\Lobby\LobbyRoomData.cs
	namespace 	
Application
 
. 
Models 
{ 
public		 

sealed		 
class		 
LobbyRoomData		 %
{

 
public 
Guid 
LobbyInstanceId #
{$ %
get& )
;) *
}+ ,
=- .
Guid/ 3
.3 4
NewGuid4 ;
(; <
)< =
;= >
public 
string 
	LobbyCode 
{  !
get" %
;% &
set' *
;* +
}, -
public 
int 

HostUserId 
{ 
get  #
;# $
set% (
;( )
}* +
public 
byte 
TargetMissionCount &
{' (
get) ,
;, -
set. 1
;1 2
}3 4
public 
byte 
PlayerLimit 
{  !
get" %
;% &
set' *
;* +
}, -
public 
byte 
Status 
{ 
get  
;  !
set" %
;% &
}' (
public 
bool 
	IsPrivate 
{ 
get  #
;# $
set% (
;( )
}* +
=, -
true. 2
;2 3
public 
long 
StateVersion  
{! "
get# &
;& '
set( +
;+ ,
}- .
public 
HashSet 
< 
int 
> $
KickedParticipantUserIds 4
{5 6
get7 :
;: ;
}< =
=> ?
new@ C
HashSetD K
<K L
intL O
>O P
(P Q
)Q R
;R S
public 
List 
<  
LobbyParticipantData (
>( )
Players* 1
{2 3
get4 7
;7 8
set9 <
;< =
}> ?
=@ A
newB E
ListF J
<J K 
LobbyParticipantDataK _
>_ `
(` a
)a b
;b c
} 
}   ≥
gC:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\Models\Lobby\LobbyParticipantData.cs
	namespace 	
Application
 
. 
Models 
{ 
public 

sealed 
class  
LobbyParticipantData ,
{ 
public 
int 
IdUser 
{ 
get 
;  
set! $
;$ %
}& '
public

 
string

 
Username

 
{

  
get

! $
;

$ %
set

& )
;

) *
}

+ ,
public 
bool 
IsHost 
{ 
get  
;  !
set" %
;% &
}' (
public 
bool 
IsReady 
{ 
get !
;! "
set# &
;& '
}( )
} 
} å

eC:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\Models\Lobby\LobbyActionOutcome.cs
	namespace 	
Application
 
. 
Models 
{ 
public 

sealed 
class 
LobbyActionOutcome *
{ 
public 
bool 
	IsSuccess 
{ 
get  #
;# $
set% (
;( )
}* +
public

 
string

 
Message

 
{

 
get

  #
;

# $
set

% (
;

( )
}

* +
public 
int 
	ErrorCode 
{ 
get "
;" #
set$ '
;' (
}) *
public 
bool 
IsRoomDisbanded #
{$ %
get& )
;) *
set+ .
;. /
}0 1
public 
LobbyRoomData 
Lobby "
{# $
get% (
;( )
set* -
;- .
}/ 0
public  
LobbyParticipantData #
AffectedPlayer$ 2
{3 4
get5 8
;8 9
set: =
;= >
}? @
} 
} ü
jC:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\Models\Account\AuthenticatedUserData.cs
	namespace 	
Application
 
. 
Models 
{ 
public 

sealed 
class !
AuthenticatedUserData -
{ 
public 
int 
IdUser 
{ 
get 
;  
set! $
;$ %
}& '
public

 
string

 
Username

 
{

  
get

! $
;

$ %
set

& )
;

) *
}

+ ,
public 
string 
Email 
{ 
get !
;! "
set# &
;& '
}( )
} 
} É
~C:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\Models\ChatModeration\AuthenticatedChatMessageSubmission.cs
	namespace 	
Application
 
. 
Models 
{ 
public 

sealed 
class .
"AuthenticatedChatMessageSubmission :
{ 
public		 
int		 
AccountUserId		  
{		! "
get		# &
;		& '
set		( +
;		+ ,
}		- .
public 
Guid #
ChatMessageSubmissionId +
{, -
get. 1
;1 2
set3 6
;6 7
}8 9
public 
string 
	LobbyCode 
{  !
get" %
;% &
set' *
;* +
}, -
public 
string #
OriginalChatMessageText -
{. /
get0 3
;3 4
set5 8
;8 9
}: ;
} 
} Ã	
pC:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\Models\ChatModeration\ChatInfractionRecord.cs
	namespace 	
Application
 
. 
Models 
{ 
public 

sealed 
class  
ChatInfractionRecord ,
{ 
public		 &
ChatAccountInfractionState		 )"
AccountInfractionState		* @
{		A B
get		C F
;		F G
set		H K
;		K L
}		M N
public 
int *
CurrentMessageInfractionPoints 1
{2 3
get4 7
;7 8
set9 <
;< =
}> ?
public 
bool +
IsRepeatedChatMessageSubmission 3
{4 5
get6 9
;9 :
set; >
;> ?
}@ A
public 
bool /
#HasConflictingChatMessageIdentifier 7
{8 9
get: =
;= >
set? B
;B C
}D E
public 
bool 
IsAccountBanned #
{$ %
get& )
;) *
set+ .
;. /
}0 1
} 
} ë
tC:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\Models\ChatModeration\ChatInfractionSubmission.cs
	namespace 	
Application
 
. 
Models 
{ 
public 

sealed 
class $
ChatInfractionSubmission 0
{		 
public

 
int

 
AccountUserId

  
{

! "
get

# &
;

& '
set

( +
;

+ ,
}

- .
public 
Guid #
ChatMessageSubmissionId +
{, -
get. 1
;1 2
set3 6
;6 7
}8 9
public 
string $
ChatMessageContentDigest .
{/ 0
get1 4
;4 5
set6 9
;9 :
}; <
public "
ChatInfractionCategory %&
DetectedInfractionCategory& @
{A B
getC F
;F G
setH K
;K L
}M N
} 
} ∞
vC:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\Models\ChatModeration\LobbyChatMessageProcessing.cs
	namespace 	
Application
 
. 
Models 
{ 
public 

sealed 
class &
LobbyChatMessageProcessing 2
{ 
public 
bool !
CanPublishChatMessage )
{* +
get, /
;/ 0
set1 4
;4 5
}6 7
public &
ChatMessageRejectionReason )&
ChatMessageRejectionReason* D
{E F
getG J
;J K
setL O
;O P
}Q R
public

 
string

 #
CensoredChatMessageText

 -
{

. /
get

0 3
;

3 4
set

5 8
;

8 9
}

: ;
public  
ChatInfractionRecord #"
RecordedChatInfraction$ :
{; <
get= @
;@ A
setB E
;E F
}G H
} 
} ó
sC:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\Ports\ChatModeration\ILobbyChatMessageUseCase.cs
	namespace 	
Application
 
. 
Ports 
{ 
public 

	interface $
ILobbyChatMessageUseCase -
{		 
bool

 "
IsChatSendingAvailable

 #
{

$ %
get

& )
;

) *
}

+ ,&
LobbyChatMessageProcessing "
ProcessChatMessage# 5
(5 6.
"AuthenticatedChatMessageSubmission ..
"authenticatedChatMessageSubmission/ Q
)Q R
;R S
} 
} ë
xC:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\Ports\Account\IAuthenticatedAccountSessionRegistry.cs
	namespace 	
Application
 
. 
Ports 
{ 
public 

	interface 0
$IAuthenticatedAccountSessionRegistry 9
{ 
string  
CreateAccountSession #
(# $
int$ '
accountUserId( 5
)5 6
;6 7
int

  
ResolveAccountUserId

  
(

  !
string

! '
accountSessionToken

( ;
)

; <
;

< =
void !
RevokeAccountSessions "
(" #
int# &
accountUserId' 4
)4 5
;5 6
} 
} †
{C:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\Ports\ChatModeration\IProhibitedChatExpressionCatalog.cs
	namespace 	
Application
 
. 
Ports 
{ 
public 

	interface ,
 IProhibitedChatExpressionCatalog 5
{		 
IReadOnlyCollection

 
<

 $
ProhibitedChatExpression

 4
>

4 5.
"GetAllSupportedLanguageExpressions

6 X
(

X Y
)

Y Z
;

Z [
} 
} º
tC:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\Ports\ChatModeration\IChatInfractionRepository.cs
	namespace 	
Application
 
. 
Ports 
{ 
public

 

	interface

 %
IChatInfractionRepository

 .
{  
ChatInfractionRecord '
RecordChatMessageInfraction 8
(8 9$
ChatInfractionSubmission9 Q$
chatInfractionSubmissionR j
)j k
;k l&
ChatAccountInfractionState "%
GetAccountInfractionState# <
(< =
int= @
accountUserIdA N
)N O
;O P
} 
} Ël
uC:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\UseCases\ChatModeration\LobbyChatMessageUseCase.cs
	namespace 	
Application
 
{ 
public 

sealed 
class #
LobbyChatMessageUseCase /
:0 1$
ILobbyChatMessageUseCase2 J
{ 
private 
const 
string 1
%ChatModerationMatchingTimeoutTemplate B
=C D
$str m
+n o
$str !
;! "
private 
const 
string 0
$ChatModerationMessageTimeoutTemplate A
=B C
$str f
+g h
$str !
;! "
private 
const 
string *
ChatInfractionDetectedTemplate ;
=< =
$str o
;o p
private 
const 
string 4
(ChatMessageRejectedBannedAccountTemplate E
=F G
$str _
;_ `
private 
const 
string 4
(ChatInfractionPersistenceFailureTemplate E
=F G
$str o
;o p
private 
readonly  
ChatMessageModerator -!
_chatMessageModerator. C
;C D
private 
readonly %
IChatInfractionRepository 2%
_chatInfractionRepository3 L
;L M
private 
readonly 
ILoggerService '
_moderationLogger( 9
;9 :
public!! #
LobbyChatMessageUseCase!! &
(!!& '%
ChatModerationPreparation!!' @!
moderationPreparation!!A V
,!!V W%
IChatInfractionRepository"" %$
chatInfractionRepository""& >
,""> ?
ILoggerService""@ N
moderationLogger""O _
)""_ `
{## 	
if$$ 
($$ !
moderationPreparation$$ %
==$$& (
null$$) -
)$$- .
{%% 
throw&& 
new&& !
ArgumentNullException&& /
(&&/ 0
nameof&&0 6
(&&6 7!
moderationPreparation&&7 L
)&&L M
)&&M N
;&&N O
}'' !
_chatMessageModerator)) !
=))" #!
moderationPreparation))$ 9
.))9 :
MessageModerator)): J
;))J K%
_chatInfractionRepository** %
=**& '$
chatInfractionRepository**( @
??**A C
throw++ 
new++ !
ArgumentNullException++ /
(++/ 0
nameof++0 6
(++6 7$
chatInfractionRepository++7 O
)++O P
)++P Q
;++Q R
_moderationLogger,, 
=,, 
moderationLogger,,  0
??,,1 3
throw,,4 9
new,,: =!
ArgumentNullException,,> S
(,,S T
nameof,,T Z
(,,Z [
moderationLogger,,[ k
),,k l
),,l m
;,,m n
}-- 	
public// 
bool// "
IsChatSendingAvailable// *
=>//+ -!
_chatMessageModerator//. C
!=//D F
null//G K
;//K L
public11 &
LobbyChatMessageProcessing11 )
ProcessChatMessage11* <
(11< =.
"AuthenticatedChatMessageSubmission11= _!
chatMessageSubmission11` u
)11u v
{22 	&
LobbyChatMessageProcessing33 &!
chatMessageProcessing33' <
=33= >
new33? B&
LobbyChatMessageProcessing33C ]
{44 &
ChatMessageRejectionReason55 *
=55+ ,&
ChatMessageRejectionReason55- G
.55G H
InvalidChatMessage55H Z
}66 
;66 
if77 
(77 
!77 "
IsChatSendingAvailable77 '
)77' (
{88 !
chatMessageProcessing99 %
.99% &&
ChatMessageRejectionReason99& @
=99A B&
ChatMessageRejectionReason99C ]
.99] ^%
ChatModerationUnavailable99^ w
;99w x
}:: 
else;; 
if;; 
(;; (
IsValidChatMessageSubmission;; 1
(;;1 2!
chatMessageSubmission;;2 G
);;G H
);;H I
{<< 
try== 
{>> !
chatMessageProcessing?? )
=??* +(
ModerateAndRecordChatMessage??, H
(??H I!
chatMessageSubmission??I ^
)??^ _
;??_ `
}@@ 
catchAA 
(AA &
RegexMatchTimeoutExceptionAA 1
exAA2 4
)AA4 5
{BB 
_moderationLoggerCC %
.CC% &
WarningCC& -
(CC- .1
%ChatModerationMatchingTimeoutTemplateCC. S
,CCS T!
chatMessageSubmissionDD -
.DD- .
AccountUserIdDD. ;
,DD; <!
chatMessageSubmissionDD= R
.DDR S
	LobbyCodeDDS \
,DD\ ]
exDD^ `
.DD` a
GetTypeDDa h
(DDh i
)DDi j
.DDj k
NameDDk o
)DDo p
;DDp q!
chatMessageProcessingEE )
.EE) *&
ChatMessageRejectionReasonEE* D
=EEE F&
ChatMessageRejectionReasonFF 2
.FF2 3%
ChatModerationUnavailableFF3 L
;FFL M
}GG 
catchHH 
(HH 
TimeoutExceptionHH '
exHH( *
)HH* +
{II 
_moderationLoggerJJ %
.JJ% &
WarningJJ& -
(JJ- .0
$ChatModerationMessageTimeoutTemplateJJ. R
,JJR S!
chatMessageSubmissionKK -
.KK- .
AccountUserIdKK. ;
,KK; <!
chatMessageSubmissionKK= R
.KKR S
	LobbyCodeKKS \
,KK\ ]
exKK^ `
.KK` a
GetTypeKKa h
(KKh i
)KKi j
.KKj k
NameKKk o
)KKo p
;KKp q!
chatMessageProcessingLL )
.LL) *&
ChatMessageRejectionReasonLL* D
=LLE F&
ChatMessageRejectionReasonMM 2
.MM2 3%
ChatModerationUnavailableMM3 L
;MML M
}NN 
catchOO 
(OO %
InvalidOperationExceptionOO 0
)OO0 1
{PP 
_moderationLoggerQQ %
.QQ% &
WarningQQ& -
(QQ- .4
(ChatInfractionPersistenceFailureTemplateQQ. V
,QQV W!
chatMessageSubmissionRR -
.RR- .
AccountUserIdRR. ;
,RR; <!
chatMessageSubmissionRR= R
.RRR S
	LobbyCodeRRS \
)RR\ ]
;RR] ^!
chatMessageProcessingSS )
.SS) *&
ChatMessageRejectionReasonSS* D
=SSE F&
ChatMessageRejectionReasonTT 2
.TT2 3%
ChatModerationUnavailableTT3 L
;TTL M
}UU 
}VV 
returnXX !
chatMessageProcessingXX (
;XX( )
}YY 	
private[[ 
static[[ 
bool[[ (
IsValidChatMessageSubmission[[ 8
([[8 9.
"AuthenticatedChatMessageSubmission[[9 [!
chatMessageSubmission[[\ q
)[[q r
{\\ 	
return]] !
chatMessageSubmission]] (
!=]]) +
null]], 0
&&]]1 3!
chatMessageSubmission]]4 I
.]]I J
AccountUserId]]J W
>]]X Y
$num]]Z [
&&]]\ ^!
chatMessageSubmission^^ %
.^^% &#
ChatMessageSubmissionId^^& =
!=^^> @
Guid^^A E
.^^E F
Empty^^F K
&&^^L N
!__ 
string__ 
.__ 
IsNullOrWhiteSpace__ *
(__* +!
chatMessageSubmission__+ @
.__@ A#
OriginalChatMessageText__A X
)__X Y
&&__Z \!
chatMessageSubmission`` %
.``% &#
OriginalChatMessageText``& =
.``= >
Length``> D
<=``E G
ChatInfractionRules``H [
.``[ \$
MaximumChatMessageLength``\ t
;``t u
}aa 	
privatecc &
LobbyChatMessageProcessingcc *(
ModerateAndRecordChatMessagecc+ G
(ccG H.
"AuthenticatedChatMessageSubmissiondd .!
chatMessageSubmissiondd/ D
)ddD E
{ee 	)
ChatMessageModerationDecisionff )
moderationDecisionff* <
=ff= >!
_chatMessageModeratorff? T
.ffT U
EvaluateChatMessageffU h
(ffh i!
chatMessageSubmissiongg %
.gg% &#
OriginalChatMessageTextgg& =
)gg= >
;gg> ? 
ChatInfractionRecordhh  "
recordedChatInfractionhh! 7
=hh8 9%
_chatInfractionRepositoryhh: S
.hhS T'
RecordChatMessageInfractionhhT o
(hho p
newii $
ChatInfractionSubmissionii ,
{jj 
AccountUserIdkk !
=kk" #!
chatMessageSubmissionkk$ 9
.kk9 :
AccountUserIdkk: G
,kkG H#
ChatMessageSubmissionIdll +
=ll, -!
chatMessageSubmissionll. C
.llC D#
ChatMessageSubmissionIdllD [
,ll[ \$
ChatMessageContentDigestmm ,
=mm- .+
ComputeChatMessageContentDigestmm/ N
(mmN O!
chatMessageSubmissionmmO d
)mmd e
,mme f&
DetectedInfractionCategorynn .
=nn/ 0
moderationDecisionnn1 C
.nnC D&
DetectedInfractionCategorynnD ^
}oo 
)oo 
;oo 
ifpp 
(pp 
moderationDecisionpp "
.pp" #&
DetectedInfractionCategorypp# =
!=pp> @"
ChatInfractionCategoryppA W
.ppW X
NoneppX \
)pp\ ]
{qq 
_moderationLoggerrr !
.rr! "
Warningrr" )
(rr) **
ChatInfractionDetectedTemplaterr* H
,rrH I
moderationDecisionss &
.ss& '&
DetectedInfractionCategoryss' A
,ssA B!
chatMessageSubmissiontt )
.tt) *
AccountUserIdtt* 7
,tt7 8!
chatMessageSubmissionuu )
.uu) *
	LobbyCodeuu* 3
)uu3 4
;uu4 5
}vv &
ChatMessageRejectionReasonxx &&
chatMessageRejectionReasonxx' A
=xxB C&
ChatMessageRejectionReasonxxD ^
.xx^ _
Nonexx_ c
;xxc d
ifyy 
(yy "
recordedChatInfractionyy &
.yy& '/
#HasConflictingChatMessageIdentifieryy' J
)yyJ K
{zz &
chatMessageRejectionReason{{ *
={{+ ,&
ChatMessageRejectionReason{{- G
.{{G H,
 ConflictingChatMessageIdentifier{{H h
;{{h i
}|| 
else}} 
if}} 
(}} "
recordedChatInfraction}} +
.}}+ ,
IsAccountBanned}}, ;
)}}; <
{~~ 
_moderationLogger !
.! "
Warning" )
() *4
(ChatMessageRejectedBannedAccountTemplate* R
,R S#
chatMessageSubmission
ÄÄ )
.
ÄÄ) *
AccountUserId
ÄÄ* 7
,
ÄÄ7 8#
chatMessageSubmission
ÅÅ )
.
ÅÅ) *
	LobbyCode
ÅÅ* 3
)
ÅÅ3 4
;
ÅÅ4 5(
chatMessageRejectionReason
ÇÇ *
=
ÇÇ+ ,(
ChatMessageRejectionReason
ÇÇ- G
.
ÇÇG H
ChatAccountBanned
ÇÇH Y
;
ÇÇY Z
}
ÉÉ 
return
ÖÖ 
new
ÖÖ (
LobbyChatMessageProcessing
ÖÖ 1
{
ÜÜ #
CanPublishChatMessage
áá %
=
áá& '(
chatMessageRejectionReason
áá( B
==
ááC E(
ChatMessageRejectionReason
ááF `
.
áá` a
None
ááa e
&&
ááf h
!
àà $
recordedChatInfraction
àà +
.
àà+ ,-
IsRepeatedChatMessageSubmission
àà, K
,
ààK L(
ChatMessageRejectionReason
ââ *
=
ââ+ ,(
chatMessageRejectionReason
ââ- G
,
ââG H%
CensoredChatMessageText
ää '
=
ää( ) 
moderationDecision
ää* <
.
ää< =%
CensoredChatMessageText
ää= T
,
ääT U$
RecordedChatInfraction
ãã &
=
ãã' ($
recordedChatInfraction
ãã) ?
}
åå 
;
åå 
}
çç 	
private
èè 
static
èè 
string
èè -
ComputeChatMessageContentDigest
èè =
(
èè= >0
"AuthenticatedChatMessageSubmission
èè> `#
chatMessageSubmission
èèa v
)
èèv w
{
êê 	
byte
ëë 
[
ëë 
]
ëë 
chatMessageDigest
ëë $
;
ëë$ %
using
íí 
(
íí 
SHA256
íí 
chatMessageHasher
íí +
=
íí, -
SHA256
íí. 4
.
íí4 5
Create
íí5 ;
(
íí; <
)
íí< =
)
íí= >
{
ìì 
string
îî %
chatMessageIdentityText
îî .
=
îî/ 0#
chatMessageSubmission
îî1 F
.
îîF G
	LobbyCode
îîG P
.
îîP Q
Trim
îîQ U
(
îîU V
)
îîV W
.
îîW X
ToUpperInvariant
îîX h
(
îîh i
)
îîi j
+
îîk l
$str
îîm q
+
îîr s#
chatMessageSubmission
ïï )
.
ïï) *%
OriginalChatMessageText
ïï* A
;
ïïA B
chatMessageDigest
ññ !
=
ññ" #
chatMessageHasher
ññ$ 5
.
ññ5 6
ComputeHash
ññ6 A
(
ññA B
Encoding
ññB J
.
ññJ K
UTF8
ññK O
.
ññO P
GetBytes
ññP X
(
ññX Y%
chatMessageIdentityText
ññY p
)
ññp q
)
ññq r
;
ññr s
}
óó 
return
ôô 
Convert
ôô 
.
ôô 
ToBase64String
ôô )
(
ôô) *
chatMessageDigest
ôô* ;
)
ôô; <
;
ôô< =
}
öö 	
}
õõ 
}úú ˆ
hC:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\Ports\Account\IAccountAccessPolicy.cs
	namespace 	
Application
 
. 
Ports 
{ 
public 

	interface  
IAccountAccessPolicy )
{		 &
ChatAccountInfractionState "
GetAccountBanState# 5
(5 6
int6 9
accountUserId: G
)G H
;H I
string '
CreateAllowedAccountSession *
(* +
int+ .
accountUserId/ <
)< =
;= >
bool %
IsAccountOperationAllowed &
(& '
int' *
accountUserId+ 8
,8 9
string: @
accountSessionTokenA T
)T U
;U V
int '
ResolveAllowedAccountUserId '
(' (
string( .
accountSessionToken/ B
)B C
;C D
void !
RevokeAccountSessions "
(" #
int# &
accountUserId' 4
)4 5
;5 6
} 
} ”0
jC:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\UseCases\Account\AccountAccessPolicy.cs
	namespace 	
Application
 
{ 
public 

sealed 
class 
AccountAccessPolicy +
:, - 
IAccountAccessPolicy. B
{ 
private 
const 
string "
SessionCreatedTemplate 3
=4 5
$str E
;E F
private 
const 
string 8
,SessionCreationRejectedBannedAccountTemplate I
=J K
$str X
;X Y
private 
const 
string 2
&OperationRejectedBannedAccountTemplate C
=D E
$str Q
;Q R
private 
const 
string #
SessionsRevokedTemplate 4
=5 6
$str 9
;9 :
private 
readonly 0
$IAuthenticatedAccountSessionRegistry =#
_accountSessionRegistry> U
;U V
private 
readonly %
IChatInfractionRepository 2%
_chatInfractionRepository3 L
;L M
private 
readonly 
ILoggerService '
_logger( /
;/ 0
public 
AccountAccessPolicy "
(" #0
$IAuthenticatedAccountSessionRegistry# G"
accountSessionRegistryH ^
,^ _%
IChatInfractionRepository %$
chatInfractionRepository& >
,> ?
ILoggerService@ N
loggerO U
)U V
{ 	#
_accountSessionRegistry #
=$ %"
accountSessionRegistry& <
;< =%
_chatInfractionRepository %
=& '$
chatInfractionRepository( @
;@ A
_logger   
=   
logger   
??   
throw    %
new  & )!
ArgumentNullException  * ?
(  ? @
nameof  @ F
(  F G
logger  G M
)  M N
)  N O
;  O P
}!! 	
public## &
ChatAccountInfractionState## )
GetAccountBanState##* <
(##< =
int##= @
accountUserId##A N
)##N O
{$$ 	
return%% %
_chatInfractionRepository%% ,
.%%, -%
GetAccountInfractionState%%- F
(%%F G
accountUserId%%G T
)%%T U
;%%U V
}&& 	
public(( 
string(( '
CreateAllowedAccountSession(( 1
(((1 2
int((2 5
accountUserId((6 C
)((C D
{)) 	
string** 
accountSessionToken** &
=**' (
null**) -
;**- .
if++ 
(++ 
!++ 
ChatInfractionRules++ $
.++$ %
IsAccountBanned++% 4
(++4 5%
_chatInfractionRepository,, )
.,,) *%
GetAccountInfractionState,,* C
(,,C D
accountUserId,,D Q
),,Q R
,,,R S
DateTime,,T \
.,,\ ]
UtcNow,,] c
),,c d
),,d e
{-- 
accountSessionToken.. #
=..$ %#
_accountSessionRegistry..& =
...= > 
CreateAccountSession..> R
(..R S
accountUserId..S `
)..` a
;..a b
_logger// 
.// 
Information// #
(//# $"
SessionCreatedTemplate//$ :
,//: ;
accountUserId//< I
)//I J
;//J K
}00 
else11 
{22 
_logger33 
.33 
Warning33 
(33  8
,SessionCreationRejectedBannedAccountTemplate33  L
,33L M
accountUserId33N [
)33[ \
;33\ ]
}44 
return66 
accountSessionToken66 &
;66& '
}77 	
public99 
bool99 %
IsAccountOperationAllowed99 -
(99- .
int99. 1
accountUserId992 ?
,99? @
string99A G
accountSessionToken99H [
)99[ \
{:: 	
return;; 
accountUserId;;  
>;;! "
$num;;# $
&&;;% ''
ResolveAllowedAccountUserId;;( C
(;;C D
accountSessionToken;;D W
);;W X
==;;Y [
accountUserId;;\ i
;;;i j
}<< 	
public>> 
int>> '
ResolveAllowedAccountUserId>> .
(>>. /
string>>/ 5
accountSessionToken>>6 I
)>>I J
{?? 	
int@@ 
accountUserId@@ 
=@@ #
_accountSessionRegistry@@  7
.@@7 8 
ResolveAccountUserId@@8 L
(@@L M
accountSessionToken@@M `
)@@` a
;@@a b
ifAA 
(AA 
accountUserIdAA 
>AA 
$numAA  !
&&AA" $
ChatInfractionRulesAA% 8
.AA8 9
IsAccountBannedAA9 H
(AAH I%
_chatInfractionRepositoryBB )
.BB) *%
GetAccountInfractionStateBB* C
(BBC D
accountUserIdBBD Q
)BBQ R
,BBR S
DateTimeBBT \
.BB\ ]
UtcNowBB] c
)BBc d
)BBd e
{CC 
_loggerDD 
.DD 
WarningDD 
(DD  2
&OperationRejectedBannedAccountTemplateDD  F
,DDF G
accountUserIdDDH U
)DDU V
;DDV W
accountUserIdEE 
=EE 
$numEE  !
;EE! "
}FF 
returnHH 
accountUserIdHH  
;HH  !
}II 	
publicKK 
voidKK !
RevokeAccountSessionsKK )
(KK) *
intKK* -
accountUserIdKK. ;
)KK; <
{LL 	#
_accountSessionRegistryMM #
.MM# $!
RevokeAccountSessionsMM$ 9
(MM9 :
accountUserIdMM: G
)MMG H
;MMH I
_loggerNN 
.NN 
InformationNN 
(NN  #
SessionsRevokedTemplateNN  7
,NN7 8
accountUserIdNN9 F
)NNF G
;NNG H
}OO 	
}PP 
}QQ ™
vC:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\Models\ChatModeration\ChatMessageRejectionReason.cs
	namespace 	
Application
 
. 
Models 
{ 
public 

enum &
ChatMessageRejectionReason *
{ 
None 
= 
$num 
, 
InvalidChatMessage 
= 
$num 
, &
ChatAuthenticationRequired "
=# $
$num% &
,& '%
ChatParticipantNotInLobby		 !
=		" #
$num		$ %
,		% &"
ChatStorageUnavailable

 
=

  
$num

! "
,

" #%
ChatModerationUnavailable !
=" #
$num$ %
,% &,
 ConflictingChatMessageIdentifier (
=) *
$num+ ,
,, -
ChatAccountBanned 
= 
$num 
, 
ChatDeliveryUnknown 
= 
$num 
} 
} ´
eC:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\Models\Lobby\LobbyConfiguration.cs
	namespace 	
Application
 
. 
Models 
{ 
public 

sealed 
record 
LobbyConfiguration +
{ 
public 
byte 
TargetMissionCount &
{' (
get) ,
;, -
init. 2
;2 3
}4 5
public 
byte 
PlayerLimit 
{  !
get" %
;% &
init' +
;+ ,
}- .
public 
bool 
	IsPrivate 
{ 
get  #
;# $
init% )
;) *
}+ ,
}		 
}

 î
ÜC:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\..\ServerTrickTakingMissions\Domain\Compatibility\IsExternalInit.cs
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
} â
eC:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\Ports\Lobby\ILobbyHostSelection.cs
	namespace 	
Application
 
. 
Ports 
{ 
public 

	interface 
ILobbyHostSelection (
{ 
int 
SelectHostUserId 
( 
IReadOnlyList *
<* +
int+ .
>. /&
eligibleParticipantUserIds0 J
)J K
;K L
} 
} Ó
rC:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\Ports\Account\IBlockedAccountEmailRepository.cs
	namespace 	
Application
 
. 
Ports 
{ 
public 

	interface *
IBlockedAccountEmailRepository 3
{ 
bool		 ,
 IsAccountEmailPermanentlyBlocked		 -
(		- .
string		. 4
accountEmail		5 A
)		A B
;		B C
}

 
} ßR
sC:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\UseCases\ChatModeration\ChatModerationStartup.cs
	namespace		 	
Application		
 
.		 
UseCases		 
{

 
public 

sealed 
class !
ChatModerationStartup -
{ 
private 
const 
string "
CatalogFailureTemplate 3
=4 5
$str r
;r s
private 
const 
string :
.ChatModerationAvailableEditableCatalogTemplate K
=L M
$str Y
;Y Z
private 
const 
string 1
%ChatModerationBackupActivatedTemplate B
=C D
$str T
;T U
private 
const 
string ;
/ChatModerationDisabledNoFilterAvailableTemplate L
=M N
$str o
+p q
$str  
;  !
private 
const 
string (
CatalogSourceEditableCatalog 9
=: ;
$str< M
;M N
private 
const 
string (
CatalogSourceValidatedBackup 9
=: ;
$str< M
;M N
private 
const 
string *
CatalogSourceBackupPublication ;
=< =
$str> Q
;Q R
private 
readonly (
IChatModerationCatalogBackup 5$
_moderationCatalogBackup6 N
;N O
private 
readonly 
ILoggerService '
_moderationLogger( 9
;9 :
public !
ChatModerationStartup $
($ %(
IChatModerationCatalogBackup% A#
moderationCatalogBackupB Y
,Y Z
ILoggerService   
moderationLogger   +
)  + ,
{!! 	$
_moderationCatalogBackup"" $
=""% &#
moderationCatalogBackup""' >
??""? A
throw## 
new## !
ArgumentNullException## /
(##/ 0
nameof##0 6
(##6 7#
moderationCatalogBackup##7 N
)##N O
)##O P
;##P Q
_moderationLogger$$ 
=$$ 
moderationLogger$$  0
??$$1 3
throw$$4 9
new$$: =!
ArgumentNullException$$> S
($$S T
nameof$$T Z
($$Z [
moderationLogger$$[ k
)$$k l
)$$l m
;$$m n
}%% 	
public'' %
ChatModerationPreparation'' (!
PrepareChatModeration'') >
(''> ?
string''? E
catalogDirectory''F V
)''V W
{(( 	%
ChatModerationPreparation)) %!
moderationPreparation))& ;
=))< =
TryPrepareCatalog))> O
())O P
(** 
)** 
=>** $
_moderationCatalogBackup** .
.**. /
LoadEditableCatalog**/ B
(**B C
catalogDirectory**C S
)**S T
,**T U(
CatalogSourceEditableCatalog**V r
)**r s
;**s t
if++ 
(++ !
moderationPreparation++ %
.++% &"
IsChatSendingAvailable++& <
)++< =
{,, "
TrySaveValidatedBackup-- &
(--& '!
moderationPreparation--' <
)--< =
;--= >
_moderationLogger.. !
...! "
Information.." -
(..- .:
.ChatModerationAvailableEditableCatalogTemplate... \
)..\ ]
;..] ^
}// 
else00 
{11 !
moderationPreparation22 %
=22& '
TryPrepareCatalog22( 9
(229 :$
_moderationCatalogBackup33 ,
.33, -
LoadValidatedBackup33- @
,33@ A(
CatalogSourceValidatedBackup33B ^
)33^ _
;33_ `#
LogRecoveryAvailability44 '
(44' (!
moderationPreparation44( =
.44= >"
IsChatSendingAvailable44> T
)44T U
;44U V
}55 
return77 !
moderationPreparation77 (
;77( )
}88 	
private:: %
ChatModerationPreparation:: )
TryPrepareCatalog::* ;
(::; <
Func::< @
<::@ A%
ChatModerationPreparation::A Z
>::Z [
prepareCatalog::\ j
,::j k
string;; 
catalogSource;;  
);;  !
{<< 	%
ChatModerationPreparation== %!
moderationPreparation==& ;
===< =
new==> A%
ChatModerationPreparation==B [
(==[ \
)==\ ]
;==] ^
try>> 
{?? !
moderationPreparation@@ %
=@@& '
prepareCatalog@@( 6
(@@6 7
)@@7 8
;@@8 9
}AA 
catchBB 
(BB  
InvalidDataExceptionBB '
exBB( *
)BB* +
{CC 
LogCatalogFailureDD !
(DD! "
catalogSourceDD" /
,DD/ 0
exDD1 3
.DD3 4
GetTypeDD4 ;
(DD; <
)DD< =
.DD= >
NameDD> B
,DDB C
exDDD F
.DDF G
MessageDDG N
)DDN O
;DDO P
}EE 
catchFF 
(FF 
IOExceptionFF 
exFF !
)FF! "
{GG 
LogCatalogFailureHH !
(HH! "
catalogSourceHH" /
,HH/ 0
exHH1 3
.HH3 4
GetTypeHH4 ;
(HH; <
)HH< =
.HH= >
NameHH> B
,HHB C
exHHD F
.HHF G
MessageHHG N
)HHN O
;HHO P
}II 
catchJJ 
(JJ '
UnauthorizedAccessExceptionJJ .
exJJ/ 1
)JJ1 2
{KK 
LogCatalogFailureLL !
(LL! "
catalogSourceLL" /
,LL/ 0
exLL1 3
.LL3 4
GetTypeLL4 ;
(LL; <
)LL< =
.LL= >
NameLL> B
,LLB C
exLLD F
.LLF G
MessageLLG N
)LLN O
;LLO P
}MM 
catchNN 
(NN 
XmlExceptionNN 
exNN  "
)NN" #
{OO 
LogCatalogFailurePP !
(PP! "
catalogSourcePP" /
,PP/ 0
exPP1 3
.PP3 4
GetTypePP4 ;
(PP; <
)PP< =
.PP= >
NamePP> B
,PPB C
exPPD F
.PPF G
MessagePPG N
)PPN O
;PPO P
}QQ 
catchRR 
(RR 
FormatExceptionRR "
exRR# %
)RR% &
{SS 
LogCatalogFailureTT !
(TT! "
catalogSourceTT" /
,TT/ 0
exTT1 3
.TT3 4
GetTypeTT4 ;
(TT; <
)TT< =
.TT= >
NameTT> B
,TTB C
exTTD F
.TTF G
MessageTTG N
)TTN O
;TTO P
}UU 
catchVV 
(VV 
ArgumentExceptionVV $
exVV% '
)VV' (
{WW 
LogCatalogFailureXX !
(XX! "
catalogSourceXX" /
,XX/ 0
exXX1 3
.XX3 4
GetTypeXX4 ;
(XX; <
)XX< =
.XX= >
NameXX> B
,XXB C
exXXD F
.XXF G
MessageXXG N
)XXN O
;XXO P
}YY 
catchZZ 
(ZZ 
TimeoutExceptionZZ #
exZZ$ &
)ZZ& '
{[[ 
LogCatalogFailure\\ !
(\\! "
catalogSource\\" /
,\\/ 0
ex\\1 3
.\\3 4
GetType\\4 ;
(\\; <
)\\< =
.\\= >
Name\\> B
,\\B C
ex\\D F
.\\F G
Message\\G N
)\\N O
;\\O P
}]] 
return__ !
moderationPreparation__ (
;__( )
}`` 	
privatebb 
voidbb "
TrySaveValidatedBackupbb +
(bb+ ,%
ChatModerationPreparationbb, E!
moderationPreparationbbF [
)bb[ \
{cc 	
trydd 
{ee $
_moderationCatalogBackupff (
.ff( )
SaveValidatedBackupff) <
(ff< =!
moderationPreparationff= R
)ffR S
;ffS T
}gg 
catchhh 
(hh 
IOExceptionhh 
exhh !
)hh! "
{ii 
LogCatalogFailurejj !
(jj! "*
CatalogSourceBackupPublicationjj" @
,jj@ A
exjjB D
.jjD E
GetTypejjE L
(jjL M
)jjM N
.jjN O
NamejjO S
,jjS T
exjjU W
.jjW X
MessagejjX _
)jj_ `
;jj` a
}kk 
catchll 
(ll '
UnauthorizedAccessExceptionll .
exll/ 1
)ll1 2
{mm 
LogCatalogFailurenn !
(nn! "*
CatalogSourceBackupPublicationnn" @
,nn@ A
exnnB D
.nnD E
GetTypennE L
(nnL M
)nnM N
.nnN O
NamennO S
,nnS T
exnnU W
.nnW X
MessagennX _
)nn_ `
;nn` a
}oo 
}pp 	
privaterr 
voidrr 
LogCatalogFailurerr &
(rr& '
stringrr' -
catalogSourcerr. ;
,rr; <
stringrr= C
failureTyperrD O
,rrO P
stringrrQ W
failureReasonrrX e
)rre f
{ss 	
_moderationLoggertt 
.tt 
Warningtt %
(tt% &"
CatalogFailureTemplatett& <
,tt< =
catalogSourcett> K
,ttK L
failureTypettM X
,ttX Y
failureReasonttZ g
)ttg h
;tth i
}uu 	
privateww 
voidww #
LogRecoveryAvailabilityww ,
(ww, -
boolww- 1"
isChatSendingAvailableww2 H
)wwH I
{xx 	
ifyy 
(yy "
isChatSendingAvailableyy &
)yy& '
{zz 
_moderationLogger{{ !
.{{! "
Warning{{" )
({{) *1
%ChatModerationBackupActivatedTemplate{{* O
){{O P
;{{P Q
}|| 
else}} 
{~~ 
_moderationLogger !
.! "
Error" '
(' (;
/ChatModerationDisabledNoFilterAvailableTemplate( W
)W X
;X Y
}
ÄÄ 
}
ÅÅ 	
}
ÇÇ 
}ÉÉ í
wC:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\Ports\ChatModeration\IChatModerationCatalogBackup.cs
	namespace 	
Application
 
. 
Ports 
{ 
public 

	interface (
IChatModerationCatalogBackup 1
{ %
ChatModerationPreparation !
LoadEditableCatalog" 5
(5 6
string6 <
catalogDirectory= M
)M N
;N O%
ChatModerationPreparation

 !
LoadValidatedBackup

" 5
(

5 6
)

6 7
;

7 8
void 
SaveValidatedBackup  
(  !%
ChatModerationPreparation! :
preparation; F
)F G
;G H
} 
} ∞
uC:\Users\oscar\source\repos\TrickTakingMissions\Server\Application\Models\ChatModeration\ChatModerationPreparation.cs
	namespace 	
Application
 
. 
Models 
{ 
public 

sealed 
record %
ChatModerationPreparation 2
{		 
public

 
IReadOnlyCollection

 "
<

" #$
ProhibitedChatExpression

# ;
>

; <
Expressions

= H
{

I J
get

K N
;

N O
init

P T
;

T U
}

V W
public  
ChatMessageModerator #
MessageModerator$ 4
{5 6
get7 :
;: ;
init< @
;@ A
}B C
public 
bool "
IsChatSendingAvailable *
=>+ -
MessageModerator. >
!=? A
nullB F
;F G
} 
} 