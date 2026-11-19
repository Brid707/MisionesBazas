ŒH
qC:\Users\oscar\source\repos\TrickTakingMissions\Server\Services\Services\Match\LobbyService.SpecialPreparation.cs
	namespace 	
Services
 
. 
Services 
{ 
public		 

sealed		 
partial		 
class		 
LobbyService		  ,
{

 
public *
MissionPreparationConfirmation -"
IdentifyHeartNineOwner. D
(D E-
!HeartNineIdentificationSubmission -

submission. 8
,8 9
int: =
participantUserId> O
)O P
{ 	
if 
( 

submission 
== 
null "
)" #
{ 
throw "
CreatePreparationFault ,
(, -+
MissionPreparationFailureReason- L
.L M
InvalidSubmissionM ^
)^ _
;_ `
} 
return $
CommitMissionPreparation +
(+ ,$
MissionPreparationMapper, D
.D E
MapSubmissionE R
(R S

submissionS ]
)] ^
,^ _
participantUserId` q
)q r
;r s
} 	
public *
MissionPreparationConfirmation -*
AssignMissionTrickDistribution. L
(L M.
"MissionTrickDistributionSubmission .

submission/ 9
,9 :
int; >
participantUserId? P
)P Q
{ 	
if 
( 

submission 
== 
null "
)" #
{ 
throw "
CreatePreparationFault ,
(, -+
MissionPreparationFailureReason- L
.L M
InvalidSubmissionM ^
)^ _
;_ `
} 
return $
CommitMissionPreparation +
(+ ,$
MissionPreparationMapper, D
.D E
MapSubmissionE R
(R S

submissionS ]
)] ^
,^ _
participantUserId` q
)q r
;r s
} 	
public *
MissionPreparationConfirmation -
AssignMissionRole. ?
(? @+
MissionRoleAssignmentSubmission@ _

submission` j
,j k
int   
participantUserId   !
)  ! "
{!! 	
if"" 
("" 

submission"" 
=="" 
null"" "
)""" #
{## 
throw$$ "
CreatePreparationFault$$ ,
($$, -+
MissionPreparationFailureReason$$- L
.$$L M
InvalidSubmission$$M ^
)$$^ _
;$$_ `
}%% 
return&& $
CommitMissionPreparation&& +
(&&+ ,$
MissionPreparationMapper&&, D
.&&D E
MapSubmission&&E R
(&&R S

submission&&S ]
)&&] ^
,&&^ _
participantUserId&&` q
)&&q r
;&&r s
}'' 	
public)) *
MissionPreparationConfirmation)) -$
RespondToBlindObjectives)). F
())F G,
 BlindObjectiveResponseSubmission))G g

submission))h r
,))r s
int** 
participantUserId** !
)**! "
{++ 	
if,, 
(,, 

submission,, 
==,, 
null,, "
||,,# %
(,,& '

submission,,' 1
.,,1 2
Response,,2 :
!=,,; ="
BlindObjectiveResponse,,> T
.,,T U
Yes,,U X
&&,,Y [

submission-- 
.-- 
Response-- #
!=--$ &"
BlindObjectiveResponse--' =
.--= >
No--> @
)--@ A
)--A B
{.. 
throw// "
CreatePreparationFault// ,
(//, -+
MissionPreparationFailureReason//- L
.//L M
InvalidSubmission//M ^
)//^ _
;//_ `
}00 
return11 $
CommitMissionPreparation11 +
(11+ ,$
MissionPreparationMapper11, D
.11D E
MapSubmission11E R
(11R S

submission11S ]
)11] ^
,11^ _
participantUserId11` q
)11q r
;11r s
}22 	
private44 *
MissionPreparationConfirmation44 .$
CommitMissionPreparation44/ G
(44G H%
MissionPreparationRequest44H a
request44b i
,44i j
int55 
participantUserId55 !
)55! "
{66 	
if77 
(77 
string77 
.77 
IsNullOrWhiteSpace77 )
(77) *
request77* 1
.771 2
	LobbyCode772 ;
)77; <
||77= ?
request88 
.88 
	LobbyCode88 !
.88! "
Length88" (
>88) *-
!MaximumMatchActionLobbyCodeLength88+ L
)88L M
{99 
throw:: "
CreatePreparationFault:: ,
(::, -+
MissionPreparationFailureReason::- L
.::L M
InvalidSubmission::M ^
)::^ _
;::_ `
};; *
EnsureMatchActionSessionBudget<< *
(<<* +
)<<+ ,
;<<, -)
EnsureMatchParticipantAllowed== )
(==) *
request==* 1
.==1 2
	LobbyCode==2 ;
,==; <
participantUserId=== N
)==N O
;==O P$
MissionPreparationCommit>> $
commit>>% +
=>>, -%
ExecuteMissionPreparation>>. G
(>>G H
request>>H O
,>>O P
participantUserId>>Q b
)>>b c
;>>c d
if?? 
(?? 
commit?? 
.?? 
	Rejection??  
!=??! #'
MissionPreparationRejection??$ ?
.??? @
None??@ D
)??D E
{@@ 
throwAA "
CreatePreparationFaultAA ,
(AA, -$
MissionPreparationMapperAA- E
.AAE F
MapRejectionAAF R
(AAR S
commitAAS Y
.AAY Z
	RejectionAAZ c
)AAc d
)AAd e
;AAe f
}BB 
ifCC 
(CC 
commitCC 
.CC 
HasStateChangedCC &
)CC& '
{DD 
BroadcastToRoomEE 
(EE  
requestEE  '
.EE' (
	LobbyCodeEE( 1
,EE1 2
nullEE3 7
,EE7 8
callbackFF 
=>FF 
callbackFF  (
.FF( )
OnMatchStateChangedFF) <
(FF< =
commitFF= C
.FFC D&
CommittedMatchStateVersionFFD ^
)FF^ _
)FF_ `
;FF` a
}GG 
returnHH 
newHH *
MissionPreparationConfirmationHH 5
{II *
MissionPreparationSubmissionIdJJ .
=JJ/ 0
commitJJ1 7
.JJ7 8*
MissionPreparationSubmissionIdJJ8 V
,JJV W&
CommittedMatchStateVersionKK *
=KK+ ,
commitKK- 3
.KK3 4&
CommittedMatchStateVersionKK4 N
}LL 
;LL 
}MM 	
privateOO $
MissionPreparationCommitOO (%
ExecuteMissionPreparationOO) B
(OOB C%
MissionPreparationRequestOOC \
requestOO] d
,OOd e
intPP 
participantUserIdPP !
)PP! "
{QQ 	$
MissionPreparationCommitRR $
commitRR% +
;RR+ ,
trySS 
{TT 
commitUU 
=UU 
_lobbyUseCaseUU &
.UU& '
MatchUU' ,
.UU, -%
ProcessMissionPreparationUU- F
(UUF G
requestUUG N
,UUN O
participantUserIdUUP a
)UUa b
;UUb c
}VV 
catchWW 
(WW 
ArgumentExceptionWW $
exWW% '
)WW' (
{XX 
throwYY %
CreateMatchOperationFaultYY /
(YY/ 0
exYY0 2
,YY2 3
nameofYY4 :
(YY: ;+
MissionPreparationFailureReasonYY; Z
.YYZ [ 
OperationUnavailableYY[ o
)YYo p
)YYp q
;YYq r
}ZZ 
catch[[ 
([[ %
InvalidOperationException[[ ,
ex[[- /
)[[/ 0
{\\ 
throw]] %
CreateMatchOperationFault]] /
(]]/ 0
ex]]0 2
,]]2 3
nameof]]4 :
(]]: ;+
MissionPreparationFailureReason]]; Z
.]]Z [ 
OperationUnavailable]][ o
)]]o p
)]]p q
;]]q r
}^^ 
return__ 
commit__ 
;__ 
}`` 	
privatebb 
staticbb 
FaultExceptionbb %
<bb% &#
MissionPreparationFaultbb& =
>bb= >"
CreatePreparationFaultcc "
(cc" #+
MissionPreparationFailureReasoncc# B
reasonccC I
)ccI J
{dd 	
returnee 
newee 
FaultExceptionee %
<ee% &#
MissionPreparationFaultee& =
>ee= >
(ee> ?
newee? B#
MissionPreparationFaulteeC Z
{ee[ \
FailureReasonee] j
=eek l
reasoneem s
}eet u
)eeu v
;eev w
}ff 	
}gg 
}hh ÓQ
cC:\Users\oscar\source\repos\TrickTakingMissions\Server\Services\Mapping\MissionPreparationMapper.cs
	namespace 	
Services
 
. 
Mapping 
{ 
internal 
static 
class $
MissionPreparationMapper 2
{		 
internal

 
static

 %
MissionPreparationRequest

 1
MapSubmission

2 ?
(

? @-
!HeartNineIdentificationSubmission

@ a

submission

b l
)

l m
{ 	
return 
new %
MissionPreparationRequest 0
{ 
	LobbyCode 
= 

submission &
.& '
	LobbyCode' 0
,0 1
MatchId 
= 

submission $
.$ %
MatchId% ,
,, -
MissionAttemptId  
=! "

submission# -
.- .
MissionAttemptId. >
,> ?%
MissionPreparationStageId )
=* +

submission, 6
.6 7%
MissionPreparationStageId7 P
,P Q*
MissionPreparationSubmissionId .
=/ 0

submission1 ;
.; <*
MissionPreparationSubmissionId< Z
,Z [%
ExpectedMatchStateVersion )
=* +

submission, 6
.6 7%
ExpectedMatchStateVersion7 P
,P Q
Action 
= $
MissionPreparationAction 1
.1 2"
IdentifyHeartNineOwner2 H
} 
; 
} 	
internal 
static %
MissionPreparationRequest 1
MapSubmission2 ?
(? @.
"MissionTrickDistributionSubmission@ b

submissionc m
)m n
{ 	
return 
new %
MissionPreparationRequest 0
{ 
	LobbyCode 
= 

submission &
.& '
	LobbyCode' 0
,0 1
MatchId 
= 

submission $
.$ %
MatchId% ,
,, -
MissionAttemptId  
=! "

submission# -
.- .
MissionAttemptId. >
,> ?%
MissionPreparationStageId )
=* +

submission, 6
.6 7%
MissionPreparationStageId7 P
,P Q*
MissionPreparationSubmissionId   .
=  / 0

submission  1 ;
.  ; <*
MissionPreparationSubmissionId  < Z
,  Z [%
ExpectedMatchStateVersion!! )
=!!* +

submission!!, 6
.!!6 7%
ExpectedMatchStateVersion!!7 P
,!!P Q2
&FirstFourTricksWinnerParticipantUserId"" 6
=""7 8

submission""9 C
.""C D2
&FirstFourTricksWinnerParticipantUserId""D j
,""j k,
 LastTrickWinnerParticipantUserId## 0
=##1 2

submission##3 =
.##= >,
 LastTrickWinnerParticipantUserId##> ^
,##^ _
Action$$ 
=$$ $
MissionPreparationAction$$ 1
.$$1 2#
AssignTrickDistribution$$2 I
}%% 
;%% 
}&& 	
internal(( 
static(( %
MissionPreparationRequest(( 1
MapSubmission((2 ?
(((? @+
MissionRoleAssignmentSubmission((@ _

submission((` j
)((j k
{)) 	
return** 
new** %
MissionPreparationRequest** 0
{++ 
	LobbyCode,, 
=,, 

submission,, &
.,,& '
	LobbyCode,,' 0
,,,0 1
MatchId-- 
=-- 

submission-- $
.--$ %
MatchId--% ,
,--, -
MissionAttemptId..  
=..! "

submission..# -
...- .
MissionAttemptId... >
,..> ?%
MissionPreparationStageId// )
=//* +

submission//, 6
.//6 7%
MissionPreparationStageId//7 P
,//P Q*
MissionPreparationSubmissionId00 .
=00/ 0

submission001 ;
.00; <*
MissionPreparationSubmissionId00< Z
,00Z [%
ExpectedMatchStateVersion11 )
=11* +

submission11, 6
.116 7%
ExpectedMatchStateVersion117 P
,11P Q
Action22 
=22 $
MissionPreparationAction22 1
.221 2

AssignRole222 <
,22< =%
SelectedParticipantUserId33 )
=33* +

submission33, 6
.336 7%
SelectedParticipantUserId337 P
}44 
;44 
}55 	
internal77 
static77 %
MissionPreparationRequest77 1
MapSubmission772 ?
(77? @,
 BlindObjectiveResponseSubmission77@ `

submission77a k
)77k l
{88 	
return99 
new99 %
MissionPreparationRequest99 0
{:: 
	LobbyCode;; 
=;; 

submission;; &
.;;& '
	LobbyCode;;' 0
,;;0 1
MatchId<< 
=<< 

submission<< $
.<<$ %
MatchId<<% ,
,<<, -
MissionAttemptId==  
===! "

submission==# -
.==- .
MissionAttemptId==. >
,==> ?%
MissionPreparationStageId>> )
=>>* +

submission>>, 6
.>>6 7%
MissionPreparationStageId>>7 P
,>>P Q*
MissionPreparationSubmissionId?? .
=??/ 0

submission??1 ;
.??; <*
MissionPreparationSubmissionId??< Z
,??Z [%
ExpectedMatchStateVersion@@ )
=@@* +

submission@@, 6
.@@6 7%
ExpectedMatchStateVersion@@7 P
,@@P Q
ActionAA 
=AA $
MissionPreparationActionAA 1
.AA1 2
RecordBlindResponseAA2 E
,AAE F
ResponseBB 
=BB 

submissionBB %
.BB% &
ResponseBB& .
==BB/ 1"
BlindObjectiveResponseBB2 H
.BBH I
YesBBI L
?CC )
BlindObjectiveCapableResponseCC 3
.CC3 4
YesCC4 7
:CC8 9)
BlindObjectiveCapableResponseCC: W
.CCW X
NoCCX Z
}DD 
;DD 
}EE 	
internalGG 
staticGG +
MissionPreparationFailureReasonGG 7
MapRejectionGG8 D
(GGD E'
MissionPreparationRejectionGGE `
	rejectionGGa j
)GGj k
{HH 	
returnII 

s_failuresII 
[II 
	rejectionII '
]II' (
;II( )
}JJ 	
privateLL 
staticLL 
readonlyLL 
IReadOnlyDictionaryLL  3
<LL3 4'
MissionPreparationRejectionLL4 O
,LLO P+
MissionPreparationFailureReasonLLQ p
>LLp q

s_failuresMM 
=MM 
newMM 

DictionaryMM '
<MM' ('
MissionPreparationRejectionMM( C
,MMC D+
MissionPreparationFailureReasonMME d
>MMd e
{NN 
{OO '
MissionPreparationRejectionOO -
.OO- .
NoneOO. 2
,OO2 3+
MissionPreparationFailureReasonOO4 S
.OOS T
NoneOOT X
}OOY Z
,OOZ [
{PP '
MissionPreparationRejectionPP -
.PP- .
InvalidSubmissionPP. ?
,PP? @+
MissionPreparationFailureReasonPPA `
.PP` a
InvalidSubmissionPPa r
}PPs t
,PPt u
{QQ '
MissionPreparationRejectionQQ -
.QQ- .
MatchUnavailableQQ. >
,QQ> ?+
MissionPreparationFailureReasonQQ@ _
.QQ_ `
MatchUnavailableQQ` p
}QQq r
,QQr s
{RR '
MissionPreparationRejectionRR -
.RR- .!
ParticipantNotAllowedRR. C
,RRC D+
MissionPreparationFailureReasonSS 3
.SS3 4!
ParticipantNotAllowedSS4 I
}SSJ K
,SSK L
{TT '
MissionPreparationRejectionTT -
.TT- .
WrongMissionAttemptTT. A
,TTA B+
MissionPreparationFailureReasonUU 3
.UU3 4
WrongMissionAttemptUU4 G
}UUH I
,UUI J
{VV '
MissionPreparationRejectionVV -
.VV- .$
SubmissionIdentityReusedVV. F
,VVF G+
MissionPreparationFailureReasonWW 3
.WW3 4$
SubmissionIdentityReusedWW4 L
}WWM N
,WWN O
{XX '
MissionPreparationRejectionXX -
.XX- .
StageMismatchXX. ;
,XX; <+
MissionPreparationFailureReasonXX= \
.XX\ ]
StageMismatchXX] j
}XXk l
,XXl m
{YY '
MissionPreparationRejectionYY -
.YY- .
StaleMatchStateYY. =
,YY= >+
MissionPreparationFailureReasonYY? ^
.YY^ _
StaleMatchStateYY_ n
}YYo p
,YYp q
{ZZ '
MissionPreparationRejectionZZ -
.ZZ- .
CaptainRequiredZZ. =
,ZZ= >+
MissionPreparationFailureReasonZZ? ^
.ZZ^ _
CaptainRequiredZZ_ n
}ZZo p
,ZZp q
{[[ '
MissionPreparationRejection[[ -
.[[- .
InvalidTarget[[. ;
,[[; <+
MissionPreparationFailureReason[[= \
.[[\ ]
InvalidTarget[[] j
}[[k l
,[[l m
{\\ '
MissionPreparationRejection\\ -
.\\- .
ResponsesPending\\. >
,\\> ?+
MissionPreparationFailureReason\\@ _
.\\_ `
ResponsesPending\\` p
}\\q r
,\\r s
{]] '
MissionPreparationRejection]] -
.]]- .
AlreadyAnswered]]. =
,]]= >+
MissionPreparationFailureReason]]? ^
.]]^ _
AlreadyAnswered]]_ n
}]]o p
,]]p q
{^^ '
MissionPreparationRejection^^ -
.^^- .
RequestLimitReached^^. A
,^^A B+
MissionPreparationFailureReason__ 3
.__3 4
RequestLimitReached__4 G
}__H I
,__I J
{`` '
MissionPreparationRejection`` -
.``- . 
OperationUnavailable``. B
,``B C+
MissionPreparationFailureReasonaa 3
.aa3 4 
OperationUnavailableaa4 H
}aaI J
,aaJ K
}bb 
;bb 
}cc 
}dd ˇ/
mC:\Users\oscar\source\repos\TrickTakingMissions\Server\Services\Services\Match\LobbyService.DistressSignal.cs
	namespace 	
Services
 
. 
Services 
{ 
public		 

sealed		 
partial		 
class		 
LobbyService		  ,
{

 
public &
DistressSignalConfirmation ) 
SubmitDistressSignal* >
(> ?$
DistressSignalSubmission $

submission% /
,/ 0
int1 4
participantUserId5 F
)F G
{ 	
if 
( 

submission 
== 
null "
||# %
string& ,
., -
IsNullOrWhiteSpace- ?
(? @

submission@ J
.J K
	LobbyCodeK T
)T U
||V X

submission 
. 
	LobbyCode $
.$ %
Length% +
>, --
!MaximumMatchActionLobbyCodeLength. O
||P R
! 
Enum 
. 
	IsDefined 
(  
typeof  &
(& '$
DistressSignalActionType' ?
)? @
,@ A

submissionB L
.L M

ActionTypeM W
)W X
||Y [

submission 
. 

ActionType %
==& ($
DistressSignalActionType) A
.A B
NoneB F
||G I
! 
Enum 
. 
	IsDefined 
(  
typeof  &
(& '!
DistressPassDirection' <
)< =
,= >

submission? I
.I J
SelectedDirectionJ [
)[ \
)\ ]
{ 
throw 
CreateDistressFault )
() *'
DistressSignalFailureReason* E
.E F
InvalidSubmissionF W
)W X
;X Y
} *
EnsureMatchActionSessionBudget *
(* +
)+ ,
;, -)
EnsureMatchParticipantAllowed )
() *

submission* 4
.4 5
	LobbyCode5 >
,> ?
participantUserId@ Q
)Q R
;R S 
DistressSignalCommit  
result! '
=( )!
ExecuteDistressSignal* ?
(? @

submission@ J
,J K
participantUserIdL ]
)] ^
;^ _
if 
( 
result 
. 
	Rejection  
!=! ##
DistressSignalRejection$ ;
.; <
None< @
)@ A
{ 
throw 
CreateDistressFault )
() * 
DistressSignalMapper* >
.> ?
MapRejection? K
(K L
resultL R
.R S
	RejectionS \
)\ ]
)] ^
;^ _
} 
if 
( 
result 
. 
HasStateChanged &
)& '
{ 
BroadcastToRoom 
(  

submission  *
.* +
	LobbyCode+ 4
,4 5
null6 :
,: ;
callback   
=>   
callback    (
.  ( )
OnMatchStateChanged  ) <
(  < =
result  = C
.  C D&
CommittedMatchStateVersion  D ^
)  ^ _
)  _ `
;  ` a
}!! 
return"" 
new"" &
DistressSignalConfirmation"" 1
{## 

IsExecuted$$ 
=$$ 
result$$ #
.$$# $

IsExecuted$$$ .
,$$. /&
CommittedMatchStateVersion%% *
=%%+ ,
result%%- 3
.%%3 4&
CommittedMatchStateVersion%%4 N
}&& 
;&& 
}'' 	
private))  
DistressSignalCommit)) $!
ExecuteDistressSignal))% :
()): ;$
DistressSignalSubmission** $

submission**% /
,**/ 0
int**1 4
participantUserId**5 F
)**F G
{++ 	 
DistressSignalCommit,,  
result,,! '
;,,' (
try-- 
{.. 
result// 
=// 
_lobbyUseCase// &
.//& '
Match//' ,
.//, - 
SubmitDistressSignal//- A
(//A B 
DistressSignalMapper00 (
.00( )
MapSubmission00) 6
(006 7

submission007 A
)00A B
,00B C
participantUserId00D U
)00U V
;00V W
}11 
catch22 
(22 
ArgumentException22 $
ex22% '
)22' (
{33 
throw44 %
CreateMatchOperationFault44 /
(44/ 0
ex440 2
,442 3
nameof444 :
(44: ;'
DistressSignalFailureReason44; V
.44V W 
OperationUnavailable44W k
)44k l
)44l m
;44m n
}55 
catch66 
(66 %
InvalidOperationException66 ,
ex66- /
)66/ 0
{77 
throw88 %
CreateMatchOperationFault88 /
(88/ 0
ex880 2
,882 3
nameof884 :
(88: ;'
DistressSignalFailureReason88; V
.88V W 
OperationUnavailable88W k
)88k l
)88l m
;88m n
}99 
return:: 
result:: 
;:: 
};; 	
private== 
static== 
FaultException== %
<==% &
DistressSignalFault==& 9
>==9 :
CreateDistressFault==; N
(==N O'
DistressSignalFailureReason==O j
reason==k q
)==q r
{>> 	
return?? 
new?? 
FaultException?? %
<??% &
DistressSignalFault??& 9
>??9 :
(??: ;
new??; >
DistressSignalFault??? R
{??S T
FailureReason??U b
=??c d
reason??e k
}??l m
)??m n
;??n o
}@@ 	
}AA 
}BB °7
_C:\Users\oscar\source\repos\TrickTakingMissions\Server\Services\Mapping\DistressSignalMapper.cs
	namespace 	
Services
 
. 
Mapping 
{ 
internal 
static 
class  
DistressSignalMapper .
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
3 4!
DistressPassDirection

4 I
,

I J
PassDirection

K X
>

X Y 
DirectionsByContract

Z n
=

o p
new 

Dictionary 
< !
DistressPassDirection 0
,0 1
PassDirection2 ?
>? @
{ 
{ !
DistressPassDirection '
.' (
None( ,
,, -
PassDirection. ;
.; <
None< @
}A B
,B C
{ !
DistressPassDirection '
.' (
Left( ,
,, -
PassDirection. ;
.; <
Left< @
}A B
,B C
{ !
DistressPassDirection '
.' (
Right( -
,- .
PassDirection/ <
.< =
Right= B
}C D
} 
; 
private 
static 
readonly 
IReadOnlyDictionary  3
<3 4#
DistressSignalRejection4 K
,K L'
DistressSignalFailureReasonM h
>h i
FailuresByRejection 
=  !
new" %

Dictionary& 0
<0 1#
DistressSignalRejection1 H
,H I'
DistressSignalFailureReasonJ e
>e f
{ 
{ #
DistressSignalRejection )
.) *
None* .
,. /'
DistressSignalFailureReason0 K
.K L
NoneL P
}Q R
,R S
{ #
DistressSignalRejection )
.) *
InvalidSubmission* ;
,; <'
DistressSignalFailureReason= X
.X Y
InvalidSubmissionY j
}k l
,l m
{ #
DistressSignalRejection )
.) *
MatchUnavailable* :
,: ;'
DistressSignalFailureReason< W
.W X
MatchUnavailableX h
}i j
,j k
{ #
DistressSignalRejection )
.) *!
ParticipantNotAllowed* ?
,? @'
DistressSignalFailureReasonA \
.\ ]!
ParticipantNotAllowed] r
}s t
,t u
{ #
DistressSignalRejection )
.) *
WrongMissionAttempt* =
,= >'
DistressSignalFailureReason? Z
.Z [
WrongMissionAttempt[ n
}o p
,p q
{ #
DistressSignalRejection )
.) *&
MissionPreparationRequired* D
,D E'
DistressSignalFailureReason /
./ 0&
MissionPreparationRequired0 J
}K L
,L M
{ #
DistressSignalRejection )
.) *"
MissionAttemptFinished* @
,@ A'
DistressSignalFailureReasonB ]
.] ^"
MissionAttemptFinished^ t
}u v
,v w
{ #
DistressSignalRejection )
.) *
DistressAlreadyUsed* =
,= >'
DistressSignalFailureReason? Z
.Z [
DistressAlreadyUsed[ n
}o p
,p q
{ #
DistressSignalRejection )
.) *
TrickAlreadyStarted* =
,= >'
DistressSignalFailureReason? Z
.Z [
TrickAlreadyStarted[ n
}o p
,p q
{ #
DistressSignalRejection )
.) *
RadioAlreadyUsed* :
,: ;'
DistressSignalFailureReason< W
.W X
RadioAlreadyUsedX h
}i j
,j k
{   #
DistressSignalRejection   )
.  ) *
CardNotInHand  * 7
,  7 8'
DistressSignalFailureReason  9 T
.  T U
CardNotInHand  U b
}  c d
,  d e
{!! #
DistressSignalRejection!! )
.!!) *!
SpecialCardNotAllowed!!* ?
,!!? @'
DistressSignalFailureReason!!A \
.!!\ ]!
SpecialCardNotAllowed!!] r
}!!s t
,!!t u
{"" #
DistressSignalRejection"" )
."") *!
InvalidStepTransition""* ?
,""? @'
DistressSignalFailureReason""A \
.""\ ]!
InvalidStepTransition""] r
}""s t
,""t u
{## #
DistressSignalRejection## )
.##) * 
OperationUnavailable##* >
,##> ?'
DistressSignalFailureReason##@ [
.##[ \ 
OperationUnavailable##\ p
}##q r
}$$ 
;$$ 
internal&& 
static&& !
DistressSignalRequest&& -
MapSubmission&&. ;
(&&; <$
DistressSignalSubmission&&< T

submission&&U _
)&&_ `
{'' 	 
DirectionsByContract((  
.((  !
TryGetValue((! ,
(((, -

submission((- 7
.((7 8
SelectedDirection((8 I
,((I J
out((K N
PassDirection((O \
selectedDirection((] n
)((n o
;((o p
return)) 
new)) !
DistressSignalRequest)) ,
{** 
MatchId++ 
=++ 

submission++ $
.++$ %
MatchId++% ,
,++, -
	LobbyCode,, 
=,, 

submission,, &
.,,& '
	LobbyCode,,' 0
,,,0 1
MissionAttemptId--  
=--! "

submission--# -
.--- .
MissionAttemptId--. >
,--> ?
CardIdToPass.. 
=.. 

submission.. )
...) *
CardIdToPass..* 6
,..6 7
SelectedDirection// !
=//" #
selectedDirection//$ 5
,//5 6
IsVoteAccepted00 
=00  

submission00! +
.00+ ,
IsVoteAccepted00, :
,00: ;

ActionType11 
=11 

submission11 '
.11' (

ActionType11( 2
}22 
;22 
}33 	
internal55 
static55 '
DistressSignalFailureReason55 3
MapRejection554 @
(55@ A#
DistressSignalRejection55A X
	rejection55Y b
)55b c
{66 	
return77 
FailuresByRejection77 &
.77& '
TryGetValue77' 2
(772 3
	rejection773 <
,77< =
out77> A'
DistressSignalFailureReason77B ]
reason77^ d
)77d e
?88 
reason88 
:99 '
DistressSignalFailureReason99 -
.99- .
InvalidSubmission99. ?
;99? @
}:: 	
};; 
}<< µ-
qC:\Users\oscar\source\repos\TrickTakingMissions\Server\Services\Services\Match\LobbyService.RadioCommunication.cs
	namespace 	
Services
 
. 
Services 
{ 
public		 

sealed		 
partial		 
class		 
LobbyService		  ,
{

 
public *
RadioCommunicationConfirmation -$
SubmitRadioCommunication. F
(F G(
RadioCommunicationSubmissionG c

submissiond n
,n o
int 
participantUserId !
)! "
{ 	
if 
( 

submission 
== 
null "
||# %
string& ,
., -
IsNullOrWhiteSpace- ?
(? @

submission@ J
.J K
	LobbyCodeK T
)T U
||V X

submission 
. 
	LobbyCode $
.$ %
Length% +
>, --
!MaximumMatchActionLobbyCodeLength. O
||P R
! 
Enum 
. 
	IsDefined 
(  
typeof  &
(& '$
RadioCommunicationMarker' ?
)? @
,@ A

submissionB L
.L M
SelectedMarkerM [
)[ \
)\ ]
{ 
throw 
CreateRadioFault &
(& '+
RadioCommunicationFailureReason' F
.F G
InvalidSubmissionG X
)X Y
;Y Z
} *
EnsureMatchActionSessionBudget *
(* +
)+ ,
;, -)
EnsureMatchParticipantAllowed )
() *

submission* 4
.4 5
	LobbyCode5 >
,> ?
participantUserId@ Q
)Q R
;R S$
RadioCommunicationCommit $
result% +
=, -%
ExecuteRadioCommunication. G
(G H

submissionH R
,R S
participantUserIdT e
)e f
;f g
if 
( 
result 
. 
	Rejection  
!=! #'
RadioCommunicationRejection$ ?
.? @
None@ D
)D E
{ 
throw 
CreateRadioFault &
(& '$
RadioCommunicationMapper' ?
.? @
MapRejection@ L
(L M
resultM S
.S T
	RejectionT ]
)] ^
)^ _
;_ `
} 
if 
( 
result 
. 
HasStateChanged &
)& '
{ 
BroadcastToRoom 
(  

submission  *
.* +
	LobbyCode+ 4
,4 5
null6 :
,: ;
callback 
=> 
callback  (
.( )
OnMatchStateChanged) <
(< =
result= C
.C D&
CommittedMatchStateVersionD ^
)^ _
)_ `
;` a
} 
return   
new   *
RadioCommunicationConfirmation   5
{!! *
RadioCommunicationSubmissionId"" .
=""/ 0
result""1 7
.""7 8*
RadioCommunicationSubmissionId""8 V
,""V W&
CommittedMatchStateVersion## *
=##+ ,
result##- 3
.##3 4&
CommittedMatchStateVersion##4 N
}$$ 
;$$ 
}%% 	
private'' $
RadioCommunicationCommit'' (%
ExecuteRadioCommunication'') B
(''B C(
RadioCommunicationSubmission''C _

submission''` j
,''j k
int(( 
participantUserId(( !
)((! "
{)) 	$
RadioCommunicationCommit** $
result**% +
;**+ ,
try++ 
{,, 
result-- 
=-- 
_lobbyUseCase-- &
.--& '
Match--' ,
.--, -$
SubmitRadioCommunication--- E
(--E F$
RadioCommunicationMapper.. ,
..., -
MapSubmission..- :
(..: ;

submission..; E
)..E F
,..F G
participantUserId..H Y
)..Y Z
;..Z [
}// 
catch00 
(00 
ArgumentException00 $
ex00% '
)00' (
{11 
throw22 %
CreateMatchOperationFault22 /
(22/ 0
ex220 2
,222 3
nameof224 :
(22: ;+
RadioCommunicationFailureReason22; Z
.22Z [ 
OperationUnavailable22[ o
)22o p
)22p q
;22q r
}33 
catch44 
(44 %
InvalidOperationException44 ,
ex44- /
)44/ 0
{55 
throw66 %
CreateMatchOperationFault66 /
(66/ 0
ex660 2
,662 3
nameof664 :
(66: ;+
RadioCommunicationFailureReason66; Z
.66Z [ 
OperationUnavailable66[ o
)66o p
)66p q
;66q r
}77 
return88 
result88 
;88 
}99 	
private;; 
static;; 
FaultException;; %
<;;% &#
RadioCommunicationFault;;& =
>;;= >
CreateRadioFault;;? O
(;;O P+
RadioCommunicationFailureReason;;P o
reason;;p v
);;v w
{<< 	
return== 
new== 
FaultException== %
<==% &#
RadioCommunicationFault==& =
>=== >
(==> ?
new==? B#
RadioCommunicationFault==C Z
{==[ \
FailureReason==] j
===k l
reason==m s
}==t u
)==u v
;==v w
}>> 	
}?? 
}@@ Ï$
mC:\Users\oscar\source\repos\TrickTakingMissions\Server\Services\Services\Match\LobbyService.ObjectiveDraft.cs
	namespace 	
Services
 
. 
Services 
{ 
public		 

sealed		 
partial		 
class		 
LobbyService		  ,
{

 
private 
const 
int -
!MaximumMatchActionLobbyCodeLength ;
=< =
$num> @
;@ A
private 
const 
int /
#MaximumMatchActionMessagesPerSecond =
=> ?
$num@ A
;A B
private 
readonly 
object #
_matchActionRequestGate  7
=8 9
new: =
object> D
(D E
)E F
;F G
private $
MatchActionRequestBudget (%
_matchActionSessionBudget) B
;B C
public )
MissionObjectiveDraftDecision ,'
ProcessObjectiveDraftAction- H
(H I+
MissionObjectiveDraftSubmission +

submission, 6
,6 7
int8 ;
participantUserId< M
)M N
{ 	
if 
( 

submission 
== 
null "
||# %
string& ,
., -
IsNullOrWhiteSpace- ?
(? @

submission@ J
.J K
	LobbyCodeK T
)T U
||V X

submission 
. 
	LobbyCode $
.$ %
Length% +
>, --
!MaximumMatchActionLobbyCodeLength. O
)O P
{ 
throw 
new 
FaultException (
<( )
MatchAccessFault) 9
>9 :
(: ;
new; >
MatchAccessFault? O
{ 
FailureCode 
= "
FaultInvalidSubmission  6
}7 8
)8 9
;9 :
} *
EnsureMatchActionSessionBudget *
(* +
)+ ,
;, -)
EnsureMatchParticipantAllowed )
() *

submission* 4
.4 5
	LobbyCode5 >
,> ?
participantUserId@ Q
)Q R
;R S"
ObjectiveDraftDecision "
decision# +
=, -
_lobbyUseCase. ;
.; <
Match< A
.A B'
ProcessObjectiveDraftActionB ]
(] ^'
MissionObjectiveDraftMapper +
.+ ,
MapSubmission, 9
(9 :

submission: D
)D E
,E F
participantUserIdG X
)X Y
;Y Z
if 
( 
decision 
. 
HasStateChanged (
)( )
{ 
BroadcastToRoom 
(  

submission  *
.* +
	LobbyCode+ 4
,4 5
null6 :
,: ;
callback   
=>   
callback    (
.  ( )
OnMatchStateChanged  ) <
(  < =
decision  = E
.  E F&
CommittedMatchStateVersion  F `
)  ` a
)  a b
;  b c
}!! 
return"" '
MissionObjectiveDraftMapper"" .
."". /
MapDecision""/ :
("": ;
decision""; C
)""C D
;""D E
}## 	
private%% 
void%% *
EnsureMatchActionSessionBudget%% 3
(%%3 4
)%%4 5
{&& 	
lock'' 
('' #
_matchActionRequestGate'' )
)'') *
{(( $
MatchActionRequestBudget)) (
requestBudget))) 6
=))7 8$
MatchActionRequestLimits))9 Q
.))Q R
ConsumeWindow))R _
())_ `%
_matchActionSessionBudget** -
,**- ./
#MaximumMatchActionMessagesPerSecond**/ R
)**R S
;**S T
if++ 
(++ 
requestBudget++ !
==++" $
null++% )
)++) *
{,, 
throw-- 
new-- 
FaultException-- ,
<--, -
MatchAccessFault--- =
>--= >
(--> ?
new--? B
MatchAccessFault--C S
{.. 
FailureCode// #
=//$ %
nameof//& ,
(//, -0
$MissionObjectiveDraftRejectionReason//- Q
.//Q R
RequestLimitReached//R e
)//e f
}00 
)00 
;00 
}11 %
_matchActionSessionBudget22 )
=22* +
requestBudget22, 9
;229 :
}33 
}44 	
}55 
}66 ‚A
cC:\Users\oscar\source\repos\TrickTakingMissions\Server\Services\Mapping\RadioCommunicationMapper.cs
	namespace 	
Services
 
. 
Mapping 
{ 
internal 
static 
class $
RadioCommunicationMapper 2
{ 
internal		 
static		 %
RadioCommunicationRequest		 1
MapSubmission		2 ?
(		? @(
RadioCommunicationSubmission		@ \

submission		] g
)		g h
{

 	
	s_markers 
. 
TryGetValue !
(! "

submission" ,
., -
SelectedMarker- ;
,; <
out= @
RadioPublicMarkerA R
markerS Y
)Y Z
;Z [
return 
new %
RadioCommunicationRequest 0
{ 
	LobbyCode 
= 

submission &
.& '
	LobbyCode' 0
,0 1
MatchId 
= 

submission $
.$ %
MatchId% ,
,, -
MissionAttemptId  
=! "

submission# -
.- .
MissionAttemptId. >
,> ?*
RadioCommunicationSubmissionId .
=/ 0

submission1 ;
.; <*
RadioCommunicationSubmissionId< Z
,Z [%
ExpectedMatchStateVersion )
=* +

submission, 6
.6 7%
ExpectedMatchStateVersion7 P
,P Q
CardId 
= 

submission #
.# $
CardId$ *
,* +
SelectedMarker 
=  
marker! '
} 
; 
} 	
internal 
static +
RadioCommunicationFailureReason 7
MapRejection8 D
(D E'
RadioCommunicationRejectionE `
	rejectiona j
)j k
{ 	
return 

s_failures 
[ 
	rejection '
]' (
;( )
} 	
private 
static 
readonly 
IReadOnlyDictionary  3
<3 4$
RadioCommunicationMarker4 L
,L M
RadioPublicMarkerN _
>_ `
	s_markersa j
=k l
new 

Dictionary 
< $
RadioCommunicationMarker 3
,3 4
RadioPublicMarker5 F
>F G
{ 
{   $
RadioCommunicationMarker   *
.  * +
None  + /
,  / 0
RadioPublicMarker  1 B
.  B C
None  C G
}  H I
,  I J
{!! $
RadioCommunicationMarker!! *
.!!* +
Highest!!+ 2
,!!2 3
RadioPublicMarker!!4 E
.!!E F
Highest!!F M
}!!N O
,!!O P
{"" $
RadioCommunicationMarker"" *
.""* +
Only""+ /
,""/ 0
RadioPublicMarker""1 B
.""B C
Only""C G
}""H I
,""I J
{## $
RadioCommunicationMarker## *
.##* +
Lowest##+ 1
,##1 2
RadioPublicMarker##3 D
.##D E
Lowest##E K
}##L M
,##M N
{$$ $
RadioCommunicationMarker$$ *
.$$* +
Hidden$$+ 1
,$$1 2
RadioPublicMarker$$3 D
.$$D E
Hidden$$E K
}$$L M
}%% 
;%% 
private&& 
static&& 
readonly&& 
IReadOnlyDictionary&&  3
<&&3 4'
RadioCommunicationRejection&&4 O
,&&O P+
RadioCommunicationFailureReason'' +
>''+ ,

s_failures''- 7
=''8 9
new(( 

Dictionary(( 
<(( '
RadioCommunicationRejection(( 6
,((6 7+
RadioCommunicationFailureReason((8 W
>((W X
{)) 
{** '
RadioCommunicationRejection** -
.**- .
DisruptedUntilTrick**. A
,**A B+
RadioCommunicationFailureReason++ 3
.++3 4
DisruptedUntilTrick++4 G
}++H I
,++I J
{,, '
RadioCommunicationRejection,, -
.,,- .
SilencedByCaptain,,. ?
,,,? @+
RadioCommunicationFailureReason,,A `
.,,` a
SilencedByCaptain,,a r
},,s t
,,,t u
{-- '
RadioCommunicationRejection-- -
.--- .
None--. 2
,--2 3+
RadioCommunicationFailureReason--4 S
.--S T
None--T X
}--Y Z
,--Z [
{.. '
RadioCommunicationRejection.. -
...- .
InvalidSubmission... ?
,..? @+
RadioCommunicationFailureReason..A `
...` a
InvalidSubmission..a r
}..s t
,..t u
{// '
RadioCommunicationRejection// -
.//- .
MatchUnavailable//. >
,//> ?+
RadioCommunicationFailureReason//@ _
.//_ `
MatchUnavailable//` p
}//q r
,//r s
{00 '
RadioCommunicationRejection00 -
.00- .!
ParticipantNotAllowed00. C
,00C D+
RadioCommunicationFailureReason11 3
.113 4!
ParticipantNotAllowed114 I
}11J K
,11K L
{22 '
RadioCommunicationRejection22 -
.22- .
WrongMissionAttempt22. A
,22A B+
RadioCommunicationFailureReason33 3
.333 4
WrongMissionAttempt334 G
}33H I
,33I J
{44 '
RadioCommunicationRejection44 -
.44- .$
SubmissionIdentityReused44. F
,44F G+
RadioCommunicationFailureReason55 3
.553 4$
SubmissionIdentityReused554 L
}55M N
,55N O
{66 '
RadioCommunicationRejection66 -
.66- .
StaleMatchState66. =
,66= >+
RadioCommunicationFailureReason66? ^
.66^ _
StaleMatchState66_ n
}66o p
,66p q
{77 '
RadioCommunicationRejection77 -
.77- .&
MissionPreparationRequired77. H
,77H I+
RadioCommunicationFailureReason88 3
.883 4&
MissionPreparationRequired884 N
}88O P
,88P Q
{99 '
RadioCommunicationRejection99 -
.99- ."
MissionAttemptFinished99. D
,99D E+
RadioCommunicationFailureReason:: 3
.::3 4"
MissionAttemptFinished::4 J
}::K L
,::L M
{;; '
RadioCommunicationRejection;; -
.;;- .
CardNotInHand;;. ;
,;;; <+
RadioCommunicationFailureReason;;= \
.;;\ ]
CardNotInHand;;] j
};;k l
,;;l m
{<< '
RadioCommunicationRejection<< -
.<<- .!
SpecialCardNotAllowed<<. C
,<<C D+
RadioCommunicationFailureReason== 3
.==3 4!
SpecialCardNotAllowed==4 I
}==J K
,==K L
{>> '
RadioCommunicationRejection>> -
.>>- .*
AlreadyCommunicatedThisAttempt>>. L
,>>L M+
RadioCommunicationFailureReason?? 3
.??3 4*
AlreadyCommunicatedThisAttempt??4 R
}??S T
,??T U
{@@ '
RadioCommunicationRejection@@ -
.@@- ..
"CannotCommunicateDuringActiveTrick@@. P
,@@P Q+
RadioCommunicationFailureReasonAA 3
.AA3 4.
"CannotCommunicateDuringActiveTrickAA4 V
}AAW X
,AAX Y
{BB '
RadioCommunicationRejectionBB -
.BB- .'
InvalidTokenPositionForCardBB. I
,BBI J+
RadioCommunicationFailureReasonCC 3
.CC3 4'
InvalidTokenPositionForCardCC4 O
}CCP Q
,CCQ R
{DD '
RadioCommunicationRejectionDD -
.DD- .
RequestLimitReachedDD. A
,DDA B+
RadioCommunicationFailureReasonEE 3
.EE3 4
RequestLimitReachedEE4 G
}EEH I
,EEI J
{FF '
RadioCommunicationRejectionFF -
.FF- . 
OperationUnavailableFF. B
,FFB C+
RadioCommunicationFailureReasonGG 3
.GG3 4 
OperationUnavailableGG4 H
}GGI J
}HH 
;HH 
}II 
}JJ ñ?
fC:\Users\oscar\source\repos\TrickTakingMissions\Server\Services\Mapping\MissionObjectiveDraftMapper.cs
	namespace 	
Services
 
. 
Mapping 
{ 
internal 
static 
class '
MissionObjectiveDraftMapper 5
{ 
private		 
static		 
readonly		 
IReadOnlyDictionary		  3
<		3 4'
MissionObjectiveDraftAction		4 O
,		O P 
ObjectiveDraftAction		Q e
>		e f
	s_actions		g p
=		q r
new

 

Dictionary

 
<

 '
MissionObjectiveDraftAction

 6
,

6 7 
ObjectiveDraftAction

8 L
>

L M
{ 
{ '
MissionObjectiveDraftAction -
.- .
SelectObjective. =
,= > 
ObjectiveDraftAction? S
.S T
SelectObjectiveT c
}d e
,e f
{ '
MissionObjectiveDraftAction -
.- .
Pass. 2
,2 3 
ObjectiveDraftAction4 H
.H I
PassI M
}N O
} 
; 
private 
static 
readonly 
IReadOnlyDictionary  3
<3 4)
ObjectiveDraftRejectionReason4 Q
,Q R0
$MissionObjectiveDraftRejectionReason 0
>0 1
s_rejections2 >
=? @
new 

Dictionary 
< )
ObjectiveDraftRejectionReason 8
,8 90
$MissionObjectiveDraftRejectionReason: ^
>^ _
{ 
{ )
ObjectiveDraftRejectionReason /
./ 0
None0 4
,4 50
$MissionObjectiveDraftRejectionReason 8
.8 9
None9 =
}> ?
,? @
{ )
ObjectiveDraftRejectionReason /
./ 0
MatchUnavailable0 @
,@ A0
$MissionObjectiveDraftRejectionReason 8
.8 9
MatchUnavailable9 I
}J K
,K L
{ )
ObjectiveDraftRejectionReason /
./ 0!
ParticipantNotAllowed0 E
,E F0
$MissionObjectiveDraftRejectionReason 8
.8 9!
ParticipantNotAllowed9 N
}O P
,P Q
{ )
ObjectiveDraftRejectionReason /
./ 0
InvalidSubmission0 A
,A B0
$MissionObjectiveDraftRejectionReason 8
.8 9
InvalidSubmission9 J
}K L
,L M
{ )
ObjectiveDraftRejectionReason /
./ 0$
SubmissionIdentityReused0 H
,H I0
$MissionObjectiveDraftRejectionReason 8
.8 9$
SubmissionIdentityReused9 Q
}R S
,S T
{ )
ObjectiveDraftRejectionReason /
./ 0
StaleMatchState0 ?
,? @0
$MissionObjectiveDraftRejectionReason 8
.8 9
StaleMatchState9 H
}I J
,J K
{ )
ObjectiveDraftRejectionReason /
./ 0
NotDraftTurn0 <
,< =0
$MissionObjectiveDraftRejectionReason   8
.  8 9
NotDraftTurn  9 E
}  F G
,  G H
{!! )
ObjectiveDraftRejectionReason!! /
.!!/ 0 
ObjectiveUnavailable!!0 D
,!!D E0
$MissionObjectiveDraftRejectionReason"" 8
.""8 9 
ObjectiveUnavailable""9 M
}""N O
,""O P
{## )
ObjectiveDraftRejectionReason## /
.##/ 0 
PreparationCompleted##0 D
,##D E0
$MissionObjectiveDraftRejectionReason$$ 8
.$$8 9 
PreparationCompleted$$9 M
}$$N O
,$$O P
{%% )
ObjectiveDraftRejectionReason%% /
.%%/ 0
RequestLimitReached%%0 C
,%%C D0
$MissionObjectiveDraftRejectionReason&& 8
.&&8 9
RequestLimitReached&&9 L
}&&M N
,&&N O
{'' )
ObjectiveDraftRejectionReason'' /
.''/ 0 
UnsupportedDraftMode''0 D
,''D E0
$MissionObjectiveDraftRejectionReason(( 8
.((8 9 
UnsupportedDraftMode((9 M
}((N O
,((O P
{)) )
ObjectiveDraftRejectionReason)) /
.))/ 0
SubmissionExpired))0 A
,))A B0
$MissionObjectiveDraftRejectionReason** 8
.**8 9
SubmissionExpired**9 J
}**K L
}++ 
;++ 
internal-- 
static-- $
ObjectiveDraftSubmission-- 0
MapSubmission--1 >
(--> ?+
MissionObjectiveDraftSubmission--? ^

submission--_ i
)--i j
{.. 	
	s_actions// 
.// 
TryGetValue// !
(//! "

submission//" ,
.//, - 
ObjectiveDraftAction//- A
,//A B
out//C F 
ObjectiveDraftAction//G [
action//\ b
)//b c
;//c d
return00 
new00 $
ObjectiveDraftSubmission00 /
{11 
	LobbyCode22 
=22 

submission22 &
.22& '
	LobbyCode22' 0
,220 1
MatchId33 
=33 

submission33 $
.33$ %
MatchId33% ,
,33, -
MissionAttemptId44  
=44! "

submission44# -
.44- .
MissionAttemptId44. >
,44> ?&
ObjectiveDraftSubmissionId55 *
=55+ ,

submission55- 7
.557 8&
ObjectiveDraftSubmissionId558 R
,55R S%
ExpectedMatchStateVersion66 )
=66* +

submission66, 6
.666 7%
ExpectedMatchStateVersion667 P
,66P Q 
ObjectiveDraftAction77 $
=77% &
action77' -
,77- .&
SelectedMissionObjectiveId88 *
=88+ ,

submission88- 7
.887 8&
SelectedMissionObjectiveId888 R
}99 
;99 
}:: 	
internal<< 
static<< )
MissionObjectiveDraftDecision<< 5
MapDecision<<6 A
(<<A B"
ObjectiveDraftDecision<<B X
decision<<Y a
)<<a b
{== 	
bool>> 
hasKnownRejection>> "
=>># $
s_rejections>>% 1
.>>1 2
TryGetValue>>2 =
(>>= >
decision>>> F
.>>F G
RejectionReason>>G V
,>>V W
out?? 0
$MissionObjectiveDraftRejectionReason?? 8
	rejection??9 B
)??B C
;??C D
if@@ 
(@@ 
!@@ 
hasKnownRejection@@ "
)@@" #
{AA 
	rejectionBB 
=BB 0
$MissionObjectiveDraftRejectionReasonBB @
.BB@ A
InvalidSubmissionBBA R
;BBR S
}CC 
boolDD 

isAcceptedDD 
=DD 
hasKnownRejectionDD /
&&DD0 2
decisionDD3 ;
.DD; <

IsAcceptedDD< F
&&DDG I
decisionEE 
.EE 
RejectionReasonEE (
==EE) +)
ObjectiveDraftRejectionReasonEE, I
.EEI J
NoneEEJ N
;EEN O
returnFF 
newFF )
MissionObjectiveDraftDecisionFF 4
{GG &
ObjectiveDraftSubmissionIdHH *
=HH+ ,
decisionHH- 5
.HH5 6&
ObjectiveDraftSubmissionIdHH6 P
,HHP Q

IsAcceptedII 
=II 

isAcceptedII '
,II' (
RejectionReasonJJ 
=JJ  !
	rejectionJJ" +
,JJ+ ,&
CommittedMatchStateVersionKK *
=KK+ ,
decisionKK- 5
.KK5 6&
CommittedMatchStateVersionKK6 P
,KKP Q*
HasCompletedSelectionFreeCycleLL .
=LL/ 0

isAcceptedLL1 ;
&&LL< >
decisionLL? G
.LLG H*
HasCompletedSelectionFreeCycleLLH f
}MM 
;MM 
}NN 	
}OO 
}PP Ö!
gC:\Users\oscar\source\repos\TrickTakingMissions\Server\Services\Security\GuestParticipantCredentials.cs
	namespace 	
Services
 
. 
Security 
{ 
internal		 
static		 
class		 '
GuestParticipantCredentials		 5
{

 
private 
const 
int  
MaximumGuestSessions .
=/ 0
$num1 5
;5 6
private 
static 
readonly 

Dictionary  *
<* +
int+ .
,. /
string0 6
>6 7"
s_credentialsByGuestId8 N
=O P
newQ T

DictionaryU _
<_ `
int` c
,c d
stringe k
>k l
(l m
)m n
;n o
internal 
static 
void 
EnsureGuestAllowed /
(/ 0
int0 3
guestUserId4 ?
)? @
{ 	
string 
presentedCredential &
=' ( 
AccountSessionHeader) =
.= >*
ReadCurrentAccountSessionToken> \
(\ ]
)] ^
;^ _
lock 
( "
s_credentialsByGuestId (
)( )
{ 
if 
( "
s_credentialsByGuestId *
.* +
TryGetValue+ 6
(6 7
guestUserId7 B
,B C
outD G
stringH N
expectedCredentialO a
)a b
)b c
{ 
if 
( 
! 
string 
.  
Equals  &
(& '
expectedCredential' 9
,9 :
presentedCredential; N
,N O
StringComparisonP `
.` a
Ordinala h
)h i
)i j
{ 
throw 
new !
FaultException" 0
(0 1
$str1 H
)H I
;I J
} 
} 
else 
{ 
if 
( "
s_credentialsByGuestId .
.. /
Count/ 4
>=5 7 
MaximumGuestSessions8 L
)L M
{ 
throw 
new !
FaultException" 0
(0 1
$str1 G
)G H
;H I
} "
s_credentialsByGuestId   *
.  * +
Add  + .
(  . /
guestUserId  / :
,  : ;
CreateCredential  < L
(  L M
)  M N
)  N O
;  O P
}!! 
}"" 
}## 	
internal%% 
static%% 
string%% 
GetCredential%% ,
(%%, -
int%%- 0
guestUserId%%1 <
)%%< =
{&& 	
string'' 
guestCredential'' "
;''" #
lock(( 
((( "
s_credentialsByGuestId(( (
)((( )
{)) "
s_credentialsByGuestId** &
.**& '
TryGetValue**' 2
(**2 3
guestUserId**3 >
,**> ?
out**@ C
guestCredential**D S
)**S T
;**T U
}++ 
return,, 
guestCredential,, "
;,," #
}-- 	
private// 
static// 
string// 
CreateCredential// .
(//. /
)/// 0
{00 	
var11 
credentialBytes11 
=11  !
new11" %
byte11& *
[11* +
$num11+ -
]11- .
;11. /
using22 
(22 !
RandomNumberGenerator22 (
randomGenerator22) 8
=229 :!
RandomNumberGenerator22; P
.22P Q
Create22Q W
(22W X
)22X Y
)22Y Z
{33 
randomGenerator44 
.44  
GetBytes44  (
(44( )
credentialBytes44) 8
)448 9
;449 :
}55 
return66 
Convert66 
.66 
ToBase64String66 )
(66) *
credentialBytes66* 9
)669 :
;66: ;
}77 	
}88 
}99 ù
lC:\Users\oscar\source\repos\TrickTakingMissions\Server\Services\Services\Match\LobbyCallbackPresenceLease.cs
	namespace 	
Services
 
. 
Services 
{ 
internal 
sealed 
class &
LobbyCallbackPresenceLease 4
{ 
public 
long 
LastSeenTimestamp %
{& '
get( +
;+ ,
set- 0
;0 1
}2 3
public 
bool 
IsUnavailable !
{" #
get$ '
;' (
set) ,
;, -
}. /
}		 
}

 Õ¢
dC:\Users\oscar\source\repos\TrickTakingMissions\Server\Services\Services\Match\LobbyMatchPresence.cs
	namespace 	
Services
 
. 
Services 
{ 
public 

sealed 
class 
LobbyMatchPresence *
:+ ,%
IMatchParticipantPresence- F
{ 
private 
const 
string '
PresenceProbeFailedTemplate 8
=9 :
$str I
;I J
private 
static 
readonly  
ConditionalWeakTable  4
<4 5
ILobbyCallback5 C
,C D&
LobbyCallbackPresenceLeaseE _
>_ `
s_leasesa i
=j k
new  
ConditionalWeakTable $
<$ %
ILobbyCallback% 3
,3 4&
LobbyCallbackPresenceLease5 O
>O P
(P Q
)Q R
;R S
private 
static 
readonly 

Dictionary  *
<* +
string+ 1
,1 2
long3 7
>7 8
s_roomVersions9 G
=H I
new 

Dictionary 
< 
string !
,! "
long# '
>' (
(( )
StringComparer) 7
.7 8
OrdinalIgnoreCase8 I
)I J
;J K
private 
static 
long 
s_connectionVersion /
;/ 0
private 
readonly 
ILoggerService '
_logger( /
;/ 0
internal 
static 
object 
RegistryGate +
{, -
get. 1
;1 2
}3 4
=5 6
new7 :
object; A
(A B
)B C
;C D
public 
LobbyMatchPresence !
(! "
ILoggerService" 0
logger1 7
)7 8
{ 	
_logger 
= 
logger 
?? 
throw  %
new& )!
ArgumentNullException* ?
(? @
nameof@ F
(F G
loggerG M
)M N
)N O
;O P
} 	
internal!! 
static!! 
void!! "
MarkConnectionsChanged!! 3
(!!3 4
string!!4 :
	lobbyCode!!; D
)!!D E
{"" 	
lock## 
(## 
RegistryGate## 
)## 
{$$ 
s_connectionVersion%% #
++%%# %
;%%% &
s_roomVersions&& 
[&& 
	lobbyCode&& (
]&&( )
=&&* +
s_connectionVersion&&, ?
;&&? @
}'' 
}(( 	
internal** 
static** 
void** 

ForgetRoom** '
(**' (
string**( .
	lobbyCode**/ 8
)**8 9
{++ 	
lock,, 
(,, 
RegistryGate,, 
),, 
{-- 
s_roomVersions.. 
... 
Remove.. %
(..% &
	lobbyCode..& /
)../ 0
;..0 1
}// 
}00 	
internal22 
static22 
void22 
Touch22 "
(22" #
string22# )
	lobbyCode22* 3
,223 4
int225 8
participantUserId229 J
,22J K
string22L R
	sessionId22S \
)22\ ]
{33 	
lock44 
(44 
RegistryGate44 
)44 
{55 
ILobbyCallback66 
callback66 '
=66( )
LobbyService66* 6
.666 7
GetMatchCallbacks667 H
(66H I
	lobbyCode66I R
)66R S
.77 
FirstOrDefault77 #
(77# $
entry77$ )
=>77* ,
entry77- 2
.772 3
Key773 6
==777 9
participantUserId77: K
)77K L
.77L M
Value77M R
;77R S
if88 
(88 
callback88 
is88 
IContextChannel88  /
channel880 7
&&888 :
channel88; B
.88B C
	SessionId88C L
==88M O
	sessionId88P Y
)88Y Z
{99 
TouchCallback:: !
(::! "
	lobbyCode::" +
,::+ ,
callback::- 5
)::5 6
;::6 7
};; 
}<< 
}== 	
private?? 
static?? &
LobbyCallbackPresenceLease?? 1
GetLease??2 :
(??: ;
ILobbyCallback??; I
callback??J R
)??R S
{@@ 	
returnAA 
s_leasesAA 
.AA 
GetValueAA $
(AA$ %
callbackAA% -
,AA- .
_AA/ 0
=>AA1 3
CreatePresenceLeaseAA4 G
(AAG H
)AAH I
)AAI J
;AAJ K
}BB 	
privateDD 
staticDD &
LobbyCallbackPresenceLeaseDD 1
CreatePresenceLeaseDD2 E
(DDE F
)DDF G
{EE 	
returnFF 
newFF &
LobbyCallbackPresenceLeaseFF 1
{FF2 3
LastSeenTimestampFF4 E
=FFF G
	StopwatchFFH Q
.FFQ R
GetTimestampFFR ^
(FF^ _
)FF_ `
}FFa b
;FFb c
}GG 	
privateII 
staticII 
voidII 
TouchCallbackII )
(II) *
stringII* 0
	lobbyCodeII1 :
,II: ;
ILobbyCallbackII< J
callbackIIK S
)IIS T
{JJ 	&
LobbyCallbackPresenceLeaseKK &
leaseKK' ,
=KK- .
GetLeaseKK/ 7
(KK7 8
callbackKK8 @
)KK@ A
;KKA B
longLL 
	timestampLL 
=LL 
	StopwatchLL &
.LL& '
GetTimestampLL' 3
(LL3 4
)LL4 5
;LL5 6
ifMM 
(MM 
leaseMM 
.MM 
IsUnavailableMM #
||MM$ &
HasLeaseExpiredMM' 6
(MM6 7
leaseMM7 <
,MM< =
	timestampMM> G
)MMG H
)MMH I
{NN "
MarkConnectionsChangedOO &
(OO& '
	lobbyCodeOO' 0
)OO0 1
;OO1 2
}PP 
leaseQQ 
.QQ 
LastSeenTimestampQQ #
=QQ$ %
	timestampQQ& /
;QQ/ 0
leaseRR 
.RR 
IsUnavailableRR 
=RR  !
falseRR" '
;RR' (
}SS 	
publicUU $
MatchParticipantPresenceUU '
ReadPresenceUU( 4
(UU4 5
MatchPresenceQueryUU5 G
queryUUH M
)UUM N
{VV 	$
MatchParticipantPresenceWW $
presenceWW% -
;WW- .
lockXX 
(XX 
RegistryGateXX 
)XX 
{YY 

DictionaryZZ 
<ZZ 
intZZ 
,ZZ 
ILobbyCallbackZZ  .
>ZZ. /
	callbacksZZ0 9
=ZZ: ;
LobbyServiceZZ< H
.ZZH I
GetMatchCallbacksZZI Z
(ZZZ [
queryZZ[ `
.ZZ` a
	LobbyCodeZZa j
)ZZj k
.[[ 
ToDictionary[[ !
([[! "
entry[[" '
=>[[( *
entry[[+ 0
.[[0 1
Key[[1 4
,[[4 5
entry[[6 ;
=>[[< >
entry[[? D
.[[D E
Value[[E J
)[[J K
;[[K L
int\\ 
[\\ 
]\\ 
missingParticipants\\ )
=\\* +
query\\, 1
.\\1 2
ParticipantUserIds\\2 D
.\\D E
Where\\E J
(\\J K
participantUserId\\K \
=>\\] _
!]] 
HasLiveCallback]] $
(]]$ %
query]]% *
.]]* +
	LobbyCode]]+ 4
,]]4 5
	callbacks]]6 ?
,]]? @
participantUserId]]A R
)]]R S
)]]S T
.]]T U
ToArray]]U \
(]]\ ]
)]]] ^
;]]^ _
s_roomVersions^^ 
.^^ 
TryGetValue^^ *
(^^* +
query^^+ 0
.^^0 1
	LobbyCode^^1 :
,^^: ;
out^^< ?
long^^@ D
connectionVersion^^E V
)^^V W
;^^W X
presence__ 
=__ 
new__ $
MatchParticipantPresence__ 7
{`` 
ConnectionVersionaa %
=aa& '
connectionVersionaa( 9
,aa9 :%
MissingParticipantUserIdsbb -
=bb. /
missingParticipantsbb0 C
}cc 
;cc 
}dd 
returnee 
presenceee 
;ee 
}ff 	
privatehh 
statichh 
boolhh 
HasLiveCallbackhh +
(hh+ ,
stringhh, 2
	lobbyCodehh3 <
,hh< =
IDictionaryhh> I
<hhI J
inthhJ M
,hhM N
ILobbyCallbackhhO ]
>hh] ^
	callbackshh_ h
,hhh i
intii 
participantUserIdii !
)ii! "
{jj 	
boolkk 
isLivekk 
=kk 
falsekk 
;kk  
ifll 
(ll 
	callbacksll 
.ll 
TryGetValuell %
(ll% &
participantUserIdll& 7
,ll7 8
outll9 <
ILobbyCallbackll= K
callbackllL T
)llT U
&&llV X
callbackmm 
ismm 
IContextChannelmm +
channelmm, 3
&&mm4 6
channelmm7 >
.mm> ?
Statemm? D
==mmE G
CommunicationStatemmH Z
.mmZ [
Openedmm[ a
)mma b
{nn &
LobbyCallbackPresenceLeaseoo *
leaseoo+ 0
=oo1 2
GetLeaseoo3 ;
(oo; <
callbackoo< D
)ooD E
;ooE F
ifpp 
(pp 
HasLeaseExpiredpp #
(pp# $
leasepp$ )
,pp) *
	Stopwatchpp+ 4
.pp4 5
GetTimestamppp5 A
(ppA B
)ppB C
)ppC D
&&ppE G
!ppH I
leaseppI N
.ppN O
IsUnavailableppO \
)pp\ ]
{qq 
leaserr 
.rr 
IsUnavailablerr '
=rr( )
truerr* .
;rr. /"
MarkConnectionsChangedss *
(ss* +
	lobbyCodess+ 4
)ss4 5
;ss5 6
}tt 
isLiveuu 
=uu 
!uu 
leaseuu 
.uu  
IsUnavailableuu  -
;uu- .
}vv 
returnww 
isLiveww 
;ww 
}xx 	
privatezz 
staticzz 
boolzz 
HasLeaseExpiredzz +
(zz+ ,&
LobbyCallbackPresenceLeasezz, F
leasezzG L
,zzL M
longzzN R
	timestampzzS \
)zz\ ]
{{{ 	
return|| 
	timestamp|| 
-|| 
lease|| $
.||$ %
LastSeenTimestamp||% 6
>=||7 9
	Stopwatch}} 
.}} 
	Frequency}} #
*}}$ %#
MissionTransitionPolicy}}& =
.}}= > 
PresenceLeaseSeconds}}> R
;}}R S
}~~ 	
public
ÄÄ 
bool
ÄÄ 
ConfirmPresence
ÄÄ #
(
ÄÄ# $ 
MatchPresenceQuery
ÄÄ$ 6
query
ÄÄ7 <
)
ÄÄ< =
{
ÅÅ 	
KeyValuePair
ÇÇ 
<
ÇÇ 
int
ÇÇ 
,
ÇÇ 
ILobbyCallback
ÇÇ ,
>
ÇÇ, -
[
ÇÇ- .
]
ÇÇ. /
	callbacks
ÇÇ0 9
;
ÇÇ9 :
lock
ÉÉ 
(
ÉÉ 
RegistryGate
ÉÉ 
)
ÉÉ 
{
ÑÑ 
	callbacks
ÖÖ 
=
ÖÖ 
LobbyService
ÖÖ (
.
ÖÖ( )
GetMatchCallbacks
ÖÖ) :
(
ÖÖ: ;
query
ÖÖ; @
.
ÖÖ@ A
	LobbyCode
ÖÖA J
)
ÖÖJ K
.
ÜÜ 
Where
ÜÜ 
(
ÜÜ 
entry
ÜÜ  
=>
ÜÜ! #
query
ÜÜ$ )
.
ÜÜ) * 
ParticipantUserIds
ÜÜ* <
.
ÜÜ< =
Contains
ÜÜ= E
(
ÜÜE F
entry
ÜÜF K
.
ÜÜK L
Key
ÜÜL O
)
ÜÜO P
)
ÜÜP Q
.
ÜÜQ R
ToArray
ÜÜR Y
(
ÜÜY Z
)
ÜÜZ [
;
ÜÜ[ \
}
áá 
bool
àà 
hasAllResponses
àà  
=
àà! "
	callbacks
àà# ,
.
àà, -
Length
àà- 3
==
àà4 6
query
àà7 <
.
àà< = 
ParticipantUserIds
àà= O
.
ààO P
Length
ààP V
;
ààV W
foreach
ââ 
(
ââ 
KeyValuePair
ââ !
<
ââ! "
int
ââ" %
,
ââ% &
ILobbyCallback
ââ' 5
>
ââ5 6
entry
ââ7 <
in
ââ= ?
	callbacks
ââ@ I
)
ââI J
{
ää 
bool
ãã 
hasResponse
ãã  
=
ãã! "
ConfirmCallback
ãã# 2
(
ãã2 3
query
ãã3 8
,
ãã8 9
entry
ãã: ?
)
ãã? @
;
ãã@ A
hasAllResponses
åå 
=
åå  !
hasAllResponses
åå" 1
&&
åå2 4
hasResponse
åå5 @
;
åå@ A
}
çç &
MatchParticipantPresence
éé $
currentPresence
éé% 4
=
éé5 6
ReadPresence
éé7 C
(
ééC D
query
ééD I
)
ééI J
;
ééJ K
return
èè 
hasAllResponses
èè "
&&
èè# %
currentPresence
èè& 5
.
èè5 6'
MissingParticipantUserIds
èè6 O
.
èèO P
Length
èèP V
==
èèW Y
$num
èèZ [
&&
èè\ ^
currentPresence
êê 
.
êê  
ConnectionVersion
êê  1
==
êê2 4
query
êê5 :
.
êê: ;'
ExpectedConnectionVersion
êê; T
;
êêT U
}
ëë 	
private
ìì 
bool
ìì 
ConfirmCallback
ìì $
(
ìì$ % 
MatchPresenceQuery
ìì% 7
query
ìì8 =
,
ìì= >
KeyValuePair
ìì? K
<
ììK L
int
ììL O
,
ììO P
ILobbyCallback
ììQ _
>
ìì_ `
entry
ììa f
)
ììf g
{
îî 	
bool
ïï 
hasResponse
ïï 
=
ïï 
false
ïï $
;
ïï$ %
IContextChannel
ññ 
channel
ññ #
=
ññ$ %
entry
ññ& +
.
ññ+ ,
Value
ññ, 1
as
ññ2 4
IContextChannel
ññ5 D
;
ññD E
if
óó 
(
óó 
channel
óó 
!=
óó 
null
óó 
&&
óó  "
channel
óó# *
.
óó* +
State
óó+ 0
==
óó1 3 
CommunicationState
óó4 F
.
óóF G
Opened
óóG M
)
óóM N
{
òò 
TimeSpan
ôô 
originalTimeout
ôô (
=
ôô) *
channel
ôô+ 2
.
ôô2 3
OperationTimeout
ôô3 C
;
ôôC D
try
öö 
{
õõ 
channel
úú 
.
úú 
OperationTimeout
úú ,
=
úú- .
TimeSpan
úú/ 7
.
úú7 8
FromMilliseconds
úú8 H
(
úúH I%
MissionTransitionPolicy
ùù /
.
ùù/ 0.
 PresenceProbeTimeoutMilliseconds
ùù0 P
)
ùùP Q
;
ùùQ R
hasResponse
ûû 
=
ûû  !
entry
ûû" '
.
ûû' (
Value
ûû( -
.
ûû- .)
IsMatchParticipantConnected
ûû. I
(
ûûI J
query
ûûJ O
.
ûûO P
MatchId
ûûP W
,
ûûW X
query
ûûY ^
.
ûû^ _
MissionAttemptId
ûû_ o
)
ûûo p
;
ûûp q
}
üü 
catch
†† 
(
†† 
TimeoutException
†† '
ex
††( *
)
††* +
{
°° 
_logger
¢¢ 
.
¢¢ 
Warning
¢¢ #
(
¢¢# $)
PresenceProbeFailedTemplate
¢¢$ ?
,
¢¢? @
ex
¢¢A C
.
¢¢C D
GetType
¢¢D K
(
¢¢K L
)
¢¢L M
.
¢¢M N
Name
¢¢N R
)
¢¢R S
;
¢¢S T
}
££ 
catch
§§ 
(
§§ $
CommunicationException
§§ -
ex
§§. 0
)
§§0 1
{
•• 
_logger
¶¶ 
.
¶¶ 
Warning
¶¶ #
(
¶¶# $)
PresenceProbeFailedTemplate
¶¶$ ?
,
¶¶? @
ex
¶¶A C
.
¶¶C D
GetType
¶¶D K
(
¶¶K L
)
¶¶L M
.
¶¶M N
Name
¶¶N R
)
¶¶R S
;
¶¶S T
}
ßß 
finally
®® 
{
©© $
RestoreCallbackTimeout
™™ *
(
™™* +
channel
™™+ 2
,
™™2 3
originalTimeout
™™4 C
)
™™C D
;
™™D E
}
´´ 
}
¨¨ 
UpdateProbeLease
≠≠ 
(
≠≠ 
query
≠≠ "
.
≠≠" #
	LobbyCode
≠≠# ,
,
≠≠, -
entry
≠≠. 3
,
≠≠3 4
hasResponse
≠≠5 @
)
≠≠@ A
;
≠≠A B
return
ÆÆ 
hasResponse
ÆÆ 
;
ÆÆ 
}
ØØ 	
private
±± 
void
±± $
RestoreCallbackTimeout
±± +
(
±±+ ,
IContextChannel
±±, ;
channel
±±< C
,
±±C D
TimeSpan
±±E M
originalTimeout
±±N ]
)
±±] ^
{
≤≤ 	
try
≥≥ 
{
¥¥ 
if
µµ 
(
µµ 
channel
µµ 
.
µµ 
State
µµ !
==
µµ" $ 
CommunicationState
µµ% 7
.
µµ7 8
Opened
µµ8 >
)
µµ> ?
{
∂∂ 
channel
∑∑ 
.
∑∑ 
OperationTimeout
∑∑ ,
=
∑∑- .
originalTimeout
∑∑/ >
;
∑∑> ?
}
∏∏ 
}
ππ 
catch
∫∫ 
(
∫∫ '
InvalidOperationException
∫∫ ,
ex
∫∫- /
)
∫∫/ 0
{
ªª 
_logger
ºº 
.
ºº 
Warning
ºº 
(
ºº  )
PresenceProbeFailedTemplate
ºº  ;
,
ºº; <
ex
ºº= ?
.
ºº? @
GetType
ºº@ G
(
ººG H
)
ººH I
.
ººI J
Name
ººJ N
)
ººN O
;
ººO P
}
ΩΩ 
catch
ææ 
(
ææ $
CommunicationException
ææ )
ex
ææ* ,
)
ææ, -
{
øø 
_logger
¿¿ 
.
¿¿ 
Warning
¿¿ 
(
¿¿  )
PresenceProbeFailedTemplate
¿¿  ;
,
¿¿; <
ex
¿¿= ?
.
¿¿? @
GetType
¿¿@ G
(
¿¿G H
)
¿¿H I
.
¿¿I J
Name
¿¿J N
)
¿¿N O
;
¿¿O P
}
¡¡ 
}
¬¬ 	
private
ƒƒ 
static
ƒƒ 
void
ƒƒ 
UpdateProbeLease
ƒƒ ,
(
ƒƒ, -
string
ƒƒ- 3
	lobbyCode
ƒƒ4 =
,
ƒƒ= >
KeyValuePair
ƒƒ? K
<
ƒƒK L
int
ƒƒL O
,
ƒƒO P
ILobbyCallback
ƒƒQ _
>
ƒƒ_ `
entry
ƒƒa f
,
ƒƒf g
bool
≈≈ 
hasResponse
≈≈ 
)
≈≈ 
{
∆∆ 	
lock
«« 
(
«« 
RegistryGate
«« 
)
«« 
{
»» 
ILobbyCallback
…… 
currentCallback
…… .
=
……/ 0
LobbyService
……1 =
.
……= >
GetMatchCallbacks
……> O
(
……O P
	lobbyCode
……P Y
)
……Y Z
.
   
FirstOrDefault
   #
(
  # $
	candidate
  $ -
=>
  . 0
	candidate
  1 :
.
  : ;
Key
  ; >
==
  ? A
entry
  B G
.
  G H
Key
  H K
)
  K L
.
  L M
Value
  M R
;
  R S
if
ÀÀ 
(
ÀÀ 
ReferenceEquals
ÀÀ #
(
ÀÀ# $
currentCallback
ÀÀ$ 3
,
ÀÀ3 4
entry
ÀÀ5 :
.
ÀÀ: ;
Value
ÀÀ; @
)
ÀÀ@ A
)
ÀÀA B
{
ÃÃ 
if
ÕÕ 
(
ÕÕ 
hasResponse
ÕÕ #
)
ÕÕ# $
{
ŒŒ 
TouchCallback
œœ %
(
œœ% &
	lobbyCode
œœ& /
,
œœ/ 0
currentCallback
œœ1 @
)
œœ@ A
;
œœA B
}
–– 
else
—— 
{
““ 
GetLease
””  
(
””  !
currentCallback
””! 0
)
””0 1
.
””1 2
IsUnavailable
””2 ?
=
””@ A
true
””B F
;
””F G$
MarkConnectionsChanged
‘‘ .
(
‘‘. /
	lobbyCode
‘‘/ 8
)
‘‘8 9
;
‘‘9 :
}
’’ 
}
÷÷ 
}
◊◊ 
}
ÿÿ 	
}
ŸŸ 
}⁄⁄ Ï#
kC:\Users\oscar\source\repos\TrickTakingMissions\Server\Services\Services\Match\LobbyService.MissionRetry.cs
	namespace 	
Services
 
. 
Services 
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
LobbyService

  ,
{ 
private 
const 
string 2
&MissionRetryPreparationUnavailableCode C
=D E
$strF j
;j k
public  
MissionRetryDecision #
ConfirmMissionRetry$ 7
(7 8"
MissionRetrySubmission8 N

submissionO Y
,Y Z
int[ ^
participantUserId_ p
)p q
{ 	
if 
( 

submission 
== 
null "
||# %
string& ,
., -
IsNullOrWhiteSpace- ?
(? @

submission@ J
.J K
	LobbyCodeK T
)T U
||V X

submission 
. 
	LobbyCode $
.$ %
Length% +
>, --
!MaximumMatchActionLobbyCodeLength. O
)O P
{ 
throw 
new 
FaultException (
<( )
MatchAccessFault) 9
>9 :
(: ;
new; >
MatchAccessFault? O
{ 
FailureCode 
=  !"
FaultInvalidSubmission" 8
} 
) 
; 
} *
EnsureMatchActionSessionBudget *
(* +
)+ ,
;, -)
EnsureMatchParticipantAllowed )
() *

submission* 4
.4 5
	LobbyCode5 >
,> ?
participantUserId@ Q
)Q R
;R S$
MissionRetryConfirmation $
confirmation% 1
=2 3
ProcessMissionRetry4 G
(G H

submissionH R
,R S
participantUserIdT e
)e f
;f g
if 
( 
confirmation 
. 
HasStateChanged ,
), -
{ 
BroadcastToRoom 
(  

submission  *
.* +
	LobbyCode+ 4
,4 5
null6 :
,: ;
callback 
=> 
callback  (
.( )
OnMatchStateChanged) <
(< =
confirmation= I
.I J&
CommittedMatchStateVersionJ d
)d e
)e f
;f g
} 
return   
MissionRetryMapper   %
.  % &
MapDecision  & 1
(  1 2
confirmation  2 >
)  > ?
;  ? @
}!! 	
private## $
MissionRetryConfirmation## (
ProcessMissionRetry##) <
(##< ="
MissionRetrySubmission##= S

submission##T ^
,##^ _
int##` c
participantUserId##d u
)##u v
{$$ 	$
MissionRetryConfirmation%% $
confirmation%%% 1
;%%1 2
try&& 
{'' 
confirmation(( 
=(( 
_lobbyUseCase(( ,
.((, -
Match((- 2
.((2 3
ConfirmMissionRetry((3 F
(((F G
MissionRetryMapper)) &
.))& '

MapRequest))' 1
())1 2

submission))2 <
)))< =
,))= >
participantUserId))? P
)))P Q
;))Q R
}** 
catch++ 
(++ 
ArgumentException++ $
ex++% '
)++' (
{,, 
throw-- %
CreateMatchOperationFault-- /
(--/ 0
ex--0 2
,--2 32
&MissionRetryPreparationUnavailableCode--4 Z
)--Z [
;--[ \
}.. 
catch// 
(// %
InvalidOperationException// ,
ex//- /
)/// 0
{00 
throw11 %
CreateMatchOperationFault11 /
(11/ 0
ex110 2
,112 32
&MissionRetryPreparationUnavailableCode114 Z
)11Z [
;11[ \
}22 
catch33 
(33 "
CryptographicException33 )
ex33* ,
)33, -
{44 
throw55 %
CreateMatchOperationFault55 /
(55/ 0
ex550 2
,552 32
&MissionRetryPreparationUnavailableCode554 Z
)55Z [
;55[ \
}66 
return77 
confirmation77 
;77  
}88 	
}99 
}:: „-
]C:\Users\oscar\source\repos\TrickTakingMissions\Server\Services\Mapping\MissionRetryMapper.cs
	namespace 	
Services
 
. 
Mapping 
{ 
internal		 
static		 
class		 
MissionRetryMapper		 ,
{

 
private 
static 
readonly 
IReadOnlyDictionary  3
<3 4
RetryRejection4 B
,B C
GameplayD L
.L M'
MissionRetryRejectionReasonM h
>h i
s_rejectionReasons 
=  
new! $

Dictionary% /
</ 0
RetryRejection0 >
,> ?
Gameplay@ H
.H I'
MissionRetryRejectionReasonI d
>d e
{ 
{ 
RetryRejection  
.  !
None! %
,% &
Gameplay' /
./ 0'
MissionRetryRejectionReason0 K
.K L
NoneL P
}Q R
,R S
{ 
RetryRejection  
.  !
MatchUnavailable! 1
,1 2
Gameplay3 ;
.; <'
MissionRetryRejectionReason< W
.W X
MatchUnavailableX h
}i j
,j k
{ 
RetryRejection  
.  !!
ParticipantNotAllowed! 6
,6 7
Gameplay8 @
.@ A'
MissionRetryRejectionReasonA \
.\ ]!
ParticipantNotAllowed] r
}s t
,t u
{ 
RetryRejection  
.  !
InvalidSubmission! 2
,2 3
Gameplay4 <
.< ='
MissionRetryRejectionReason= X
.X Y
InvalidSubmissionY j
}k l
,l m
{ 
RetryRejection  
.  !$
SubmissionIdentityReused! 9
,9 :
Gameplay 
. '
MissionRetryRejectionReason 8
.8 9$
SubmissionIdentityReused9 Q
}R S
,S T
{ 
RetryRejection  
.  !
WrongMissionAttempt! 4
,4 5
Gameplay6 >
.> ?'
MissionRetryRejectionReason? Z
.Z [
WrongMissionAttempt[ n
}o p
,p q
{ 
RetryRejection  
.  !
RetryUnavailable! 1
,1 2
Gameplay3 ;
.; <'
MissionRetryRejectionReason< W
.W X
RetryUnavailableX h
}i j
,j k
{ 
RetryRejection  
.  !
StaleMatchState! 0
,0 1
Gameplay2 :
.: ;'
MissionRetryRejectionReason; V
.V W
StaleMatchStateW f
}g h
,h i
{ 
RetryRejection  
.  !
SubmissionExpired! 2
,2 3
Gameplay4 <
.< ='
MissionRetryRejectionReason= X
.X Y
SubmissionExpiredY j
}k l
,l m
{ 
RetryRejection  
.  !
RequestLimitReached! 4
,4 5
Gameplay6 >
.> ?'
MissionRetryRejectionReason? Z
.Z [
RequestLimitReached[ n
}o p
,p q
{ 
RetryRejection  
.  !
AttemptLimitReached! 4
,4 5
Gameplay6 >
.> ?'
MissionRetryRejectionReason? Z
.Z [
AttemptLimitReached[ n
}o p
} 
; 
internal 
static 
MissionRetryRequest +

MapRequest, 6
(6 7"
MissionRetrySubmission7 M

submissionN X
)X Y
{ 	
return 
new 
MissionRetryRequest *
{ 
	LobbyCode   
=   

submission   &
.  & '
	LobbyCode  ' 0
,  0 1
MatchId!! 
=!! 

submission!! $
.!!$ %
MatchId!!% ,
,!!, -
MissionAttemptId""  
=""! "

submission""# -
.""- .
MissionAttemptId"". >
,""> ?$
MissionRetrySubmissionId## (
=##) *

submission##+ 5
.##5 6$
MissionRetrySubmissionId##6 N
,##N O%
ExpectedMatchStateVersion$$ )
=$$* +

submission$$, 6
.$$6 7%
ExpectedMatchStateVersion$$7 P
}%% 
;%% 
}&& 	
internal(( 
static((  
MissionRetryDecision(( ,
MapDecision((- 8
(((8 9$
MissionRetryConfirmation((9 Q
confirmation((R ^
)((^ _
{)) 	
return** 
new**  
MissionRetryDecision** +
{++ $
MissionRetrySubmissionId,, (
=,,) *
confirmation,,+ 7
.,,7 8$
MissionRetrySubmissionId,,8 P
,,,P Q

IsAccepted-- 
=-- 
confirmation-- )
.--) *

IsAccepted--* 4
,--4 5
HasRestartedMission.. #
=..$ %
confirmation..& 2
...2 3
HasRestartedMission..3 F
,..F G&
CommittedMatchStateVersion// *
=//+ ,
confirmation//- 9
.//9 :&
CommittedMatchStateVersion//: T
,//T U#
CurrentMissionAttemptId00 '
=00( )
confirmation00* 6
.006 7#
CurrentMissionAttemptId007 N
,00N O
RejectionReason11 
=11  !
s_rejectionReasons11" 4
[114 5
confirmation115 A
.11A B
RejectionReason11B Q
]11Q R
}22 
;22 
}33 	
}44 
}55 ⁄9
dC:\Users\oscar\source\repos\TrickTakingMissions\Server\Services\Services\Match\LobbyService.Match.cs
	namespace 	
Services
 
. 
Services 
{ 
public 

sealed 
partial 
class 
LobbyService  ,
{ 
private		 
const		 
string		 ,
 MissionEvaluationUnavailableCode		 =
=		> ?
$str		@ ^
;		^ _
private

 
const

 
string

 -
!MatchOperationUnavailableTemplate

 >
=

? @
$str d
;d e
public 
PlayerMatchSnapshot "
GetPlayerMatch# 1
(1 2
string2 8
	lobbyCode9 B
,B C
intD G
participantUserIdH Y
)Y Z
{ 	)
EnsureMatchParticipantAllowed )
() *
	lobbyCode* 3
,3 4
participantUserId5 F
)F G
;G H
LobbyMatchPresence 
. 
Touch $
($ %
	lobbyCode% .
.. /
Trim/ 3
(3 4
)4 5
.5 6
ToUpperInvariant6 F
(F G
)G H
,H I
participantUserIdJ [
,[ \
OperationContext  
.  !
Current! (
?( )
.) *
	SessionId* 3
)3 4
;4 5
PlayerMatchSnapshot 
participantSnapshot  3
=4 5
_lobbyUseCase6 C
.C D
MatchD I
.I J
GetPlayerMatchJ X
(X Y
	lobbyCodeY b
,b c
participantUserIdd u
)u v
;v w
if 
( 
participantSnapshot #
==$ &
null' +
)+ ,
{ 
throw 
new 
FaultException (
<( )
MatchAccessFault) 9
>9 :
(: ;
new; >
MatchAccessFault? O
{ 
FailureCode 
= !
FaultMatchUnavailable  5
}6 7
)7 8
;8 9
} 
return 
participantSnapshot &
;& '
} 	
public 
CardPlayDecision 
PlayCard  (
(( )
CardPlaySubmission) ;
cardPlaySubmission< N
,N O
intP S
participantUserIdT e
)e f
{ 	
if 
( 
cardPlaySubmission "
==# %
null& *
||+ -
string. 4
.4 5
IsNullOrWhiteSpace5 G
(G H
cardPlaySubmissionH Z
.Z [
	LobbyCode[ d
)d e
||f h
cardPlaySubmission "
." #
	LobbyCode# ,
., -
Length- 3
>4 5
$num6 8
)8 9
{ 
throw   
new   
FaultException   (
<  ( )
MatchAccessFault  ) 9
>  9 :
(  : ;
new  ; >
MatchAccessFault  ? O
{!! 
FailureCode!! 
=!! "
FaultInvalidSubmission!!  6
}!!7 8
)!!8 9
;!!9 :
}"" )
EnsureMatchParticipantAllowed## )
(##) *
cardPlaySubmission##* <
.##< =
	LobbyCode##= F
,##F G
participantUserId##H Y
)##Y Z
;##Z [
CardPlayDecision$$ 
playDecision$$ )
;$$) *
try%% 
{&& 
playDecision'' 
='' 
_lobbyUseCase'' ,
.'', -
Match''- 2
.''2 3
PlayCard''3 ;
(''; <
cardPlaySubmission''< N
,''N O
participantUserId''P a
)''a b
;''b c
}(( 
catch)) 
()) 
ArgumentException)) $
ex))% '
)))' (
{** 
throw++ %
CreateMatchOperationFault++ /
(++/ 0
ex++0 2
,++2 3,
 MissionEvaluationUnavailableCode++4 T
)++T U
;++U V
},, 
catch-- 
(-- %
InvalidOperationException-- ,
ex--- /
)--/ 0
{.. 
throw// %
CreateMatchOperationFault// /
(/// 0
ex//0 2
,//2 3,
 MissionEvaluationUnavailableCode//4 T
)//T U
;//U V
}00 
if11 
(11 
playDecision11 
.11 

IsAccepted11 '
)11' (
{22 
BroadcastToRoom33 
(33  
cardPlaySubmission33  2
.332 3
	LobbyCode333 <
,33< =
null33> B
,33B C
callback44 
=>44 
callback44  (
.44( )
OnMatchStateChanged44) <
(44< =
playDecision44= I
.44I J&
CommittedMatchStateVersion44J d
)44d e
)44e f
;44f g
}55 
return66 
playDecision66 
;66  
}77 	
private99 
FaultException99 
<99 
MatchAccessFault99 /
>99/ 0%
CreateMatchOperationFault991 J
(99J K
	Exception99K T
ex99U W
,99W X
string99Y _
failureCode99` k
)99k l
{:: 	
_logger;; 
.;; 
Error;; 
(;; -
!MatchOperationUnavailableTemplate;; ;
,;;; <
failureCode;;= H
,;;H I
ex;;J L
.;;L M
GetType;;M T
(;;T U
);;U V
.;;V W
Name;;W [
);;[ \
;;;\ ]
return<< 
new<< 
FaultException<< %
<<<% &
MatchAccessFault<<& 6
><<6 7
(<<7 8
new<<8 ;
MatchAccessFault<<< L
{== 
FailureCode>> 
=>> 
failureCode>> )
}?? 
)?? 
;?? 
}@@ 	
privateBB 
voidBB )
EnsureMatchParticipantAllowedBB 2
(BB2 3
stringBB3 9
	lobbyCodeBB: C
,BBC D
intBBE H
participantUserIdBBI Z
)BBZ [
{CC 	
tryDD 
{EE -
!EnsureParticipantOperationAllowedFF 1
(FF1 2
participantUserIdFF2 C
)FFC D
;FFD E'
EnsureRegisteredRoomChannelGG +
(GG+ ,
	lobbyCodeGG, 5
,GG5 6
participantUserIdGG7 H
)GGH I
;GGI J
}HH 
catchII 
(II 
FaultExceptionII !
)II! "
{JJ 
_loggerKK 
.KK 
WarningKK 
(KK  '
MatchAccessRejectedTemplateKK  ;
,KK; <
participantUserIdKK= N
,KKN O
	lobbyCodeKKP Y
)KKY Z
;KKZ [
throwLL 
newLL 
FaultExceptionLL (
<LL( )
MatchAccessFaultLL) 9
>LL9 :
(LL: ;
newLL; >
MatchAccessFaultLL? O
{MM 
FailureCodeNN 
=NN  !&
FaultParticipantNotAllowedNN" <
}OO 
)OO 
;OO 
}PP 
}QQ 	
}RR 
}SS é
pC:\Users\oscar\source\repos\TrickTakingMissions\Server\Services\DataContracts\ProfileImages\ProfileImageFault.cs
	namespace 	
Services
 
. 
DataContracts  
{ 
[		 
DataContract		 
(		 
	Namespace		 
=		 
$str		 A
)		A B
]		B C
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
ProfileImageFault

 )
{ 
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public 
string 
FailureCode !
{" #
get$ '
;' (
set) ,
;, -
}. /
} 
} È^
mC:\Users\oscar\source\repos\TrickTakingMissions\Server\Services\Services\ProfileImages\ProfileImageService.cs
	namespace 	
Services
 
. 
Services 
{ 
[ 
ServiceBehavior 
( 
InstanceContextMode (
=) *
InstanceContextMode+ >
.> ?
Single? E
,E F
ConcurrencyModeG V
=W X
ConcurrencyModeY h
.h i
Multiplei q
,q r*
IncludeExceptionDetailInFaults &
=' (
false) .
). /
]/ 0
public 

sealed 
class 
ProfileImageService +
:, - 
IProfileImageService. B
{ 
private 
const 
string '
ProfileImageUpdatedTemplate 8
=9 :
$str <
;< =
private 
const 
string 1
%ProfileImageOperationRejectedTemplate B
=C D
$str O
;O P
private 
const 
string ;
/ProfileImageValidationUnderlyingFailureTemplate L
=M N
$str V
;V W
private 
const 
string 2
&ProfileImageStorageUnavailableTemplate C
=D E
$str 3
;3 4
private 
const 
string 7
+ProfileImageStoragePermissionDeniedTemplate H
=I J
$str   :
;  : ;
private!! 
const!! 
string!! 3
'ProfileImageMetadataUnavailableTemplate!! D
=!!E F
$str"" 4
;""4 5
private## 
const## 
string## ,
 ProfileImageOperationFaultReason## =
=##> ?
$str$$ A
;$$A B
private&& 
readonly&& 
ProfileImageUseCase&& , 
_profileImageUseCase&&- A
;&&A B
private'' 
readonly''  
IAccountAccessPolicy'' - 
_accountAccessPolicy''. B
;''B C
private(( 
readonly(( 
ILoggerService(( '
_logger((( /
;((/ 0
private)) 
readonly)) %
ProfileImageSubscriptions)) 2
_subscriptions))3 A
;))A B
public++ 
ProfileImageService++ "
(++" #
ProfileImageUseCase++# 6
profileImageUseCase++7 J
,++J K 
IAccountAccessPolicy,,  
accountAccessPolicy,,! 4
,,,4 5
ILoggerService,,6 D
logger,,E K
),,K L
{-- 	 
_profileImageUseCase..  
=..! "
profileImageUseCase..# 6
??..7 9
throw..: ?
new..@ C!
ArgumentNullException..D Y
(..Y Z
nameof..Z `
(..` a
profileImageUseCase..a t
)..t u
)..u v
;..v w 
_accountAccessPolicy//  
=//! "
accountAccessPolicy//# 6
??//7 9
throw//: ?
new//@ C!
ArgumentNullException//D Y
(//Y Z
nameof//Z `
(//` a
accountAccessPolicy//a t
)//t u
)//u v
;//v w
_logger00 
=00 
logger00 
??00 
throw00  %
new00& )!
ArgumentNullException00* ?
(00? @
nameof00@ F
(00F G
logger00G M
)00M N
)00N O
;00O P
_subscriptions11 
=11 
new11  %
ProfileImageSubscriptions11! :
(11: ;
logger11; A
)11A B
;11B C
}22 	
public44 '
PlayerProfileImageReference44 *!
ChangeOwnProfileImage44+ @
(44@ A
ProfileImageUpload44A S
profileImageUpload44T f
)44f g
{55 	
return66 !
ExecuteImageOperation66 (
(66( )
(66) *
)66* +
=>66, .+
ChangeAuthenticatedProfileImage66/ N
(66N O
profileImageUpload66O a
)66a b
)66b c
;66c d
}77 	
private99 '
PlayerProfileImageReference99 ++
ChangeAuthenticatedProfileImage99, K
(99K L
ProfileImageUpload99L ^
upload99_ e
)99e f
{:: 	
int;; 
accountUserId;; 
=;;  
_accountAccessPolicy;;  4
.;;4 5'
ResolveAllowedAccountUserId;;5 P
(;;P Q 
AccountSessionHeader<< $
.<<$ %*
ReadCurrentAccountSessionToken<<% C
(<<C D
)<<D E
)<<E F
;<<F G"
PlayerProfileImageData== "
changedImage==# /
===0 1 
_profileImageUseCase==2 F
.==F G!
ChangeOwnProfileImage==G \
(==\ ]
accountUserId>> 
,>> 
upload>> %
?>>% &
.>>& '%
SelectedProfileImageBytes>>' @
)>>@ A
;>>A B
_logger?? 
.?? 
Information?? 
(??  '
ProfileImageUpdatedTemplate??  ;
,??; <
accountUserId??= J
)??J K
;??K L
_subscriptions@@ 
.@@ 
Publish@@ "
(@@" #
accountUserId@@# 0
)@@0 1
;@@1 2
returnAA 
MapProfileImageAA "
(AA" #
changedImageAA# /
)AA/ 0
;AA0 1
}BB 	
publicDD '
PlayerProfileImageReferenceDD *
[DD* +
]DD+ ,"
GetPlayerProfileImagesDD- C
(DDC D
intDDD G
[DDG H
]DDH I
profileOwnerUserIdsDDJ ]
)DD] ^
{EE 	
returnFF !
ExecuteImageOperationFF (
(FF( )
(FF) *
)FF* +
=>FF, . 
_profileImageUseCaseFF/ C
.FFC D"
GetPlayerProfileImagesFFD Z
(FFZ [
profileOwnerUserIdsFF[ n
)FFn o
.GG 
SelectGG 
(GG 
MapProfileImageGG '
)GG' (
.GG( )
ToArrayGG) 0
(GG0 1
)GG1 2
)GG2 3
;GG3 4
}HH 	
publicJJ 
ProfileImageContentJJ "
GetProfileImageJJ# 2
(JJ2 3
GuidJJ3 7
profileImageIdJJ8 F
)JJF G
{KK 	
returnLL !
ExecuteImageOperationLL (
(LL( )
(LL) *
)LL* +
=>LL, .
newLL/ 2
ProfileImageContentLL3 F
{MM 
ProfileImageIdNN 
=NN  
profileImageIdNN! /
,NN/ 0'
NormalizedProfileImageBytesOO +
=OO, - 
_profileImageUseCaseOO. B
.OOB C
GetProfileImageOOC R
(OOR S
profileImageIdOOS a
)OOa b
}PP 
)PP 
;PP 
}QQ 	
publicSS 
voidSS (
SubscribeProfileImageChangesSS 0
(SS0 1
intSS1 4
[SS4 5
]SS5 6
profileOwnerUserIdsSS7 J
)SSJ K
{TT 	!
ExecuteImageOperationUU !
(UU! "
(UU" #
)UU# $
=>UU% ')
IsImageSubscriptionRegisteredUU( E
(UUE F
profileOwnerUserIdsUUF Y
)UUY Z
)UUZ [
;UU[ \
}VV 	
privateXX 
boolXX )
IsImageSubscriptionRegisteredXX 2
(XX2 3
intXX3 6
[XX6 7
]XX7 8
profileOwnerUserIdsXX9 L
)XXL M
{YY 	
_subscriptionsZZ 
.ZZ 
	SubscribeZZ $
(ZZ$ %
profileOwnerUserIdsZZ% 8
)ZZ8 9
;ZZ9 :
return[[ 
true[[ 
;[[ 
}\\ 	
private^^ 
T^^ !
ExecuteImageOperation^^ '
<^^' (
T^^( )
>^^) *
(^^* +
Func^^+ /
<^^/ 0
T^^0 1
>^^1 2
imageOperation^^3 A
)^^A B
{__ 	
T`` 
result`` 
;`` 
tryaa 
{bb 
resultcc 
=cc 
imageOperationcc '
(cc' (
)cc( )
;cc) *
}dd 
catchee 
(ee !
ProfileImageExceptionee (
exee) +
)ee+ ,
{ff 
_loggergg 
.gg 
Warninggg 
(gg  1
%ProfileImageOperationRejectedTemplategg  E
,ggE F
exggG I
.ggI J
FailureCodeggJ U
)ggU V
;ggV W
ifhh 
(hh 
exhh 
.hh 
InnerExceptionhh %
!=hh& (
nullhh) -
)hh- .
{ii 
_loggerjj 
.jj 
Errorjj !
(jj! "
exjj" $
,jj$ %;
/ProfileImageValidationUnderlyingFailureTemplatejj& U
)jjU V
;jjV W
}kk 
throwll 
CreateImageFaultll &
(ll& '
exll' )
.ll) *
FailureCodell* 5
)ll5 6
;ll6 7
}mm 
catchnn 
(nn 
IOExceptionnn 
exnn !
)nn! "
{oo 
_loggerpp 
.pp 
Errorpp 
(pp 
expp  
,pp  !2
&ProfileImageStorageUnavailableTemplatepp" H
)ppH I
;ppI J
throwqq 
CreateImageFaultqq &
(qq& '$
ProfileImageFailureCodesqq' ?
.qq? @#
ImageStorageUnavailableqq@ W
)qqW X
;qqX Y
}rr 
catchss 
(ss '
UnauthorizedAccessExceptionss .
exss/ 1
)ss1 2
{tt 
_loggeruu 
.uu 
Erroruu 
(uu 
exuu  
,uu  !7
+ProfileImageStoragePermissionDeniedTemplateuu" M
)uuM N
;uuN O
throwvv 
CreateImageFaultvv &
(vv& '$
ProfileImageFailureCodesvv' ?
.vv? @#
ImageStorageUnavailablevv@ W
)vvW X
;vvX Y
}ww 
catchxx 
(xx %
InvalidOperationExceptionxx ,
exxx- /
)xx/ 0
{yy 
_loggerzz 
.zz 
Errorzz 
(zz 
exzz  
,zz  !3
'ProfileImageMetadataUnavailableTemplatezz" I
)zzI J
;zzJ K
throw{{ 
CreateImageFault{{ &
({{& '$
ProfileImageFailureCodes{{' ?
.{{? @#
ImageStorageUnavailable{{@ W
){{W X
;{{X Y
}|| 
return}} 
result}} 
;}} 
}~~ 	
private
ÄÄ 
static
ÄÄ )
PlayerProfileImageReference
ÄÄ 2
MapProfileImage
ÄÄ3 B
(
ÄÄB C$
PlayerProfileImageData
ÄÄC Y
image
ÄÄZ _
)
ÄÄ_ `
{
ÅÅ 	
return
ÇÇ 
new
ÇÇ )
PlayerProfileImageReference
ÇÇ 2
{
ÉÉ  
ProfileOwnerUserId
ÑÑ "
=
ÑÑ# $
image
ÑÑ% *
.
ÑÑ* + 
ProfileOwnerUserId
ÑÑ+ =
,
ÑÑ= >
ProfileImageId
ÖÖ 
=
ÖÖ  
image
ÖÖ! &
.
ÖÖ& '
ProfileImageId
ÖÖ' 5
}
ÜÜ 
;
ÜÜ 
}
áá 	
private
ââ 
static
ââ 
FaultException
ââ %
<
ââ% &
ProfileImageFault
ââ& 7
>
ââ7 8
CreateImageFault
ââ9 I
(
ââI J
string
ââJ P
failureCode
ââQ \
)
ââ\ ]
{
ää 	
return
ãã 
new
ãã 
FaultException
ãã %
<
ãã% &
ProfileImageFault
ãã& 7
>
ãã7 8
(
ãã8 9
new
ãã9 <
ProfileImageFault
ãã= N
{
ããO P
FailureCode
ããQ \
=
ãã] ^
failureCode
ãã_ j
}
ããk l
,
ããl m
new
åå 
FaultReason
åå 
(
åå  .
 ProfileImageOperationFaultReason
åå  @
)
åå@ A
)
ååA B
;
ååB C
}
çç 	
}
éé 
}èè Ê
rC:\Users\oscar\source\repos\TrickTakingMissions\Server\Services\DataContracts\ProfileImages\ProfileImageContent.cs
	namespace 	
Services
 
. 
DataContracts  
{ 
[		 
DataContract		 
(		 
	Namespace		 
=		 
$str		 A
)		A B
]		B C
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
ProfileImageContent

 +
{ 
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public 
Guid 
ProfileImageId "
{# $
get% (
;( )
set* -
;- .
}/ 0
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public 
byte 
[ 
] '
NormalizedProfileImageBytes 1
{2 3
get4 7
;7 8
set9 <
;< =
}> ?
} 
} 
oC:\Users\oscar\source\repos\TrickTakingMissions\Server\Services\Contracts\ProfileImages\IProfileImageService.cs
	namespace 	
Services
 
. 
	Contracts 
{ 
[

 
ServiceContract

 
(

 
CallbackContract

 %
=

& '
typeof

( .
(

. /!
IProfileImageCallback

/ D
)

D E
,

E F
	Namespace 
= 
$str 7
)7 8
]8 9
public 

	interface  
IProfileImageService )
{ 
[ 	
OperationContract	 
] 
[ 	
FaultContract	 
( 
typeof 
( 
ProfileImageFault /
)/ 0
)0 1
]1 2'
PlayerProfileImageReference #!
ChangeOwnProfileImage$ 9
(9 :
ProfileImageUpload: L
profileImageUploadM _
)_ `
;` a
[ 	
OperationContract	 
] 
[ 	
FaultContract	 
( 
typeof 
( 
ProfileImageFault /
)/ 0
)0 1
]1 2'
PlayerProfileImageReference #
[# $
]$ %"
GetPlayerProfileImages& <
(< =
int= @
[@ A
]A B
profileOwnerUserIdsC V
)V W
;W X
[ 	
OperationContract	 
] 
[ 	
FaultContract	 
( 
typeof 
( 
ProfileImageFault /
)/ 0
)0 1
]1 2
ProfileImageContent 
GetProfileImage +
(+ ,
Guid, 0
profileImageId1 ?
)? @
;@ A
[ 	
OperationContract	 
] 
[ 	
FaultContract	 
( 
typeof 
( 
ProfileImageFault /
)/ 0
)0 1
]1 2
void (
SubscribeProfileImageChanges )
() *
int* -
[- .
]. /
profileOwnerUserIds0 C
)C D
;D E
} 
} Œ
zC:\Users\oscar\source\repos\TrickTakingMissions\Server\Services\DataContracts\ProfileImages\PlayerProfileImageReference.cs
	namespace 	
Services
 
. 
DataContracts  
{ 
[		 
DataContract		 
(		 
	Namespace		 
=		 
$str		 A
)		A B
]		B C
public

 

sealed

 
class

 '
PlayerProfileImageReference

 3
{ 
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public 
int 
ProfileOwnerUserId %
{& '
get( +
;+ ,
set- 0
;0 1
}2 3
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public 
Guid 
ProfileImageId "
{# $
get% (
;( )
set* -
;- .
}/ 0
} 
} Ù
pC:\Users\oscar\source\repos\TrickTakingMissions\Server\Services\Contracts\ProfileImages\IProfileImageCallback.cs
	namespace 	
Services
 
. 
	Contracts 
{ 
public 

	interface !
IProfileImageCallback *
{		 
[

 	
OperationContract

	 
(

 
IsOneWay

 #
=

$ %
true

& *
)

* +
]

+ ,
void '
OnPlayerProfileImageChanged (
(( )
int) ,
profileOwnerUserId- ?
)? @
;@ A
} 
} ÷m
sC:\Users\oscar\source\repos\TrickTakingMissions\Server\Services\Services\ProfileImages\ProfileImageSubscriptions.cs
	namespace 	
Services
 
. 
Services 
{ 
internal 
sealed 
class %
ProfileImageSubscriptions 3
{ 
private 
const 
int  
MaximumSubscriptions .
=/ 0
$num1 4
;4 5
private 
const 
string 4
(ProfileImageNotificationDeferredTemplate E
=F G
$str K
;K L
private 
const 
string 6
*ProfileImageSubscriberDisconnectedTemplate G
=H I
$str L
;L M
private 
const 
string 6
*ProfileImageCallbackChannelFaultedTemplate G
=H I
$str Y
;Y Z
private 
const 
string 2
&ProfileImageSubscriberTimedOutTemplate C
=D E
$str I
;I J
private 
readonly 
object 
_subscriptionLock  1
=2 3
new4 7
object8 >
(> ?
)? @
;@ A
private 
readonly 

Dictionary #
<# $
string$ *
,* +
Subscription, 8
>8 9
_subscriptions: H
=I J
newK N

DictionaryO Y
<Y Z
stringZ `
,` a
Subscriptionb n
>n o
(o p
)p q
;q r
private 
readonly 
ILoggerService '
_logger( /
;/ 0
private 
readonly 
HashSet  
<  !
int! $
>$ %
_pendingOwnerIds& 6
=7 8
new9 <
HashSet= D
<D E
intE H
>H I
(I J
)J K
;K L
private 
bool 
_isDeliveryRunning '
;' (
internal   %
ProfileImageSubscriptions   *
(  * +
ILoggerService  + 9
logger  : @
)  @ A
{!! 	
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
}## 	
internal%% 
void%% 
	Subscribe%% 
(%%  
int%%  #
[%%# $
]%%$ %
profileOwnerUserIds%%& 9
)%%9 :
{&& 	
if'' 
('' 
profileOwnerUserIds'' #
==''$ &
null''' +
||'', .
profileOwnerUserIds''/ B
.''B C
Length''C I
>''J K
ProfileImageLimits''L ^
.''^ _#
MaximumRequestedPlayers''_ v
)''v w
{(( 
throw)) 
new)) !
ProfileImageException)) /
())/ 0$
ProfileImageFailureCodes))0 H
.))H I
InvalidImageRequest))I \
)))\ ]
;))] ^
}** 
OperationContext++ 
context++ $
=++% &
OperationContext++' 7
.++7 8
Current++8 ?
;++? @
string,, 
	sessionId,, 
=,, 
context,, &
.,,& '
	SessionId,,' 0
;,,0 1!
IProfileImageCallback-- !
callback--" *
=--+ ,
context--- 4
.--4 5
GetCallbackChannel--5 G
<--G H!
IProfileImageCallback--H ]
>--] ^
(--^ _
)--_ `
;--` a
lock.. 
(.. 
_subscriptionLock.. #
)..# $
{// 
bool00 
isNewSubscription00 &
=00' (
!00) *
_subscriptions00* 8
.008 9
ContainsKey009 D
(00D E
	sessionId00E N
)00N O
;00O P
if11 
(11 
isNewSubscription11 %
&&11& (
_subscriptions11) 7
.117 8
Count118 =
>=11> @ 
MaximumSubscriptions11A U
)11U V
{22 
throw33 
new33 !
ProfileImageException33 3
(333 4$
ProfileImageFailureCodes334 L
.33L M
ImageServiceBusy33M ]
)33] ^
;33^ _
}44 
_subscriptions55 
[55 
	sessionId55 (
]55( )
=55* +
new55, /
Subscription550 <
(55< =
callback55= E
,55E F
profileOwnerUserIds55G Z
)55Z [
;55[ \
if66 
(66 
isNewSubscription66 %
)66% &
{77 
context88 
.88 
Channel88 #
.88# $
Closed88$ *
+=88+ -
(88. /
_88/ 0
,880 1
__882 4
)884 5
=>886 8
RemoveSubscription889 K
(88K L
	sessionId88L U
)88U V
;88V W
context99 
.99 
Channel99 #
.99# $
Faulted99$ +
+=99, .
(99/ 0
_990 1
,991 2
__993 5
)995 6
=>997 9
RemoveSubscription99: L
(99L M
	sessionId99M V
)99V W
;99W X
}:: 
};; 
}<< 	
internal>> 
void>> 
Publish>> 
(>> 
int>> !
profileOwnerUserId>>" 4
)>>4 5
{?? 	
bool@@ 
shouldStartDelivery@@ $
=@@% &
false@@' ,
;@@, -
lockAA 
(AA 
_subscriptionLockAA #
)AA# $
{BB 
ifCC 
(CC 
_pendingOwnerIdsCC $
.CC$ %
CountCC% *
<CC+ ,
ProfileImageLimitsCC- ?
.CC? @#
MaximumRequestedPlayersCC@ W
)CCW X
{DD 
_pendingOwnerIdsEE $
.EE$ %
AddEE% (
(EE( )
profileOwnerUserIdEE) ;
)EE; <
;EE< =
ifFF 
(FF 
!FF 
_isDeliveryRunningFF +
)FF+ ,
{GG 
_isDeliveryRunningHH *
=HH+ ,
trueHH- 1
;HH1 2
shouldStartDeliveryII +
=II, -
trueII. 2
;II2 3
}JJ 
}KK 
elseLL 
{MM 
_loggerNN 
.NN 
WarningNN #
(NN# $4
(ProfileImageNotificationDeferredTemplateNN$ L
)NNL M
;NNM N
}OO 
}PP 
ifQQ 
(QQ 
shouldStartDeliveryQQ #
)QQ# $
{RR 

ThreadPoolSS 
.SS 
QueueUserWorkItemSS ,
(SS, -'
DeliverPendingNotificationsSS- H
)SSH I
;SSI J
}TT 
}UU 	
privateWW 
voidWW '
DeliverPendingNotificationsWW 0
(WW0 1
objectWW1 7
_WW8 9
)WW9 :
{XX 	
intYY 
profileOwnerUserIdYY "
;YY" #
whileZZ 
(ZZ /
#HasDequeuedPendingProfileImageOwnerZZ 6
(ZZ6 7
outZZ7 :
profileOwnerUserIdZZ; M
)ZZM N
)ZZN O
{[[  
NotifyAllSubscribers\\ $
(\\$ %
profileOwnerUserId\\% 7
)\\7 8
;\\8 9
}]] 
}^^ 	
private`` 
bool`` /
#HasDequeuedPendingProfileImageOwner`` 8
(``8 9
out``9 <
int``= @
profileOwnerUserId``A S
)``S T
{aa 	
profileOwnerUserIdbb 
=bb  
$numbb! "
;bb" #
boolcc 
hasPendingOwnercc  
;cc  !
lockdd 
(dd 
_subscriptionLockdd #
)dd# $
{ee 
hasPendingOwnerff 
=ff  !
_pendingOwnerIdsff" 2
.ff2 3
Countff3 8
>ff9 :
$numff; <
;ff< =
ifgg 
(gg 
hasPendingOwnergg #
)gg# $
{hh 
profileOwnerUserIdii &
=ii' (
_pendingOwnerIdsii) 9
.ii9 :
Firstii: ?
(ii? @
)ii@ A
;iiA B
_pendingOwnerIdsjj $
.jj$ %
Removejj% +
(jj+ ,
profileOwnerUserIdjj, >
)jj> ?
;jj? @
}kk 
elsell 
{mm 
_isDeliveryRunningnn &
=nn' (
falsenn) .
;nn. /
}oo 
}pp 
returnqq 
hasPendingOwnerqq "
;qq" #
}rr 	
privatett 
voidtt  
NotifyAllSubscriberstt )
(tt) *
inttt* -
profileOwnerUserIdtt. @
)tt@ A
{uu 	
KeyValuePairvv 
<vv 
stringvv 
,vv  
Subscriptionvv! -
>vv- .
[vv. /
]vv/ 0
subscribersvv1 <
;vv< =
lockww 
(ww 
_subscriptionLockww #
)ww# $
{xx 
subscribersyy 
=yy 
_subscriptionsyy ,
.yy, -
Whereyy- 2
(yy2 3
pairyy3 7
=>yy8 :
pairyy; ?
.yy? @
Valueyy@ E
.yyE F
OwnerIdsyyF N
.yyN O
ContainsyyO W
(yyW X
profileOwnerUserIdyyX j
)yyj k
)yyk l
.yyl m
ToArrayyym t
(yyt u
)yyu v
;yyv w
}zz 
foreach{{ 
({{ 
KeyValuePair{{ !
<{{! "
string{{" (
,{{( )
Subscription{{* 6
>{{6 7

subscriber{{8 B
in{{C E
subscribers{{F Q
){{Q R
{|| 
NotifySubscriber}}  
(}}  !

subscriber}}! +
,}}+ ,
profileOwnerUserId}}- ?
)}}? @
;}}@ A
}~~ 
} 	
private
ÅÅ 
void
ÅÅ 
NotifySubscriber
ÅÅ %
(
ÅÅ% &
KeyValuePair
ÅÅ& 2
<
ÅÅ2 3
string
ÅÅ3 9
,
ÅÅ9 :
Subscription
ÅÅ; G
>
ÅÅG H

subscriber
ÅÅI S
,
ÅÅS T
int
ÅÅU X 
profileOwnerUserId
ÅÅY k
)
ÅÅk l
{
ÇÇ 	
try
ÉÉ 
{
ÑÑ 

subscriber
ÖÖ 
.
ÖÖ 
Value
ÖÖ  
.
ÖÖ  !
Callback
ÖÖ! )
.
ÖÖ) *)
OnPlayerProfileImageChanged
ÖÖ* E
(
ÖÖE F 
profileOwnerUserId
ÖÖF X
)
ÖÖX Y
;
ÖÖY Z
}
ÜÜ 
catch
áá 
(
áá $
CommunicationException
áá )
)
áá) *
{
àà  
RemoveSubscription
ââ "
(
ââ" #

subscriber
ââ# -
.
ââ- .
Key
ââ. 1
)
ââ1 2
;
ââ2 3
_logger
ää 
.
ää 
Warning
ää 
(
ää  8
*ProfileImageSubscriberDisconnectedTemplate
ää  J
,
ääJ K 
profileOwnerUserId
ääL ^
)
ää^ _
;
ää_ `
}
ãã 
catch
åå 
(
åå '
InvalidOperationException
åå ,
)
åå, -
{
çç  
RemoveSubscription
éé "
(
éé" #

subscriber
éé# -
.
éé- .
Key
éé. 1
)
éé1 2
;
éé2 3
_logger
èè 
.
èè 
Warning
èè 
(
èè  8
*ProfileImageCallbackChannelFaultedTemplate
èè  J
,
èèJ K 
profileOwnerUserId
èèL ^
)
èè^ _
;
èè_ `
}
êê 
catch
ëë 
(
ëë 
TimeoutException
ëë #
)
ëë# $
{
íí  
RemoveSubscription
ìì "
(
ìì" #

subscriber
ìì# -
.
ìì- .
Key
ìì. 1
)
ìì1 2
;
ìì2 3
_logger
îî 
.
îî 
Warning
îî 
(
îî  4
&ProfileImageSubscriberTimedOutTemplate
îî  F
,
îîF G 
profileOwnerUserId
îîH Z
)
îîZ [
;
îî[ \
}
ïï 
}
ññ 	
private
òò 
void
òò  
RemoveSubscription
òò '
(
òò' (
string
òò( .
	sessionId
òò/ 8
)
òò8 9
{
ôô 	
lock
öö 
(
öö 
_subscriptionLock
öö #
)
öö# $
{
õõ 
_subscriptions
úú 
.
úú 
Remove
úú %
(
úú% &
	sessionId
úú& /
)
úú/ 0
;
úú0 1
}
ùù 
}
ûû 	
private
†† 
sealed
†† 
class
†† 
Subscription
†† )
{
°° 	
internal
¢¢ 
Subscription
¢¢ !
(
¢¢! "#
IProfileImageCallback
¢¢" 7
callback
¢¢8 @
,
¢¢@ A
int
¢¢B E
[
¢¢E F
]
¢¢F G
ownerIds
¢¢H P
)
¢¢P Q
{
££ 
Callback
§§ 
=
§§ 
callback
§§ #
;
§§# $
OwnerIds
•• 
=
•• 
new
•• 
HashSet
•• &
<
••& '
int
••' *
>
••* +
(
••+ ,
ownerIds
••, 4
.
••4 5
Where
••5 :
(
••: ;
ownerId
••; B
=>
••C E
ownerId
••F M
>
••N O
$num
••P Q
)
••Q R
)
••R S
;
••S T
}
¶¶ 
internal
®® #
IProfileImageCallback
®® *
Callback
®®+ 3
{
®®4 5
get
®®6 9
;
®®9 :
}
®®; <
internal
©© 
HashSet
©© 
<
©© 
int
©©  
>
©©  !
OwnerIds
©©" *
{
©©+ ,
get
©©- 0
;
©©0 1
}
©©2 3
}
™™ 	
}
´´ 
}¨¨ ∫
qC:\Users\oscar\source\repos\TrickTakingMissions\Server\Services\DataContracts\ProfileImages\ProfileImageUpload.cs
	namespace 	
Services
 
. 
DataContracts  
{ 
[		 
DataContract		 
(		 
	Namespace		 
=		 
$str		 A
)		A B
]		B C
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
ProfileImageUpload

 *
{ 
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public 
byte 
[ 
] %
SelectedProfileImageBytes /
{0 1
get2 5
;5 6
set7 :
;: ;
}< =
} 
} Ö
ZC:\Users\oscar\source\repos\TrickTakingMissions\Server\Services\Properties\AssemblyInfo.cs
[ 
assembly 	
:	 

AssemblyTitle 
( 
$str #
)# $
]$ %
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
$str %
)% &
]& '
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
]!!) *˙S
dC:\Users\oscar\source\repos\TrickTakingMissions\Server\Services\Services\Account\UserLoginService.cs
	namespace 	
Services
 
. 
Services 
{ 
[ 
ServiceBehavior 
( 
ConcurrencyMode $
=% &
ConcurrencyMode' 6
.6 7
	Reentrant7 @
)@ A
]A B
public 

sealed 
class 
UserLoginService (
:) *
IUserLoginService+ <
{ 
private 
const 
string 
LoginSuccessMessage 0
=1 2
$str3 F
;F G
private 
const 
string %
InvalidCredentialsMessage 6
=7 8
$str9 U
;U V
private 
const 
string %
MessageStorageUnavailable 6
=7 8
$str9 Q
;Q R
private 
const 
string $
MessageChatAccountBanned 5
=6 7
$str8 K
;K L
private 
const 
string +
LoginPersistenceFailureTemplate <
== >
$str M
;M N
private 
const 
string 5
)LoginCallbackCommunicationFailureTemplate F
=G H
$str E
;E F
private 
const 
string /
#LoginCallbackTimeoutFailureTemplate @
=A B
$str 9
;9 :
private 
readonly 
IUserLoginUseCase *
_userLoginUseCase+ <
;< =
private   
readonly    
IAccountAccessPolicy   - 
_accountAccessPolicy  . B
;  B C
private!! 
readonly!! 
ILoggerService!! '
_logger!!( /
;!!/ 0
public## 
UserLoginService## 
(##  
IUserLoginUseCase##  1
userLoginUseCase##2 B
,##B C 
IAccountAccessPolicy##D X
accountAccessPolicy##Y l
,##l m
ILoggerService$$ 
logger$$ !
)$$! "
{%% 	
if&& 
(&& 
userLoginUseCase&&  
==&&! #
null&&$ (
)&&( )
{'' 
throw(( 
new(( !
ArgumentNullException(( /
(((/ 0
nameof((0 6
(((6 7
userLoginUseCase((7 G
)((G H
)((H I
;((I J
})) 
_userLoginUseCase++ 
=++ 
userLoginUseCase++  0
;++0 1 
_accountAccessPolicy,,  
=,,! "
accountAccessPolicy,,# 6
??,,7 9
throw,,: ?
new,,@ C!
ArgumentNullException,,D Y
(,,Y Z
nameof,,Z `
(,,` a
accountAccessPolicy,,a t
),,t u
),,u v
;,,v w
_logger-- 
=-- 
logger-- 
??-- 
throw--  %
new--& )!
ArgumentNullException--* ?
(--? @
nameof--@ F
(--F G
logger--G M
)--M N
)--N O
;--O P
}.. 	
public00 
void00 
Login00 
(00 
string00  
email00! &
,00& '
string00( .
password00/ 7
)007 8
{11 	
try22 
{33 (
AuthenticateAndNotifyAccount44 ,
(44, -
email44- 2
,442 3
password444 <
)44< =
;44= >
}55 
catch66 
(66 %
InvalidOperationException66 ,
ex66- /
)66/ 0
{77 
_logger88 
.88 
Error88 
(88 
ex88  
,88  !+
LoginPersistenceFailureTemplate88" A
,88A B
email88C H
)88H I
;88I J%
NotifyLoginStorageFailure99 )
(99) *
email99* /
)99/ 0
;990 1
}:: 
catch;; 
(;; 
TimeoutException;; #
ex;;$ &
);;& '
{<< 
_logger== 
.== 
Error== 
(== 
ex==  
,==  !+
LoginPersistenceFailureTemplate==" A
,==A B
email==C H
)==H I
;==I J%
NotifyLoginStorageFailure>> )
(>>) *
email>>* /
)>>/ 0
;>>0 1
}?? 
}@@ 	
privateBB 
voidBB %
NotifyLoginStorageFailureBB .
(BB. /
stringBB/ 5
emailBB6 ;
)BB; <
{CC 	!
SafeNotifyLoginResultDD !
(DD! "
emailDD" '
,DD' (
falseDD) .
,DD. /%
MessageStorageUnavailableDD0 I
,DDI J
nullDDK O
)DDO P
;DDP Q
}EE 	
privateGG 
voidGG !
SafeNotifyLoginResultGG *
(GG* +
stringGG+ 1
emailGG2 7
,GG7 8
boolGG9 =
isLoginSuccessfulGG> O
,GGO P
stringGGQ W
responseMessageGGX g
,GGg h
UserGGi m
userGGn r
)GGr s
{HH 	
tryII 
{JJ 
OperationContextKK  
.KK  !
CurrentKK! (
?KK( )
.LL 
GetCallbackChannelLL '
<LL' (
IUserLoginCallbackLL( :
>LL: ;
(LL; <
)LL< =
?LL= >
.MM 
LoginResultMM  
(MM  !
isLoginSuccessfulMM! 2
,MM2 3
responseMessageMM4 C
,MMC D
userMME I
)MMI J
;MMJ K
}NN 
catchOO 
(OO "
CommunicationExceptionOO )
)OO) *
{PP 
_loggerQQ 
.QQ 
WarningQQ 
(QQ  5
)LoginCallbackCommunicationFailureTemplateQQ  I
,QQI J
emailQQK P
)QQP Q
;QQQ R
}RR 
catchSS 
(SS 
TimeoutExceptionSS #
)SS# $
{TT 
_loggerUU 
.UU 
WarningUU 
(UU  /
#LoginCallbackTimeoutFailureTemplateUU  C
,UUC D
emailUUE J
)UUJ K
;UUK L
}VV 
}WW 	
privateYY 
UserYY '
CreateRestrictedLoginNoticeYY 0
(YY0 1
intYY1 4
accountUserIdYY5 B
)YYB C
{ZZ 	&
ChatAccountInfractionState[[ &
accountBanState[[' 6
=[[7 8 
_accountAccessPolicy[[9 M
.[[M N
GetAccountBanState[[N `
([[` a
accountUserId[[a n
)[[n o
;[[o p
ChatAccountBanType\\ 
accountBanType\\ -
=\\. /
ChatAccountBanType\\0 B
.\\B C
	Temporary\\C L
;\\L M
if]] 
(]] 
accountBanState]] 
.]]  *
IsChatAccountPermanentlyBanned]]  >
)]]> ?
{^^ 
accountBanType__ 
=__  
ChatAccountBanType__! 3
.__3 4
	Permanent__4 =
;__= >
}`` 
returnbb 
newbb 
Userbb 
{cc  
ChatAccountBanNoticedd $
=dd% &
newdd' * 
ChatAccountBanNoticedd+ ?
{ee 
ChatAccountBanTypeff &
=ff' (
accountBanTypeff) 7
,ff7 8#
ChatAccountBanEndsAtUtcgg +
=gg, -
accountBanStategg. =
.gg= >#
ChatAccountBanEndsAtUtcgg> U
,ggU V
EvaluatedAtUtchh "
=hh# $
DateTimehh% -
.hh- .
UtcNowhh. 4
}ii 
}jj 
;jj 
}kk 	
privatemm 
voidmm (
AuthenticateAndNotifyAccountmm 1
(mm1 2
stringmm2 8
emailmm9 >
,mm> ?
stringmm@ F
passwordmmG O
)mmO P
{nn 	!
AuthenticatedUserDataoo !
useroo" &
=oo' (
_userLoginUseCaseoo) :
.oo: ;
AuthenticateUseroo; K
(ooK L
emailooL Q
,ooQ R
passwordooS [
)oo[ \
;oo\ ]
stringpp 
accountSessionTokenpp &
=pp' (
nullpp) -
;pp- .
ifqq 
(qq 
userqq 
!=qq 
nullqq 
)qq 
{rr 
accountSessionTokenss #
=ss$ % 
_accountAccessPolicyss& :
.ss: ;'
CreateAllowedAccountSessionss; V
(ssV W
userssW [
.ss[ \
IdUserss\ b
)ssb c
;ssc d
}tt 
boolvv 
isLoginSuccessfulvv "
=vv# $
!vv% &
stringvv& ,
.vv, -
IsNullOrEmptyvv- :
(vv: ;
accountSessionTokenvv; N
)vvN O
;vvO P
Userww 
userDtoww 
=ww 
nullww 
;ww  
stringxx 
responseMessagexx "
;xx" #
ifzz 
(zz 
isLoginSuccessfulzz !
)zz! "
{{{ 
responseMessage|| 
=||  !
LoginSuccessMessage||" 5
;||5 6
userDto}} 
=}} 
new}} 
User}} "
{~~ 
IdUser 
= 
user !
.! "
IdUser" (
,( )
Username
ÄÄ 
=
ÄÄ 
user
ÄÄ #
.
ÄÄ# $
Username
ÄÄ$ ,
,
ÄÄ, -
Email
ÅÅ 
=
ÅÅ 
user
ÅÅ  
.
ÅÅ  !
Email
ÅÅ! &
,
ÅÅ& '!
AccountSessionToken
ÇÇ '
=
ÇÇ( )!
accountSessionToken
ÇÇ* =
}
ÉÉ 
;
ÉÉ 
}
ÑÑ 
else
ÖÖ 
{
ÜÜ 
responseMessage
áá 
=
áá  !'
InvalidCredentialsMessage
áá" ;
;
áá; <
if
àà 
(
àà 
user
àà 
!=
àà 
null
àà  
)
àà  !
{
ââ 
responseMessage
ää #
=
ää$ %&
MessageChatAccountBanned
ää& >
;
ää> ?
userDto
ãã 
=
ãã )
CreateRestrictedLoginNotice
ãã 9
(
ãã9 :
user
ãã: >
.
ãã> ?
IdUser
ãã? E
)
ããE F
;
ããF G
}
åå 
}
çç #
SafeNotifyLoginResult
èè !
(
èè! "
email
èè" '
,
èè' (
isLoginSuccessful
èè) :
,
èè: ;
responseMessage
èè< K
,
èèK L
userDto
èèM T
)
èèT U
;
èèU V
}
êê 	
}
ëë 
}íí ∑/
lC:\Users\oscar\source\repos\TrickTakingMissions\Server\Services\Services\Account\AccountManagementService.cs
	namespace		 	
Services		
 
.		 
Services		 
{

 
[ 
ServiceBehavior 
( 
InstanceContextMode (
=) *
InstanceContextMode+ >
.> ?
PerCall? F
,F G
ConcurrencyModeH W
=X Y
ConcurrencyModeZ i
.i j
Multiplej r
)r s
]s t
public 

sealed 
class $
AccountManagementService 0
:1 2%
IAccountManagementService3 L
{ 
private 
const 
int %
ErrorCodeValidationFailed 3
=4 5
$num6 9
;9 :
private 
const 
int "
ErrorCodeInternalFault 0
=1 2
$num3 6
;6 7
private 
const 
string 
MessageNullPayload /
=0 1
$str2 ]
;] ^
private 
const 
string "
MessageUnexpectedFault 3
=4 5
$str6 l
+m n
$str 
; 
private 
const 
string +
RegisterUserNullPayloadTemplate <
== >
$str B
;B C
private 
const 
string /
#UnexpectedRegistrationFaultTemplate @
=A B
$str c
;c d
private 
readonly %
IAccountManagementUseCase 2%
_accountManagementUseCase3 L
;L M
private 
readonly 
ILoggerService '
_logger( /
;/ 0
public%% $
AccountManagementService%% '
(%%' (%
IAccountManagementUseCase%%( A$
accountManagementUseCase%%B Z
,%%Z [
ILoggerService%%\ j
logger%%k q
)%%q r
{&& 	%
_accountManagementUseCase'' %
=''& '$
accountManagementUseCase''( @
??''A C
throw(( 
new(( !
ArgumentNullException(( /
(((/ 0
nameof((0 6
(((6 7$
accountManagementUseCase((7 O
)((O P
)((P Q
;((Q R
_logger)) 
=)) 
logger)) 
??)) 
throw))  %
new))& )!
ArgumentNullException))* ?
())? @
nameof))@ F
())F G
logger))G M
)))M N
)))N O
;))O P
}** 	
public-- 
OperationResult-- 
RegisterUser-- +
(--+ ,
UserRegister--, 8
user--9 =
)--= >
{.. 	
OperationResult// 
result// "
;//" #
if11 
(11 
user11 
==11 
null11 
)11 
{22 
_logger33 
.33 
Warning33 
(33  +
RegisterUserNullPayloadTemplate33  ?
)33? @
;33@ A
result44 
=44 
new44 
OperationResult44 ,
{55 
	IsSuccess66 
=66 
false66  %
,66% &
	ErrorCode77 
=77 %
ErrorCodeValidationFailed77  9
,779 :
Message88 
=88 
MessageNullPayload88 0
}99 
;99 
}:: 
else;; 
{<< 
try== 
{>> #
UserRegistrationOutcome?? +
outcome??, 3
=??4 5%
_accountManagementUseCase??6 O
.??O P
RegisterUser??P \
(??\ ]
user@@ 
.@@ 
Username@@ %
,@@% &
userAA 
.AA 
EmailAA "
,AA" #
userBB 
.BB 
PasswordHashBB )
)BB) *
;BB* +
resultDD 
=DD 
newDD  
OperationResultDD! 0
{EE 
	IsSuccessFF !
=FF" #
outcomeFF$ +
.FF+ ,
	IsSuccessFF, 5
,FF5 6
	ErrorCodeGG !
=GG" #
outcomeGG$ +
.GG+ ,
	ErrorCodeGG, 5
,GG5 6
MessageHH 
=HH  !
outcomeHH" )
.HH) *
MessageHH* 1
}II 
;II 
}JJ 
catchKK 
(KK %
InvalidOperationExceptionKK 0
exKK1 3
)KK3 4
{LL 
resultMM 
=MM #
HandleRegistrationFaultMM 4
(MM4 5
exMM5 7
,MM7 8
userMM9 =
)MM= >
;MM> ?
}NN 
catchOO 
(OO 
TimeoutExceptionOO '
exOO( *
)OO* +
{PP 
resultQQ 
=QQ #
HandleRegistrationFaultQQ 4
(QQ4 5
exQQ5 7
,QQ7 8
userQQ9 =
)QQ= >
;QQ> ?
}RR 
}SS 
returnUU 
resultUU 
;UU 
}VV 	
privateXX 
OperationResultXX #
HandleRegistrationFaultXX  7
(XX7 8
	ExceptionXX8 A
exXXB D
,XXD E
UserRegisterXXF R
userXXS W
)XXW X
{YY 	
_loggerZZ 
.ZZ 
ErrorZZ 
(ZZ 
exZZ 
,ZZ /
#UnexpectedRegistrationFaultTemplateZZ A
,ZZA B
userZZC G
.ZZG H
UsernameZZH P
,ZZP Q
userZZR V
.ZZV W
EmailZZW \
)ZZ\ ]
;ZZ] ^
return[[ 
new[[ 
OperationResult[[ &
{\\ 
	IsSuccess]] 
=]] 
false]] !
,]]! "
	ErrorCode^^ 
=^^ "
ErrorCodeInternalFault^^ 2
,^^2 3
Message__ 
=__ "
MessageUnexpectedFault__ 0
}`` 
;`` 
}aa 	
}bb 
}cc ø\
iC:\Users\oscar\source\repos\TrickTakingMissions\Server\Services\Services\Friends\FriendsRequestService.cs
	namespace 	
Services
 
. 
Services 
{ 
[ 
ServiceBehavior 
( 
InstanceContextMode (
=) *
InstanceContextMode+ >
.> ?
PerCall? F
,F G
ConcurrencyModeH W
=X Y
ConcurrencyModeZ i
.i j
Multiplej r
)r s
]s t
public 

sealed 
class !
FriendsRequestService -
:. /"
IFriendsRequestService0 F
{ 
private 
readonly 
IFriendshipUseCase +
_friendshipUseCase, >
;> ?
private 
readonly 
ILoggerService '
_logger( /
;/ 0
public !
FriendsRequestService $
($ %
IFriendshipUseCase% 7
friendshipUseCase8 I
,I J
ILoggerServiceK Y
loggerZ `
)` a
{ 	
if 
( 
friendshipUseCase !
==" $
null% )
)) *
{ 
throw 
new !
ArgumentNullException /
(/ 0
nameof0 6
(6 7
friendshipUseCase7 H
)H I
)I J
;J K
} 
_friendshipUseCase 
=  
friendshipUseCase! 2
;2 3
_logger 
= 
logger 
?? 
throw  %
new& )!
ArgumentNullException* ?
(? @
nameof@ F
(F G
loggerG M
)M N
)N O
;O P
} 	
public 
async 
Task 
< 
OperationResult )
>) *"
SendFriendRequestAsync+ A
(A B
intB E
senderUserIdF R
,R S
stringT Z
targetUsername[ i
)i j
{   	#
FriendshipActionOutcome!! ##
friendshipActionOutcome!!$ ;
=!!< =
await!!> C
_friendshipUseCase"" "
.""" #"
SendFriendRequestAsync""# 9
(""9 :
senderUserId"": F
,""F G
targetUsername""H V
)""V W
;""W X
if$$ 
($$ #
friendshipActionOutcome$$ '
.$$' (
	IsSuccess$$( 1
)$$1 2
{%% 
await&& +
NotifyReceiverOfNewRequestAsync&& 5
(&&5 6
senderUserId&&6 B
,&&B C
targetUsername&&D R
)&&R S
;&&S T
}'' 
return))  
MapToOperationResult)) '
())' (#
friendshipActionOutcome))( ?
)))? @
;))@ A
}** 	
public,, 
async,, 
Task,, 
<,, 
OperationResult,, )
>,,) *$
AcceptFriendRequestAsync,,+ C
(,,C D
int,,D G
receiverUserId,,H V
,,,V W
int,,X [
senderUserId,,\ h
),,h i
{-- 	#
FriendshipActionOutcome.. ##
friendshipActionOutcome..$ ;
=..< =
await..> C
_friendshipUseCase// "
.//" #$
AcceptFriendRequestAsync//# ;
(//; <
receiverUserId//< J
,//J K
senderUserId//L X
)//X Y
;//Y Z
if11 
(11 #
friendshipActionOutcome11 '
.11' (
	IsSuccess11( 1
)111 2
{22 
bool33 
isReceiverOnline33 %
=33& '
FriendshipService33( 9
.339 :
IsUserOnline33: F
(33F G
receiverUserId33G U
)33U V
;33V W
FriendshipService44 !
.44! "$
NotifySingleFriendStatus44" :
(44: ;
senderUserId44; G
,44G H
receiverUserId44I W
,44W X
isReceiverOnline44Y i
,44i j
_logger44k r
)44r s
;44s t
}55 
return77  
MapToOperationResult77 '
(77' (#
friendshipActionOutcome77( ?
)77? @
;77@ A
}88 	
public:: 
async:: 
Task:: 
<:: 
OperationResult:: )
>::) *$
RejectFriendRequestAsync::+ C
(::C D
int::D G
receiverUserId::H V
,::V W
int::X [
senderUserId::\ h
)::h i
{;; 	#
FriendshipActionOutcome<< #
outcome<<$ +
=<<, -
await<<. 3
_friendshipUseCase== "
.==" #$
RejectFriendRequestAsync==# ;
(==; <
receiverUserId==< J
,==J K
senderUserId==L X
)==X Y
;==Y Z
return??  
MapToOperationResult?? '
(??' (
outcome??( /
)??/ 0
;??0 1
}@@ 	
publicBB 
asyncBB 
TaskBB 
<BB 
OperationResultBB )
>BB) *$
CancelFriendRequestAsyncBB+ C
(BBC D
intBBD G
senderUserIdBBH T
,BBT U
intBBV Y
receiverUserIdBBZ h
)BBh i
{CC 	#
FriendshipActionOutcomeDD #
outcomeDD$ +
=DD, -
awaitDD. 3
_friendshipUseCaseEE "
.EE" #$
CancelFriendRequestAsyncEE# ;
(EE; <
senderUserIdEE< H
,EEH I
receiverUserIdEEJ X
)EEX Y
;EEY Z
returnGG  
MapToOperationResultGG '
(GG' (
outcomeGG( /
)GG/ 0
;GG0 1
}HH 	
publicJJ 
asyncJJ 
TaskJJ 
<JJ 
ListJJ 
<JJ 
FriendRequestJJ ,
>JJ, -
>JJ- .0
$GetPendingFriendRequestByUserIdAsyncJJ/ S
(JJS T
intJJT W
userIdJJX ^
)JJ^ _
{KK 	
ListLL 
<LL 
FriendRequestLL 
>LL 
pendingRequestsLL  /
=LL0 1
newLL2 5
ListLL6 :
<LL: ;
FriendRequestLL; H
>LLH I
(LLI J
)LLJ K
;LLK L
ListMM 
<MM 
FriendRequestDataMM "
>MM" #
domainRequestsMM$ 2
=MM3 4
awaitMM5 :
_friendshipUseCaseNN "
.NN" #1
%GetPendingFriendRequestsByUserIdAsyncNN# H
(NNH I
userIdNNI O
)NNO P
;NNP Q
foreachPP 
(PP 
FriendRequestDataPP &
friendRequestDataPP' 8
inPP9 ;
domainRequestsPP< J
)PPJ K
{QQ 
pendingRequestsRR 
.RR  
AddRR  #
(RR# $
MapToFriendRequestRR$ 6
(RR6 7
friendRequestDataRR7 H
)RRH I
)RRI J
;RRJ K
}SS 
returnUU 
pendingRequestsUU "
;UU" #
}VV 	
publicXX 
asyncXX 
TaskXX 
<XX 
ListXX 
<XX 
FriendRequestXX ,
>XX, -
>XX- .-
!GetSentFriendRequestByUserIdAsyncXX/ P
(XXP Q
intXXQ T
userIdXXU [
)XX[ \
{YY 	
ListZZ 
<ZZ 
FriendRequestZZ 
>ZZ 
sentRequestsZZ  ,
=ZZ- .
newZZ/ 2
ListZZ3 7
<ZZ7 8
FriendRequestZZ8 E
>ZZE F
(ZZF G
)ZZG H
;ZZH I
List[[ 
<[[ 
FriendRequestData[[ "
>[[" #
domainRequests[[$ 2
=[[3 4
await[[5 :
_friendshipUseCase\\ "
.\\" #.
"GetSentFriendRequestsByUserIdAsync\\# E
(\\E F
userId\\F L
)\\L M
;\\M N
foreach^^ 
(^^ 
FriendRequestData^^ &
friendRequestData^^' 8
in^^9 ;
domainRequests^^< J
)^^J K
{__ 
sentRequests`` 
.`` 
Add``  
(``  !
MapToFriendRequest``! 3
(``3 4
friendRequestData``4 E
)``E F
)``F G
;``G H
}aa 
returncc 
sentRequestscc 
;cc  
}dd 	
privateff 
asyncff 
Taskff +
NotifyReceiverOfNewRequestAsyncff :
(ff: ;
intff; >
senderUserIdff? K
,ffK L
stringffM S
targetUsernameffT b
)ffb c
{gg 	
Listhh 
<hh 
FriendRequestDatahh "
>hh" #
sentRequestshh$ 0
=hh1 2
awaithh3 8
_friendshipUseCaseii "
.ii" #.
"GetSentFriendRequestsByUserIdAsyncii# E
(iiE F
senderUserIdiiF R
)iiR S
;iiS T
foreachkk 
(kk 
FriendRequestDatakk &
requestDatakk' 2
inkk3 5
sentRequestskk6 B
)kkB C
{ll 
ifmm 
(mm 
stringmm 
.mm 
Equalsmm !
(mm! "
requestDatamm" -
.mm- .
ReceiverUsernamemm. >
,mm> ?
targetUsernamemm@ N
?mmN O
.mmO P
TrimmmP T
(mmT U
)mmU V
,mmV W
StringComparisonnn $
.nn$ %
OrdinalIgnoreCasenn% 6
)nn6 7
)nn7 8
{oo 
FriendRequestpp !
friendRequestpp" /
=pp0 1
MapToFriendRequestpp2 D
(ppD E
requestDatappE P
)ppP Q
;ppQ R
FriendshipServiceqq %
.qq% &'
NotifyFriendRequestReceivedqq& A
(qqA B
friendRequestqqB O
,qqO P
_loggerqqQ X
)qqX Y
;qqY Z
}rr 
}ss 
}tt 	
privatevv 
staticvv 
FriendRequestvv $
MapToFriendRequestvv% 7
(vv7 8
FriendRequestDatavv8 I
requestDatavvJ U
)vvU V
{ww 	
returnxx 
newxx 
FriendRequestxx $
{yy 
SenderUserIdzz 
=zz 
requestDatazz *
.zz* +
SenderIdUserzz+ 7
,zz7 8
SenderUsername{{ 
={{  
requestData{{! ,
.{{, -
SenderUsername{{- ;
,{{; <
ReceiverUserId|| 
=||  
requestData||! ,
.||, -
ReceiverIdUser||- ;
,||; <
ReceiverUsername}}  
=}}! "
requestData}}# .
.}}. /
ReceiverUsername}}/ ?
,}}? @
Status~~ 
=~~ 
requestData~~ $
.~~$ %
Status~~% +
,~~+ ,
RequestedAt 
= 
requestData )
.) *
RequestDate* 5
}
ÄÄ 
;
ÄÄ 
}
ÅÅ 	
private
ÉÉ 
static
ÉÉ 
OperationResult
ÉÉ &"
MapToOperationResult
ÉÉ' ;
(
ÉÉ; <%
FriendshipActionOutcome
ÉÉ< S%
friendshipActionOutcome
ÉÉT k
)
ÉÉk l
{
ÑÑ 	
return
ÖÖ 
new
ÖÖ 
OperationResult
ÖÖ &
{
ÜÜ 
	IsSuccess
áá 
=
áá %
friendshipActionOutcome
áá 3
.
áá3 4
	IsSuccess
áá4 =
,
áá= >
	ErrorCode
àà 
=
àà %
friendshipActionOutcome
àà 3
.
àà3 4
	ErrorCode
àà4 =
,
àà= >
Message
ââ 
=
ââ %
friendshipActionOutcome
ââ 1
.
ââ1 2
Message
ââ2 9
}
ää 
;
ää 
}
ãã 	
}
åå 
}çç ó≠
^C:\Users\oscar\source\repos\TrickTakingMissions\Server\Services\Services\Lobby\LobbyService.cs
	namespace 	
Services
 
. 
Services 
{ 
[ 
ServiceBehavior 
( 
ConcurrencyMode $
=% &
ConcurrencyMode' 6
.6 7
	Reentrant7 @
)@ A
]A B
public 

sealed 
partial 
class 
LobbyService  ,
:- .
ILobbyService/ <
,< =&
IMatchStateChangePublisher> X
{ 
private 
const 
string 
PlayerLeftReason -
=. /
$str0 H
;H I
private 
const 
string 
PlayerKickedReason /
=0 1
$str2 R
;R S
private 
const 
string  
ReasonConnectionLost 1
=2 3
$str4 D
;D E
private 
const 
string $
ReasonParticipantRemoved 5
=6 7
$str8 L
;L M
private 
const 
string "
FaultLobbyHostRequired 3
=4 5
$str6 I
;I J
private 
const 
string !
FaultMatchUnavailable 2
=3 4
$str5 G
;G H
private   
const   
string   #
FaultMatchStartRejected   4
=  5 6
$str  7 K
;  K L
private!! 
const!! 
string!! "
FaultInvalidSubmission!! 3
=!!4 5
$str!!6 I
;!!I J
private"" 
const"" 
string"" &
FaultParticipantNotAllowed"" 7
=""8 9
$str"": Q
;""Q R
private$$ 
const$$ 
string$$ .
"LobbyCallbackChannelClosedTemplate$$ ?
=$$@ A
$str%% Y
;%%Y Z
private&& 
const&& 
string&& (
LobbyCallbackTimeoutTemplate&& 9
=&&: ;
$str'' T
;''T U
private(( 
const(( 
string(( 5
)LobbyCallbackCommunicationFaultedTemplate(( F
=((G H
$str)) `
;))` a
private++ 
const++ 
string++ &
ChatStorageFailureTemplate++ 7
=++8 9
$str,, Y
;,,Y Z
private-- 
const-- 
string-- )
ChatModerationTimeoutTemplate-- :
=--; <
$str.. G
;..G H
private// 
const// 
string// )
ChatSubmissionInvalidTemplate// :
=//; <
$str00 E
;00E F
private22 
const22 
string22 3
'BanCallbackCommunicationFaultedTemplate22 D
=22E F
$str33 8
;338 9
private44 
const44 
string44 &
BanCallbackTimeoutTemplate44 7
=448 9
$str55 :
;55: ;
private77 
const77 
string77 2
&MatchStartupPersistenceFailureTemplate77 C
=77D E
$str88 P
;88P Q
private99 
const99 
string99 '
MatchAccessRejectedTemplate99 8
=999 :
$str:: Q
;::Q R
private<< 
const<< 
byte<< #
UnspecifiedSettingValue<< 2
=<<3 4
$num<<5 6
;<<6 7
private>> 
static>> 
readonly>>  
ConcurrentDictionary>>  4
<>>4 5
string>>5 ;
,>>; < 
ConcurrentDictionary??  
<??  !
int??! $
,??$ %
ILobbyCallback??& 4
>??4 5
>??5 6
s_roomCallbacks??7 F
=??G H
new@@  
ConcurrentDictionary@@ (
<@@( )
string@@) /
,@@/ 0 
ConcurrentDictionary@@1 E
<@@E F
int@@F I
,@@I J
ILobbyCallback@@K Y
>@@Y Z
>@@Z [
(@@[ \
StringComparerAA "
.AA" #
OrdinalIgnoreCaseAA# 4
)AA4 5
;AA5 6
privateCC 
readonlyCC 
ILobbyUseCaseCC &
_lobbyUseCaseCC' 4
;CC4 5
privateDD 
readonlyDD $
ILobbyChatMessageUseCaseDD 1$
_lobbyChatMessageUseCaseDD2 J
;DDJ K
privateEE 
readonlyEE  
IAccountAccessPolicyEE - 
_accountAccessPolicyEE. B
;EEB C
privateFF 
readonlyFF 
ILoggerServiceFF '
_loggerFF( /
;FF/ 0
publicHH 
LobbyServiceHH 
(HH 
ILobbyUseCaseHH )
lobbyUseCaseHH* 6
,HH6 7$
ILobbyChatMessageUseCaseHH8 P#
lobbyChatMessageUseCaseHHQ h
,HHh i 
IAccountAccessPolicyII  
accountAccessPolicyII! 4
,II4 5
ILoggerServiceII6 D
loggerIIE K
)IIK L
{JJ 	
ifKK 
(KK 
lobbyUseCaseKK 
==KK 
nullKK  $
)KK$ %
{LL 
throwMM 
newMM !
ArgumentNullExceptionMM /
(MM/ 0
nameofMM0 6
(MM6 7
lobbyUseCaseMM7 C
)MMC D
)MMD E
;MME F
}NN 
_lobbyUseCasePP 
=PP 
lobbyUseCasePP (
;PP( )$
_lobbyChatMessageUseCaseQQ $
=QQ% &#
lobbyChatMessageUseCaseQQ' >
;QQ> ? 
_accountAccessPolicyRR  
=RR! "
accountAccessPolicyRR# 6
;RR6 7
_loggerSS 
=SS 
loggerSS 
??SS 
throwSS  %
newSS& )!
ArgumentNullExceptionSS* ?
(SS? @
nameofSS@ F
(SSF G
loggerSSG M
)SSM N
)SSN O
;SSO P
}TT 	
publicVV 
LobbyResultVV 
UpdateLobbySettingsVV .
(VV. /
stringVV/ 5
	lobbyCodeVV6 ?
,VV? @
intVVA D
requesterUserIdVVE T
,VVT U
LobbySettingsVVV c
settingsVVd l
)VVl m
{WW 	-
!EnsureParticipantOperationAllowedXX -
(XX- .
requesterUserIdXX. =
)XX= >
;XX> ?'
EnsureRegisteredRoomChannelYY '
(YY' (
	lobbyCodeYY( 1
,YY1 2
requesterUserIdYY3 B
)YYB C
;YYC D
LobbyActionOutcomeZZ 
configurationUpdateZZ 2
=ZZ3 4
_lobbyUseCaseZZ5 B
.ZZB C
UpdateLobbySettingsZZC V
(ZZV W
	lobbyCodeZZW `
,ZZ` a
requesterUserIdZZb q
,ZZq r!
MapLobbyConfiguration[[ %
([[% &
settings[[& .
)[[. /
)[[/ 0
;[[0 1
if\\ 
(\\ 
configurationUpdate\\ #
.\\# $
	IsSuccess\\$ -
)\\- .
{]] 
PublishLobbyState^^ !
(^^! "
configurationUpdate^^" 5
)^^5 6
;^^6 7
}__ 
returnaa 
MapToLobbyResultaa #
(aa# $
configurationUpdateaa$ 7
)aa7 8
;aa8 9
}bb 	
privatedd 
staticdd 
LobbyConfigurationdd )!
MapLobbyConfigurationdd* ?
(dd? @
LobbySettingsdd@ M
settingsddN V
)ddV W
{ee 	
returnff 
newff 
LobbyConfigurationff )
{gg 
TargetMissionCounthh "
=hh# $
settingshh% -
?hh- .
.hh. /
TargetMissionCounthh/ A
??hhB D#
UnspecifiedSettingValuehhE \
,hh\ ]
PlayerLimitii 
=ii 
settingsii &
?ii& '
.ii' (
PlayerLimitii( 3
??ii4 6#
UnspecifiedSettingValueii7 N
,iiN O
	IsPrivatejj 
=jj 
settingsjj $
?jj$ %
.jj% &
	IsPrivatejj& /
??jj0 2
truejj3 7
}kk 
;kk 
}ll 	
privatenn 
staticnn 
voidnn '
EnsureRegisteredRoomChannelnn 7
(nn7 8
stringnn8 >
	lobbyCodenn? H
,nnH I
intnnJ M
requesterUserIdnnN ]
)nn] ^
{oo 	
ILobbyCallbackpp 
requesterCallbackpp ,
=pp- .
nullpp/ 3
;pp3 4
boolqq  
hasRegisteredChannelqq %
=qq& '
s_roomCallbacksqq( 7
.qq7 8
TryGetValueqq8 C
(qqC D
NormalizeRoomKeyqqD T
(qqT U
	lobbyCodeqqU ^
)qq^ _
,qq_ `
outrr  
ConcurrentDictionaryrr (
<rr( )
intrr) ,
,rr, -
ILobbyCallbackrr. <
>rr< =
participantsrr> J
)rrJ K
&&rrL N
participantsss 
.ss 
TryGetValuess (
(ss( )
requesterUserIdss) 8
,ss8 9
outss: =
requesterCallbackss> O
)ssO P
;ssP Q
IContextChanneltt 
callbackChanneltt +
=tt, -
requesterCallbacktt. ?
astt@ B
IContextChannelttC R
;ttR S
ifuu 
(uu 
!uu  
hasRegisteredChanneluu %
||uu& (
callbackChanneluu) 8
?uu8 9
.uu9 :
	SessionIduu: C
!=uuD F
OperationContextuuG W
.uuW X
CurrentuuX _
?uu_ `
.uu` a
	SessionIduua j
)uuj k
{vv 
throwww 
newww 
FaultExceptionww (
(ww( )"
FaultLobbyHostRequiredww) ?
)ww? @
;ww@ A
}xx 
}yy 	
private{{ 
void{{ 
PublishLobbyState{{ &
({{& '
LobbyActionOutcome{{' 9
lobbyActionOutcome{{: L
){{L M
{|| 	
Lobby}} 
confirmedLobby}}  
=}}! "
MapToLobbyResult}}# 3
(}}3 4
lobbyActionOutcome}}4 F
)}}F G
.}}G H
Lobby}}H M
;}}M N
if~~ 
(~~ 
confirmedLobby~~ 
!=~~ !
null~~" &
)~~& '
{ 
BroadcastToRoom
ÄÄ 
(
ÄÄ  
confirmedLobby
ÄÄ  .
.
ÄÄ. /
	LobbyCode
ÄÄ/ 8
,
ÄÄ8 9
null
ÄÄ: >
,
ÄÄ> ?
callback
ÅÅ 
=>
ÅÅ 
callback
ÅÅ  (
.
ÅÅ( )!
OnLobbyStateChanged
ÅÅ) <
(
ÅÅ< =
confirmedLobby
ÅÅ= K
)
ÅÅK L
)
ÅÅL M
;
ÅÅM N
}
ÇÇ 
}
ÉÉ 	
private
ÖÖ 
void
ÖÖ '
ObserveParticipantChannel
ÖÖ .
(
ÖÖ. /
ILobbyCallback
ÖÖ/ =
callback
ÖÖ> F
)
ÖÖF G
{
ÜÜ 	"
ICommunicationObject
áá   
participantChannel
áá! 3
=
áá4 5
callback
áá6 >
as
áá? A"
ICommunicationObject
ááB V
;
ááV W
if
àà 
(
àà  
participantChannel
àà "
!=
àà# %
null
àà& *
)
àà* +
{
ââ  
participantChannel
ää "
.
ää" #
Closed
ää# )
+=
ää* ,.
 OnParticipantChannelDisconnected
ää- M
;
ääM N 
participantChannel
ãã "
.
ãã" #
Faulted
ãã# *
+=
ãã+ -.
 OnParticipantChannelDisconnected
ãã. N
;
ããN O
}
åå 
}
çç 	
private
èè 
void
èè .
 OnParticipantChannelDisconnected
èè 5
(
èè5 6
object
èè6 <
sender
èè= C
,
èèC D
	EventArgs
èèE N
e
èèO P
)
èèP Q
{
êê 	
foreach
ëë 
(
ëë 
KeyValuePair
ëë !
<
ëë! "
string
ëë" (
,
ëë( )"
ConcurrentDictionary
ëë* >
<
ëë> ?
int
ëë? B
,
ëëB C
ILobbyCallback
ëëD R
>
ëëR S
>
ëëS T
room
ëëU Y
in
íí 
s_roomCallbacks
íí "
.
íí" #
ToArray
íí# *
(
íí* +
)
íí+ ,
)
íí, -
{
ìì /
!RemoveMatchingDisconnectedChannel
îî 1
(
îî1 2
room
îî2 6
,
îî6 7
sender
îî8 >
)
îî> ?
;
îî? @
}
ïï 
}
ññ 	
private
òò 
void
òò /
!RemoveMatchingDisconnectedChannel
òò 6
(
òò6 7
KeyValuePair
ôô 
<
ôô 
string
ôô 
,
ôô  "
ConcurrentDictionary
ôô! 5
<
ôô5 6
int
ôô6 9
,
ôô9 :
ILobbyCallback
ôô; I
>
ôôI J
>
ôôJ K
room
ôôL P
,
ôôP Q
object
ôôR X!
disconnectedChannel
ôôY l
)
ôôl m
{
öö 	
foreach
õõ 
(
õõ 
KeyValuePair
õõ !
<
õõ! "
int
õõ" %
,
õõ% &
ILobbyCallback
õõ' 5
>
õõ5 6
participant
õõ7 B
in
õõC E
room
õõF J
.
õõJ K
Value
õõK P
.
õõP Q
ToArray
õõQ X
(
õõX Y
)
õõY Z
)
õõZ [
{
úú 
if
ùù 
(
ùù 
ReferenceEquals
ùù #
(
ùù# $
participant
ùù$ /
.
ùù/ 0
Value
ùù0 5
,
ùù5 6!
disconnectedChannel
ùù7 J
)
ùùJ K
)
ùùK L
{
ûû *
HandleParticipantChannelLoss
üü 0
(
üü0 1
room
üü1 5
.
üü5 6
Key
üü6 9
,
üü9 :
participant
üü; F
.
üüF G
Key
üüG J
,
üüJ K
participant
üüL W
.
üüW X
Value
üüX ]
)
üü] ^
;
üü^ _
}
†† 
}
°° 
}
¢¢ 	
private
§§ 
void
§§ *
HandleParticipantChannelLoss
§§ 1
(
§§1 2
string
§§2 8
	lobbyCode
§§9 B
,
§§B C
int
§§D G
participantUserId
§§H Y
,
§§Y Z
ILobbyCallback
§§[ i
callback
§§j r
)
§§r s
{
•• 	
if
¶¶ 
(
¶¶ 
s_roomCallbacks
¶¶ 
.
¶¶  
TryGetValue
¶¶  +
(
¶¶+ ,
NormalizeRoomKey
¶¶, <
(
¶¶< =
	lobbyCode
¶¶= F
)
¶¶F G
,
¶¶G H
out
ßß "
ConcurrentDictionary
ßß (
<
ßß( )
int
ßß) ,
,
ßß, -
ILobbyCallback
ßß. <
>
ßß< =
participants
ßß> J
)
ßßJ K
)
ßßK L
{
®® .
 RemoveCurrentDisconnectedChannel
©© 0
(
©©0 1
participants
©©1 =
,
©©= >
participantUserId
©©? P
,
©©P Q
callback
©©R Z
)
©©Z [
;
©©[ \
}
™™ 
}
´´ 	
private
≠≠ 
void
≠≠ .
 RemoveCurrentDisconnectedChannel
≠≠ 5
(
≠≠5 6"
ConcurrentDictionary
≠≠6 J
<
≠≠J K
int
≠≠K N
,
≠≠N O
ILobbyCallback
≠≠P ^
>
≠≠^ _
participants
≠≠` l
,
≠≠l m
int
ÆÆ 
participantUserId
ÆÆ !
,
ÆÆ! "
ILobbyCallback
ÆÆ# 1
callback
ÆÆ2 :
)
ÆÆ: ;
{
ØØ 	
bool
∞∞ &
hasRemovedCurrentChannel
∞∞ )
;
∞∞) *
lock
±± 
(
±±  
LobbyMatchPresence
±± $
.
±±$ %
RegistryGate
±±% 1
)
±±1 2
{
≤≤ &
hasRemovedCurrentChannel
≥≥ (
=
≥≥) *
(
≥≥+ ,
(
≥≥, -
ICollection
≥≥- 8
<
≥≥8 9
KeyValuePair
≥≥9 E
<
≥≥E F
int
≥≥F I
,
≥≥I J
ILobbyCallback
≥≥K Y
>
≥≥Y Z
>
≥≥Z [
)
≥≥[ \
participants
≥≥\ h
)
≥≥h i
.
¥¥ 
Remove
¥¥ 
(
¥¥ 
new
¥¥ 
KeyValuePair
¥¥  ,
<
¥¥, -
int
¥¥- 0
,
¥¥0 1
ILobbyCallback
¥¥2 @
>
¥¥@ A
(
¥¥A B
participantUserId
¥¥B S
,
¥¥S T
callback
¥¥U ]
)
¥¥] ^
)
¥¥^ _
;
¥¥_ `
if
µµ 
(
µµ &
hasRemovedCurrentChannel
µµ ,
)
µµ, -
{
∂∂  
LobbyMatchPresence
∑∑ &
.
∑∑& '$
MarkConnectionsChanged
∑∑' =
(
∑∑= >"
FindCallbackRoomCode
∑∑> R
(
∑∑R S
participants
∑∑S _
)
∑∑_ `
)
∑∑` a
;
∑∑a b
}
∏∏ 
}
ππ 
if
∫∫ 
(
∫∫ &
hasRemovedCurrentChannel
∫∫ (
)
∫∫( )
{
ªª 
string
ºº 
	lobbyCode
ºº  
=
ºº! ""
FindCallbackRoomCode
ºº# 7
(
ºº7 8
participants
ºº8 D
)
ººD E
;
ººE F 
LobbyActionOutcome
ΩΩ ""
participantDeparture
ΩΩ# 7
=
ΩΩ8 9
_lobbyUseCase
ΩΩ: G
.
ΩΩG H(
DisconnectLobbyParticipant
ΩΩH b
(
ΩΩb c
	lobbyCode
ææ 
,
ææ 
participantUserId
ææ 0
)
ææ0 1
;
ææ1 2#
NotifyPlayerDeparture
øø %
(
øø% &"
participantDeparture
øø& :
,
øø: ;
participantUserId
øø< M
,
øøM N"
ReasonConnectionLost
øøO c
)
øøc d
;
øød e
}
¿¿ 
}
¡¡ 	
private
√√ 
static
√√ 
string
√√ "
FindCallbackRoomCode
√√ 2
(
√√2 3"
ConcurrentDictionary
√√3 G
<
√√G H
int
√√H K
,
√√K L
ILobbyCallback
√√M [
>
√√[ \
participants
√√] i
)
√√i j
{
ƒƒ 	
return
≈≈ 
s_roomCallbacks
≈≈ "
.
≈≈" #
FirstOrDefault
≈≈# 1
(
≈≈1 2
room
≈≈2 6
=>
≈≈7 9
ReferenceEquals
≈≈: I
(
≈≈I J
room
≈≈J N
.
≈≈N O
Value
≈≈O T
,
≈≈T U
participants
≈≈V b
)
≈≈b c
)
≈≈c d
.
≈≈d e
Key
≈≈e h
??
≈≈i k
string
∆∆ 
.
∆∆ 
Empty
∆∆ 
;
∆∆ 
}
«« 	
public
…… 
LobbyResult
…… 
CreateLobby
…… &
(
……& '
int
……' *

hostUserId
……+ 5
,
……5 6
LobbySettings
……7 D
settings
……E M
)
……M N
{
   	/
!EnsureParticipantOperationAllowed
ÀÀ -
(
ÀÀ- .

hostUserId
ÀÀ. 8
)
ÀÀ8 9
;
ÀÀ9 : 
LobbyActionOutcome
ÃÃ  
lobbyActionOutcome
ÃÃ 1
=
ÃÃ2 3
_lobbyUseCase
ÃÃ4 A
.
ÃÃA B
CreateLobby
ÃÃB M
(
ÃÃM N

hostUserId
ÃÃN X
,
ÃÃX Y#
MapLobbyConfiguration
ÕÕ %
(
ÕÕ% &
settings
ÕÕ& .
)
ÕÕ. /
)
ÕÕ/ 0
;
ÕÕ0 1
if
ŒŒ 
(
ŒŒ  
lobbyActionOutcome
ŒŒ "
.
ŒŒ" #
	IsSuccess
ŒŒ# ,
&&
ŒŒ- / 
lobbyActionOutcome
ŒŒ0 B
.
ŒŒB C
Lobby
ŒŒC H
!=
ŒŒI K
null
ŒŒL P
)
ŒŒP Q
{
œœ %
RegisterCurrentCallback
–– '
(
––' ( 
lobbyActionOutcome
––( :
.
––: ;
Lobby
––; @
.
––@ A
	LobbyCode
––A J
,
––J K

hostUserId
––L V
)
––V W
;
––W X
}
—— 
LobbyResult
”” 
entryDecision
”” %
=
””& '
MapToLobbyResult
””( 8
(
””8 9 
lobbyActionOutcome
””9 K
)
””K L
;
””L M
if
‘‘ 
(
‘‘ 

hostUserId
‘‘ 
<
‘‘ 
$num
‘‘ 
)
‘‘ 
{
’’ 
entryDecision
÷÷ 
.
÷÷ 
GuestSessionToken
÷÷ /
=
÷÷0 1)
GuestParticipantCredentials
÷÷2 M
.
÷÷M N
GetCredential
÷÷N [
(
÷÷[ \

hostUserId
÷÷\ f
)
÷÷f g
;
÷÷g h
}
◊◊ 
return
ÿÿ 
entryDecision
ÿÿ  
;
ÿÿ  !
}
ŸŸ 	
public
€€ 
LobbyResult
€€ 
JoinLobbyByCode
€€ *
(
€€* +
string
€€+ 1
	lobbyCode
€€2 ;
,
€€; <
int
€€= @
userId
€€A G
)
€€G H
{
‹‹ 	/
!EnsureParticipantOperationAllowed
›› -
(
››- .
userId
››. 4
)
››4 5
;
››5 6 
LobbyActionOutcome
ﬁﬁ  
lobbyActionOutcome
ﬁﬁ 1
=
ﬁﬁ2 3
_lobbyUseCase
ﬁﬁ4 A
.
ﬁﬁA B
	JoinLobby
ﬁﬁB K
(
ﬁﬁK L
	lobbyCode
ﬁﬁL U
,
ﬁﬁU V
userId
ﬁﬁW ]
)
ﬁﬁ] ^
;
ﬁﬁ^ _
if
ﬂﬂ 
(
ﬂﬂ  
lobbyActionOutcome
ﬂﬂ "
.
ﬂﬂ" #
	IsSuccess
ﬂﬂ# ,
&&
ﬂﬂ- / 
lobbyActionOutcome
ﬂﬂ0 B
.
ﬂﬂB C
Lobby
ﬂﬂC H
!=
ﬂﬂI K
null
ﬂﬂL P
&&
ﬂﬂQ S 
lobbyActionOutcome
‡‡ "
.
‡‡" #
AffectedPlayer
‡‡# 1
!=
‡‡2 4
null
‡‡5 9
)
‡‡9 :
{
·· 
string
‚‚ 
canonicalCode
‚‚ $
=
‚‚% & 
lobbyActionOutcome
‚‚' 9
.
‚‚9 :
Lobby
‚‚: ?
.
‚‚? @
	LobbyCode
‚‚@ I
;
‚‚I J%
RegisterCurrentCallback
„„ '
(
„„' (
canonicalCode
„„( 5
,
„„5 6
userId
„„7 =
)
„„= >
;
„„> ?
LobbyPlayer
ÂÂ 
joinedPlayer
ÂÂ (
=
ÂÂ) *
MapToPlayerDto
ÂÂ+ 9
(
ÂÂ9 : 
lobbyActionOutcome
ÂÂ: L
.
ÂÂL M
AffectedPlayer
ÂÂM [
)
ÂÂ[ \
;
ÂÂ\ ]
BroadcastToRoom
ÊÊ 
(
ÊÊ  
canonicalCode
ÁÁ !
,
ÁÁ! "
userId
ËË 
,
ËË 
callback
ÈÈ 
=>
ÈÈ 
callback
ÈÈ  (
.
ÈÈ( )!
OnPlayerJoinedLobby
ÈÈ) <
(
ÈÈ< =
joinedPlayer
ÈÈ= I
)
ÈÈI J
)
ÈÈJ K
;
ÈÈK L
PublishLobbyState
ÍÍ !
(
ÍÍ! " 
lobbyActionOutcome
ÍÍ" 4
)
ÍÍ4 5
;
ÍÍ5 6
}
ÎÎ 
LobbyResult
ÌÌ 
entryDecision
ÌÌ %
=
ÌÌ& '
MapToLobbyResult
ÌÌ( 8
(
ÌÌ8 9 
lobbyActionOutcome
ÌÌ9 K
)
ÌÌK L
;
ÌÌL M
if
ÓÓ 
(
ÓÓ 
userId
ÓÓ 
<
ÓÓ 
$num
ÓÓ 
)
ÓÓ 
{
ÔÔ 
entryDecision
 
.
 
GuestSessionToken
 /
=
0 1)
GuestParticipantCredentials
2 M
.
M N
GetCredential
N [
(
[ \
userId
\ b
)
b c
;
c d
}
ÒÒ 
return
ÚÚ 
entryDecision
ÚÚ  
;
ÚÚ  !
}
ÛÛ 	
public
ıı 
void
ıı 

LeaveLobby
ıı 
(
ıı 
string
ıı %
	lobbyCode
ıı& /
,
ıı/ 0
int
ıı1 4
userId
ıı5 ;
)
ıı; <
{
ˆˆ 	/
!EnsureParticipantOperationAllowed
˜˜ -
(
˜˜- .
userId
˜˜. 4
)
˜˜4 5
;
˜˜5 6 
LobbyActionOutcome
¯¯  
lobbyActionOutcome
¯¯ 1
=
¯¯2 3
_lobbyUseCase
¯¯4 A
.
¯¯A B

LeaveLobby
¯¯B L
(
¯¯L M
	lobbyCode
¯¯M V
,
¯¯V W
userId
¯¯X ^
)
¯¯^ _
;
¯¯_ `
if
˘˘ 
(
˘˘  
lobbyActionOutcome
˘˘ "
.
˘˘" #
	IsSuccess
˘˘# ,
)
˘˘, -
{
˙˙  
UnregisterCallback
˚˚ "
(
˚˚" #
	lobbyCode
˚˚# ,
,
˚˚, -
userId
˚˚. 4
)
˚˚4 5
;
˚˚5 6#
NotifyPlayerDeparture
¸¸ %
(
¸¸% & 
lobbyActionOutcome
¸¸& 8
,
¸¸8 9
userId
¸¸: @
,
¸¸@ A
PlayerLeftReason
¸¸B R
)
¸¸R S
;
¸¸S T
}
˝˝ 
}
˛˛ 	
public
ÄÄ 
void
ÄÄ  
KickPlayerByUserId
ÄÄ &
(
ÄÄ& '
string
ÄÄ' -
	lobbyCode
ÄÄ. 7
,
ÄÄ7 8
int
ÄÄ9 <

hostUserId
ÄÄ= G
,
ÄÄG H
int
ÄÄI L
targetUserId
ÄÄM Y
)
ÄÄY Z
{
ÅÅ 	/
!EnsureParticipantOperationAllowed
ÇÇ -
(
ÇÇ- .

hostUserId
ÇÇ. 8
)
ÇÇ8 9
;
ÇÇ9 :)
EnsureRegisteredRoomChannel
ÉÉ '
(
ÉÉ' (
	lobbyCode
ÉÉ( 1
,
ÉÉ1 2

hostUserId
ÉÉ3 =
)
ÉÉ= >
;
ÉÉ> ? 
LobbyActionOutcome
ÑÑ  
lobbyActionOutcome
ÑÑ 1
=
ÑÑ2 3
_lobbyUseCase
ÑÑ4 A
.
ÑÑA B

KickPlayer
ÑÑB L
(
ÑÑL M
	lobbyCode
ÑÑM V
,
ÑÑV W

hostUserId
ÑÑX b
,
ÑÑb c
targetUserId
ÑÑd p
)
ÑÑp q
;
ÑÑq r
if
ÖÖ 
(
ÖÖ  
lobbyActionOutcome
ÖÖ "
.
ÖÖ" #
	IsSuccess
ÖÖ# ,
)
ÖÖ, -
{
ÜÜ 
BroadcastToRoom
áá 
(
áá  
	lobbyCode
àà 
,
àà 
excludedUserId
ââ "
:
ââ" #
null
ââ$ (
,
ââ( )
callback
ää 
=>
ää 
callback
ää  (
.
ää( )
OnPlayerLeftLobby
ää) :
(
ää: ;
targetUserId
ää; G
,
ääG H 
PlayerKickedReason
ääI [
)
ää[ \
)
ää\ ]
;
ää] ^ 
UnregisterCallback
ãã "
(
ãã" #
	lobbyCode
ãã# ,
,
ãã, -
targetUserId
ãã. :
)
ãã: ;
;
ãã; <
PublishLobbyState
åå !
(
åå! " 
lobbyActionOutcome
åå" 4
)
åå4 5
;
åå5 6
}
çç 
}
éé 	
public
ëë 
LobbyResult
ëë *
AuthorizeKickedPlayerReentry
ëë 7
(
ëë7 8
string
ëë8 >
	lobbyCode
ëë? H
,
ëëH I
int
ëëJ M

hostUserId
ëëN X
,
ëëX Y
int
ëëZ ]
targetUserId
ëë^ j
)
ëëj k
{
íí 	/
!EnsureParticipantOperationAllowed
ìì -
(
ìì- .

hostUserId
ìì. 8
)
ìì8 9
;
ìì9 :)
EnsureRegisteredRoomChannel
îî '
(
îî' (
	lobbyCode
îî( 1
,
îî1 2

hostUserId
îî3 =
)
îî= >
;
îî> ? 
LobbyActionOutcome
ïï "
reentryAuthorization
ïï 3
=
ïï4 5
_lobbyUseCase
ïï6 C
.
ïïC D*
AuthorizeKickedPlayerReentry
ïïD `
(
ïï` a
	lobbyCode
ññ 
,
ññ 

hostUserId
ññ %
,
ññ% &
targetUserId
ññ' 3
)
ññ3 4
;
ññ4 5
return
óó 
MapToLobbyResult
óó #
(
óó# $"
reentryAuthorization
óó$ 8
)
óó8 9
;
óó9 :
}
òò 	
public
öö 
void
öö "
SetPlayerReadyStatus
öö (
(
öö( )
string
öö) /
	lobbyCode
öö0 9
,
öö9 :
int
öö; >
userId
öö? E
,
ööE F
bool
ööG K
isReady
ööL S
)
ööS T
{
õõ 	/
!EnsureParticipantOperationAllowed
úú -
(
úú- .
userId
úú. 4
)
úú4 5
;
úú5 6 
LobbyActionOutcome
ùù  
lobbyActionOutcome
ùù 1
=
ùù2 3
_lobbyUseCase
ùù4 A
.
ùùA B#
UpdatePlayerReadiness
ùùB W
(
ùùW X
	lobbyCode
ùùX a
,
ùùa b
userId
ùùc i
,
ùùi j
isReady
ùùk r
)
ùùr s
;
ùùs t
if
ûû 
(
ûû  
lobbyActionOutcome
ûû "
.
ûû" #
	IsSuccess
ûû# ,
)
ûû, -
{
üü 
BroadcastToRoom
†† 
(
††  
	lobbyCode
°° 
,
°° 
excludedUserId
¢¢ "
:
¢¢" #
null
¢¢$ (
,
¢¢( )
callback
££ 
=>
££ 
callback
££  (
.
££( )(
OnPlayerReadyStatusChanged
££) C
(
££C D
userId
££D J
,
££J K
isReady
££L S
)
££S T
)
££T U
;
££U V
PublishLobbyState
§§ !
(
§§! " 
lobbyActionOutcome
§§" 4
)
§§4 5
;
§§5 6
}
•• 
}
¶¶ 	
public
®® /
!LobbyChatMessageSubmissionOutcome
®® 0"
SendLobbyChatMessage
®®1 E
(
®®E F(
LobbyChatMessageSubmission
©© &#
chatMessageSubmission
©©' <
)
©©< =
{
™™ 	/
!LobbyChatMessageSubmissionOutcome
´´ -*
chatMessageSubmissionOutcome
´´. J
=
´´K L
new
´´M P/
!LobbyChatMessageSubmissionOutcome
´´Q r
{
¨¨ (
ChatMessageRejectionReason
≠≠ *
=
≠≠+ ,-
LobbyChatMessageRejectionReason
≠≠- L
.
≠≠L M 
InvalidChatMessage
≠≠M _
}
ÆÆ 
;
ÆÆ 
try
ØØ 
{
∞∞ *
chatMessageSubmissionOutcome
±± ,
=
±±- .-
ProcessAuthenticatedChatMessage
±±/ N
(
±±N O#
chatMessageSubmission
±±O d
)
±±d e
;
±±e f
}
≤≤ 
catch
≥≥ 
(
≥≥ '
InvalidOperationException
≥≥ ,
ex
≥≥- /
)
≥≥/ 0
{
¥¥ 
_logger
µµ 
.
µµ 
Error
µµ 
(
µµ 
ex
µµ  
,
µµ  !(
ChatStorageFailureTemplate
µµ" <
,
µµ< =#
chatMessageSubmission
µµ> S
?
µµS T
.
µµT U
	LobbyCode
µµU ^
)
µµ^ _
;
µµ_ `*
chatMessageSubmissionOutcome
∂∂ ,
.
∂∂, -(
ChatMessageRejectionReason
∂∂- G
=
∂∂H I-
LobbyChatMessageRejectionReason
∑∑ 3
.
∑∑3 4$
ChatStorageUnavailable
∑∑4 J
;
∑∑J K
}
∏∏ 
catch
ππ 
(
ππ (
RegexMatchTimeoutException
ππ -
)
ππ- .
{
∫∫ 
_logger
ªª 
.
ªª 
Warning
ªª 
(
ªª  +
ChatModerationTimeoutTemplate
ªª  =
,
ªª= >#
chatMessageSubmission
ªª? T
?
ªªT U
.
ªªU V
	LobbyCode
ªªV _
)
ªª_ `
;
ªª` a*
chatMessageSubmissionOutcome
ºº ,
.
ºº, -(
ChatMessageRejectionReason
ºº- G
=
ººH I-
LobbyChatMessageRejectionReason
ΩΩ 3
.
ΩΩ3 4'
ChatModerationUnavailable
ΩΩ4 M
;
ΩΩM N
}
ææ 
catch
øø 
(
øø 
ArgumentException
øø $
)
øø$ %
{
¿¿ 
_logger
¡¡ 
.
¡¡ 
Warning
¡¡ 
(
¡¡  +
ChatSubmissionInvalidTemplate
¡¡  =
,
¡¡= >#
chatMessageSubmission
¡¡? T
?
¡¡T U
.
¡¡U V
	LobbyCode
¡¡V _
)
¡¡_ `
;
¡¡` a*
chatMessageSubmissionOutcome
¬¬ ,
.
¬¬, -(
ChatMessageRejectionReason
¬¬- G
=
¬¬H I-
LobbyChatMessageRejectionReason
√√ 3
.
√√3 4 
InvalidChatMessage
√√4 F
;
√√F G
}
ƒƒ 
return
∆∆ *
chatMessageSubmissionOutcome
∆∆ /
;
∆∆/ 0
}
«« 	
private
…… /
!LobbyChatMessageSubmissionOutcome
…… 1-
ProcessAuthenticatedChatMessage
……2 Q
(
……Q R(
LobbyChatMessageSubmission
   &#
chatMessageSubmission
  ' <
)
  < =
{
ÀÀ 	/
!LobbyChatMessageSubmissionOutcome
ÃÃ -*
chatMessageSubmissionOutcome
ÃÃ. J
=
ÃÃK L
new
ÃÃM P/
!LobbyChatMessageSubmissionOutcome
ÃÃQ r
{
ÕÕ (
ChatMessageRejectionReason
ŒŒ *
=
ŒŒ+ ,-
LobbyChatMessageRejectionReason
ŒŒ- L
.
ŒŒL M(
ChatAuthenticationRequired
ŒŒM g
}
œœ 
;
œœ 
int
–– (
authenticatedAccountUserId
–– *
=
––+ ,"
_accountAccessPolicy
––- A
.
––A B)
ResolveAllowedAccountUserId
––B ]
(
––] ^"
AccountSessionHeader
—— $
.
——$ %,
ReadCurrentAccountSessionToken
——% C
(
——C D
)
——D E
)
——E F
;
——F G
if
““ 
(
““ #
chatMessageSubmission
““ %
!=
““& (
null
““) -
&&
““. 0(
authenticatedAccountUserId
““1 K
>
““L M
$num
““N O
)
““O P
{
”” *
chatMessageSubmissionOutcome
‘‘ ,
.
‘‘, -%
ChatMessageSubmissionId
‘‘- D
=
‘‘E F#
chatMessageSubmission
‘‘G \
.
‘‘\ ]%
ChatMessageSubmissionId
‘‘] t
;
‘‘t u
string
’’ !
participantUsername
’’ *
=
’’+ ,
_lobbyUseCase
’’- :
.
’’: ;$
GetParticipantUsername
’’; Q
(
’’Q R#
chatMessageSubmission
÷÷ )
.
÷÷) *
	LobbyCode
÷÷* 3
,
÷÷3 4(
authenticatedAccountUserId
÷÷5 O
)
÷÷O P
;
÷÷P Q
if
◊◊ 
(
◊◊ 
!
◊◊ 
string
◊◊ 
.
◊◊ 
IsNullOrEmpty
◊◊ )
(
◊◊) *!
participantUsername
◊◊* =
)
◊◊= >
)
◊◊> ?
{
ÿÿ *
chatMessageSubmissionOutcome
ŸŸ 0
=
ŸŸ1 2+
ProcessParticipantChatMessage
ŸŸ3 P
(
ŸŸP Q#
chatMessageSubmission
ŸŸQ f
,
ŸŸf g(
authenticatedAccountUserId
⁄⁄ 2
,
⁄⁄2 3!
participantUsername
⁄⁄4 G
)
⁄⁄G H
;
⁄⁄H I
}
€€ 
else
‹‹ 
{
›› *
chatMessageSubmissionOutcome
ﬁﬁ 0
.
ﬁﬁ0 1(
ChatMessageRejectionReason
ﬁﬁ1 K
=
ﬁﬁL M-
LobbyChatMessageRejectionReason
ﬂﬂ 7
.
ﬂﬂ7 8'
ChatParticipantNotInLobby
ﬂﬂ8 Q
;
ﬂﬂQ R
}
‡‡ 
}
·· 
return
„„ *
chatMessageSubmissionOutcome
„„ /
;
„„/ 0
}
‰‰ 	
private
ÊÊ /
!LobbyChatMessageSubmissionOutcome
ÊÊ 1+
ProcessParticipantChatMessage
ÊÊ2 O
(
ÊÊO P(
LobbyChatMessageSubmission
ÁÁ &#
chatMessageSubmission
ÁÁ' <
,
ÁÁ< =
int
ÁÁ> A(
authenticatedAccountUserId
ÁÁB \
,
ÁÁ\ ]
string
ËË !
participantUsername
ËË &
)
ËË& '
{
ÈÈ 	(
LobbyChatMessageProcessing
ÍÍ &#
chatMessageProcessing
ÍÍ' <
=
ÍÍ= >&
_lobbyChatMessageUseCase
ÍÍ? W
.
ÍÍW X 
ProcessChatMessage
ÍÍX j
(
ÍÍj k
new
ÎÎ 0
"AuthenticatedChatMessageSubmission
ÎÎ 6
{
ÏÏ 
AccountUserId
ÌÌ !
=
ÌÌ" #(
authenticatedAccountUserId
ÌÌ$ >
,
ÌÌ> ?%
ChatMessageSubmissionId
ÓÓ +
=
ÓÓ, -#
chatMessageSubmission
ÓÓ. C
.
ÓÓC D%
ChatMessageSubmissionId
ÓÓD [
,
ÓÓ[ \
	LobbyCode
ÔÔ 
=
ÔÔ #
chatMessageSubmission
ÔÔ  5
.
ÔÔ5 6
	LobbyCode
ÔÔ6 ?
,
ÔÔ? @%
OriginalChatMessageText
 +
=
, -#
chatMessageSubmission
. C
.
C D%
OriginalChatMessageText
D [
}
ÒÒ 
)
ÒÒ 
;
ÒÒ /
!LobbyChatMessageSubmissionOutcome
ÚÚ -*
chatMessageSubmissionOutcome
ÚÚ. J
=
ÚÚK L&
MapChatSubmissionOutcome
ÚÚM e
(
ÚÚe f#
chatMessageSubmission
ÛÛ %
,
ÛÛ% &#
chatMessageProcessing
ÛÛ' <
)
ÛÛ< =
;
ÛÛ= >
if
ÙÙ 
(
ÙÙ *
chatMessageSubmissionOutcome
ÙÙ ,
.
ÙÙ, -"
ChatAccountBanNotice
ÙÙ- A
!=
ÙÙB D
null
ÙÙE I
)
ÙÙI J
{
ıı ,
RemoveBannedAccountFromLobbies
ˆˆ .
(
ˆˆ. /(
authenticatedAccountUserId
ˆˆ/ I
,
ˆˆI J*
chatMessageSubmissionOutcome
˜˜ 0
.
˜˜0 1"
ChatAccountBanNotice
˜˜1 E
)
˜˜E F
;
˜˜F G
}
¯¯ 
else
˘˘ 
if
˘˘ 
(
˘˘ #
chatMessageProcessing
˘˘ *
.
˘˘* +#
CanPublishChatMessage
˘˘+ @
&&
˘˘A C*
chatMessageSubmissionOutcome
˘˘D `
.
˘˘` a#
IsChatMessageAccepted
˘˘a v
)
˘˘v w
{
˙˙ 
LobbyMessage
˚˚ "
publishedChatMessage
˚˚ 1
=
˚˚2 3
new
˚˚4 7
LobbyMessage
˚˚8 D
{
¸¸ 
SenderUserId
˝˝  
=
˝˝! "(
authenticatedAccountUserId
˝˝# =
,
˝˝= >
SenderUsername
˛˛ "
=
˛˛# $!
participantUsername
˛˛% 8
,
˛˛8 9
Message
ˇˇ 
=
ˇˇ #
chatMessageProcessing
ˇˇ 3
.
ˇˇ3 4%
CensoredChatMessageText
ˇˇ4 K
,
ˇˇK L
SentAt
ÄÄ 
=
ÄÄ 
DateTime
ÄÄ %
.
ÄÄ% &
UtcNow
ÄÄ& ,
}
ÅÅ 
;
ÅÅ 
BroadcastToRoom
ÇÇ 
(
ÇÇ  #
chatMessageSubmission
ÇÇ  5
.
ÇÇ5 6
	LobbyCode
ÇÇ6 ?
,
ÇÇ? @
null
ÇÇA E
,
ÇÇE F!
participantCallback
ÉÉ '
=>
ÉÉ( *!
participantCallback
ÉÉ+ >
.
ÉÉ> ?'
OnReceiveLobbyChatMessage
ÉÉ? X
(
ÉÉX Y"
publishedChatMessage
ÉÉY m
)
ÉÉm n
)
ÉÉn o
;
ÉÉo p
}
ÑÑ 
return
ÜÜ *
chatMessageSubmissionOutcome
ÜÜ /
;
ÜÜ/ 0
}
áá 	
private
ââ 
static
ââ /
!LobbyChatMessageSubmissionOutcome
ââ 8&
MapChatSubmissionOutcome
ââ9 Q
(
ââQ R(
LobbyChatMessageSubmission
ää &#
chatMessageSubmission
ää' <
,
ää< =(
LobbyChatMessageProcessing
ää> X#
chatMessageProcessing
ääY n
)
ään o
{
ãã 	"
ChatInfractionRecord
åå   
recordedInfraction
åå! 3
=
åå4 5#
chatMessageProcessing
åå6 K
.
ååK L$
RecordedChatInfraction
ååL b
;
ååb c/
!LobbyChatMessageSubmissionOutcome
çç -*
chatMessageSubmissionOutcome
çç. J
=
ççK L
new
ççM P/
!LobbyChatMessageSubmissionOutcome
ççQ r
{
éé %
ChatMessageSubmissionId
èè '
=
èè( )#
chatMessageSubmission
èè* ?
.
èè? @%
ChatMessageSubmissionId
èè@ W
,
èèW X(
ChatMessageRejectionReason
êê *
=
êê+ ,-
LobbyChatMessageRejectionMapper
êê- L
.
êêL M 
MapRejectionReason
êêM _
(
êê_ `#
chatMessageProcessing
ëë )
.
ëë) *(
ChatMessageRejectionReason
ëë* D
)
ëëD E
,
ëëE F#
IsChatMessageAccepted
íí %
=
íí& '#
chatMessageProcessing
íí( =
.
íí= >(
ChatMessageRejectionReason
íí> X
==
ííY [(
ChatMessageRejectionReason
ìì .
.
ìì. /
None
ìì/ 3
}
îî 
;
îî 
if
ïï 
(
ïï  
recordedInfraction
ïï "
!=
ïï# %
null
ïï& *
)
ïï* +
{
ññ *
chatMessageSubmissionOutcome
óó ,
.
óó, --
IsRepeatedChatMessageSubmission
óó- L
=
óóM N 
recordedInfraction
òò &
.
òò& '-
IsRepeatedChatMessageSubmission
òò' F
;
òòF G*
chatMessageSubmissionOutcome
ôô ,
.
ôô, -"
ChatInfractionNotice
ôô- A
=
ôôB C(
CreateChatInfractionNotice
ôôD ^
(
ôô^ _#
chatMessageSubmission
öö )
.
öö) *%
ChatMessageSubmissionId
öö* A
,
ööA B 
recordedInfraction
ööC U
)
ööU V
;
ööV W
if
õõ 
(
õõ  
recordedInfraction
õõ &
.
õõ& '
IsAccountBanned
õõ' 6
)
õõ6 7
{
úú *
chatMessageSubmissionOutcome
ùù 0
.
ùù0 1"
ChatAccountBanNotice
ùù1 E
=
ùùF G(
CreateChatAccountBanNotice
ùùH b
(
ùùb c#
chatMessageSubmission
ûû -
.
ûû- .%
ChatMessageSubmissionId
ûû. E
,
ûûE F 
recordedInfraction
ûûG Y
.
ûûY Z$
AccountInfractionState
ûûZ p
)
ûûp q
;
ûûq r
}
üü 
}
†† 
return
¢¢ *
chatMessageSubmissionOutcome
¢¢ /
;
¢¢/ 0
}
££ 	
private
•• 
static
•• "
ChatInfractionNotice
•• +(
CreateChatInfractionNotice
••, F
(
••F G
Guid
••G K%
chatMessageSubmissionId
••L c
,
••c d"
ChatInfractionRecord
¶¶   
recordedInfraction
¶¶! 3
)
¶¶3 4
{
ßß 	(
ChatAccountInfractionState
®® &$
accountInfractionState
®®' =
=
®®> ? 
recordedInfraction
®®@ R
.
®®R S$
AccountInfractionState
®®S i
;
®®i j
return
©© 
new
©© "
ChatInfractionNotice
©© +
{
™™ %
ChatMessageSubmissionId
´´ '
=
´´( )%
chatMessageSubmissionId
´´* A
,
´´A B,
CurrentMessageInfractionPoints
¨¨ .
=
¨¨/ 0 
recordedInfraction
¨¨1 C
.
¨¨C D,
CurrentMessageInfractionPoints
¨¨D b
,
¨¨b c-
AccumulatedChatInfractionPoints
≠≠ /
=
≠≠0 1$
accountInfractionState
≠≠2 H
.
≠≠H I-
AccumulatedChatInfractionPoints
≠≠I h
,
≠≠h i*
ChatInfractionPointThreshold
ÆÆ ,
=
ÆÆ- .!
ChatInfractionRules
ÆÆ/ B
.
ÆÆB C*
ChatInfractionPointThreshold
ÆÆC _
,
ÆÆ_ `4
&RemainingChatInfractionPointsBeforeBan
ØØ 6
=
ØØ7 8
Math
ØØ9 =
.
ØØ= >
Max
ØØ> A
(
ØØA B
$num
ØØB C
,
ØØC D!
ChatInfractionRules
ØØE X
.
ØØX Y*
ChatInfractionPointThreshold
ØØY u
-
ØØv w$
accountInfractionState
∞∞ *
.
∞∞* +-
AccumulatedChatInfractionPoints
∞∞+ J
)
∞∞J K
,
∞∞K L)
ThreateningChatMessageCount
±± +
=
±±, -$
accountInfractionState
±±. D
.
±±D E)
ThreateningChatMessageCount
±±E `
}
≤≤ 
;
≤≤ 
}
≥≥ 	
private
µµ 
static
µµ "
ChatAccountBanNotice
µµ +(
CreateChatAccountBanNotice
µµ, F
(
µµF G
Guid
µµG K%
chatMessageSubmissionId
µµL c
,
µµc d(
ChatAccountInfractionState
∂∂ &$
accountInfractionState
∂∂' =
)
∂∂= >
{
∑∑ 	 
ChatAccountBanType
∏∏  
chatAccountBanType
∏∏ 1
=
∏∏2 3 
ChatAccountBanType
∏∏4 F
.
∏∏F G
	Temporary
∏∏G P
;
∏∏P Q
if
ππ 
(
ππ $
accountInfractionState
ππ &
.
ππ& ',
IsChatAccountPermanentlyBanned
ππ' E
)
ππE F
{
∫∫  
chatAccountBanType
ªª "
=
ªª# $ 
ChatAccountBanType
ªª% 7
.
ªª7 8
	Permanent
ªª8 A
;
ªªA B
}
ºº 
return
ææ 
new
ææ "
ChatAccountBanNotice
ææ +
{
øø %
ChatMessageSubmissionId
¿¿ '
=
¿¿( )%
chatMessageSubmissionId
¿¿* A
,
¿¿A B 
ChatAccountBanType
¡¡ "
=
¡¡# $ 
chatAccountBanType
¡¡% 7
,
¡¡7 8
EvaluatedAtUtc
¬¬ 
=
¬¬  
DateTime
¬¬! )
.
¬¬) *
UtcNow
¬¬* 0
,
¬¬0 1%
ChatAccountBanEndsAtUtc
√√ '
=
√√( )$
accountInfractionState
√√* @
.
√√@ A%
ChatAccountBanEndsAtUtc
√√A X
}
ƒƒ 
;
ƒƒ 
}
≈≈ 	
private
«« 
void
«« ,
RemoveBannedAccountFromLobbies
«« 3
(
««3 4
int
««4 7
accountUserId
««8 E
,
««E F"
ChatAccountBanNotice
««G ["
chatAccountBanNotice
««\ p
)
««p q
{
»» 	"
_accountAccessPolicy
……  
.
……  !#
RevokeAccountSessions
……! 6
(
……6 7
accountUserId
……7 D
)
……D E
;
……E F
foreach
   
(
   
KeyValuePair
   !
<
  ! "
string
  " (
,
  ( )"
ConcurrentDictionary
  * >
<
  > ?
int
  ? B
,
  B C
ILobbyCallback
  D R
>
  R S
>
  S T
lobbyCallbacks
  U c
in
  d f
s_roomCallbacks
  g v
)
  v w
{
ÀÀ 
if
ÃÃ 
(
ÃÃ 
lobbyCallbacks
ÃÃ "
.
ÃÃ" #
Value
ÃÃ# (
.
ÃÃ( )
TryGetValue
ÃÃ) 4
(
ÃÃ4 5
accountUserId
ÃÃ5 B
,
ÃÃB C
out
ÃÃD G
ILobbyCallback
ÃÃH V
accountCallback
ÃÃW f
)
ÃÃf g
)
ÃÃg h
{
ÕÕ  
LobbyActionOutcome
ŒŒ &%
accountDepartureOutcome
ŒŒ' >
=
ŒŒ? @
_lobbyUseCase
ŒŒA N
.
ŒŒN O

LeaveLobby
ŒŒO Y
(
ŒŒY Z
lobbyCallbacks
œœ &
.
œœ& '
Key
œœ' *
,
œœ* +
accountUserId
œœ, 9
)
œœ9 :
;
œœ: ; 
UnregisterCallback
–– &
(
––& '
lobbyCallbacks
––' 5
.
––5 6
Key
––6 9
,
––9 :
accountUserId
––; H
)
––H I
;
––I J$
NotifyAccountBanSafely
—— *
(
——* +
accountCallback
——+ :
,
——: ;"
chatAccountBanNotice
——< P
)
——P Q
;
——Q R#
NotifyPlayerDeparture
““ )
(
““) *%
accountDepartureOutcome
““* A
,
““A B
accountUserId
““C P
,
““P Q&
ReasonParticipantRemoved
““R j
)
““j k
;
““k l
}
”” 
}
‘‘ 
}
’’ 	
private
◊◊ 
void
◊◊ $
NotifyAccountBanSafely
◊◊ +
(
◊◊+ ,
ILobbyCallback
◊◊, :
accountCallback
◊◊; J
,
◊◊J K"
ChatAccountBanNotice
◊◊L `"
chatAccountBanNotice
◊◊a u
)
◊◊u v
{
ÿÿ 	
try
ŸŸ 
{
⁄⁄ 
accountCallback
€€ 
.
€€  %
OnChatAccountBanApplied
€€  7
(
€€7 8"
chatAccountBanNotice
€€8 L
)
€€L M
;
€€M N
}
‹‹ 
catch
›› 
(
›› $
CommunicationException
›› )
)
››) *
{
ﬁﬁ 
_logger
‡‡ 
.
‡‡ 
Warning
‡‡ 
(
‡‡  5
'BanCallbackCommunicationFaultedTemplate
‡‡  G
)
‡‡G H
;
‡‡H I
}
·· 
catch
‚‚ 
(
‚‚ 
TimeoutException
‚‚ #
)
‚‚# $
{
„„ 
_logger
ÂÂ 
.
ÂÂ 
Warning
ÂÂ 
(
ÂÂ  (
BanCallbackTimeoutTemplate
ÂÂ  :
)
ÂÂ: ;
;
ÂÂ; <
}
ÊÊ 
}
ÁÁ 	
private
ÈÈ 
void
ÈÈ /
!EnsureParticipantOperationAllowed
ÈÈ 6
(
ÈÈ6 7
int
ÈÈ7 :
participantUserId
ÈÈ; L
)
ÈÈL M
{
ÍÍ 	
if
ÎÎ 
(
ÎÎ 
participantUserId
ÎÎ !
<
ÎÎ" #
$num
ÎÎ$ %
)
ÎÎ% &
{
ÏÏ )
GuestParticipantCredentials
ÌÌ +
.
ÌÌ+ , 
EnsureGuestAllowed
ÌÌ, >
(
ÌÌ> ?
participantUserId
ÌÌ? P
)
ÌÌP Q
;
ÌÌQ R
}
ÓÓ 
bool
ÔÔ (
isRegisteredAccountAllowed
ÔÔ +
=
ÔÔ, -"
_accountAccessPolicy
ÔÔ. B
.
ÔÔB C'
IsAccountOperationAllowed
ÔÔC \
(
ÔÔ\ ]
participantUserId
 !
,
! ""
AccountSessionHeader
# 7
.
7 8,
ReadCurrentAccountSessionToken
8 V
(
V W
)
W X
)
X Y
;
Y Z
if
ÒÒ 
(
ÒÒ 
participantUserId
ÒÒ !
>=
ÒÒ" $
$num
ÒÒ% &
&&
ÒÒ' )
!
ÒÒ* +(
isRegisteredAccountAllowed
ÒÒ+ E
)
ÒÒE F
{
ÚÚ 
throw
ÛÛ 
new
ÛÛ 
FaultException
ÛÛ (
(
ÛÛ( )(
ChatMessageRejectionReason
ÛÛ) C
.
ÛÛC D(
ChatAuthenticationRequired
ÛÛD ^
.
ÛÛ^ _
ToString
ÛÛ_ g
(
ÛÛg h
)
ÛÛh i
)
ÛÛi j
;
ÛÛj k
}
ÙÙ 
}
ıı 	
public
˜˜ 
void
˜˜  
StartGameFromLobby
˜˜ &
(
˜˜& '
string
˜˜' -
	lobbyCode
˜˜. 7
,
˜˜7 8
int
˜˜9 <

hostUserId
˜˜= G
)
˜˜G H
{
¯¯ 	/
!EnsureParticipantOperationAllowed
˘˘ -
(
˘˘- .

hostUserId
˘˘. 8
)
˘˘8 9
;
˘˘9 :)
EnsureRegisteredRoomChannel
˙˙ '
(
˙˙' (
	lobbyCode
˙˙( 1
,
˙˙1 2

hostUserId
˙˙3 =
)
˙˙= >
;
˙˙> ?
bool
˚˚ 
canStart
˚˚ 
;
˚˚ 
try
¸¸ 
{
˝˝ 
canStart
˛˛ 
=
˛˛ 
_lobbyUseCase
˛˛ (
.
˛˛( )&
CanTransitionLobbyToGame
˛˛) A
(
˛˛A B
	lobbyCode
˛˛B K
,
˛˛K L

hostUserId
˛˛M W
)
˛˛W X
;
˛˛X Y
}
ˇˇ 
catch
ÄÄ 
(
ÄÄ '
InvalidOperationException
ÄÄ ,
ex
ÄÄ- /
)
ÄÄ/ 0
{
ÅÅ 
_logger
ÇÇ 
.
ÇÇ 
Error
ÇÇ 
(
ÇÇ 
ex
ÇÇ  
,
ÇÇ  !4
&MatchStartupPersistenceFailureTemplate
ÇÇ" H
,
ÇÇH I
	lobbyCode
ÇÇJ S
)
ÇÇS T
;
ÇÇT U
throw
ÉÉ 
new
ÉÉ 
FaultException
ÉÉ (
(
ÉÉ( )#
FaultMatchUnavailable
ÉÉ) >
)
ÉÉ> ?
;
ÉÉ? @
}
ÑÑ 
if
ÖÖ 
(
ÖÖ 
canStart
ÖÖ 
)
ÖÖ 
{
ÜÜ 
int
áá 
generatedGameId
áá #
=
áá$ %
NormalizeRoomKey
áá& 6
(
áá6 7
	lobbyCode
áá7 @
)
áá@ A
.
ááA B
GetHashCode
ááB M
(
ááM N
)
ááN O
&
ááP Q
int
ááR U
.
ááU V
MaxValue
ááV ^
;
áá^ _
BroadcastToRoom
àà 
(
àà  
	lobbyCode
ââ 
,
ââ 
excludedUserId
ää "
:
ää" #
null
ää$ (
,
ää( )
callback
ãã 
=>
ãã 
callback
ãã  (
.
ãã( )
OnGameStarting
ãã) 7
(
ãã7 8
generatedGameId
ãã8 G
)
ããG H
)
ããH I
;
ããI J
}
åå 
else
çç 
{
éé 
throw
èè 
new
èè 
FaultException
èè (
(
èè( )%
FaultMatchStartRejected
èè) @
)
èè@ A
;
èèA B
}
êê 
}
ëë 	
private
ìì 
void
ìì #
NotifyPlayerDeparture
ìì *
(
ìì* + 
LobbyActionOutcome
ìì+ ="
participantDeparture
ìì> R
,
ììR S
int
ììT W
userId
ììX ^
,
ìì^ _
string
ìì` f
departureReason
ììg v
)
ììv w
{
îî 	
if
ïï 
(
ïï "
participantDeparture
ïï $
.
ïï$ %
Lobby
ïï% *
!=
ïï+ -
null
ïï. 2
&&
ïï3 5"
participantDeparture
ïï6 J
.
ïïJ K
	IsSuccess
ïïK T
)
ïïT U
{
ññ )
PublishParticipantDeparture
óó +
(
óó+ ,"
participantDeparture
óó, @
,
óó@ A
userId
óóB H
,
óóH I
departureReason
óóJ Y
)
óóY Z
;
óóZ [
}
òò 
}
ôô 	
private
õõ 
void
õõ )
PublishParticipantDeparture
õõ 0
(
õõ0 1 
LobbyActionOutcome
õõ1 C"
participantDeparture
õõD X
,
õõX Y
int
õõZ ]
userId
õõ^ d
,
õõd e
string
úú 
departureReason
úú "
)
úú" #
{
ùù 	
string
ûû 
	lobbyCode
ûû 
=
ûû "
participantDeparture
ûû 3
.
ûû3 4
Lobby
ûû4 9
.
ûû9 :
	LobbyCode
ûû: C
;
ûûC D
if
üü 
(
üü "
participantDeparture
üü $
.
üü$ %
IsRoomDisbanded
üü% 4
)
üü4 5
{
†† 
lock
°° 
(
°°  
LobbyMatchPresence
°° (
.
°°( )
RegistryGate
°°) 5
)
°°5 6
{
¢¢ 
s_roomCallbacks
££ #
.
££# $
	TryRemove
££$ -
(
££- .
NormalizeRoomKey
££. >
(
££> ?
	lobbyCode
££? H
)
££H I
,
££I J
out
§§ "
ConcurrentDictionary
§§ 0
<
§§0 1
int
§§1 4
,
§§4 5
ILobbyCallback
§§6 D
>
§§D E
_
§§F G
)
§§G H
;
§§H I 
LobbyMatchPresence
•• &
.
••& '

ForgetRoom
••' 1
(
••1 2
NormalizeRoomKey
••2 B
(
••B C
	lobbyCode
••C L
)
••L M
)
••M N
;
••N O
}
¶¶ 
}
ßß 
else
®® 
{
©© 
BroadcastToRoom
™™ 
(
™™  
	lobbyCode
™™  )
,
™™) *
userId
™™+ 1
,
™™1 2
callback
´´ 
=>
´´ 
callback
´´  (
.
´´( )
OnPlayerLeftLobby
´´) :
(
´´: ;
userId
´´; A
,
´´A B
departureReason
´´C R
)
´´R S
)
´´S T
;
´´T U
PublishLobbyState
¨¨ !
(
¨¨! ""
participantDeparture
¨¨" 6
)
¨¨6 7
;
¨¨7 8
}
≠≠ 
}
ÆÆ 	
private
ØØ 
void
ØØ %
RegisterCurrentCallback
ØØ ,
(
ØØ, -
string
ØØ- 3
	lobbyCode
ØØ4 =
,
ØØ= >
int
ØØ? B
userId
ØØC I
)
ØØI J
{
∞∞ 	
OperationContext
±± 
context
±± $
=
±±% &
OperationContext
±±' 7
.
±±7 8
Current
±±8 ?
;
±±? @
ILobbyCallback
≤≤ 
callback
≤≤ #
=
≤≤$ %
context
≤≤& -
!=
≤≤. 0
null
≤≤1 5
?
≥≥ 
context
≥≥ 
.
≥≥  
GetCallbackChannel
≥≥ ,
<
≥≥, -
ILobbyCallback
≥≥- ;
>
≥≥; <
(
≥≥< =
)
≥≥= >
:
¥¥ 
null
¥¥ 
;
¥¥ 
if
∂∂ 
(
∂∂ 
callback
∂∂ 
!=
∂∂ 
null
∂∂  
)
∂∂  !
{
∑∑ 
string
∏∏ 
roomKey
∏∏ 
=
∏∏  
NormalizeRoomKey
∏∏! 1
(
∏∏1 2
	lobbyCode
∏∏2 ;
)
∏∏; <
;
∏∏< ="
ConcurrentDictionary
ππ $
<
ππ$ %
int
ππ% (
,
ππ( )
ILobbyCallback
ππ* 8
>
ππ8 9
participants
ππ: F
=
ππG H
s_roomCallbacks
ππI X
.
ππX Y
GetOrAdd
ππY a
(
ππa b
roomKey
ππb i
,
ππi j
_
∫∫ 
=>
∫∫ 
new
∫∫ "
ConcurrentDictionary
∫∫ 1
<
∫∫1 2
int
∫∫2 5
,
∫∫5 6
ILobbyCallback
∫∫7 E
>
∫∫E F
(
∫∫F G
)
∫∫G H
)
∫∫H I
;
∫∫I J
lock
ªª 
(
ªª  
LobbyMatchPresence
ªª (
.
ªª( )
RegistryGate
ªª) 5
)
ªª5 6
{
ºº 
bool
ΩΩ 
hasNewChannel
ΩΩ &
=
ΩΩ' (
!
ΩΩ) *
participants
ΩΩ* 6
.
ΩΩ6 7
TryGetValue
ΩΩ7 B
(
ΩΩB C
userId
ΩΩC I
,
ΩΩI J
out
ΩΩK N
ILobbyCallback
ΩΩO ]
previousCallback
ΩΩ^ n
)
ΩΩn o
||
ΩΩp r
!
ææ 
ReferenceEquals
ææ (
(
ææ( )
previousCallback
ææ) 9
,
ææ9 :
callback
ææ; C
)
ææC D
;
ææD E
participants
øø  
[
øø  !
userId
øø! '
]
øø' (
=
øø) *
callback
øø+ 3
;
øø3 4
if
¿¿ 
(
¿¿ 
hasNewChannel
¿¿ %
)
¿¿% &
{
¡¡  
LobbyMatchPresence
¬¬ *
.
¬¬* +$
MarkConnectionsChanged
¬¬+ A
(
¬¬A B
roomKey
¬¬B I
)
¬¬I J
;
¬¬J K
}
√√  
LobbyMatchPresence
ƒƒ &
.
ƒƒ& '
Touch
ƒƒ' ,
(
ƒƒ, -
roomKey
ƒƒ- 4
,
ƒƒ4 5
userId
ƒƒ6 <
,
ƒƒ< =
context
ƒƒ> E
.
ƒƒE F
	SessionId
ƒƒF O
)
ƒƒO P
;
ƒƒP Q
}
≈≈ '
ObserveParticipantChannel
∆∆ )
(
∆∆) *
callback
∆∆* 2
)
∆∆2 3
;
∆∆3 4
}
«« 
}
»» 	
private
   
static
   
void
    
UnregisterCallback
   .
(
  . /
string
  / 5
	lobbyCode
  6 ?
,
  ? @
int
  A D
userId
  E K
)
  K L
{
ÀÀ 	
string
ÃÃ 
roomKey
ÃÃ 
=
ÃÃ 
NormalizeRoomKey
ÃÃ -
(
ÃÃ- .
	lobbyCode
ÃÃ. 7
)
ÃÃ7 8
;
ÃÃ8 9
if
ÕÕ 
(
ÕÕ 
s_roomCallbacks
ÕÕ 
.
ÕÕ  
TryGetValue
ÕÕ  +
(
ÕÕ+ ,
roomKey
ÕÕ, 3
,
ÕÕ3 4
out
ÕÕ5 8"
ConcurrentDictionary
ÕÕ9 M
<
ÕÕM N
int
ÕÕN Q
,
ÕÕQ R
ILobbyCallback
ÕÕS a
>
ÕÕa b
participants
ÕÕc o
)
ÕÕo p
)
ÕÕp q
{
ŒŒ 
lock
œœ 
(
œœ  
LobbyMatchPresence
œœ (
.
œœ( )
RegistryGate
œœ) 5
)
œœ5 6
{
–– 
if
—— 
(
—— 
participants
—— $
.
——$ %
	TryRemove
——% .
(
——. /
userId
——/ 5
,
——5 6
out
——7 :
ILobbyCallback
——; I
_
——J K
)
——K L
)
——L M
{
““  
LobbyMatchPresence
”” *
.
””* +$
MarkConnectionsChanged
””+ A
(
””A B
roomKey
””B I
)
””I J
;
””J K
}
‘‘ 
}
’’ 
}
÷÷ 
}
◊◊ 	
internal
ŸŸ 
static
ŸŸ 
KeyValuePair
ŸŸ $
<
ŸŸ$ %
int
ŸŸ% (
,
ŸŸ( )
ILobbyCallback
ŸŸ* 8
>
ŸŸ8 9
[
ŸŸ9 :
]
ŸŸ: ;
GetMatchCallbacks
ŸŸ< M
(
ŸŸM N
string
ŸŸN T
	lobbyCode
ŸŸU ^
)
ŸŸ^ _
{
⁄⁄ 	
KeyValuePair
€€ 
<
€€ 
int
€€ 
,
€€ 
ILobbyCallback
€€ ,
>
€€, -
[
€€- .
]
€€. /
	callbacks
€€0 9
=
€€: ;
Array
€€< A
.
€€A B
Empty
€€B G
<
€€G H
KeyValuePair
€€H T
<
€€T U
int
€€U X
,
€€X Y
ILobbyCallback
€€Z h
>
€€h i
>
€€i j
(
€€j k
)
€€k l
;
€€l m
if
‹‹ 
(
‹‹ 
s_roomCallbacks
‹‹ 
.
‹‹  
TryGetValue
‹‹  +
(
‹‹+ ,
NormalizeRoomKey
‹‹, <
(
‹‹< =
	lobbyCode
‹‹= F
)
‹‹F G
,
‹‹G H
out
›› "
ConcurrentDictionary
›› (
<
››( )
int
››) ,
,
››, -
ILobbyCallback
››. <
>
››< =
participants
››> J
)
››J K
)
››K L
{
ﬁﬁ 
	callbacks
ﬂﬂ 
=
ﬂﬂ 
participants
ﬂﬂ (
.
ﬂﬂ( )
ToArray
ﬂﬂ) 0
(
ﬂﬂ0 1
)
ﬂﬂ1 2
;
ﬂﬂ2 3
}
‡‡ 
return
·· 
	callbacks
·· 
;
·· 
}
‚‚ 	
public
‰‰ 
void
‰‰ %
PublishMatchStateChange
‰‰ +
(
‰‰+ ,
string
‰‰, 2
	lobbyCode
‰‰3 <
,
‰‰< =
long
‰‰> B
matchStateVersion
‰‰C T
)
‰‰T U
{
ÂÂ 	
BroadcastToRoom
ÊÊ 
(
ÊÊ 
	lobbyCode
ÊÊ %
,
ÊÊ% &
null
ÊÊ' +
,
ÊÊ+ ,
callback
ÊÊ- 5
=>
ÊÊ6 8
callback
ÊÊ9 A
.
ÊÊA B!
OnMatchStateChanged
ÊÊB U
(
ÊÊU V
matchStateVersion
ÊÊV g
)
ÊÊg h
)
ÊÊh i
;
ÊÊi j
}
ÁÁ 	
private
ÈÈ 
void
ÈÈ 
BroadcastToRoom
ÈÈ $
(
ÈÈ$ %
string
ÍÍ 
	lobbyCode
ÍÍ 
,
ÍÍ 
int
ÎÎ 
?
ÎÎ 
excludedUserId
ÎÎ 
,
ÎÎ  
Action
ÏÏ 
<
ÏÏ 
ILobbyCallback
ÏÏ !
>
ÏÏ! " 
notificationAction
ÏÏ# 5
)
ÏÏ5 6
{
ÌÌ 	
string
ÓÓ 
roomKey
ÓÓ 
=
ÓÓ 
NormalizeRoomKey
ÓÓ -
(
ÓÓ- .
	lobbyCode
ÓÓ. 7
)
ÓÓ7 8
;
ÓÓ8 9
if
ÔÔ 
(
ÔÔ 
s_roomCallbacks
ÔÔ 
.
ÔÔ  
TryGetValue
ÔÔ  +
(
ÔÔ+ ,
roomKey
ÔÔ, 3
,
ÔÔ3 4
out
ÔÔ5 8"
ConcurrentDictionary
ÔÔ9 M
<
ÔÔM N
int
ÔÔN Q
,
ÔÔQ R
ILobbyCallback
ÔÔS a
>
ÔÔa b
participants
ÔÔc o
)
ÔÔo p
)
ÔÔp q
{
 
foreach
ÒÒ 
(
ÒÒ 
KeyValuePair
ÒÒ %
<
ÒÒ% &
int
ÒÒ& )
,
ÒÒ) *
ILobbyCallback
ÒÒ+ 9
>
ÒÒ9 :
entry
ÒÒ; @
in
ÒÒA C
participants
ÒÒD P
.
ÒÒP Q
ToArray
ÒÒQ X
(
ÒÒX Y
)
ÒÒY Z
)
ÒÒZ [
{
ÚÚ 
bool
ÛÛ 
shouldNotify
ÛÛ %
=
ÛÛ& '
!
ÛÛ( )
excludedUserId
ÛÛ) 7
.
ÛÛ7 8
HasValue
ÛÛ8 @
||
ÛÛA C
entry
ÛÛD I
.
ÛÛI J
Key
ÛÛJ M
!=
ÛÛN P
excludedUserId
ÛÛQ _
.
ÛÛ_ `
Value
ÛÛ` e
;
ÛÛe f
if
ÙÙ 
(
ÙÙ 
shouldNotify
ÙÙ $
)
ÙÙ$ %
{
ıı 
TryInvokeCallback
ˆˆ )
(
ˆˆ) *
participants
ˆˆ* 6
,
ˆˆ6 7
entry
ˆˆ8 =
,
ˆˆ= > 
notificationAction
ˆˆ? Q
)
ˆˆQ R
;
ˆˆR S
}
˜˜ 
}
¯¯ 
}
˘˘ 
}
˙˙ 	
private
¸¸ 
void
¸¸ 
TryInvokeCallback
¸¸ &
(
¸¸& '"
ConcurrentDictionary
˝˝  
<
˝˝  !
int
˝˝! $
,
˝˝$ %
ILobbyCallback
˝˝& 4
>
˝˝4 5
participants
˝˝6 B
,
˝˝B C
KeyValuePair
˛˛ 
<
˛˛ 
int
˛˛ 
,
˛˛ 
ILobbyCallback
˛˛ ,
>
˛˛, -
entry
˛˛. 3
,
˛˛3 4
Action
ˇˇ 
<
ˇˇ 
ILobbyCallback
ˇˇ !
>
ˇˇ! " 
notificationAction
ˇˇ# 5
)
ˇˇ5 6
{
ÄÄ 	
string
ÅÅ 
roomCode
ÅÅ 
=
ÅÅ "
FindCallbackRoomCode
ÅÅ 2
(
ÅÅ2 3
participants
ÅÅ3 ?
)
ÅÅ? @
;
ÅÅ@ A
try
ÇÇ 
{
ÉÉ "
ICommunicationObject
ÑÑ $"
communicationChannel
ÑÑ% 9
=
ÑÑ: ;
entry
ÑÑ< A
.
ÑÑA B
Value
ÑÑB G
as
ÑÑH J"
ICommunicationObject
ÑÑK _
;
ÑÑ_ `
bool
ÖÖ 
isChannelOpen
ÖÖ "
=
ÖÖ# $"
communicationChannel
ÖÖ% 9
==
ÖÖ: <
null
ÖÖ= A
||
ÖÖB D"
communicationChannel
ÜÜ% 9
.
ÜÜ9 :
State
ÜÜ: ?
==
ÜÜ@ B 
CommunicationState
ÜÜC U
.
ÜÜU V
Opened
ÜÜV \
;
ÜÜ\ ]
if
àà 
(
àà 
isChannelOpen
àà !
)
àà! "
{
ââ  
notificationAction
ää &
(
ää& '
entry
ää' ,
.
ää, -
Value
ää- 2
)
ää2 3
;
ää3 4
}
ãã 
else
åå 
{
çç 
_logger
éé 
.
éé 
Warning
éé #
(
éé# $0
"LobbyCallbackChannelClosedTemplate
éé$ F
,
ééF G
entry
ééH M
.
ééM N
Key
ééN Q
,
ééQ R
roomCode
ééS [
)
éé[ \
;
éé\ ]*
HandleParticipantChannelLoss
èè 0
(
èè0 1
roomCode
èè1 9
,
èè9 :
entry
èè; @
.
èè@ A
Key
èèA D
,
èèD E
entry
èèF K
.
èèK L
Value
èèL Q
)
èèQ R
;
èèR S
}
êê 
}
ëë 
catch
íí 
(
íí 
TimeoutException
íí #
)
íí# $
{
ìì 
_logger
îî 
.
îî 
Warning
îî 
(
îî  *
LobbyCallbackTimeoutTemplate
îî  <
,
îî< =
entry
îî> C
.
îîC D
Key
îîD G
,
îîG H
roomCode
îîI Q
)
îîQ R
;
îîR S*
HandleParticipantChannelLoss
ïï ,
(
ïï, -
roomCode
ïï- 5
,
ïï5 6
entry
ïï7 <
.
ïï< =
Key
ïï= @
,
ïï@ A
entry
ïïB G
.
ïïG H
Value
ïïH M
)
ïïM N
;
ïïN O
}
ññ 
catch
óó 
(
óó $
CommunicationException
óó )
)
óó) *
{
òò 
_logger
ôô 
.
ôô 
Warning
ôô 
(
ôô  7
)LobbyCallbackCommunicationFaultedTemplate
ôô  I
,
ôôI J
entry
ôôK P
.
ôôP Q
Key
ôôQ T
,
ôôT U
roomCode
ôôV ^
)
ôô^ _
;
ôô_ `*
HandleParticipantChannelLoss
öö ,
(
öö, -
roomCode
öö- 5
,
öö5 6
entry
öö7 <
.
öö< =
Key
öö= @
,
öö@ A
entry
ööB G
.
ööG H
Value
ööH M
)
ööM N
;
ööN O
}
õõ 
}
úú 	
private
ûû 
static
ûû 
string
ûû 
NormalizeRoomKey
ûû .
(
ûû. /
string
ûû/ 5
	lobbyCode
ûû6 ?
)
ûû? @
{
üü 	
return
†† 
string
†† 
.
††  
IsNullOrWhiteSpace
†† ,
(
††, -
	lobbyCode
††- 6
)
††6 7
?
°° 
string
°° 
.
°° 
Empty
°° 
:
¢¢ 
	lobbyCode
¢¢ 
.
¢¢ 
Trim
¢¢  
(
¢¢  !
)
¢¢! "
.
¢¢" #
ToUpperInvariant
¢¢# 3
(
¢¢3 4
)
¢¢4 5
;
¢¢5 6
}
££ 	
private
•• 
LobbyResult
•• 
MapToLobbyResult
•• ,
(
••, - 
LobbyActionOutcome
••- ? 
lobbyActionOutcome
••@ R
)
••R S
{
¶¶ 	
Lobby
ßß 
mappedLobby
ßß 
=
ßß 
null
ßß  $
;
ßß$ %
if
®® 
(
®®  
lobbyActionOutcome
®® "
.
®®" #
Lobby
®®# (
!=
®®) +
null
®®, 0
)
®®0 1
{
©© 
mappedLobby
™™ 
=
™™ 
new
™™ !
Lobby
™™" '
{
´´ 
	LobbyCode
¨¨ 
=
¨¨  
lobbyActionOutcome
¨¨  2
.
¨¨2 3
Lobby
¨¨3 8
.
¨¨8 9
	LobbyCode
¨¨9 B
,
¨¨B C

HostUserId
≠≠ 
=
≠≠   
lobbyActionOutcome
≠≠! 3
.
≠≠3 4
Lobby
≠≠4 9
.
≠≠9 :

HostUserId
≠≠: D
,
≠≠D E 
TargetMissionCount
ÆÆ &
=
ÆÆ' ( 
lobbyActionOutcome
ÆÆ) ;
.
ÆÆ; <
Lobby
ÆÆ< A
.
ÆÆA B 
TargetMissionCount
ÆÆB T
,
ÆÆT U
PlayerLimit
ØØ 
=
ØØ  ! 
lobbyActionOutcome
ØØ" 4
.
ØØ4 5
Lobby
ØØ5 :
.
ØØ: ;
PlayerLimit
ØØ; F
,
ØØF G
Status
∞∞ 
=
∞∞  
lobbyActionOutcome
∞∞ /
.
∞∞/ 0
Lobby
∞∞0 5
.
∞∞5 6
Status
∞∞6 <
,
∞∞< =
	IsPrivate
±± 
=
±±  
lobbyActionOutcome
±±  2
.
±±2 3
Lobby
±±3 8
.
±±8 9
	IsPrivate
±±9 B
,
±±B C$
IsChatSendingAvailable
≤≤ *
=
≤≤+ ,&
_lobbyChatMessageUseCase
≤≤- E
.
≤≤E F$
IsChatSendingAvailable
≤≤F \
,
≤≤\ ]
StateVersion
≥≥  
=
≥≥! " 
lobbyActionOutcome
≥≥# 5
.
≥≥5 6
Lobby
≥≥6 ;
.
≥≥; <
StateVersion
≥≥< H
,
≥≥H I
Players
¥¥ 
=
¥¥  
lobbyActionOutcome
¥¥ 0
.
¥¥0 1
Lobby
¥¥1 6
.
¥¥6 7
Players
¥¥7 >
.
¥¥> ?
Select
¥¥? E
(
¥¥E F
MapToPlayerDto
¥¥F T
)
¥¥T U
.
¥¥U V
ToList
¥¥V \
(
¥¥\ ]
)
¥¥] ^
}
µµ 
;
µµ 
}
∂∂ 
return
∏∏ 
new
∏∏ 
LobbyResult
∏∏ "
{
ππ 
	IsSuccess
∫∫ 
=
∫∫  
lobbyActionOutcome
∫∫ .
.
∫∫. /
	IsSuccess
∫∫/ 8
,
∫∫8 9
	ErrorCode
ªª 
=
ªª  
lobbyActionOutcome
ªª .
.
ªª. /
	ErrorCode
ªª/ 8
,
ªª8 9
Message
ºº 
=
ºº  
lobbyActionOutcome
ºº ,
.
ºº, -
Message
ºº- 4
,
ºº4 5
Lobby
ΩΩ 
=
ΩΩ 
mappedLobby
ΩΩ #
}
ææ 
;
ææ 
}
øø 	
private
¡¡ 
static
¡¡ 
LobbyPlayer
¡¡ "
MapToPlayerDto
¡¡# 1
(
¡¡1 2"
LobbyParticipantData
¡¡2 F
participant
¡¡G R
)
¡¡R S
{
¬¬ 	
return
√√ 
new
√√ 
LobbyPlayer
√√ "
{
ƒƒ 
IdUser
≈≈ 
=
≈≈ 
participant
≈≈ $
.
≈≈$ %
IdUser
≈≈% +
,
≈≈+ ,
Username
∆∆ 
=
∆∆ 
participant
∆∆ &
.
∆∆& '
Username
∆∆' /
,
∆∆/ 0
IsHost
«« 
=
«« 
participant
«« $
.
««$ %
IsHost
««% +
,
««+ ,
IsReady
»» 
=
»» 
participant
»» %
.
»»% &
IsReady
»»& -
}
…… 
;
…… 
}
   	
}
ÀÀ 
}ÃÃ «
eC:\Users\oscar\source\repos\TrickTakingMissions\Server\Services\Services\Friends\FriendshipService.cs
	namespace 	
Services
 
. 
Services 
{ 
[ 
ServiceBehavior 
( 
ConcurrencyMode $
=% &
ConcurrencyMode' 6
.6 7
	Reentrant7 @
)@ A
]A B
public 

sealed 
class 
FriendshipService )
:* +
IFriendshipService, >
{ 
private 
const 
string )
CallbackChannelClosedTemplate :
=; <
$str Q
;Q R
private 
const 
string #
CallbackTimeoutTemplate 4
=5 6
$str L
;L M
private 
const 
string 0
$CallbackCommunicationFaultedTemplate A
=B C
$str X
;X Y
private 
const 
string "
OperationFriendRequest 3
=4 5
$str6 E
;E F
private 
const 
string !
OperationFriendStatus 2
=3 4
$str5 C
;C D
private 
const 
string "
OperationFriendRemoved 3
=4 5
$str6 E
;E F
private 
const 
string #
OperationGameInvitation 4
=5 6
$str7 G
;G H
private 
static 
readonly  
ConcurrentDictionary  4
<4 5
int5 8
,8 9&
IFriendshipServiceCallback: T
>T U
s_onlineSubscribersV i
= 
new  
ConcurrentDictionary &
<& '
int' *
,* +&
IFriendshipServiceCallback, F
>F G
(G H
)H I
;I J
private 
readonly 
IFriendshipUseCase +
_friendshipUseCase, >
;> ?
private   
readonly   
ILoggerService   '
_logger  ( /
;  / 0
public"" 
FriendshipService""  
(""  !
IFriendshipUseCase""! 3
friendshipUseCase""4 E
,""E F
ILoggerService""G U
logger""V \
)""\ ]
{## 	
if$$ 
($$ 
friendshipUseCase$$ !
==$$" $
null$$% )
)$$) *
{%% 
throw&& 
new&& !
ArgumentNullException&& /
(&&/ 0
nameof&&0 6
(&&6 7
friendshipUseCase&&7 H
)&&H I
)&&I J
;&&J K
}'' 
_friendshipUseCase)) 
=))  
friendshipUseCase))! 2
;))2 3
_logger** 
=** 
logger** 
??** 
throw**  %
new**& )!
ArgumentNullException*** ?
(**? @
nameof**@ F
(**F G
logger**G M
)**M N
)**N O
;**O P
}++ 	
public-- 
void-- !
SubscribeSocialEvents-- )
(--) *
int--* -
userId--. 4
)--4 5
{.. 	
if// 
(// 
IsValidUserId// 
(// 
userId// $
)//$ %
)//% &
{00 
OperationContext11  
operationContext11! 1
=112 3
OperationContext114 D
.11D E
Current11E L
;11L M&
IFriendshipServiceCallback22 *
callback22+ 3
=224 5
operationContext226 F
!=22G I
null22J N
?33 
operationContext33 &
.33& '
GetCallbackChannel33' 9
<339 :&
IFriendshipServiceCallback33: T
>33T U
(33U V
)33V W
:44 
null44 
;44 
if66 
(66 
callback66 
!=66 
null66  $
)66$ %
{77 
s_onlineSubscribers88 '
[88' (
userId88( .
]88. /
=880 1
callback882 :
;88: ;+
AttachChannelDisconnectHandlers99 3
(993 4
userId994 :
,99: ;
callback99< D
,99D E
operationContext99F V
.99V W
Channel99W ^
)99^ _
;99_ `*
NotifyFriendsAboutStatusChange:: 2
(::2 3
userId::3 9
,::9 :
true::; ?
)::? @
;::@ A
};; 
}<< 
}== 	
public?? 
void?? #
UnsubscribeSocialEvents?? +
(??+ ,
int??, /
userId??0 6
)??6 7
{@@ 	
ifAA 
(AA 
IsValidUserIdAA 
(AA 
userIdAA $
)AA$ %
)AA% &
{BB 
ifCC 
(CC 
s_onlineSubscribersCC '
.CC' (
	TryRemoveCC( 1
(CC1 2
userIdCC2 8
,CC8 9
outCC: =&
IFriendshipServiceCallbackCC> X
_CCY Z
)CCZ [
)CC[ \
{DD *
NotifyFriendsAboutStatusChangeEE 2
(EE2 3
userIdEE3 9
,EE9 :
falseEE; @
)EE@ A
;EEA B
}FF 
}GG 
}HH 	
publicJJ 
ListJJ 
<JJ 
FriendJJ 
>JJ "
GetFriendsListByUserIdJJ 2
(JJ2 3
intJJ3 6
userIdJJ7 =
)JJ= >
{KK 	
ListLL 
<LL 
FriendLL 
>LL 
friendsLL  
=LL! "
newLL# &
ListLL' +
<LL+ ,
FriendLL, 2
>LL2 3
(LL3 4
)LL4 5
;LL5 6
ListMM 
<MM 
FriendSummaryDataMM "
>MM" #
domainFriendsMM$ 1
=MM2 3
_friendshipUseCaseMM4 F
.MMF G"
GetFriendsListByUserIdMMG ]
(MM] ^
userIdMM^ d
)MMd e
;MMe f
foreachOO 
(OO 
FriendSummaryDataOO &
friendSummaryDataOO' 8
inOO9 ;
domainFriendsOO< I
)OOI J
{PP 
friendsQQ 
.QQ 
AddQQ 
(QQ 
MapToFriendQQ '
(QQ' (
friendSummaryDataQQ( 9
)QQ9 :
)QQ: ;
;QQ; <
}RR 
returnTT 
friendsTT 
;TT 
}UU 	
publicWW 
OperationResultWW 
BlockPlayerWW *
(WW* +
intWW+ .
blockerUserIdWW/ <
,WW< =
intWW> A
targetUserIdWWB N
)WWN O
{XX 	#
FriendshipActionOutcomeYY ##
friendshipActionOutcomeYY$ ;
=YY< =
_friendshipUseCaseYY> P
.YYP Q
BlockPlayerYYQ \
(YY\ ]
blockerUserIdYY] j
,YYj k
targetUserIdZZ 
)ZZ 
;ZZ 
if\\ 
(\\ #
friendshipActionOutcome\\ '
.\\' (
	IsSuccess\\( 1
)\\1 2
{]] 
NotifyFriendRemoved^^ #
(^^# $
targetUserId^^$ 0
,^^0 1
blockerUserId^^2 ?
)^^? @
;^^@ A
}__ 
returnaa  
MapToOperationResultaa '
(aa' (#
friendshipActionOutcomeaa( ?
)aa? @
;aa@ A
}bb 	
publicdd 
OperationResultdd 
UnblockPlayerdd ,
(dd, -
intdd- 0
blockerUserIddd1 >
,dd> ?
intdd@ C
targetUserIdddD P
)ddP Q
{ee 	#
FriendshipActionOutcomeff ##
friendshipActionOutcomeff$ ;
=ff< =
_friendshipUseCaseff> P
.ffP Q
UnblockPlayerffQ ^
(ff^ _
blockerUserIdff_ l
,ffl m
targetUserIdgg 
)gg 
;gg 
returnii  
MapToOperationResultii '
(ii' (#
friendshipActionOutcomeii( ?
)ii? @
;ii@ A
}jj 	
publicll 
OperationResultll 
RemoveFriendll +
(ll+ ,
intll, /
userIdll0 6
,ll6 7
intll8 ;
friendUserIdll< H
)llH I
{mm 	#
FriendshipActionOutcomenn ##
friendshipActionOutcomenn$ ;
=nn< =
_friendshipUseCasenn> P
.nnP Q
RemoveFriendnnQ ]
(nn] ^
userIdnn^ d
,nnd e
friendUserIdnnf r
)nnr s
;nns t
ifpp 
(pp #
friendshipActionOutcomepp '
.pp' (
	IsSuccesspp( 1
)pp1 2
{qq 
NotifyFriendRemovedrr #
(rr# $
friendUserIdrr$ 0
,rr0 1
userIdrr2 8
)rr8 9
;rr9 :
}ss 
returnuu  
MapToOperationResultuu '
(uu' (#
friendshipActionOutcomeuu( ?
)uu? @
;uu@ A
}vv 	
publicxx 
voidxx 
SendGameInvitationxx &
(xx& '
GameInvitationxx' 5
gameInvitationxx6 D
)xxD E
{yy 	
ifzz 
(zz 
gameInvitationzz 
!=zz !
nullzz" &
&&zz' )
IsValidUserIdzz* 7
(zz7 8
gameInvitationzz8 F
.zzF G
ReceiverUserIdzzG U
)zzU V
)zzV W
{{{ 
if|| 
(|| 
s_onlineSubscribers|| '
.||' (
TryGetValue||( 3
(||3 4
gameInvitation||4 B
.||B C
ReceiverUserId||C Q
,||Q R
out}} &
IFriendshipServiceCallback}} 2
receiverCallback}}3 C
)}}C D
)}}D E
{~~ )
TrySendGameInvitationCallback 1
(1 2
gameInvitation2 @
,@ A
receiverCallbackB R
)R S
;S T
}
ÄÄ 
}
ÅÅ 
}
ÇÇ 	
internal
ÑÑ 
static
ÑÑ 
bool
ÑÑ 
IsUserOnline
ÑÑ )
(
ÑÑ) *
int
ÑÑ* -
userId
ÑÑ. 4
)
ÑÑ4 5
{
ÖÖ 	
return
ÜÜ !
s_onlineSubscribers
ÜÜ &
.
ÜÜ& '
ContainsKey
ÜÜ' 2
(
ÜÜ2 3
userId
ÜÜ3 9
)
ÜÜ9 :
;
ÜÜ: ;
}
áá 	
internal
ââ 
static
ââ 
void
ââ )
NotifyFriendRequestReceived
ââ 8
(
ââ8 9
FriendRequest
ââ9 F
friendRequest
ââG T
,
ââT U
ILoggerService
ââV d
logger
ââe k
=
ââl m
null
âân r
)
ââr s
{
ää 	
if
ãã 
(
ãã 
friendRequest
ãã 
!=
ãã  
null
ãã! %
&&
ãã& (!
s_onlineSubscribers
ãã) <
.
ãã< =
TryGetValue
ãã= H
(
ããH I
friendRequest
åå 
.
åå 
ReceiverUserId
åå ,
,
åå, -
out
çç (
IFriendshipServiceCallback
çç .
receiverCallback
çç/ ?
)
çç? @
)
çç@ A
{
éé *
TrySendFriendRequestCallback
èè ,
(
èè, -
friendRequest
èè- :
,
èè: ;
receiverCallback
èè< L
,
èèL M
logger
èèN T
)
èèT U
;
èèU V
}
êê 
}
ëë 	
internal
ìì 
static
ìì 
void
ìì &
NotifySingleFriendStatus
ìì 5
(
ìì5 6
int
ìì6 9$
targetSubscriberUserId
ìì: P
,
ììP Q
int
ììR U
friendUserId
ììV b
,
ììb c
bool
ììd h
isOnline
ììi q
,
ììq r
ILoggerService
îî 
logger
îî !
=
îî" #
null
îî$ (
)
îî( )
{
ïï 	
if
ññ 
(
ññ !
s_onlineSubscribers
ññ #
.
ññ# $
TryGetValue
ññ$ /
(
ññ/ 0$
targetSubscriberUserId
ññ0 F
,
ññF G
out
ññH K(
IFriendshipServiceCallback
ññL f
callback
ññg o
)
ñño p
)
ññp q
{
óó *
TrySendStatusChangedCallback
òò ,
(
òò, -$
targetSubscriberUserId
òò- C
,
òòC D
callback
òòE M
,
òòM N
friendUserId
òòO [
,
òò[ \
isOnline
òò] e
,
òòe f
logger
òòg m
)
òòm n
;
òòn o
}
ôô 
}
öö 	
internal
úú 
void
úú !
NotifyFriendRemoved
úú )
(
úú) *
int
úú* -$
targetSubscriberUserId
úú. D
,
úúD E
int
úúF I
removedByUserId
úúJ Y
)
úúY Z
{
ùù 	
if
ûû 
(
ûû !
s_onlineSubscribers
ûû #
.
ûû# $
TryGetValue
ûû$ /
(
ûû/ 0$
targetSubscriberUserId
ûû0 F
,
ûûF G
out
ûûH K(
IFriendshipServiceCallback
ûûL f
callback
ûûg o
)
ûûo p
)
ûûp q
{
üü *
TrySendFriendRemovedCallback
†† ,
(
††, -$
targetSubscriberUserId
††- C
,
††C D
callback
††E M
,
††M N
removedByUserId
††O ^
)
††^ _
;
††_ `
}
°° 
}
¢¢ 	
internal
§§ 
void
§§ +
HandleSubscriberChannelClosed
§§ 3
(
§§3 4
int
§§4 7
userId
§§8 >
,
§§> ?(
IFriendshipServiceCallback
§§@ Z
closedCallback
§§[ i
)
§§i j
{
•• 	
if
¶¶ 
(
¶¶ !
s_onlineSubscribers
¶¶ #
.
¶¶# $
TryGetValue
¶¶$ /
(
¶¶/ 0
userId
¶¶0 6
,
¶¶6 7
out
¶¶8 ;(
IFriendshipServiceCallback
¶¶< V
activeCallback
¶¶W e
)
¶¶e f
&&
¶¶g i
ReferenceEquals
ßß 
(
ßß  
activeCallback
ßß  .
,
ßß. /
closedCallback
ßß0 >
)
ßß> ?
)
ßß? @
{
®® 
if
©© 
(
©© !
s_onlineSubscribers
©© '
.
©©' (
	TryRemove
©©( 1
(
©©1 2
userId
©©2 8
,
©©8 9
out
©©: =(
IFriendshipServiceCallback
©©> X
_
©©Y Z
)
©©Z [
)
©©[ \
{
™™ ,
NotifyFriendsAboutStatusChange
´´ 2
(
´´2 3
userId
´´3 9
,
´´9 :
false
´´; @
)
´´@ A
;
´´A B
}
¨¨ 
}
≠≠ 
}
ÆÆ 	
private
∞∞ 
void
∞∞ -
AttachChannelDisconnectHandlers
∞∞ 4
(
∞∞4 5
int
∞∞5 8
userId
∞∞9 ?
,
∞∞? @(
IFriendshipServiceCallback
∞∞A [
callback
∞∞\ d
,
∞∞d e
IContextChannel
±± 
channel
±± #
)
±±# $
{
≤≤ 	
if
≥≥ 
(
≥≥ 
channel
≥≥ 
!=
≥≥ 
null
≥≥ 
)
≥≥  
{
¥¥ '
ChannelDisconnectObserver
µµ )
observer
µµ* 2
=
µµ3 4
new
µµ5 8'
ChannelDisconnectObserver
µµ9 R
(
µµR S
this
µµS W
,
µµW X
userId
µµY _
,
µµ_ `
callback
µµa i
)
µµi j
;
µµj k
channel
∂∂ 
.
∂∂ 
Closed
∂∂ 
+=
∂∂ !
observer
∂∂" *
.
∂∂* +&
OnChannelClosedOrFaulted
∂∂+ C
;
∂∂C D
channel
∑∑ 
.
∑∑ 
Faulted
∑∑ 
+=
∑∑  "
observer
∑∑# +
.
∑∑+ ,&
OnChannelClosedOrFaulted
∑∑, D
;
∑∑D E
}
∏∏ 
}
ππ 	
private
ªª 
void
ªª ,
NotifyFriendsAboutStatusChange
ªª 3
(
ªª3 4
int
ªª4 7
userId
ªª8 >
,
ªª> ?
bool
ªª@ D
isOnline
ªªE M
)
ªªM N
{
ºº 	
List
ΩΩ 
<
ΩΩ 
FriendSummaryData
ΩΩ "
>
ΩΩ" #
friends
ΩΩ$ +
=
ΩΩ, - 
_friendshipUseCase
ΩΩ. @
.
ΩΩ@ A$
GetFriendsListByUserId
ΩΩA W
(
ΩΩW X
userId
ΩΩX ^
)
ΩΩ^ _
;
ΩΩ_ `
foreach
øø 
(
øø 
FriendSummaryData
øø &
friend
øø' -
in
øø. 0
friends
øø1 8
)
øø8 9
{
¿¿ &
NotifySingleFriendStatus
¡¡ (
(
¡¡( )
friend
¡¡) /
.
¡¡/ 0
IdUser
¡¡0 6
,
¡¡6 7
userId
¡¡8 >
,
¡¡> ?
isOnline
¡¡@ H
,
¡¡H I
_logger
¡¡J Q
)
¡¡Q R
;
¡¡R S
}
¬¬ 
}
√√ 	
private
≈≈ 
static
≈≈ 
void
≈≈ *
TrySendFriendRequestCallback
≈≈ 8
(
≈≈8 9
FriendRequest
≈≈9 F
friendRequest
≈≈G T
,
≈≈T U(
IFriendshipServiceCallback
∆∆ &
receiverCallback
∆∆' 7
,
∆∆7 8
ILoggerService
∆∆9 G
logger
∆∆H N
)
∆∆N O
{
«« 	
int
»» 
subscriberUserId
»»  
=
»»! "
friendRequest
»»# 0
.
»»0 1
ReceiverUserId
»»1 ?
;
»»? @
try
   
{
ÀÀ 
if
ÃÃ 
(
ÃÃ #
IsCallbackChannelOpen
ÃÃ )
(
ÃÃ) *
receiverCallback
ÃÃ* :
)
ÃÃ: ;
)
ÃÃ; <
{
ÕÕ 
receiverCallback
ŒŒ $
.
ŒŒ$ %$
OnReceiveFriendRequest
ŒŒ% ;
(
ŒŒ; <
friendRequest
ŒŒ< I
)
ŒŒI J
;
ŒŒJ K
}
œœ 
else
–– 
{
—— !
s_onlineSubscribers
““ '
.
““' (
	TryRemove
““( 1
(
““1 2
subscriberUserId
““2 B
,
““B C
out
““D G(
IFriendshipServiceCallback
““H b
_
““c d
)
““d e
;
““e f
logger
”” 
?
”” 
.
”” 
Warning
”” #
(
””# $+
CallbackChannelClosedTemplate
””$ A
,
””A B
subscriberUserId
””C S
,
””S T$
OperationFriendRequest
””U k
)
””k l
;
””l m
}
‘‘ 
}
’’ 
catch
÷÷ 
(
÷÷ 
TimeoutException
÷÷ #
)
÷÷# $
{
◊◊ !
s_onlineSubscribers
ÿÿ #
.
ÿÿ# $
	TryRemove
ÿÿ$ -
(
ÿÿ- .
subscriberUserId
ÿÿ. >
,
ÿÿ> ?
out
ÿÿ@ C(
IFriendshipServiceCallback
ÿÿD ^
_
ÿÿ_ `
)
ÿÿ` a
;
ÿÿa b
logger
ŸŸ 
?
ŸŸ 
.
ŸŸ 
Warning
ŸŸ 
(
ŸŸ  %
CallbackTimeoutTemplate
ŸŸ  7
,
ŸŸ7 8
subscriberUserId
ŸŸ9 I
,
ŸŸI J$
OperationFriendRequest
ŸŸK a
)
ŸŸa b
;
ŸŸb c
}
⁄⁄ 
catch
€€ 
(
€€ $
CommunicationException
€€ )
)
€€) *
{
‹‹ !
s_onlineSubscribers
›› #
.
››# $
	TryRemove
››$ -
(
››- .
subscriberUserId
››. >
,
››> ?
out
››@ C(
IFriendshipServiceCallback
››D ^
_
››_ `
)
››` a
;
››a b
logger
ﬁﬁ 
?
ﬁﬁ 
.
ﬁﬁ 
Warning
ﬁﬁ 
(
ﬁﬁ  2
$CallbackCommunicationFaultedTemplate
ﬁﬁ  D
,
ﬁﬁD E
subscriberUserId
ﬁﬁF V
,
ﬁﬁV W$
OperationFriendRequest
ﬁﬁX n
)
ﬁﬁn o
;
ﬁﬁo p
}
ﬂﬂ 
}
‡‡ 	
private
‚‚ 
static
‚‚ 
bool
‚‚ 
IsValidUserId
‚‚ )
(
‚‚) *
int
‚‚* -
userId
‚‚. 4
)
‚‚4 5
{
„„ 	
return
‰‰ 
userId
‰‰ 
>
‰‰ 
$num
‰‰ 
;
‰‰ 
}
ÂÂ 	
private
ÁÁ 
static
ÁÁ 
void
ÁÁ *
TrySendStatusChangedCallback
ÁÁ 8
(
ÁÁ8 9
int
ÁÁ9 <$
targetSubscriberUserId
ÁÁ= S
,
ÁÁS T(
IFriendshipServiceCallback
ËË &
callback
ËË' /
,
ËË/ 0
int
ËË1 4
friendUserId
ËË5 A
,
ËËA B
bool
ËËC G
isOnline
ËËH P
,
ËËP Q
ILoggerService
ËËR `
logger
ËËa g
)
ËËg h
{
ÈÈ 	
try
ÍÍ 
{
ÎÎ 
if
ÏÏ 
(
ÏÏ #
IsCallbackChannelOpen
ÏÏ )
(
ÏÏ) *
callback
ÏÏ* 2
)
ÏÏ2 3
)
ÏÏ3 4
{
ÌÌ 
callback
ÓÓ 
.
ÓÓ #
OnFriendStatusChanged
ÓÓ 2
(
ÓÓ2 3
friendUserId
ÓÓ3 ?
,
ÓÓ? @
isOnline
ÓÓA I
)
ÓÓI J
;
ÓÓJ K
}
ÔÔ 
else
 
{
ÒÒ !
s_onlineSubscribers
ÚÚ '
.
ÚÚ' (
	TryRemove
ÚÚ( 1
(
ÚÚ1 2$
targetSubscriberUserId
ÚÚ2 H
,
ÚÚH I
out
ÚÚJ M(
IFriendshipServiceCallback
ÚÚN h
_
ÚÚi j
)
ÚÚj k
;
ÚÚk l
logger
ÛÛ 
?
ÛÛ 
.
ÛÛ 
Warning
ÛÛ #
(
ÛÛ# $+
CallbackChannelClosedTemplate
ÛÛ$ A
,
ÛÛA B$
targetSubscriberUserId
ÛÛC Y
,
ÛÛY Z#
OperationFriendStatus
ÛÛ[ p
)
ÛÛp q
;
ÛÛq r
}
ÙÙ 
}
ıı 
catch
ˆˆ 
(
ˆˆ 
TimeoutException
ˆˆ #
)
ˆˆ# $
{
˜˜ !
s_onlineSubscribers
¯¯ #
.
¯¯# $
	TryRemove
¯¯$ -
(
¯¯- .$
targetSubscriberUserId
¯¯. D
,
¯¯D E
out
¯¯F I(
IFriendshipServiceCallback
¯¯J d
_
¯¯e f
)
¯¯f g
;
¯¯g h
logger
˘˘ 
?
˘˘ 
.
˘˘ 
Warning
˘˘ 
(
˘˘  %
CallbackTimeoutTemplate
˘˘  7
,
˘˘7 8$
targetSubscriberUserId
˘˘9 O
,
˘˘O P#
OperationFriendStatus
˘˘Q f
)
˘˘f g
;
˘˘g h
}
˙˙ 
catch
˚˚ 
(
˚˚ $
CommunicationException
˚˚ )
)
˚˚) *
{
¸¸ !
s_onlineSubscribers
˝˝ #
.
˝˝# $
	TryRemove
˝˝$ -
(
˝˝- .$
targetSubscriberUserId
˝˝. D
,
˝˝D E
out
˝˝F I(
IFriendshipServiceCallback
˝˝J d
_
˝˝e f
)
˝˝f g
;
˝˝g h
logger
˛˛ 
?
˛˛ 
.
˛˛ 
Warning
˛˛ 
(
˛˛  2
$CallbackCommunicationFaultedTemplate
˛˛  D
,
˛˛D E$
targetSubscriberUserId
˛˛F \
,
˛˛\ ]#
OperationFriendStatus
˛˛^ s
)
˛˛s t
;
˛˛t u
}
ˇˇ 
}
ÄÄ 	
private
ÇÇ 
void
ÇÇ *
TrySendFriendRemovedCallback
ÇÇ 1
(
ÇÇ1 2
int
ÇÇ2 5$
targetSubscriberUserId
ÇÇ6 L
,
ÇÇL M(
IFriendshipServiceCallback
ÇÇN h
callback
ÇÇi q
,
ÇÇq r
int
ÉÉ 
removedByUserId
ÉÉ 
)
ÉÉ  
{
ÑÑ 	
try
ÖÖ 
{
ÜÜ 
if
áá 
(
áá #
IsCallbackChannelOpen
áá )
(
áá) *
callback
áá* 2
)
áá2 3
)
áá3 4
{
àà 
callback
ââ 
.
ââ 
OnFriendRemoved
ââ ,
(
ââ, -
removedByUserId
ââ- <
)
ââ< =
;
ââ= >
}
ää 
else
ãã 
{
åå !
s_onlineSubscribers
çç '
.
çç' (
	TryRemove
çç( 1
(
çç1 2$
targetSubscriberUserId
çç2 H
,
ççH I
out
ççJ M(
IFriendshipServiceCallback
ççN h
_
ççi j
)
ççj k
;
ççk l
_logger
éé 
.
éé 
Warning
éé #
(
éé# $+
CallbackChannelClosedTemplate
éé$ A
,
ééA B$
targetSubscriberUserId
ééC Y
,
ééY Z$
OperationFriendRemoved
éé[ q
)
ééq r
;
éér s
}
èè 
}
êê 
catch
ëë 
(
ëë 
TimeoutException
ëë #
)
ëë# $
{
íí !
s_onlineSubscribers
ìì #
.
ìì# $
	TryRemove
ìì$ -
(
ìì- .$
targetSubscriberUserId
ìì. D
,
ììD E
out
ììF I(
IFriendshipServiceCallback
ììJ d
_
ììe f
)
ììf g
;
ììg h
_logger
îî 
.
îî 
Warning
îî 
(
îî  %
CallbackTimeoutTemplate
îî  7
,
îî7 8$
targetSubscriberUserId
îî9 O
,
îîO P$
OperationFriendRemoved
îîQ g
)
îîg h
;
îîh i
}
ïï 
catch
ññ 
(
ññ $
CommunicationException
ññ )
)
ññ) *
{
óó !
s_onlineSubscribers
òò #
.
òò# $
	TryRemove
òò$ -
(
òò- .$
targetSubscriberUserId
òò. D
,
òòD E
out
òòF I(
IFriendshipServiceCallback
òòJ d
_
òòe f
)
òòf g
;
òòg h
_logger
ôô 
.
ôô 
Warning
ôô 
(
ôô  2
$CallbackCommunicationFaultedTemplate
ôô  D
,
ôôD E$
targetSubscriberUserId
ôôF \
,
ôô\ ]$
OperationFriendRemoved
ôô^ t
)
ôôt u
;
ôôu v
}
öö 
}
õõ 	
private
ùù 
void
ùù +
TrySendGameInvitationCallback
ùù 2
(
ùù2 3
GameInvitation
ùù3 A
gameInvitation
ùùB P
,
ùùP Q(
IFriendshipServiceCallback
ûû &
receiverCallback
ûû' 7
)
ûû7 8
{
üü 	
try
†† 
{
°° 
if
¢¢ 
(
¢¢ #
IsCallbackChannelOpen
¢¢ )
(
¢¢) *
receiverCallback
¢¢* :
)
¢¢: ;
)
¢¢; <
{
££ 
receiverCallback
§§ $
.
§§$ %%
OnReceiveGameInvitation
§§% <
(
§§< =
gameInvitation
§§= K
)
§§K L
;
§§L M
}
•• 
else
¶¶ 
{
ßß !
s_onlineSubscribers
®® '
.
®®' (
	TryRemove
®®( 1
(
®®1 2
gameInvitation
®®2 @
.
®®@ A
ReceiverUserId
®®A O
,
®®O P
out
®®Q T(
IFriendshipServiceCallback
®®U o
_
®®p q
)
®®q r
;
®®r s
_logger
©© 
.
©© 
Warning
©© #
(
©©# $+
CallbackChannelClosedTemplate
©©$ A
,
©©A B
gameInvitation
©©C Q
.
©©Q R
ReceiverUserId
©©R `
,
©©` a%
OperationGameInvitation
™™ /
)
™™/ 0
;
™™0 1
}
´´ 
}
¨¨ 
catch
≠≠ 
(
≠≠ 
TimeoutException
≠≠ #
)
≠≠# $
{
ÆÆ !
s_onlineSubscribers
ØØ #
.
ØØ# $
	TryRemove
ØØ$ -
(
ØØ- .
gameInvitation
ØØ. <
.
ØØ< =
ReceiverUserId
ØØ= K
,
ØØK L
out
ØØM P(
IFriendshipServiceCallback
ØØQ k
_
ØØl m
)
ØØm n
;
ØØn o
_logger
∞∞ 
.
∞∞ 
Warning
∞∞ 
(
∞∞  %
CallbackTimeoutTemplate
∞∞  7
,
∞∞7 8
gameInvitation
∞∞9 G
.
∞∞G H
ReceiverUserId
∞∞H V
,
∞∞V W%
OperationGameInvitation
∞∞X o
)
∞∞o p
;
∞∞p q
}
±± 
catch
≤≤ 
(
≤≤ $
CommunicationException
≤≤ )
)
≤≤) *
{
≥≥ !
s_onlineSubscribers
¥¥ #
.
¥¥# $
	TryRemove
¥¥$ -
(
¥¥- .
gameInvitation
¥¥. <
.
¥¥< =
ReceiverUserId
¥¥= K
,
¥¥K L
out
¥¥M P(
IFriendshipServiceCallback
¥¥Q k
_
¥¥l m
)
¥¥m n
;
¥¥n o
_logger
µµ 
.
µµ 
Warning
µµ 
(
µµ  2
$CallbackCommunicationFaultedTemplate
µµ  D
,
µµD E
gameInvitation
µµF T
.
µµT U
ReceiverUserId
µµU c
,
µµc d%
OperationGameInvitation
∂∂ +
)
∂∂+ ,
;
∂∂, -
}
∑∑ 
}
∏∏ 	
private
∫∫ 
static
∫∫ 
bool
∫∫ #
IsCallbackChannelOpen
∫∫ 1
(
∫∫1 2(
IFriendshipServiceCallback
∫∫2 L
callback
∫∫M U
)
∫∫U V
{
ªª 	"
ICommunicationObject
ºº  "
communicationChannel
ºº! 5
=
ºº6 7
callback
ºº8 @
as
ººA C"
ICommunicationObject
ººD X
;
ººX Y
return
ΩΩ "
communicationChannel
ΩΩ '
==
ΩΩ( *
null
ΩΩ+ /
||
ΩΩ0 2"
communicationChannel
ΩΩ3 G
.
ΩΩG H
State
ΩΩH M
==
ΩΩN P 
CommunicationState
ΩΩQ c
.
ΩΩc d
Opened
ΩΩd j
;
ΩΩj k
}
ææ 	
private
¿¿ 
static
¿¿ 
Friend
¿¿ 
MapToFriend
¿¿ )
(
¿¿) *
FriendSummaryData
¿¿* ;
friendSummaryData
¿¿< M
)
¿¿M N
{
¡¡ 	
bool
¬¬ "
isCurrentlyConnected
¬¬ %
=
¬¬& '
IsUserOnline
¬¬( 4
(
¬¬4 5
friendSummaryData
¬¬5 F
.
¬¬F G
IdUser
¬¬G M
)
¬¬M N
;
¬¬N O
return
√√ 
new
√√ 
Friend
√√ 
{
ƒƒ 
UserId
≈≈ 
=
≈≈ 
friendSummaryData
≈≈ *
.
≈≈* +
IdUser
≈≈+ 1
,
≈≈1 2
Username
∆∆ 
=
∆∆ 
friendSummaryData
∆∆ ,
.
∆∆, -
Username
∆∆- 5
,
∆∆5 6
IsOnline
«« 
=
«« "
isCurrentlyConnected
«« /
}
»» 
;
»» 
}
…… 	
private
ÀÀ 
static
ÀÀ 
OperationResult
ÀÀ &"
MapToOperationResult
ÀÀ' ;
(
ÀÀ; <%
FriendshipActionOutcome
ÀÀ< S%
friendshipActionOutcome
ÀÀT k
)
ÀÀk l
{
ÃÃ 	
return
ÕÕ 
new
ÕÕ 
OperationResult
ÕÕ &
{
ŒŒ 
	IsSuccess
œœ 
=
œœ %
friendshipActionOutcome
œœ 3
.
œœ3 4
	IsSuccess
œœ4 =
,
œœ= >
	ErrorCode
–– 
=
–– %
friendshipActionOutcome
–– 3
.
––3 4
	ErrorCode
––4 =
,
––= >
Message
—— 
=
—— %
friendshipActionOutcome
—— 1
.
——1 2
Message
——2 9
}
““ 
;
““ 
}
”” 	
}
‘‘ 
}’’ ⁄
eC:\Users\oscar\source\repos\TrickTakingMissions\Server\Services\Services\ChannelDisconnectObserver.cs
	namespace 	
Services
 
. 
Services 
{ 
internal 
sealed 
class %
ChannelDisconnectObserver 3
{ 
private		 
readonly		 
FriendshipService		 *
_service		+ 3
;		3 4
private

 
readonly

 
int

 
_userId

 $
;

$ %
private 
readonly &
IFriendshipServiceCallback 3
	_callback4 =
;= >
public %
ChannelDisconnectObserver (
(( )
FriendshipService) :
service; B
,B C
intD G
userIdH N
,N O&
IFriendshipServiceCallbackP j
callbackk s
)s t
{ 	
_service 
= 
service 
?? !
throw" '
new( +!
ArgumentNullException, A
(A B
nameofB H
(H I
serviceI P
)P Q
)Q R
;R S
_userId 
= 
userId 
; 
	_callback 
= 
callback  
??! #
throw$ )
new* -!
ArgumentNullException. C
(C D
nameofD J
(J K
callbackK S
)S T
)T U
;U V
} 	
public 
void $
OnChannelClosedOrFaulted ,
(, -
object- 3
sender4 :
,: ;
	EventArgs< E
eF G
)G H
{ 	
if 
( 
sender 
is  
ICommunicationObject .
channel/ 6
)6 7
{ 
channel 
. 
Closed 
-= !$
OnChannelClosedOrFaulted" :
;: ;
channel 
. 
Faulted 
-=  "$
OnChannelClosedOrFaulted# ;
;; <
} 
_service 
. )
HandleSubscriberChannelClosed 2
(2 3
_userId3 :
,: ;
	_callback< E
)E F
;F G
} 	
} 
} ¯
eC:\Users\oscar\source\repos\TrickTakingMissions\Server\Services\DataContracts\Account\UserRegister.cs
	namespace 	
Services
 
. 
DataContracts  
{ 
[ 
DataContract 
] 
public		 

sealed		 
class		 
UserRegister		 $
{

 
[ 	

DataMember	 
] 
public 
string 
Username 
{  
get! $
;$ %
set& )
;) *
}+ ,
[ 	

DataMember	 
] 
public 
string 
Email 
{ 
get !
;! "
set# &
;& '
}( )
[ 	

DataMember	 
] 
public 
string 
PasswordHash "
{# $
get% (
;( )
set* -
;- .
}/ 0
} 
} ®
]C:\Users\oscar\source\repos\TrickTakingMissions\Server\Services\DataContracts\Account\User.cs
	namespace 	
Services
 
. 
DataContracts  
{ 
[ 
DataContract 
] 
public		 

sealed		 
class		 
User		 
{

 
[ 	

DataMember	 
] 
public  
ChatAccountBanNotice # 
ChatAccountBanNotice$ 8
{9 :
get; >
;> ?
set@ C
;C D
}E F
[ 	

DataMember	 
] 
public 
int 
IdUser 
{ 
get 
;  
set! $
;$ %
}& '
[ 	

DataMember	 
] 
public 
string 
Username 
{  
get! $
;$ %
set& )
;) *
}+ ,
[ 	

DataMember	 
] 
public 
string 
Email 
{ 
get !
;! "
set# &
;& '
}( )
[ 	

DataMember	 
] 
public 
string 
AccountSessionToken )
{* +
get, /
;/ 0
set1 4
;4 5
}6 7
} 
} Ç	
gC:\Users\oscar\source\repos\TrickTakingMissions\Server\Services\DataContracts\Common\OperationResult.cs
	namespace 	
Services
 
. 
DataContracts  
{ 
[ 
DataContract 
] 
[		 
	KnownType		 
(		 
typeof		 
(		 
LobbyResult		 !
)		! "
)		" #
]		# $
public

 

class

 
OperationResult

  
{ 
[ 	

DataMember	 
] 
public 
bool 
	IsSuccess 
{ 
get  #
;# $
set% (
;( )
}* +
[ 	

DataMember	 
] 
public 
string 
Message 
{ 
get  #
;# $
set% (
;( )
}* +
[ 	

DataMember	 
] 
public 
int 
	ErrorCode 
{ 
get "
;" #
set$ '
;' (
}) *
} 
} Ø
dC:\Users\oscar\source\repos\TrickTakingMissions\Server\Services\DataContracts\Lobby\LobbySettings.cs
	namespace 	
Services
 
. 
DataContracts  
{ 
[ 
DataContract 
] 
public		 

sealed		 
class		 
LobbySettings		 %
{

 
[ 	

DataMember	 
] 
public 
byte 
TargetMissionCount &
{' (
get) ,
;, -
set. 1
;1 2
}3 4
[ 	

DataMember	 
] 
public 
byte 
PlayerLimit 
{  !
get" %
;% &
set' *
;* +
}, -
[ 	

DataMember	 
] 
public 
bool 
	IsPrivate 
{ 
get  #
;# $
set% (
;( )
}* +
=, -
true. 2
;2 3
} 
} “
bC:\Users\oscar\source\repos\TrickTakingMissions\Server\Services\DataContracts\Lobby\LobbyResult.cs
	namespace 	
Services
 
. 
DataContracts  
{ 
[ 
DataContract 
] 
public		 

sealed		 
class		 
LobbyResult		 #
:		$ %
OperationResult		& 5
{

 
[ 	

DataMember	 
] 
public 
string 
GuestSessionToken '
{( )
get* -
;- .
set/ 2
;2 3
}4 5
[ 	

DataMember	 
] 
public 
Lobby 
Lobby 
{ 
get  
;  !
set" %
;% &
}' (
} 
} π	
bC:\Users\oscar\source\repos\TrickTakingMissions\Server\Services\DataContracts\Lobby\LobbyPlayer.cs
	namespace 	
Services
 
. 
DataContracts  
{ 
[ 
DataContract 
] 
public		 

sealed		 
class		 
LobbyPlayer		 #
{

 
[ 	

DataMember	 
] 
public 
int 
IdUser 
{ 
get 
;  
set! $
;$ %
}& '
[ 	

DataMember	 
] 
public 
string 
Username 
{  
get! $
;$ %
set& )
;) *
}+ ,
[ 	

DataMember	 
] 
public 
bool 
IsHost 
{ 
get  
;  !
set" %
;% &
}' (
[ 	

DataMember	 
] 
public 
bool 
IsReady 
{ 
get !
;! "
set# &
;& '
}( )
} 
} Õ	
cC:\Users\oscar\source\repos\TrickTakingMissions\Server\Services\DataContracts\Lobby\LobbyMessage.cs
	namespace 	
Services
 
. 
DataContracts  
{ 
[		 
DataContract		 
]		 
public

 

sealed

 
class

 
LobbyMessage

 $
{ 
[ 	

DataMember	 
] 
public 
int 
SenderUserId 
{  !
get" %
;% &
set' *
;* +
}, -
[ 	

DataMember	 
] 
public 
string 
SenderUsername $
{% &
get' *
;* +
set, /
;/ 0
}1 2
[ 	

DataMember	 
] 
public 
string 
Message 
{ 
get  #
;# $
set% (
;( )
}* +
[ 	

DataMember	 
] 
public 
DateTime 
SentAt 
{  
get! $
;$ %
set& )
;) *
}+ ,
} 
} ﬂ
\C:\Users\oscar\source\repos\TrickTakingMissions\Server\Services\DataContracts\Lobby\Lobby.cs
	namespace 	
Services
 
. 
DataContracts  
{ 
[		 
DataContract		 
]		 
public

 

sealed

 
class

 
Lobby

 
{ 
[ 	

DataMember	 
] 
public 
string 
	LobbyCode 
{  !
get" %
;% &
set' *
;* +
}, -
[ 	

DataMember	 
] 
public 
int 

HostUserId 
{ 
get  #
;# $
set% (
;( )
}* +
[ 	

DataMember	 
] 
public 
byte 
TargetMissionCount &
{' (
get) ,
;, -
set. 1
;1 2
}3 4
[ 	

DataMember	 
] 
public 
byte 
PlayerLimit 
{  !
get" %
;% &
set' *
;* +
}, -
[ 	

DataMember	 
] 
public 
byte 
Status 
{ 
get  
;  !
set" %
;% &
}' (
[ 	

DataMember	 
] 
public 
bool 
	IsPrivate 
{ 
get  #
;# $
set% (
;( )
}* +
=, -
true. 2
;2 3
[ 	

DataMember	 
] 
public 
bool "
IsChatSendingAvailable *
{+ ,
get- 0
;0 1
set2 5
;5 6
}7 8
[!! 	

DataMember!!	 
]!! 
public"" 
long"" 
StateVersion""  
{""! "
get""# &
;""& '
set""( +
;""+ ,
}""- .
[$$ 	

DataMember$$	 
]$$ 
public%% 
List%% 
<%% 
LobbyPlayer%% 
>%%  
Players%%! (
{%%) *
get%%+ .
;%%. /
set%%0 3
;%%3 4
}%%5 6
=%%7 8
new%%9 <
List%%= A
<%%A B
LobbyPlayer%%B M
>%%M N
(%%N O
)%%O P
;%%P Q
}&& 
}'' Ö
gC:\Users\oscar\source\repos\TrickTakingMissions\Server\Services\DataContracts\Friends\GameInvitation.cs
	namespace 	
Services
 
. 
DataContracts  
.  !

Friendship! +
{ 
[ 
DataContract 
] 
public 

sealed 
class 
GameInvitation &
{ 
[ 	

DataMember	 
] 
public		 
int		 
CurrentPlayerCount		 %
{		& '
get		( +
;		+ ,
set		- 0
;		0 1
}		2 3
[ 	

DataMember	 
] 
public 
string 
	LobbyCode 
{  !
get" %
;% &
set' *
;* +
}, -
[ 	

DataMember	 
] 
public 
byte 
PlayerLimit 
{  !
get" %
;% &
set' *
;* +
}, -
[ 	

DataMember	 
] 
public 
int 
ReceiverUserId !
{" #
get$ '
;' (
set) ,
;, -
}. /
[ 	

DataMember	 
] 
public 
int 
SenderUserId 
{  !
get" %
;% &
set' *
;* +
}, -
[ 	

DataMember	 
] 
public 
string 
SenderUsername $
{% &
get' *
;* +
set, /
;/ 0
}1 2
[ 	

DataMember	 
] 
public 
byte 
TargetMissionCount &
{' (
get) ,
;, -
set. 1
;1 2
}3 4
} 
} ©
fC:\Users\oscar\source\repos\TrickTakingMissions\Server\Services\DataContracts\Friends\FriendRequest.cs
	namespace 	
Services
 
. 
DataContracts  
.  !

Friendship! +
{		 
[

 
DataContract

 
]

 
public 

sealed 
class 
FriendRequest %
{ 
[ 	

DataMember	 
] 
public 
int 
SenderUserId 
{  !
get" %
;% &
set' *
;* +
}, -
[ 	

DataMember	 
] 
public 
string 
SenderUsername $
{% &
get' *
;* +
set, /
;/ 0
}1 2
[ 	

DataMember	 
] 
public 
int 
ReceiverUserId !
{" #
get$ '
;' (
set) ,
;, -
}. /
[ 	

DataMember	 
] 
public 
string 
ReceiverUsername &
{' (
get) ,
;, -
set. 1
;1 2
}3 4
[ 	

DataMember	 
] 
public 
byte 
Status 
{ 
get  
;  !
set" %
;% &
}' (
[ 	

DataMember	 
] 
public 
DateTime 
RequestedAt #
{$ %
get& )
;) *
set+ .
;. /
}0 1
} 
} ã
_C:\Users\oscar\source\repos\TrickTakingMissions\Server\Services\DataContracts\Friends\Friend.cs
	namespace 	
Services
 
. 
DataContracts  
.  !

Friendship! +
{ 
[ 
DataContract 
] 
public 

sealed 
class 
Friend 
{ 
[ 	

DataMember	 
] 
public		 
int		 
UserId		 
{		 
get		 
;		  
set		! $
;		$ %
}		& '
[ 	

DataMember	 
] 
public 
string 
Username 
{  
get! $
;$ %
set& )
;) *
}+ ,
[ 	

DataMember	 
] 
public 
bool 
IsOnline 
{ 
get "
;" #
set$ '
;' (
}) *
} 
} ©

fC:\Users\oscar\source\repos\TrickTakingMissions\Server\Services\Contracts\Account\IUserLoginService.cs
	namespace 	
Services
 
. 
	Contracts 
{ 
[		 
ServiceContract		 
(		 
Name		 
=		 
$str		 (
,		( )
CallbackContract		* :
=		; <
typeof		= C
(		C D
IUserLoginCallback		D V
)		V W
)		W X
]		X Y
public

 

	interface

 
IUserLoginService

 &
{ 
[ 	
OperationContract	 
( 
IsOneWay #
=$ %
true& *
)* +
]+ ,
void 
Login 
( 
string 
email 
,  
string! '
password( 0
)0 1
;1 2
} 
public 

	interface 
IUserLoginCallback '
{ 
[   	
OperationContract  	 
]   
void!! 
LoginResult!! 
(!! 
bool!! 
success!! %
,!!% &
string!!' -
message!!. 5
,!!5 6
User!!7 ;
user!!< @
)!!@ A
;!!A B
}"" 
}## ”
nC:\Users\oscar\source\repos\TrickTakingMissions\Server\Services\Contracts\Account\IAccountManagementService.cs
	namespace 	
Services
 
. 
	Contracts 
{ 
[		 
ServiceContract		 
]		 
public

 

	interface

 %
IAccountManagementService

 .
{ 
[ 	
OperationContract	 
] 
OperationResult 
RegisterUser $
($ %
UserRegister% 1
user2 6
)6 7
;7 8
} 
} —
`C:\Users\oscar\source\repos\TrickTakingMissions\Server\Services\Contracts\Lobby\ILobbyService.cs
	namespace 	
Services
 
. 
	Contracts 
{ 
[

 
ServiceContract

 
(

 
CallbackContract

 %
=

& '
typeof

( .
(

. /
ILobbyCallback

/ =
)

= >
)

> ?
]

? @
public 

	interface 
ILobbyService "
:# $
Gameplay% -
.- .
IMatchService. ;
{ 
[ 	
OperationContract	 
] 
LobbyResult 
UpdateLobbySettings '
(' (
string( .
	lobbyCode/ 8
,8 9
int: =
requesterUserId> M
,M N
LobbySettingsO \
settings] e
)e f
;f g
[ 	
OperationContract	 
] 
LobbyResult 
CreateLobby 
(  
int  #

hostUserId$ .
,. /
LobbySettings0 =
settings> F
)F G
;G H
[$$ 	
OperationContract$$	 
]$$ 
LobbyResult%% 
JoinLobbyByCode%% #
(%%# $
string%%$ *
	lobbyCode%%+ 4
,%%4 5
int%%6 9
userId%%: @
)%%@ A
;%%A B
[,, 	
OperationContract,,	 
(,, 
IsOneWay,, #
=,,$ %
true,,& *
),,* +
],,+ ,
void-- 

LeaveLobby-- 
(-- 
string-- 
	lobbyCode-- (
,--( )
int--* -
userId--. 4
)--4 5
;--5 6
[55 	
OperationContract55	 
(55 
IsOneWay55 #
=55$ %
true55& *
)55* +
]55+ ,
void66 
KickPlayerByUserId66 
(66  
string66  &
	lobbyCode66' 0
,660 1
int662 5

hostUserId666 @
,66@ A
int66B E
targetUserId66F R
)66R S
;66S T
[== 	
OperationContract==	 
]== 
LobbyResult>> (
AuthorizeKickedPlayerReentry>> 0
(>>0 1
string>>1 7
	lobbyCode>>8 A
,>>A B
int>>C F

hostUserId>>G Q
,>>Q R
int>>S V
targetUserId>>W c
)>>c d
;>>d e
[FF 	
OperationContractFF	 
(FF 
IsOneWayFF #
=FF$ %
trueFF& *
)FF* +
]FF+ ,
voidGG  
SetPlayerReadyStatusGG !
(GG! "
stringGG" (
	lobbyCodeGG) 2
,GG2 3
intGG4 7
userIdGG8 >
,GG> ?
boolGG@ D
isReadyGGE L
)GGL M
;GGM N
[LL 	
OperationContractLL	 
]LL -
!LobbyChatMessageSubmissionOutcomeMM ) 
SendLobbyChatMessageMM* >
(MM> ?&
LobbyChatMessageSubmissionMM? Y!
chatMessageSubmissionMMZ o
)MMo p
;MMp q
[TT 	
OperationContractTT	 
]TT 
voidUU 
StartGameFromLobbyUU 
(UU  
stringUU  &
	lobbyCodeUU' 0
,UU0 1
intUU2 5

hostUserIdUU6 @
)UU@ A
;UUA B
}VV 
}WW ƒ
aC:\Users\oscar\source\repos\TrickTakingMissions\Server\Services\Contracts\Lobby\ILobbyCallback.cs
	namespace 	
Services
 
. 
	Contracts 
{ 
public

 

	interface

 
ILobbyCallback

 #
{ 
[ 	
OperationContract	 
( 
Action !
=" #
$str$ G
,G H
ReplyActionI T
=U V
$strW Z
)Z [
][ \
bool '
IsMatchParticipantConnected (
(( )
System) /
./ 0
Guid0 4
matchId5 <
,< =
int> A
missionAttemptIdB R
)R S
;S T
[ 	
OperationContract	 
( 
IsOneWay #
=$ %
true& *
,* +
Action, 2
=3 4
$str5 \
)\ ]
]] ^
void 
OnMatchStateChanged  
(  !
long! %
matchStateVersion& 7
)7 8
;8 9
[ 	
OperationContract	 
( 
IsOneWay #
=$ %
true& *
)* +
]+ ,
void 
OnLobbyStateChanged  
(  !
Lobby! &
lobby' ,
), -
;- .
[ 	
OperationContract	 
( 
IsOneWay #
=$ %
true& *
)* +
]+ ,
void 
OnPlayerJoinedLobby  
(  !
LobbyPlayer! ,
player- 3
)3 4
;4 5
[$$ 	
OperationContract$$	 
($$ 
IsOneWay$$ #
=$$$ %
true$$& *
)$$* +
]$$+ ,
void%% 
OnPlayerLeftLobby%% 
(%% 
int%% "
userId%%# )
,%%) *
string%%+ 1
reason%%2 8
)%%8 9
;%%9 :
[,, 	
OperationContract,,	 
(,, 
IsOneWay,, #
=,,$ %
true,,& *
),,* +
],,+ ,
void-- &
OnPlayerReadyStatusChanged-- '
(--' (
int--( +
userId--, 2
,--2 3
bool--4 8
isReady--9 @
)--@ A
;--A B
[33 	
OperationContract33	 
(33 
IsOneWay33 #
=33$ %
true33& *
)33* +
]33+ ,
void44 %
OnReceiveLobbyChatMessage44 &
(44& '
LobbyMessage44' 3
message444 ;
)44; <
;44< =
[77 	
OperationContract77	 
(77 
IsOneWay77 #
=77$ %
true77& *
)77* +
]77+ ,
void88 #
OnChatAccountBanApplied88 $
(88$ % 
ChatAccountBanNotice88% 9 
chatAccountBanNotice88: N
)88N O
;88O P
[>> 	
OperationContract>>	 
(>> 
IsOneWay>> #
=>>$ %
true>>& *
)>>* +
]>>+ ,
void?? 
OnGameStarting?? 
(?? 
int?? 
gameId??  &
)??& '
;??' (
[EE 	
OperationContractEE	 
(EE 
IsOneWayEE #
=EE$ %
trueEE& *
)EE* +
]EE+ ,
voidFF 
OnLobbyDisbandedFF 
(FF 
stringFF $
reasonFF% +
)FF+ ,
;FF, -
}GG 
}HH Ã
`C:\Users\oscar\source\repos\TrickTakingMissions\Server\Services\Security\AccountSessionHeader.cs
	namespace 	
Services
 
. 
Security 
{ 
internal 
static 
class  
AccountSessionHeader .
{		 
private

 
const

 
string

 $
AccountSessionHeaderName

 5
=

6 7
$str

8 M
;

M N
private 
const 
string )
AccountSessionHeaderNamespace :
=; <
$str= a
;a b
public 
static 
string *
ReadCurrentAccountSessionToken ;
(; <
)< =
{ 	
string 
accountSessionToken &
=' (
null) -
;- .
if 
( 
OperationContext  
.  !
Current! (
!=) +
null, 0
)0 1
{ 
MessageHeaders 
incomingHeaders .
=/ 0
OperationContext1 A
.A B
CurrentB I
.I J"
IncomingMessageHeadersJ `
;` a
int 
sessionHeaderIndex &
=' (
incomingHeaders) 8
.8 9

FindHeader9 C
(C D$
AccountSessionHeaderName ,
,, -)
AccountSessionHeaderNamespace. K
)K L
;L M
if 
( 
sessionHeaderIndex &
>=' )
$num* +
)+ ,
{ 
accountSessionToken '
=( )
incomingHeaders* 9
.9 :
	GetHeader: C
<C D
stringD J
>J K
(K L
sessionHeaderIndexL ^
)^ _
;_ `
} 
} 
return 
accountSessionToken &
;& '
} 	
} 
} •
gC:\Users\oscar\source\repos\TrickTakingMissions\Server\Services\Security\AuthenticatedAccountSession.cs
	namespace 	
Services
 
. 
Security 
{ 
internal 
sealed 
class '
AuthenticatedAccountSession 5
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
public 
DateTime &
AccountSessionExpiresAtUtc 2
{3 4
get5 8
;8 9
set: =
;= >
}? @
} 
} Î1
oC:\Users\oscar\source\repos\TrickTakingMissions\Server\Services\Security\AuthenticatedAccountSessionRegistry.cs
	namespace 	
Services
 
. 
Security 
{		 
public 

sealed 
class /
#AuthenticatedAccountSessionRegistry ;
:< =0
$IAuthenticatedAccountSessionRegistry> b
{ 
private 
const 
int (
AccountSessionTokenByteCount 6
=7 8
$num9 ;
;; <
private 
const 
int '
AccountSessionLifetimeHours 5
=6 7
$num8 :
;: ;
private 
readonly  
ConcurrentDictionary -
<- .
string. 4
,4 5'
AuthenticatedAccountSession6 Q
>Q R)
_authenticatedAccountSessionsS p
=q r
new  
ConcurrentDictionary $
<$ %
string% +
,+ ,'
AuthenticatedAccountSession- H
>H I
(I J
StringComparerJ X
.X Y
OrdinalY `
)` a
;a b
public 
string  
CreateAccountSession *
(* +
int+ .
accountUserId/ <
)< =
{ 	(
RemoveExpiredAccountSessions (
(( )
)) *
;* +
byte 
[ 
] $
accountSessionTokenBytes +
=, -
new. 1
byte2 6
[6 7(
AccountSessionTokenByteCount7 S
]S T
;T U
using 
( !
RandomNumberGenerator ((
accountSessionTokenGenerator) E
=F G!
RandomNumberGeneratorH ]
.] ^
Create^ d
(d e
)e f
)f g
{ (
accountSessionTokenGenerator ,
., -
GetBytes- 5
(5 6$
accountSessionTokenBytes6 N
)N O
;O P
} 
string 
accountSessionToken &
=' (
Convert) 0
.0 1
ToBase64String1 ?
(? @$
accountSessionTokenBytes@ X
)X Y
;Y Z)
_authenticatedAccountSessions )
[) *
accountSessionToken* =
]= >
=? @
newA D'
AuthenticatedAccountSessionE `
{ 
AccountUserId 
= 
accountUserId  -
,- .&
AccountSessionExpiresAtUtc *
=+ ,
DateTime- 5
.5 6
UtcNow6 <
.< =
AddHours= E
(E F'
AccountSessionLifetimeHoursF a
)a b
}   
;   
return!! 
accountSessionToken!! &
;!!& '
}"" 	
public$$ 
int$$  
ResolveAccountUserId$$ '
($$' (
string$$( .
accountSessionToken$$/ B
)$$B C
{%% 	
int&& 
accountUserId&& 
=&& 
$num&&  !
;&&! "
if'' 
('' 
!'' 
string'' 
.'' 
IsNullOrEmpty'' %
(''% &
accountSessionToken''& 9
)''9 :
&&''; =)
_authenticatedAccountSessions(( -
.((- .
TryGetValue((. 9
(((9 :
accountSessionToken((: M
,((M N
out)) '
AuthenticatedAccountSession)) 3
accountSession))4 B
)))B C
)))C D
{** 
if++ 
(++ 
accountSession++ "
.++" #&
AccountSessionExpiresAtUtc++# =
>++> ?
DateTime++@ H
.++H I
UtcNow++I O
)++O P
{,, 
accountUserId-- !
=--" #
accountSession--$ 2
.--2 3
AccountUserId--3 @
;--@ A
}.. 
else// 
{00 )
_authenticatedAccountSessions11 1
.111 2
	TryRemove112 ;
(11; <
accountSessionToken11< O
,11O P
out11Q T'
AuthenticatedAccountSession11U p
_11q r
)11r s
;11s t
}22 
}33 
return55 
accountUserId55  
;55  !
}66 	
public88 
void88 !
RevokeAccountSessions88 )
(88) *
int88* -
accountUserId88. ;
)88; <
{99 	
foreach:: 
(:: 
KeyValuePair:: !
<::! "
string::" (
,::( )'
AuthenticatedAccountSession::* E
>::E F
accountSession::G U
in::V X)
_authenticatedAccountSessions::Y v
)::v w
{;; 
if<< 
(<< 
accountSession<< "
.<<" #
Value<<# (
.<<( )
AccountUserId<<) 6
==<<7 9
accountUserId<<: G
)<<G H
{== )
_authenticatedAccountSessions>> 1
.>>1 2
	TryRemove>>2 ;
(>>; <
accountSession>>< J
.>>J K
Key>>K N
,>>N O
out>>P S'
AuthenticatedAccountSession>>T o
_>>p q
)>>q r
;>>r s
}?? 
}@@ 
}AA 	
privateCC 
voidCC (
RemoveExpiredAccountSessionsCC 1
(CC1 2
)CC2 3
{DD 	
foreachEE 
(EE 
KeyValuePairEE !
<EE! "
stringEE" (
,EE( )'
AuthenticatedAccountSessionEE* E
>EEE F
accountSessionEEG U
inEEV X)
_authenticatedAccountSessionsEEY v
)EEv w
{FF 
ifGG 
(GG 
accountSessionGG "
.GG" #
ValueGG# (
.GG( )&
AccountSessionExpiresAtUtcGG) C
<=GGD F
DateTimeGGG O
.GGO P
UtcNowGGP V
)GGV W
{HH )
_authenticatedAccountSessionsII 1
.II1 2
	TryRemoveII2 ;
(II; <
accountSessionII< J
.IIJ K
KeyIIK N
,IIN O
outIIP S'
AuthenticatedAccountSessionIIT o
_IIp q
)IIq r
;IIr s
}JJ 
}KK 
}LL 	
}MM 
}NN Û
tC:\Users\oscar\source\repos\TrickTakingMissions\Server\Services\DataContracts\ChatModeration\ChatAccountBanNotice.cs
	namespace 	
Services
 
. 
DataContracts  
{ 
[ 
DataContract 
] 
public 

sealed 
class  
ChatAccountBanNotice ,
{		 
[

 	

DataMember

	 
(

 
Order

 
=

 
$num

 
)

 
]

 
public 
DateTime 
EvaluatedAtUtc &
{' (
get) ,
;, -
set. 1
;1 2
}3 4
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public 
Guid #
ChatMessageSubmissionId +
{, -
get. 1
;1 2
set3 6
;6 7
}8 9
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public 
ChatAccountBanType !
ChatAccountBanType" 4
{5 6
get7 :
;: ;
set< ?
;? @
}A B
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public 
DateTime 
? #
ChatAccountBanEndsAtUtc 0
{1 2
get3 6
;6 7
set8 ;
;; <
}= >
} 
} È
rC:\Users\oscar\source\repos\TrickTakingMissions\Server\Services\DataContracts\ChatModeration\ChatAccountBanType.cs
	namespace 	
Services
 
. 
DataContracts  
{ 
[ 
DataContract 
] 
public 

enum 
ChatAccountBanType "
{		 
[

 	

EnumMember

	 
]

 
Unspecified 
= 
$num 
, 
[ 	

EnumMember	 
] 
	Temporary 
= 
$num 
, 
[ 	

EnumMember	 
] 
	Permanent 
= 
$num 
} 
} ≠

zC:\Users\oscar\source\repos\TrickTakingMissions\Server\Services\DataContracts\ChatModeration\LobbyChatMessageSubmission.cs
	namespace 	
Services
 
. 
DataContracts  
{ 
[ 
DataContract 
] 
public		 

sealed		 
class		 &
LobbyChatMessageSubmission		 2
{

 
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public 
Guid #
ChatMessageSubmissionId +
{, -
get. 1
;1 2
set3 6
;6 7
}8 9
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public 
string 
	LobbyCode 
{  !
get" %
;% &
set' *
;* +
}, -
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public 
string #
OriginalChatMessageText -
{. /
get0 3
;3 4
set5 8
;8 9
}: ;
} 
} ‡
tC:\Users\oscar\source\repos\TrickTakingMissions\Server\Services\DataContracts\ChatModeration\ChatInfractionNotice.cs
	namespace 	
Services
 
. 
DataContracts  
{ 
[ 
DataContract 
] 
public		 

sealed		 
class		  
ChatInfractionNotice		 ,
{

 
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public 
Guid #
ChatMessageSubmissionId +
{, -
get. 1
;1 2
set3 6
;6 7
}8 9
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public 
int *
CurrentMessageInfractionPoints 1
{2 3
get4 7
;7 8
set9 <
;< =
}> ?
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public 
int +
AccumulatedChatInfractionPoints 2
{3 4
get5 8
;8 9
set: =
;= >
}? @
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public 
int (
ChatInfractionPointThreshold /
{0 1
get2 5
;5 6
set7 :
;: ;
}< =
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public 
int 2
&RemainingChatInfractionPointsBeforeBan 9
{: ;
get< ?
;? @
setA D
;D E
}F G
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public 
int '
ThreateningChatMessageCount .
{/ 0
get1 4
;4 5
set6 9
;9 :
}; <
} 
} ú
jC:\Users\oscar\source\repos\TrickTakingMissions\Server\Services\Mapping\LobbyChatMessageRejectionMapper.cs
	namespace 	
Services
 
. 
Mapping 
{ 
internal 
static 
class +
LobbyChatMessageRejectionMapper 9
{ 
internal 
static +
LobbyChatMessageRejectionReason 7
MapRejectionReason8 J
(J K&
ChatMessageRejectionReason		 &&
applicationRejectionReason		' A
)		A B
{

 	+
LobbyChatMessageRejectionReason +#
contractRejectionReason, C
;C D
switch 
( &
applicationRejectionReason .
). /
{ 
case &
ChatMessageRejectionReason /
./ 0
None0 4
:4 5#
contractRejectionReason +
=, -+
LobbyChatMessageRejectionReason. M
.M N
NoneN R
;R S
break 
; 
case &
ChatMessageRejectionReason /
./ 0
InvalidChatMessage0 B
:B C#
contractRejectionReason +
=, -+
LobbyChatMessageRejectionReason. M
.M N
InvalidChatMessageN `
;` a
break 
; 
case &
ChatMessageRejectionReason /
./ 0&
ChatAuthenticationRequired0 J
:J K#
contractRejectionReason +
=, -+
LobbyChatMessageRejectionReason. M
.M N&
ChatAuthenticationRequiredN h
;h i
break 
; 
case &
ChatMessageRejectionReason /
./ 0%
ChatParticipantNotInLobby0 I
:I J#
contractRejectionReason +
=, -+
LobbyChatMessageRejectionReason. M
.M N%
ChatParticipantNotInLobbyN g
;g h
break 
; 
case &
ChatMessageRejectionReason /
./ 0"
ChatStorageUnavailable0 F
:F G#
contractRejectionReason +
=, -+
LobbyChatMessageRejectionReason. M
.M N"
ChatStorageUnavailableN d
;d e
break 
; 
case &
ChatMessageRejectionReason /
./ 0%
ChatModerationUnavailable0 I
:I J#
contractRejectionReason +
=, -+
LobbyChatMessageRejectionReason. M
.M N%
ChatModerationUnavailableN g
;g h
break 
; 
case   &
ChatMessageRejectionReason   /
.  / 0,
 ConflictingChatMessageIdentifier  0 P
:  P Q#
contractRejectionReason!! +
=!!, -+
LobbyChatMessageRejectionReason!!. M
.!!M N,
 ConflictingChatMessageIdentifier!!N n
;!!n o
break"" 
;"" 
case## &
ChatMessageRejectionReason## /
.##/ 0
ChatAccountBanned##0 A
:##A B#
contractRejectionReason$$ +
=$$, -+
LobbyChatMessageRejectionReason$$. M
.$$M N
ChatAccountBanned$$N _
;$$_ `
break%% 
;%% 
case&& &
ChatMessageRejectionReason&& /
.&&/ 0
ChatDeliveryUnknown&&0 C
:&&C D#
contractRejectionReason'' +
='', -+
LobbyChatMessageRejectionReason''. M
.''M N
ChatDeliveryUnknown''N a
;''a b
break(( 
;(( 
default)) 
:)) #
contractRejectionReason** +
=**, -+
LobbyChatMessageRejectionReason**. M
.**M N
ChatDeliveryUnknown**N a
;**a b
break++ 
;++ 
},, 
return.. #
contractRejectionReason.. *
;..* +
}// 	
}00 
}11 Ú
C:\Users\oscar\source\repos\TrickTakingMissions\Server\Services\DataContracts\ChatModeration\LobbyChatMessageRejectionReason.cs
	namespace 	
Services
 
. 
DataContracts  
{ 
[ 
DataContract 
( 
Name 
= 
$str 5
,5 6
	Namespace 
= 
$str P
)P Q
]Q R
public 

enum +
LobbyChatMessageRejectionReason /
{		 
[

 	

EnumMember

	 
]

 
None 
= 
$num 
, 
[ 	

EnumMember	 
] 
InvalidChatMessage 
= 
$num 
, 
[ 	

EnumMember	 
] &
ChatAuthenticationRequired "
=# $
$num% &
,& '
[ 	

EnumMember	 
] %
ChatParticipantNotInLobby !
=" #
$num$ %
,% &
[ 	

EnumMember	 
] "
ChatStorageUnavailable 
=  
$num! "
," #
[ 	

EnumMember	 
] %
ChatModerationUnavailable !
=" #
$num$ %
,% &
[ 	

EnumMember	 
] ,
 ConflictingChatMessageIdentifier (
=) *
$num+ ,
,, -
[ 	

EnumMember	 
] 
ChatAccountBanned   
=   
$num   
,   
["" 	

EnumMember""	 
]"" 
ChatDeliveryUnknown## 
=## 
$num## 
}$$ 
}%% ó
ÅC:\Users\oscar\source\repos\TrickTakingMissions\Server\Services\DataContracts\ChatModeration\LobbyChatMessageSubmissionOutcome.cs
	namespace 	
Services
 
. 
DataContracts  
{ 
[ 
DataContract 
] 
public 

sealed 
class -
!LobbyChatMessageSubmissionOutcome 9
{		 
[

 	

DataMember

	 
(

 
Order

 
=

 
$num

 
)

 
]

 
public 
Guid #
ChatMessageSubmissionId +
{, -
get. 1
;1 2
set3 6
;6 7
}8 9
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public 
bool !
IsChatMessageAccepted )
{* +
get, /
;/ 0
set1 4
;4 5
}6 7
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public 
bool +
IsRepeatedChatMessageSubmission 3
{4 5
get6 9
;9 :
set; >
;> ?
}@ A
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public +
LobbyChatMessageRejectionReason .&
ChatMessageRejectionReason/ I
{J K
getL O
;O P
setQ T
;T U
}V W
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public  
ChatInfractionNotice # 
ChatInfractionNotice$ 8
{9 :
get; >
;> ?
set@ C
;C D
}E F
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public  
ChatAccountBanNotice # 
ChatAccountBanNotice$ 8
{9 :
get; >
;> ?
set@ C
;C D
}E F
} 
} ≠
kC:\Users\oscar\source\repos\TrickTakingMissions\Server\Services\Contracts\Friends\IFriendsRequestService.cs
	namespace

 	
Services


 
.

 
	Contracts

 
.

 

Friendship

 '
{ 
[ 
ServiceContract 
] 
public 

	interface "
IFriendsRequestService +
{ 
[ 	
OperationContract	 
] 
Task 
< 
OperationResult 
> "
SendFriendRequestAsync 4
(4 5
int5 8
senderUserId9 E
,E F
stringG M
targetUserNameN \
)\ ]
;] ^
[ 	
OperationContract	 
] 
Task 
< 
OperationResult 
> $
AcceptFriendRequestAsync 6
(6 7
int7 :
receiverUserId; I
,I J
intK N
senderUserIdO [
)[ \
;\ ]
[ 	
OperationContract	 
] 
Task 
< 
OperationResult 
> $
RejectFriendRequestAsync 6
(6 7
int7 :
receiverUserId; I
,I J
intK N
senderUserIdO [
)[ \
;\ ]
[ 	
OperationContract	 
] 
Task 
< 
OperationResult 
> $
CancelFriendRequestAsync 6
(6 7
int7 :
senderUserId; G
,G H
intI L
receiverUserIdM [
)[ \
;\ ]
[ 	
OperationContract	 
] 
Task 
< 
List 
< 
FriendRequest 
>  
>  !0
$GetPendingFriendRequestByUserIdAsync" F
(F G
intG J
userIdK Q
)Q R
;R S
[ 	
OperationContract	 
] 
Task 
< 
List 
< 
FriendRequest 
>  
>  !-
!GetSentFriendRequestByUserIdAsync" C
(C D
intD G
userIdH N
)N O
;O P
}   
}!! º
oC:\Users\oscar\source\repos\TrickTakingMissions\Server\Services\Contracts\Friends\IFriendshipServiceCallback.cs
	namespace 	
Services
 
. 
	Contracts 
. 

Friendship '
{ 
public 

	interface &
IFriendshipServiceCallback /
{ 
[ 	
OperationContract	 
( 
IsOneWay #
=$ %
true& *
)* +
]+ ,
void		 "
OnReceiveFriendRequest		 #
(		# $
FriendRequest		$ 1
friendRequest		2 ?
)		? @
;		@ A
[ 	
OperationContract	 
( 
IsOneWay #
=$ %
true& *
)* +
]+ ,
void !
OnFriendStatusChanged "
(" #
int# &
friendUserId' 3
,3 4
bool5 9
isOnline: B
)B C
;C D
[ 	
OperationContract	 
( 
IsOneWay #
=$ %
true& *
)* +
]+ ,
void 
OnFriendRemoved 
( 
int  
friendUserId! -
)- .
;. /
[ 	
OperationContract	 
( 
IsOneWay #
=$ %
true& *
)* +
]+ ,
void #
OnReceiveGameInvitation $
($ %
GameInvitation% 3
gameInvitation4 B
)B C
;C D
} 
} ¶
gC:\Users\oscar\source\repos\TrickTakingMissions\Server\Services\Contracts\Friends\IFriendshipService.cs
	namespace 	
Services
 
. 
	Contracts 
. 

Friendship '
{ 
[ 
ServiceContract 
( 
CallbackContract %
=& '
typeof( .
(. /&
IFriendshipServiceCallback/ I
)I J
)J K
]K L
public		 

	interface		 
IFriendshipService		 '
{

 
[ 	
OperationContract	 
( 
IsOneWay #
=$ %
true& *
)* +
]+ ,
void !
SubscribeSocialEvents "
(" #
int# &
userId' -
)- .
;. /
[ 	
OperationContract	 
( 
IsOneWay #
=$ %
true& *
)* +
]+ ,
void #
UnsubscribeSocialEvents $
($ %
int% (
userId) /
)/ 0
;0 1
[ 	
OperationContract	 
] 
List 
< 
Friend 
> "
GetFriendsListByUserId +
(+ ,
int, /
userId0 6
)6 7
;7 8
[ 	
OperationContract	 
] 
OperationResult 
BlockPlayer #
(# $
int$ '
blockerUserId( 5
,5 6
int7 :
targetUserId; G
)G H
;H I
[ 	
OperationContract	 
] 
OperationResult 
UnblockPlayer %
(% &
int& )
blockerUserId* 7
,7 8
int9 <
targetUserId= I
)I J
;J K
[ 	
OperationContract	 
] 
OperationResult 
RemoveFriend $
($ %
int% (
userId) /
,/ 0
int1 4
friendUserId5 A
)A B
;B C
[ 	
OperationContract	 
( 
IsOneWay #
=$ %
true& *
)* +
]+ ,
void 
SendGameInvitation 
(  
GameInvitation  .
gameInvitation/ =
)= >
;> ?
} 
}   