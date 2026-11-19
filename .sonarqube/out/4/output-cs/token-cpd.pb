û
cC:\Users\oscar\source\repos\TrickTakingMissions\Client\Model\Services\Partials\LobbyResult.Guest.cs
	namespace 	
Model
 
. 
GameServices 
{ 
public 

partial 
class 
LobbyResult $
{ 
[ 	

DataMember	 
] 
public 
string 
GuestSessionToken '
{( )
get* -
;- .
set/ 2
;2 3
}4 5
}		 
}

 ‰(
jC:\Users\oscar\source\repos\TrickTakingMissions\Client\Model\Services\Partials\LobbyServiceClient.Match.cs
	namespace 	
Model
 
. 
GameServices 
{ 
public 

partial 
class 
LobbyServiceClient +
{ 
public *
MissionPreparationConfirmation -"
IdentifyHeartNineOwner. D
(D E-
!HeartNineIdentificationSubmission -

submission. 8
,8 9
int: =
participantUserId> O
)O P
{		 	
return

 
Channel

 
.

 "
IdentifyHeartNineOwner

 1
(

1 2

submission

2 <
,

< =
participantUserId

> O
)

O P
;

P Q
} 	
public *
MissionPreparationConfirmation -*
AssignMissionTrickDistribution. L
(L M.
"MissionTrickDistributionSubmission .

submission/ 9
,9 :
int; >
participantUserId? P
)P Q
{ 	
return 
Channel 
. *
AssignMissionTrickDistribution 9
(9 :

submission: D
,D E
participantUserIdF W
)W X
;X Y
} 	
public *
MissionPreparationConfirmation -
AssignMissionRole. ?
(? @+
MissionRoleAssignmentSubmission@ _

submission` j
,j k
int 
participantUserId !
)! "
{ 	
return 
Channel 
. 
AssignMissionRole ,
(, -

submission- 7
,7 8
participantUserId9 J
)J K
;K L
} 	
public *
MissionPreparationConfirmation -$
RespondToBlindObjectives. F
(F G,
 BlindObjectiveResponseSubmissionG g

submissionh r
,r s
int 
participantUserId !
)! "
{ 	
return 
Channel 
. $
RespondToBlindObjectives 3
(3 4

submission4 >
,> ?
participantUserId@ Q
)Q R
;R S
} 	
public *
RadioCommunicationConfirmation -$
SubmitRadioCommunication. F
(F G(
RadioCommunicationSubmissionG c

submissiond n
,n o
int   
participantUserId   !
)  ! "
{!! 	
return"" 
Channel"" 
."" $
SubmitRadioCommunication"" 3
(""3 4

submission""4 >
,""> ?
participantUserId""@ Q
)""Q R
;""R S
}## 	
public%% 
PlayerMatchSnapshot%% "
GetPlayerMatch%%# 1
(%%1 2
string%%2 8
	lobbyCode%%9 B
,%%B C
int%%D G
participantUserId%%H Y
)%%Y Z
{&& 	
return'' 
Channel'' 
.'' 
GetPlayerMatch'' )
('') *
	lobbyCode''* 3
,''3 4
participantUserId''5 F
)''F G
;''G H
}(( 	
public** )
MissionObjectiveDraftDecision** ,'
ProcessObjectiveDraftAction**- H
(**H I+
MissionObjectiveDraftSubmission++ +

submission++, 6
,++6 7
int++8 ;
participantUserId++< M
)++M N
{,, 	
return-- 
Channel-- 
.-- '
ProcessObjectiveDraftAction-- 6
(--6 7

submission--7 A
,--A B
participantUserId--C T
)--T U
;--U V
}.. 	
public00  
MissionRetryDecision00 #
ConfirmMissionRetry00$ 7
(007 8"
MissionRetrySubmission008 N

submission00O Y
,00Y Z
int00[ ^
participantUserId00_ p
)00p q
{11 	
return22 
Channel22 
.22 
ConfirmMissionRetry22 .
(22. /

submission22/ 9
,229 :
participantUserId22; L
)22L M
;22M N
}33 	
public55 
CardPlayDecision55 
PlayCard55  (
(55( )
CardPlaySubmission55) ;
cardPlaySubmission55< N
,55N O
int55P S
participantUserId55T e
)55e f
{66 	
return77 
Channel77 
.77 
PlayCard77 #
(77# $
cardPlaySubmission77$ 6
,776 7
participantUserId778 I
)77I J
;77J K
}88 	
public:: &
DistressSignalConfirmation:: ) 
SubmitDistressSignal::* >
(::> ?$
DistressSignalSubmission;; $

submission;;% /
,;;/ 0
int;;1 4
participantUserId;;5 F
);;F G
{<< 	
return== 
Channel== 
.==  
SubmitDistressSignal== /
(==/ 0

submission==0 :
,==: ;
participantUserId==< M
)==M N
;==N O
}>> 	
}?? 
}@@ úà
hC:\Users\oscar\source\repos\TrickTakingMissions\Client\Model\Services\LobbyAndMatch\LobbyClient.Match.cs
	namespace		 	
Model		
 
.		 
Services		 
{

 
public 

sealed 
partial 
class 
LobbyClient  +
{ 
private 
const 
string +
MatchCommunicationFaultTemplate <
== >
$str S
;S T
private 
const 
string  
MatchTimeoutTemplate 1
=2 3
$str T
;T U
private 
readonly 
SemaphoreSlim &
_matchRequestGate' 8
=9 :
new; >
SemaphoreSlim? L
(L M
$numM N
,N O
$numP Q
)Q R
;R S
private 
string %
_registeredMatchLobbyCode 0
;0 1
private 
readonly 
object 
_matchPresenceGate  2
=3 4
new5 8
object9 ?
(? @
)@ A
;A B
private 
Guid 
_observedMatchId %
;% &
private 
int %
_observedMissionAttemptId -
;- .
public 
Task 
< *
MissionPreparationConfirmation 2
>2 3'
IdentifyHeartNineOwnerAsync4 O
(O P-
!HeartNineIdentificationSubmission -

submission. 8
,8 9
int: =
participantUserId> O
)O P
{ 	
return &
ExecuteMatchOperationAsync -
(- .
channel. 5
=>6 8
channel9 @
.@ A"
IdentifyHeartNineOwnerA W
(W X

submissionX b
,b c
participantUserIdd u
)u v
,v w

submission 
. 
	LobbyCode $
,$ %
participantUserId& 7
)7 8
;8 9
} 	
public 
Task 
< *
MissionPreparationConfirmation 2
>2 3/
#AssignMissionTrickDistributionAsync4 W
(W X.
"MissionTrickDistributionSubmission   .

submission  / 9
,  9 :
int  ; >
participantUserId  ? P
)  P Q
{!! 	
return"" &
ExecuteMatchOperationAsync"" -
(""- .
channel"". 5
=>""6 8
channel""9 @
.""@ A*
AssignMissionTrickDistribution""A _
(""_ `

submission""` j
,""j k
participantUserId## !
)##! "
,##" #

submission$$ 
.$$ 
	LobbyCode$$ $
,$$$ %
participantUserId$$& 7
)$$7 8
;$$8 9
}%% 	
public'' 
Task'' 
<'' *
MissionPreparationConfirmation'' 2
>''2 3"
AssignMissionRoleAsync''4 J
(''J K+
MissionRoleAssignmentSubmission''K j

submission''k u
,''u v
int(( 
participantUserId(( !
)((! "
{)) 	
return** &
ExecuteMatchOperationAsync** -
(**- .
channel**. 5
=>**6 8
channel**9 @
.**@ A
AssignMissionRole**A R
(**R S

submission**S ]
,**] ^
participantUserId**_ p
)**p q
,**q r

submission++ 
.++ 
	LobbyCode++ $
,++$ %
participantUserId++& 7
)++7 8
;++8 9
},, 	
public.. 
Task.. 
<.. *
MissionPreparationConfirmation.. 2
>..2 3)
RespondToBlindObjectivesAsync..4 Q
(..Q R,
 BlindObjectiveResponseSubmission..R r

submission// 
,// 
int00 
participantUserId00 !
)00! "
{11 	
return22 &
ExecuteMatchOperationAsync22 -
(22- .
channel22. 5
=>226 8
channel229 @
.22@ A$
RespondToBlindObjectives22A Y
(22Y Z

submission22Z d
,22d e
participantUserId33 !
)33! "
,33" #

submission44 
.44 
	LobbyCode44 $
,44$ %
participantUserId44& 7
)447 8
;448 9
}55 	
public77 
event77 
Action77 
<77 
long77  
>77  !
MatchStateChanged77" 3
;773 4
public99 
async99 
Task99 
<99 
PlayerMatchSnapshot99 -
>99- .
GetPlayerMatchAsync99/ B
(99B C
string99C I
	lobbyCode99J S
,99S T
int99U X
participantUserId99Y j
)99j k
{:: 	
PlayerMatchSnapshot;; 
snapshot;;  (
=;;) *
await;;+ 0&
ExecuteMatchOperationAsync;;1 K
(;;K L
channel<< 
=><< 
channel<< "
.<<" #
GetPlayerMatch<<# 1
(<<1 2
	lobbyCode<<2 ;
,<<; <
participantUserId<<= N
)<<N O
,<<O P
	lobbyCode<<Q Z
,<<Z [
participantUserId<<\ m
)<<m n
;<<n o
lock== 
(== 
_matchPresenceGate== $
)==$ %
{>> 
_observedMatchId??  
=??! "
snapshot??# +
.??+ ,
MatchId??, 3
;??3 4%
_observedMissionAttemptId@@ )
=@@* +
snapshot@@, 4
.@@4 5
MissionPreparation@@5 G
.@@G H
MissionAttemptId@@H X
;@@X Y
}AA 
returnBB 
snapshotBB 
;BB 
}CC 	
publicEE 
boolEE '
IsMatchParticipantConnectedEE /
(EE/ 0
GuidEE0 4
matchIdEE5 <
,EE< =
intEE> A
missionAttemptIdEEB R
)EER S
{FF 	
boolGG 
isConnectedGG 
;GG 
lockHH 
(HH 
_matchPresenceGateHH $
)HH$ %
{II 
isConnectedJJ 
=JJ 
!JJ "
_isLobbyClientDisposedJJ 5
&&JJ6 8
_clientJJ9 @
?JJ@ A
.JJA B
StateJJB G
==JJH J
CommunicationStateJJK ]
.JJ] ^
OpenedJJ^ d
&&JJe g
_observedMatchIdKK $
==KK% '
matchIdKK( /
&&KK0 2%
_observedMissionAttemptIdKK3 L
==KKM O
missionAttemptIdKKP `
;KK` a
}LL 
returnMM 
isConnectedMM 
;MM 
}NN 	
publicPP 
TaskPP 
<PP *
RadioCommunicationConfirmationPP 2
>PP2 3)
SubmitRadioCommunicationAsyncPP4 Q
(PPQ R(
RadioCommunicationSubmissionQQ (

submissionQQ) 3
,QQ3 4
intQQ5 8
participantUserIdQQ9 J
)QQJ K
{RR 	
returnSS &
ExecuteMatchOperationAsyncSS -
(SS- .
channelSS. 5
=>SS6 8
channelSS9 @
.SS@ A$
SubmitRadioCommunicationSSA Y
(SSY Z

submissionSSZ d
,SSd e
participantUserIdTT !
)TT! "
,TT" #

submissionUU 
.UU 
	LobbyCodeUU $
,UU$ %
participantUserIdUU& 7
)UU7 8
;UU8 9
}VV 	
publicXX 
TaskXX 
<XX 
CardPlayDecisionXX $
>XX$ %
PlayCardAsyncXX& 3
(XX3 4
CardPlaySubmissionXX4 F
cardPlaySubmissionXXG Y
,XXY Z
intXX[ ^
participantUserIdXX_ p
)XXp q
{YY 	
returnZZ &
ExecuteMatchOperationAsyncZZ -
(ZZ- .
channelZZ. 5
=>ZZ6 8
channelZZ9 @
.ZZ@ A
PlayCardZZA I
(ZZI J
cardPlaySubmissionZZJ \
,ZZ\ ]
participantUserIdZZ^ o
)ZZo p
,ZZp q
cardPlaySubmission[[ "
.[[" #
	LobbyCode[[# ,
,[[, -
participantUserId[[. ?
)[[? @
;[[@ A
}\\ 	
public^^ 
Task^^ 
<^^ )
MissionObjectiveDraftDecision^^ 1
>^^1 2,
 ProcessObjectiveDraftActionAsync^^3 S
(^^S T+
MissionObjectiveDraftSubmission__ +

submission__, 6
,__6 7
int__8 ;
participantUserId__< M
)__M N
{`` 	
returnaa &
ExecuteMatchOperationAsyncaa -
(aa- .
channelaa. 5
=>aa6 8
channelaa9 @
.aa@ A'
ProcessObjectiveDraftActionaaA \
(aa\ ]

submissionaa] g
,aag h
participantUserIdbb !
)bb! "
,bb" #

submissionbb$ .
.bb. /
	LobbyCodebb/ 8
,bb8 9
participantUserIdbb: K
)bbK L
;bbL M
}cc 	
publicee 
Taskee 
<ee  
MissionRetryDecisionee (
>ee( )$
ConfirmMissionRetryAsyncee* B
(eeB C"
MissionRetrySubmissioneeC Y

submissioneeZ d
,eed e
intff 
participantUserIdff !
)ff! "
{gg 	
returnhh &
ExecuteMatchOperationAsynchh -
(hh- .
channelhh. 5
=>hh6 8
channelhh9 @
.hh@ A
ConfirmMissionRetryhhA T
(hhT U

submissionhhU _
,hh_ `
participantUserIdhha r
)hhr s
,hhs t

submissionii 
.ii 
	LobbyCodeii $
,ii$ %
participantUserIdii& 7
)ii7 8
;ii8 9
}jj 	
publicll 
Taskll 
<ll &
DistressSignalConfirmationll .
>ll. /%
SubmitDistressSignalAsyncll0 I
(llI J$
DistressSignalSubmissionmm $

submissionmm% /
,mm/ 0
intmm1 4
participantUserIdmm5 F
)mmF G
{nn 	
returnoo &
ExecuteMatchOperationAsyncoo -
(oo- .
channelpp 
=>pp 
channelpp "
.pp" # 
SubmitDistressSignalpp# 7
(pp7 8

submissionpp8 B
,ppB C
participantUserIdppD U
)ppU V
,ppV W

submissionqq 
.qq 
	LobbyCodeqq $
,qq$ %
participantUserIdqq& 7
)qq7 8
;qq8 9
}rr 	
publictt 
voidtt 
OnMatchStateChangedtt '
(tt' (
longtt( ,
matchStateVersiontt- >
)tt> ?
{uu 	
MatchStateChangedvv 
?vv 
.vv 
Invokevv %
(vv% &
matchStateVersionvv& 7
)vv7 8
;vv8 9
}ww 	
privateyy 
asyncyy 
Taskyy 
<yy 
Tyy 
>yy &
ExecuteMatchOperationAsyncyy 8
<yy8 9
Tyy9 :
>yy: ;
(yy; <
Funcyy< @
<yy@ A
LobbyServiceClientyyA S
,yyS T
TyyU V
>yyV W
matchOperationyyX f
,yyf g
stringzz 
	lobbyCodezz 
,zz 
intzz !
participantUserIdzz" 3
)zz3 4
{{{ 	
T||  
matchOperationResult|| "
;||" #
await}} 
_matchRequestGate}} #
.}}# $
	WaitAsync}}$ -
(}}- .
)}}. /
;}}/ 0
try~~ 
{ "
matchOperationResult
ÄÄ $
=
ÄÄ% &
await
ÄÄ' ,
Task
ÄÄ- 1
.
ÄÄ1 2
Run
ÄÄ2 5
(
ÄÄ5 6
(
ÄÄ6 7
)
ÄÄ7 8
=>
ÄÄ9 ;"
InvokeMatchOperation
ÄÄ< P
(
ÄÄP Q
matchOperation
ÅÅ "
,
ÅÅ" #
	lobbyCode
ÅÅ$ -
,
ÅÅ- .
participantUserId
ÅÅ/ @
)
ÅÅ@ A
)
ÅÅA B
;
ÅÅB C
}
ÇÇ 
catch
ÉÉ 
(
ÉÉ 
FaultException
ÉÉ !
)
ÉÉ! "
{
ÑÑ 
throw
ÖÖ 
;
ÖÖ 
}
ÜÜ 
catch
áá 
(
áá $
CommunicationException
áá )
ex
áá* ,
)
áá, -
{
àà 
_logger
ââ 
.
ââ 
Error
ââ 
(
ââ 
ex
ââ  
,
ââ  !-
MatchCommunicationFaultTemplate
ââ" A
,
ââA B
	lobbyCode
ââC L
)
ââL M
;
ââM N'
_registeredMatchLobbyCode
ää )
=
ää* +
null
ää, 0
;
ää0 1
throw
ãã 
;
ãã 
}
åå 
catch
çç 
(
çç 
TimeoutException
çç #
ex
çç$ &
)
çç& '
{
éé 
_logger
èè 
.
èè 
Error
èè 
(
èè 
ex
èè  
,
èè  !"
MatchTimeoutTemplate
èè" 6
,
èè6 7
	lobbyCode
èè8 A
)
èèA B
;
èèB C'
_registeredMatchLobbyCode
êê )
=
êê* +
null
êê, 0
;
êê0 1
_client
ëë 
?
ëë 
.
ëë 
Abort
ëë 
(
ëë 
)
ëë  
;
ëë  !
throw
íí 
;
íí 
}
ìì 
finally
îî 
{
ïï 
_matchRequestGate
ññ !
.
ññ! "
Release
ññ" )
(
ññ) *
)
ññ* +
;
ññ+ ,
}
óó 
return
òò "
matchOperationResult
òò '
;
òò' (
}
ôô 	
private
õõ 
T
õõ "
InvokeMatchOperation
õõ &
<
õõ& '
T
õõ' (
>
õõ( )
(
õõ) *
Func
õõ* .
<
õõ. / 
LobbyServiceClient
õõ/ A
,
õõA B
T
õõC D
>
õõD E
matchOperation
õõF T
,
õõT U
string
úú 
	lobbyCode
úú 
,
úú 
int
úú !
participantUserId
úú" 3
)
úú3 4
{
ùù 	+
EnsureMatchParticipantChannel
ûû )
(
ûû) *
	lobbyCode
ûû* 3
,
ûû3 4
participantUserId
ûû5 F
)
ûûF G
;
ûûG H
return
üü 
matchOperation
üü !
(
üü! "
_client
üü" )
)
üü) *
;
üü* +
}
†† 	
private
¢¢ 
void
¢¢ +
EnsureMatchParticipantChannel
¢¢ 2
(
¢¢2 3
string
¢¢3 9
	lobbyCode
¢¢: C
,
¢¢C D
int
¢¢E H
participantUserId
¢¢I Z
)
¢¢Z [
{
££ 	
bool
§§ 
isChannelReplaced
§§ "
=
§§# $
_client
§§% ,
==
§§- /
null
§§0 4
||
§§5 7
_client
§§8 ?
.
§§? @
State
§§@ E
==
§§F H 
CommunicationState
§§I [
.
§§[ \
Faulted
§§\ c
||
§§d f
_client
•• 
.
•• 
State
•• 
==
••   
CommunicationState
••! 3
.
••3 4
Closed
••4 :
;
••: ; 
EnsureClientIsOpen
¶¶ 
(
¶¶ 
)
¶¶  
;
¶¶  !
if
ßß 
(
ßß 
isChannelReplaced
ßß !
||
ßß" $'
_registeredMatchLobbyCode
ßß% >
!=
ßß? A
	lobbyCode
ßßB K
)
ßßK L
{
®® 
LobbyResult
©© 
entryDecision
©© )
=
©©* +
_client
©©, 3
.
©©3 4
JoinLobbyByCode
©©4 C
(
©©C D
	lobbyCode
©©D M
,
©©M N
participantUserId
©©O `
)
©©` a
;
©©a b%
PreserveGuestCredential
™™ '
(
™™' (
entryDecision
™™( 5
)
™™5 6
;
™™6 7
if
´´ 
(
´´ 
!
´´ 
entryDecision
´´ "
.
´´" #
	IsSuccess
´´# ,
)
´´, -
{
¨¨ 
throw
≠≠ 
new
≠≠ 
FaultException
≠≠ ,
(
≠≠, -
$str
≠≠- ?
)
≠≠? @
;
≠≠@ A
}
ÆÆ '
_registeredMatchLobbyCode
ØØ )
=
ØØ* +
	lobbyCode
ØØ, 5
;
ØØ5 6
}
∞∞ 
}
±± 	
private
≥≥ 
static
≥≥ 
void
≥≥ %
PreserveGuestCredential
≥≥ 3
(
≥≥3 4
LobbyResult
≥≥4 ?
entryDecision
≥≥@ M
)
≥≥M N
{
¥¥ 	
if
µµ 
(
µµ 
entryDecision
µµ 
!=
µµ  
null
µµ! %
&&
µµ& (
!
µµ) *
string
µµ* 0
.
µµ0 1
IsNullOrEmpty
µµ1 >
(
µµ> ?
entryDecision
µµ? L
.
µµL M
GuestSessionToken
µµM ^
)
µµ^ _
&&
µµ` b
UserSession
∂∂ 
.
∂∂ 
Current
∂∂ #
.
∂∂# $
CurrentUser
∂∂$ /
!=
∂∂0 2
null
∂∂3 7
)
∂∂7 8
{
∑∑ 
UserSession
∏∏ 
.
∏∏ 
Current
∏∏ #
.
∏∏# $
CurrentUser
∏∏$ /
.
∏∏/ 0
GuestSessionToken
∏∏0 A
=
∏∏B C
entryDecision
∏∏D Q
.
∏∏Q R
GuestSessionToken
∏∏R c
;
∏∏c d
}
ππ 
}
∫∫ 	
}
ªª 
}ºº Ì
cC:\Users\oscar\source\repos\TrickTakingMissions\Client\Model\Services\LobbyAndMatch\IMatchClient.cs
	namespace 	
Model
 
. 
Services 
{ 
public 

	interface 
IMatchClient !
{		 
Task

 
<

 *
MissionPreparationConfirmation

 +
>

+ ,'
IdentifyHeartNineOwnerAsync

- H
(

H I-
!HeartNineIdentificationSubmission -

submission. 8
,8 9
int: =
participantUserId> O
)O P
;P Q
Task 
< *
MissionPreparationConfirmation +
>+ ,/
#AssignMissionTrickDistributionAsync- P
(P Q.
"MissionTrickDistributionSubmission .

submission/ 9
,9 :
int; >
participantUserId? P
)P Q
;Q R
Task 
< *
MissionPreparationConfirmation +
>+ ,"
AssignMissionRoleAsync- C
(C D+
MissionRoleAssignmentSubmission +

submission, 6
,6 7
int8 ;
participantUserId< M
)M N
;N O
Task 
< *
MissionPreparationConfirmation +
>+ ,)
RespondToBlindObjectivesAsync- J
(J K,
 BlindObjectiveResponseSubmission ,

submission- 7
,7 8
int9 <
participantUserId= N
)N O
;O P
event 
Action 
< 
long 
> 
MatchStateChanged ,
;, -
Task 
< *
RadioCommunicationConfirmation +
>+ ,)
SubmitRadioCommunicationAsync- J
(J K(
RadioCommunicationSubmission (

submission) 3
,3 4
int5 8
participantUserId9 J
)J K
;K L
Task 
< )
MissionObjectiveDraftDecision *
>* +,
 ProcessObjectiveDraftActionAsync, L
(L M+
MissionObjectiveDraftSubmission +

submission, 6
,6 7
int8 ;
participantUserId< M
)M N
;N O
Task 
< 
PlayerMatchSnapshot  
>  !
GetPlayerMatchAsync" 5
(5 6
string6 <
	lobbyCode= F
,F G
intH K
participantUserIdL ]
)] ^
;^ _
Task 
<  
MissionRetryDecision !
>! "$
ConfirmMissionRetryAsync# ;
(; <"
MissionRetrySubmission< R

submissionS ]
,] ^
int_ b
participantUserIdc t
)t u
;u v
Task 
< 
CardPlayDecision 
> 
PlayCardAsync ,
(, -
CardPlaySubmission- ?
cardPlaySubmission@ R
,R S
intT W
participantUserIdX i
)i j
;j k
Task 
< &
DistressSignalConfirmation '
>' (%
SubmitDistressSignalAsync) B
(B C$
DistressSignalSubmission $

submission% /
,/ 0
int1 4
participantUserId5 F
)F G
;G H
} 
} â
uC:\Users\oscar\source\repos\TrickTakingMissions\Client\Model\Services\Partials\ILobbyServiceCallback.MatchPresence.cs
	namespace 	
Model
 
. 
GameServices 
{ 
public 

partial 
	interface !
ILobbyServiceCallback 2
{ 
[		 	
OperationContract			 
(		 
Action		 !
=		" #
$str		$ G
,		G H
ReplyAction		I T
=		U V
$str		W Z
)		Z [
]		[ \
bool

 '
IsMatchParticipantConnected

 (
(

( )
Guid

) -
matchId

. 5
,

5 6
int

7 :
missionAttemptId

; K
)

K L
;

L M
} 
} –
sC:\Users\oscar\source\repos\TrickTakingMissions\Client\Model\..\..\Shared\ProfileImages\ProfileImageFailureCodes.cs
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
} ¢	
iC:\Users\oscar\source\repos\TrickTakingMissions\Client\Model\Services\ProfileImages\IProfileImageCache.cs
	namespace 	
Model
 
. 
Services 
{ 
public		 

	interface		 
IProfileImageCache		 '
:		( )
IDisposable		* 5
{

 
event 
Action 
< 
int 
> 
ProfileImageChanged -
;- .
void 
RegisterPlayer 
( 
int 
profileOwnerUserId  2
)2 3
;3 4
void 
UnregisterPlayer 
( 
int !
profileOwnerUserId" 4
)4 5
;5 6
Task 
< 
byte 
[ 
] 
> !
LoadProfileImageAsync *
(* +
int+ .
profileOwnerUserId/ A
)A B
;B C
Task &
ChangeOwnProfileImageAsync '
(' (
byte( ,
[, -
]- .%
selectedProfileImageBytes/ H
)H I
;I J
} 
} ˇ	
mC:\Users\oscar\source\repos\TrickTakingMissions\Client\Model\..\..\Shared\ProfileImages\ProfileImageLimits.cs
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
} `
iC:\Users\oscar\source\repos\TrickTakingMissions\Client\Model\Services\ProfileImages\ProfileImageClient.cs
	namespace 	
Model
 
. 
Services 
{ 
[ 
CallbackBehavior 
( %
UseSynchronizationContext /
=0 1
false2 7
,7 8
ConcurrencyMode9 H
=I J
ConcurrencyModeK Z
.Z [
Multiple[ c
)c d
]d e
public 

sealed 
class 
ProfileImageClient *
:+ ,
IProfileImageClient- @
,@ A!
IProfileImageCallbackB W
{ 
private 
const 
string '
ConnectionFailedLogTemplate 8
=9 :
$str; n
;n o
private 
const 
string )
ConnectionTimedOutLogTemplate :
=; <
$str= s
;s t
private 
readonly 
string 
_endpointAddress  0
;0 1
private 
readonly 
ILoggerService '
_logger( /
;/ 0
private  
DuplexChannelFactory $
<$ % 
IProfileImageService% 9
>9 :
_channelFactory; J
;J K
private  
IProfileImageService $ 
_profileImageChannel% 9
;9 :
public 
ProfileImageClient !
(! "
string" (
endpointAddress) 8
,8 9
ILoggerService: H
loggerI O
)O P
{ 	
_endpointAddress 
= 
endpointAddress .
;. /
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
} 	
public!! 
event!! 
Action!! 
<!! 
int!! 
>!!  
ProfileImageChanged!!! 4
;!!4 5
public## 
Task## 
<## '
PlayerProfileImageReference## /
[##/ 0
]##0 1
>##1 2'
GetPlayerProfileImagesAsync##3 N
(##N O
int##O R
[##R S
]##S T
profileOwnerUserIds##U h
)##h i
{$$ 	
return%% 
ExecuteAsync%% 
(%%  
channel%%  '
=>%%( *
channel%%+ 2
.%%2 3"
GetPlayerProfileImages%%3 I
(%%I J
profileOwnerUserIds%%J ]
)%%] ^
)%%^ _
;%%_ `
}&& 	
public(( 
Task(( 
<(( 
ProfileImageContent(( '
>((' ( 
GetProfileImageAsync(() =
(((= >
Guid((> B
profileImageId((C Q
)((Q R
{)) 	
return** 
ExecuteAsync** 
(**  
channel**  '
=>**( *
channel**+ 2
.**2 3
GetProfileImage**3 B
(**B C
profileImageId**C Q
)**Q R
)**R S
;**S T
}++ 	
public-- 
Task-- 
<-- '
PlayerProfileImageReference-- /
>--/ 0&
ChangeOwnProfileImageAsync--1 K
(--K L
byte--L P
[--P Q
]--Q R%
selectedProfileImageBytes--S l
)--l m
{.. 	
return// 
ExecuteAsync// 
(//  
channel//  '
=>//( *
channel//+ 2
.//2 3!
ChangeOwnProfileImage//3 H
(//H I
new//I L
ProfileImageUpload//M _
{00 %
SelectedProfileImageBytes11 )
=11* +%
selectedProfileImageBytes11, E
}22 
)22 
)22 
;22 
}33 	
public55 
Task55 -
!SubscribeProfileImageChangesAsync55 5
(555 6
int556 9
[559 :
]55: ;
profileOwnerUserIds55< O
)55O P
{66 	
return77 
ExecuteAsync77 
(77  
channel77  '
=>77( *)
IsImageSubscriptionRegistered77+ H
(77H I
channel77I P
,77P Q
profileOwnerUserIds77R e
)77e f
)77f g
;77g h
}88 	
private:: 
static:: 
bool:: )
IsImageSubscriptionRegistered:: 9
(::9 : 
IProfileImageService::: N
channel::O V
,::V W
int::X [
[::[ \
]::\ ]
profileOwnerUserIds::^ q
)::q r
{;; 	
channel<< 
.<< (
SubscribeProfileImageChanges<< 0
(<<0 1
profileOwnerUserIds<<1 D
)<<D E
;<<E F
return== 
true== 
;== 
}>> 	
public@@ 
void@@ '
OnPlayerProfileImageChanged@@ /
(@@/ 0
int@@0 3
profileOwnerUserId@@4 F
)@@F G
{AA 	
ProfileImageChangedBB 
?BB  
.BB  !
InvokeBB! '
(BB' (
profileOwnerUserIdBB( :
)BB: ;
;BB; <
}CC 	
privateEE 
TaskEE 
<EE 
TEE 
>EE 
ExecuteAsyncEE $
<EE$ %
TEE% &
>EE& '
(EE' (
FuncEE( ,
<EE, - 
IProfileImageServiceEE- A
,EEA B
TEEC D
>EED E
	operationEEF O
)EEO P
{FF 	
returnGG 
TaskGG 
.GG 
RunGG 
(GG 
(GG 
)GG 
=>GG !
ExecuteOperationGG" 2
(GG2 3
	operationGG3 <
)GG< =
)GG= >
;GG> ?
}HH 	
privateJJ 
TJJ 
ExecuteOperationJJ "
<JJ" #
TJJ# $
>JJ$ %
(JJ% &
FuncJJ& *
<JJ* + 
IProfileImageServiceJJ+ ?
,JJ? @
TJJA B
>JJB C
	operationJJD M
)JJM N
{KK 	
TLL 
resultLL 
;LL 
tryMM 
{NN 
EnsureChannelOO 
(OO 
)OO 
;OO  
resultPP 
=PP 
	operationPP "
(PP" # 
_profileImageChannelPP# 7
)PP7 8
;PP8 9
}QQ 
catchRR 
(RR 
FaultExceptionRR !
<RR! "
ProfileImageFaultRR" 3
>RR3 4
exRR5 7
)RR7 8
{SS 
throwTT 
newTT *
ProfileImageOperationExceptionTT 8
(TT8 9
exTT9 ;
.TT; <
DetailTT< B
.TTB C
FailureCodeTTC N
,TTN O
exTTP R
)TTR S
;TTS T
}UU 
catchVV 
(VV "
CommunicationExceptionVV )
exVV* ,
)VV, -
{WW 
_loggerXX 
.XX 
WarningXX 
(XX  '
ConnectionFailedLogTemplateXX  ;
,XX; <
exXX= ?
.XX? @
GetTypeXX@ G
(XXG H
)XXH I
.XXI J
NameXXJ N
)XXN O
;XXO P
DisposeYY 
(YY 
)YY 
;YY 
throwZZ 
newZZ *
ProfileImageOperationExceptionZZ 8
(ZZ8 9$
ProfileImageFailureCodesZZ9 Q
.ZZQ R&
ImageConnectionUnavailableZZR l
,ZZl m
exZZn p
)ZZp q
;ZZq r
}[[ 
catch\\ 
(\\ 
TimeoutException\\ #
ex\\$ &
)\\& '
{]] 
_logger^^ 
.^^ 
Warning^^ 
(^^  )
ConnectionTimedOutLogTemplate^^  =
,^^= >
ex^^? A
.^^A B
GetType^^B I
(^^I J
)^^J K
.^^K L
Name^^L P
)^^P Q
;^^Q R
Dispose__ 
(__ 
)__ 
;__ 
throw`` 
new`` *
ProfileImageOperationException`` 8
(``8 9$
ProfileImageFailureCodes``9 Q
.``Q R&
ImageConnectionUnavailable``R l
,``l m
ex``n p
)``p q
;``q r
}aa 
returnbb 
resultbb 
;bb 
}cc 	
privateee 
voidee 
EnsureChannelee "
(ee" #
)ee# $
{ff 	
ifgg 
(gg  
_profileImageChannelgg $
==gg% '
nullgg( ,
||gg- /
(gg0 1
(gg1 2 
ICommunicationObjectgg2 F
)ggF G 
_profileImageChannelggG [
)gg[ \
.gg\ ]
Stategg] b
!=ggc e
CommunicationStatehh "
.hh" #
Openedhh# )
)hh) *
{ii 
Disposejj 
(jj 
)jj 
;jj 
varkk 
bindingkk 
=kk 
newkk !
NetTcpBindingkk" /
(kk/ 0
SecurityModekk0 <
.kk< =
	Transportkk= F
)kkF G
{ll "
MaxReceivedMessageSizemm *
=mm+ ,
ProfileImageLimitsmm- ?
.mm? @(
MaximumTransportMessageBytesmm@ \
,mm\ ]
MaxBufferSizenn !
=nn" #
ProfileImageLimitsnn$ 6
.nn6 7(
MaximumTransportMessageBytesnn7 S
,nnS T
CloseTimeoutoo  
=oo! "
TimeSpanoo# +
.oo+ ,
FromSecondsoo, 7
(oo7 8
$numoo8 9
)oo9 :
,oo: ;
OpenTimeoutpp 
=pp  !
TimeSpanpp" *
.pp* +
FromSecondspp+ 6
(pp6 7
$numpp7 8
)pp8 9
,pp9 :
SendTimeoutqq 
=qq  !
TimeSpanqq" *
.qq* +
FromSecondsqq+ 6
(qq6 7
$numqq7 9
)qq9 :
}rr 
;rr 
bindingss 
.ss 
ReaderQuotasss $
.ss$ %
MaxArrayLengthss% 3
=ss4 5
ProfileImageLimitsss6 H
.ssH I
MaximumUploadBytesssI [
;ss[ \
bindingtt 
.tt 
Securitytt  
.tt  !
	Transporttt! *
.tt* +
ProtectionLeveltt+ :
=tt; <
ProtectionLeveltt= L
.ttL M
EncryptAndSignttM [
;tt[ \
_channelFactoryuu 
=uu  !
newuu" % 
DuplexChannelFactoryuu& :
<uu: ; 
IProfileImageServiceuu; O
>uuO P
(uuP Q
newuuQ T
InstanceContextuuU d
(uud e
thisuue i
)uui j
,uuj k
bindingvv 
,vv 
newvv  
EndpointAddressvv! 0
(vv0 1
_endpointAddressvv1 A
)vvA B
)vvB C
;vvC D
_channelFactoryww 
.ww  
Endpointww  (
.ww( )
EndpointBehaviorsww) :
.ww: ;
Addww; >
(ww> ?
newww? B*
AccountSessionEndpointBehaviorwwC a
(wwa b
)wwb c
)wwc d
;wwd e 
_profileImageChannelxx $
=xx% &
_channelFactoryxx' 6
.xx6 7
CreateChannelxx7 D
(xxD E
)xxE F
;xxF G
(yy 
(yy  
ICommunicationObjectyy &
)yy& ' 
_profileImageChannelyy' ;
)yy; <
.yy< =
Openyy= A
(yyA B
)yyB C
;yyC D
}zz 
}{{ 	
public}} 
void}} 
Dispose}} 
(}} 
)}} 
{~~ 	
GameChannelCloser 
. 
CloseChannel *
(* + 
_profileImageChannel+ ?
as@ B 
ICommunicationObjectC W
,W X
_loggerY `
)` a
;a b
GameChannelCloser
ÄÄ 
.
ÄÄ 
CloseChannel
ÄÄ *
(
ÄÄ* +
_channelFactory
ÄÄ+ :
,
ÄÄ: ;
_logger
ÄÄ< C
)
ÄÄC D
;
ÄÄD E"
_profileImageChannel
ÅÅ  
=
ÅÅ! "
null
ÅÅ# '
;
ÅÅ' (
_channelFactory
ÇÇ 
=
ÇÇ 
null
ÇÇ "
;
ÇÇ" #
}
ÉÉ 	
}
ÑÑ 
}ÖÖ ı
uC:\Users\oscar\source\repos\TrickTakingMissions\Client\Model\Services\ProfileImages\ProfileImageOperationException.cs
	namespace 	
Model
 
. 
Services 
{ 
public		 

sealed		 
class		 *
ProfileImageOperationException		 6
:		7 8
	Exception		9 B
{

 
public *
ProfileImageOperationException -
(- .
). /
:0 1
this2 6
(6 7$
ProfileImageFailureCodes7 O
.O P
OperationFailedP _
)_ `
{ 	
} 	
public *
ProfileImageOperationException -
(- .
string. 4
failureCode5 @
)@ A
:B C
thisD H
(H I
failureCodeI T
,T U
nullV Z
)Z [
{ 	
} 	
public *
ProfileImageOperationException -
(- .
string. 4
failureCode5 @
,@ A
	ExceptionB K
innerExceptionL Z
)Z [
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
} ô
jC:\Users\oscar\source\repos\TrickTakingMissions\Client\Model\Services\ProfileImages\IProfileImageClient.cs
	namespace 	
Model
 
. 
Services 
{ 
public

 

	interface

 
IProfileImageClient

 (
:

) *
IDisposable

+ 6
{ 
event 
Action 
< 
int 
> 
ProfileImageChanged -
;- .
Task 
< '
PlayerProfileImageReference (
[( )
]) *
>* +'
GetPlayerProfileImagesAsync, G
(G H
intH K
[K L
]L M
profileOwnerUserIdsN a
)a b
;b c
Task 
< 
ProfileImageContent  
>  ! 
GetProfileImageAsync" 6
(6 7
Guid7 ;
profileImageId< J
)J K
;K L
Task 
< '
PlayerProfileImageReference (
>( )&
ChangeOwnProfileImageAsync* D
(D E
byteE I
[I J
]J K%
selectedProfileImageBytesL e
)e f
;f g
Task -
!SubscribeProfileImageChangesAsync .
(. /
int/ 2
[2 3
]3 4
profileOwnerUserIds5 H
)H I
;I J
} 
} ˛
mC:\Users\oscar\source\repos\TrickTakingMissions\Client\Model\Services\ProfileImages\ProfileImageCacheEntry.cs
	namespace 	
Model
 
. 
Services 
{ 
internal 
sealed 
class "
ProfileImageCacheEntry 0
{ 
internal 
int 
ReferenceCount #
{$ %
get& )
;) *
set+ .
;. /
}0 1
internal 
Guid 
ProfileImageId $
{% &
get' *
;* +
set, /
;/ 0
}1 2
internal		 
byte		 
[		 
]		 

ImageBytes		 "
{		# $
get		% (
;		( )
set		* -
;		- .
}		/ 0
internal

 
DateTime

 
LastValidatedAtUtc

 ,
{

- .
get

/ 2
;

2 3
set

4 7
;

7 8
}

9 :
} 
} ›§
hC:\Users\oscar\source\repos\TrickTakingMissions\Client\Model\Services\ProfileImages\ProfileImageCache.cs
	namespace

 	
Model


 
.

 
Services

 
{ 
public 

sealed 
class 
ProfileImageCache )
:* +
IProfileImageCache, >
{ 
private 
const 
int  
MaximumCachedPlayers .
=/ 0
ProfileImageLimits1 C
.C D#
MaximumRequestedPlayersD [
;[ \
private 
readonly 
IProfileImageClient ,
_profileImageClient- @
;@ A
private 
readonly 
object 

_entryLock  *
=+ ,
new- 0
object1 7
(7 8
)8 9
;9 :
private 
readonly 
SemaphoreSlim &
_refreshGate' 3
=4 5
new6 9
SemaphoreSlim: G
(G H
$numH I
,I J
$numK L
)L M
;M N
private 
readonly 

Dictionary #
<# $
int$ '
,' ("
ProfileImageCacheEntry) ?
>? @
_entriesA I
=J K
new 

Dictionary 
< 
int 
, "
ProfileImageCacheEntry  6
>6 7
(7 8
)8 9
;9 :
private 
readonly 
Timer 
_refreshTimer ,
;, -
private 
int 
_isRefreshScheduled '
;' (
private 
bool 
_isDisposed  
;  !
public 
ProfileImageCache  
(  !
IProfileImageClient! 4
profileImageClient5 G
)G H
{ 	
_profileImageClient 
=  !
profileImageClient" 4
;4 5
_profileImageClient 
.  
ProfileImageChanged  3
+=4 6 
OnServerImageChanged7 K
;K L
_refreshTimer 
= 
new 
Timer  %
(% &
_& '
=>( *
ScheduleRefresh+ :
(: ;
); <
,< =
null> B
,B C
TimeSpanD L
.L M
FromSecondsM X
(X Y
$numY [
)[ \
,\ ]
TimeSpan^ f
.f g
FromSecondsg r
(r s
$nums u
)u v
)v w
;w x
}   	
public"" 
event"" 
Action"" 
<"" 
int"" 
>""  
ProfileImageChanged""! 4
;""4 5
public$$ 
void$$ 
RegisterPlayer$$ "
($$" #
int$$# &
profileOwnerUserId$$' 9
)$$9 :
{%% 	
if&& 
(&& 
profileOwnerUserId&& "
>&&# $
$num&&% &
)&&& '
{'' 
lock(( 
((( 

_entryLock((  
)((  !
{)) 
EnsureCacheEntry** $
(**$ %
profileOwnerUserId**% 7
)**7 8
.**8 9
ReferenceCount**9 G
++**G I
;**I J
}++ 
},, 
}-- 	
private// "
ProfileImageCacheEntry// &
EnsureCacheEntry//' 7
(//7 8
int//8 ;
ownerId//< C
)//C D
{00 	
if11 
(11 
!11 
_entries11 
.11 
TryGetValue11 %
(11% &
ownerId11& -
,11- .
out11/ 2"
ProfileImageCacheEntry113 I
entry11J O
)11O P
)11P Q
{22 
if33 
(33 
_entries33 
.33 
Count33 "
>=33# % 
MaximumCachedPlayers33& :
)33: ;
{44 
int55 
unusedOwnerId55 %
=55& '
_entries55( 0
.550 1
FirstOrDefault551 ?
(55? @
pair55@ D
=>55E G
pair55H L
.55L M
Value55M R
.55R S
ReferenceCount55S a
==55b d
$num55e f
)55f g
.55g h
Key55h k
;55k l
if66 
(66 
unusedOwnerId66 %
==66& (
$num66) *
)66* +
{77 
throw88 
new88 !*
ProfileImageOperationException88" @
(88@ A$
ProfileImageFailureCodes88A Y
.88Y Z
ImageServiceBusy88Z j
)88j k
;88k l
}99 
_entries:: 
.:: 
Remove:: #
(::# $
unusedOwnerId::$ 1
)::1 2
;::2 3
};; 
entry<< 
=<< 
new<< "
ProfileImageCacheEntry<< 2
(<<2 3
)<<3 4
;<<4 5
_entries== 
.== 
Add== 
(== 
ownerId== $
,==$ %
entry==& +
)==+ ,
;==, -
}>> 
return?? 
entry?? 
;?? 
}@@ 	
publicBB 
voidBB 
UnregisterPlayerBB $
(BB$ %
intBB% (
profileOwnerUserIdBB) ;
)BB; <
{CC 	
lockDD 
(DD 

_entryLockDD 
)DD 
{EE 
ifFF 
(FF 
_entriesFF 
.FF 
TryGetValueFF (
(FF( )
profileOwnerUserIdFF) ;
,FF; <
outFF= @"
ProfileImageCacheEntryFFA W
entryFFX ]
)FF] ^
)FF^ _
{GG 
entryHH 
.HH 
ReferenceCountHH (
=HH) *
MathHH+ /
.HH/ 0
MaxHH0 3
(HH3 4
$numHH4 5
,HH5 6
entryHH7 <
.HH< =
ReferenceCountHH= K
-HHL M
$numHHN O
)HHO P
;HHP Q
}II 
}JJ 
}KK 	
publicMM 
asyncMM 
TaskMM 
<MM 
byteMM 
[MM 
]MM  
>MM  !!
LoadProfileImageAsyncMM" 7
(MM7 8
intMM8 ;
profileOwnerUserIdMM< N
)MMN O
{NN 	
byteOO 
[OO 
]OO 

imageBytesOO 
=OO 
nullOO  $
;OO$ %
ifPP 
(PP 
profileOwnerUserIdPP "
>PP# $
$numPP% &
&&PP' )
!PP* +
_isDisposedPP+ 6
)PP6 7
{QQ 
awaitRR 
_refreshGateRR "
.RR" #
	WaitAsyncRR# ,
(RR, -
)RR- .
.RR. /
ConfigureAwaitRR/ =
(RR= >
falseRR> C
)RRC D
;RRD E
trySS 
{TT 
boolUU 
needsRefreshUU %
;UU% &
lockVV 
(VV 

_entryLockVV $
)VV$ %
{WW 
needsRefreshXX $
=XX% &
EnsureCacheEntryXX' 7
(XX7 8
profileOwnerUserIdXX8 J
)XXJ K
.XXK L
LastValidatedAtUtcXXL ^
<XX_ `
DateTimeYY $
.YY$ %
UtcNowYY% +
.YY+ ,

AddMinutesYY, 6
(YY6 7
-YY7 8
$numYY8 9
)YY9 :
;YY: ;
}ZZ 
if[[ 
([[ 
needsRefresh[[ $
)[[$ %
{\\ 
await]] $
RefreshActiveImagesAsync]] 6
(]]6 7
profileOwnerUserId]]7 I
)]]I J
.]]J K
ConfigureAwait]]K Y
(]]Y Z
false]]Z _
)]]_ `
;]]` a
}^^ 
lock__ 
(__ 

_entryLock__ $
)__$ %
{`` 

imageBytesaa "
=aa# $
EnsureCacheEntryaa% 5
(aa5 6
profileOwnerUserIdaa6 H
)aaH I
.aaI J

ImageBytesaaJ T
;aaT U
}bb 
}cc 
finallydd 
{ee 
_refreshGateff  
.ff  !
Releaseff! (
(ff( )
)ff) *
;ff* +
}gg 
}hh 
returnii 

imageBytesii 
;ii 
}jj 	
publicll 
asyncll 
Taskll &
ChangeOwnProfileImageAsyncll 4
(ll4 5
bytell5 9
[ll9 :
]ll: ;%
selectedProfileImageBytesll< U
)llU V
{mm 	
awaitnn 
_refreshGatenn 
.nn 
	WaitAsyncnn (
(nn( )
)nn) *
.nn* +
ConfigureAwaitnn+ 9
(nn9 :
falsenn: ?
)nn? @
;nn@ A
tryoo 
{pp '
PlayerProfileImageReferenceqq +
changedImageqq, 8
=qq9 :
awaitrr 
_profileImageClientrr -
.rr- .&
ChangeOwnProfileImageAsyncrr. H
(rrH I%
selectedProfileImageBytesrrI b
)rrb c
.ss 
ConfigureAwaitss '
(ss' (
falsess( -
)ss- .
;ss. /
locktt 
(tt 

_entryLocktt  
)tt  !
{uu 
EnsureCacheEntryvv $
(vv$ %
changedImagevv% 1
.vv1 2
ProfileOwnerUserIdvv2 D
)vvD E
.vvE F
LastValidatedAtUtcvvF X
=vvY Z
DateTimevv[ c
.vvc d
MinValuevvd l
;vvl m
}ww 
tryxx 
{yy 
awaitzz $
RefreshActiveImagesAsynczz 2
(zz2 3
changedImagezz3 ?
.zz? @
ProfileOwnerUserIdzz@ R
)zzR S
.zzS T
ConfigureAwaitzzT b
(zzb c
falsezzc h
)zzh i
;zzi j
}{{ 
catch|| 
(|| *
ProfileImageOperationException|| 5
ex||6 8
)||8 9
{}} 
Trace~~ 
.~~ 
TraceWarning~~ &
(~~& '
$str~~' ]
,~~] ^
ex~~_ a
.~~a b
FailureCode~~b m
)~~m n
;~~n o
} 
}
ÄÄ 
finally
ÅÅ 
{
ÇÇ 
_refreshGate
ÉÉ 
.
ÉÉ 
Release
ÉÉ $
(
ÉÉ$ %
)
ÉÉ% &
;
ÉÉ& '
}
ÑÑ 
}
ÖÖ 	
private
áá 
async
áá 
Task
áá &
RefreshActiveImagesAsync
áá 3
(
áá3 4
int
áá4 7
requestedOwnerId
áá8 H
)
ááH I
{
àà 	
int
ââ 
[
ââ 
]
ââ 
activeOwnerIds
ââ  
;
ââ  !
lock
ää 
(
ää 

_entryLock
ää 
)
ää 
{
ãã 
activeOwnerIds
åå 
=
åå  
_entries
åå! )
.
åå) *
Where
åå* /
(
åå/ 0
pair
åå0 4
=>
åå5 7
pair
åå8 <
.
åå< =
Value
åå= B
.
ååB C
ReferenceCount
ååC Q
>
ååR S
$num
ååT U
||
ååV X
pair
ååY ]
.
åå] ^
Key
åå^ a
==
ååb d
requestedOwnerId
ååe u
)
ååu v
.
çç 
Select
çç 
(
çç 
pair
çç  
=>
çç! #
pair
çç$ (
.
çç( )
Key
çç) ,
)
çç, -
.
çç- .
ToArray
çç. 5
(
çç5 6
)
çç6 7
;
çç7 8
}
éé 
if
èè 
(
èè 
!
èè 
_isDisposed
èè 
&&
èè 
activeOwnerIds
èè  .
.
èè. /
Length
èè/ 5
>
èè6 7
$num
èè8 9
)
èè9 :
{
êê 
await
ëë !
_profileImageClient
ëë )
.
ëë) */
!SubscribeProfileImageChangesAsync
ëë* K
(
ëëK L
activeOwnerIds
ëëL Z
)
ëëZ [
.
ëë[ \
ConfigureAwait
ëë\ j
(
ëëj k
false
ëëk p
)
ëëp q
;
ëëq r)
PlayerProfileImageReference
íí +
[
íí+ ,
]
íí, -

references
íí. 8
=
íí9 :
await
ìì !
_profileImageClient
ìì -
.
ìì- .)
GetPlayerProfileImagesAsync
ìì. I
(
ììI J
activeOwnerIds
ììJ X
)
ììX Y
.
ììY Z
ConfigureAwait
ììZ h
(
ììh i
false
ììi n
)
ììn o
;
ììo p
foreach
îî 
(
îî )
PlayerProfileImageReference
îî 4
	reference
îî5 >
in
îî? A

references
îîB L
)
îîL M
{
ïï 
await
ññ &
RefreshImageContentAsync
ññ 2
(
ññ2 3
	reference
ññ3 <
)
ññ< =
.
ññ= >
ConfigureAwait
ññ> L
(
ññL M
false
ññM R
)
ññR S
;
ññS T
}
óó 
}
òò 
}
ôô 	
private
õõ 
async
õõ 
Task
õõ &
RefreshImageContentAsync
õõ 3
(
õõ3 4)
PlayerProfileImageReference
õõ4 O
	reference
õõP Y
)
õõY Z
{
úú 	$
ProfileImageCacheEntry
ùù "
entry
ùù# (
;
ùù( )
lock
ûû 
(
ûû 

_entryLock
ûû 
)
ûû 
{
üü 
entry
†† 
=
†† 
EnsureCacheEntry
†† (
(
††( )
	reference
††) 2
.
††2 3 
ProfileOwnerUserId
††3 E
)
††E F
;
††F G
}
°° 
bool
¢¢ 

hasChanged
¢¢ 
=
¢¢ 
entry
¢¢ #
.
¢¢# $
ProfileImageId
¢¢$ 2
!=
¢¢3 5
	reference
¢¢6 ?
.
¢¢? @
ProfileImageId
¢¢@ N
;
¢¢N O
byte
££ 
[
££ 
]
££ 

imageBytes
££ 
=
££ 
entry
££  %
.
££% &

ImageBytes
££& 0
;
££0 1
if
§§ 
(
§§ 

hasChanged
§§ 
&&
§§ 
	reference
§§ '
.
§§' (
ProfileImageId
§§( 6
!=
§§7 9
Guid
§§: >
.
§§> ?
Empty
§§? D
)
§§D E
{
•• !
ProfileImageContent
¶¶ #
content
¶¶$ +
=
¶¶, -
await
¶¶. 3!
_profileImageClient
¶¶4 G
.
¶¶G H"
GetProfileImageAsync
¶¶H \
(
¶¶\ ]
	reference
¶¶] f
.
¶¶f g
ProfileImageId
¶¶g u
)
¶¶u v
.
ßß 
ConfigureAwait
ßß #
(
ßß# $
false
ßß$ )
)
ßß) *
;
ßß* +
if
®® 
(
®® 
content
®® 
.
®® )
NormalizedProfileImageBytes
®® 7
==
®®8 :
null
®®; ?
||
®®@ B
content
®®C J
.
®®J K)
NormalizedProfileImageBytes
®®K f
.
®®f g
Length
®®g m
>
®®n o 
ProfileImageLimits
©© &
.
©©& '%
MaximumStoredImageBytes
©©' >
)
©©> ?
{
™™ 
throw
´´ 
new
´´ ,
ProfileImageOperationException
´´ <
(
´´< =&
ProfileImageFailureCodes
´´= U
.
´´U V 
InvalidStoredImage
´´V h
)
´´h i
;
´´i j
}
¨¨ 

imageBytes
≠≠ 
=
≠≠ 
content
≠≠ $
.
≠≠$ %)
NormalizedProfileImageBytes
≠≠% @
;
≠≠@ A
}
ÆÆ 
lock
ØØ 
(
ØØ 

_entryLock
ØØ 
)
ØØ 
{
∞∞ 
entry
±± 
.
±± 
ProfileImageId
±± $
=
±±% &
	reference
±±' 0
.
±±0 1
ProfileImageId
±±1 ?
;
±±? @
entry
≤≤ 
.
≤≤ 

ImageBytes
≤≤  
=
≤≤! "
	reference
≤≤# ,
.
≤≤, -
ProfileImageId
≤≤- ;
==
≤≤< >
Guid
≤≤? C
.
≤≤C D
Empty
≤≤D I
?
≤≤J K
null
≤≤L P
:
≤≤Q R

imageBytes
≤≤S ]
;
≤≤] ^
entry
≥≥ 
.
≥≥  
LastValidatedAtUtc
≥≥ (
=
≥≥) *
DateTime
≥≥+ 3
.
≥≥3 4
UtcNow
≥≥4 :
;
≥≥: ;
}
¥¥ 
if
µµ 
(
µµ 

hasChanged
µµ 
)
µµ 
{
∂∂ !
ProfileImageChanged
∑∑ #
?
∑∑# $
.
∑∑$ %
Invoke
∑∑% +
(
∑∑+ ,
	reference
∑∑, 5
.
∑∑5 6 
ProfileOwnerUserId
∑∑6 H
)
∑∑H I
;
∑∑I J
}
∏∏ 
}
ππ 	
private
ªª 
void
ªª "
OnServerImageChanged
ªª )
(
ªª) *
int
ªª* - 
profileOwnerUserId
ªª. @
)
ªª@ A
{
ºº 	
lock
ΩΩ 
(
ΩΩ 

_entryLock
ΩΩ 
)
ΩΩ 
{
ææ 
if
øø 
(
øø 
_entries
øø 
.
øø 
TryGetValue
øø (
(
øø( ) 
profileOwnerUserId
øø) ;
,
øø; <
out
øø= @$
ProfileImageCacheEntry
øøA W
entry
øøX ]
)
øø] ^
)
øø^ _
{
¿¿ 
entry
¡¡ 
.
¡¡  
LastValidatedAtUtc
¡¡ ,
=
¡¡- .
DateTime
¡¡/ 7
.
¡¡7 8
MinValue
¡¡8 @
;
¡¡@ A
}
¬¬ 
}
√√ 
ScheduleRefresh
ƒƒ 
(
ƒƒ 
)
ƒƒ 
;
ƒƒ 
}
≈≈ 	
private
«« 
void
«« 
ScheduleRefresh
«« $
(
««$ %
)
««% &
{
»» 	
if
…… 
(
…… 
!
…… 
_isDisposed
…… 
&&
…… 
Interlocked
……  +
.
……+ ,
CompareExchange
……, ;
(
……; <
ref
……< ?!
_isRefreshScheduled
……@ S
,
……S T
$num
……U V
,
……V W
$num
……X Y
)
……Y Z
==
……[ ]
$num
……^ _
)
……_ `
{
   
_
ÀÀ 
=
ÀÀ &
RefreshInBackgroundAsync
ÀÀ ,
(
ÀÀ, -
)
ÀÀ- .
;
ÀÀ. /
}
ÃÃ 
}
ÕÕ 	
private
œœ 
async
œœ 
Task
œœ &
RefreshInBackgroundAsync
œœ 3
(
œœ3 4
)
œœ4 5
{
–– 	
await
—— 
_refreshGate
—— 
.
—— 
	WaitAsync
—— (
(
——( )
)
——) *
.
——* +
ConfigureAwait
——+ 9
(
——9 :
false
——: ?
)
——? @
;
——@ A
try
““ 
{
”” 
await
‘‘ &
RefreshActiveImagesAsync
‘‘ .
(
‘‘. /
$num
‘‘/ 0
)
‘‘0 1
.
‘‘1 2
ConfigureAwait
‘‘2 @
(
‘‘@ A
false
‘‘A F
)
‘‘F G
;
‘‘G H
}
’’ 
catch
÷÷ 
(
÷÷ ,
ProfileImageOperationException
÷÷ 1
ex
÷÷2 4
)
÷÷4 5
{
◊◊ 
Trace
ÿÿ 
.
ÿÿ 
TraceWarning
ÿÿ "
(
ÿÿ" #
$str
ÿÿ# H
,
ÿÿH I
ex
ÿÿJ L
.
ÿÿL M
FailureCode
ÿÿM X
)
ÿÿX Y
;
ÿÿY Z
}
ŸŸ 
finally
⁄⁄ 
{
€€ 
_refreshGate
‹‹ 
.
‹‹ 
Release
‹‹ $
(
‹‹$ %
)
‹‹% &
;
‹‹& '
Interlocked
›› 
.
›› 
Exchange
›› $
(
››$ %
ref
››% (!
_isRefreshScheduled
››) <
,
››< =
$num
››> ?
)
››? @
;
››@ A
}
ﬁﬁ 
}
ﬂﬂ 	
public
·· 
void
·· 
Dispose
·· 
(
·· 
)
·· 
{
‚‚ 	
_isDisposed
„„ 
=
„„ 
true
„„ 
;
„„ 
_refreshTimer
‰‰ 
.
‰‰ 
Dispose
‰‰ !
(
‰‰! "
)
‰‰" #
;
‰‰# $!
_profileImageClient
ÂÂ 
.
ÂÂ  !
ProfileImageChanged
ÂÂ  3
-=
ÂÂ4 6"
OnServerImageChanged
ÂÂ7 K
;
ÂÂK L
_
ÊÊ 
=
ÊÊ 
CloseClientAsync
ÊÊ  
(
ÊÊ  !
)
ÊÊ! "
;
ÊÊ" #
}
ÁÁ 	
private
ÈÈ 
async
ÈÈ 
Task
ÈÈ 
CloseClientAsync
ÈÈ +
(
ÈÈ+ ,
)
ÈÈ, -
{
ÍÍ 	
await
ÎÎ 
_refreshGate
ÎÎ 
.
ÎÎ 
	WaitAsync
ÎÎ (
(
ÎÎ( )
)
ÎÎ) *
.
ÎÎ* +
ConfigureAwait
ÎÎ+ 9
(
ÎÎ9 :
false
ÎÎ: ?
)
ÎÎ? @
;
ÎÎ@ A
try
ÏÏ 
{
ÌÌ !
_profileImageClient
ÓÓ #
.
ÓÓ# $
Dispose
ÓÓ$ +
(
ÓÓ+ ,
)
ÓÓ, -
;
ÓÓ- .
}
ÔÔ 
finally
 
{
ÒÒ 
_refreshGate
ÚÚ 
.
ÚÚ 
Release
ÚÚ $
(
ÚÚ$ %
)
ÚÚ% &
;
ÚÚ& '
}
ÛÛ 
}
ÙÙ 	
}
ıı 
}ˆˆ ¢
ÉC:\Users\oscar\source\repos\TrickTakingMissions\Client\Model\..\..\Server\Services\DataContracts\ProfileImages\ProfileImageFault.cs
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
} ˙
ÖC:\Users\oscar\source\repos\TrickTakingMissions\Client\Model\..\..\Server\Services\DataContracts\ProfileImages\ProfileImageContent.cs
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
} Ñ
ÇC:\Users\oscar\source\repos\TrickTakingMissions\Client\Model\..\..\Server\Services\Contracts\ProfileImages\IProfileImageService.cs
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
} à
ÉC:\Users\oscar\source\repos\TrickTakingMissions\Client\Model\..\..\Server\Services\Contracts\ProfileImages\IProfileImageCallback.cs
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
} ‚
çC:\Users\oscar\source\repos\TrickTakingMissions\Client\Model\..\..\Server\Services\DataContracts\ProfileImages\PlayerProfileImageReference.cs
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
} Œ
ÑC:\Users\oscar\source\repos\TrickTakingMissions\Client\Model\..\..\Server\Services\DataContracts\ProfileImages\ProfileImageUpload.cs
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
} Õ
WC:\Users\oscar\source\repos\TrickTakingMissions\Client\Model\Session\UserSessionData.cs
	namespace 	
Model
 
. 
Session 
{ 
public 

sealed 
class 
UserSessionData '
{ 
public 
int 
IdUser 
{ 
get 
;  
set! $
;$ %
}& '
public 
string 
Username 
{  
get! $
;$ %
set& )
;) *
}+ ,
public 
string 
Email 
{ 
get !
;! "
set# &
;& '
}( )
public 
string 
GuestSessionToken '
{( )
get* -
;- .
set/ 2
;2 3
}4 5
public 
string 
AccountSessionToken )
{* +
get, /
;/ 0
set1 4
;4 5
}6 7
} 
} Ò
SC:\Users\oscar\source\repos\TrickTakingMissions\Client\Model\Session\UserSession.cs
	namespace 	
Model
 
. 
Session 
{ 
public 

sealed 
class 
UserSession #
{		 
private

 
const

 
int

 
GuestIdMinimum

 (
=

) *
$num

+ /
;

/ 0
private 
const 
int 
GuestIdMaximum (
=) *
$num+ 0
;0 1
private 
static 
readonly 
object  &
_lockObject' 2
=3 4
new5 8
object9 ?
(? @
)@ A
;A B
private 
static 
readonly 
Random  &
s_random' /
=0 1
new2 5
Random6 <
(< =
)= >
;> ?
private 
static 
UserSession "
	_instance# ,
;, -
private 
UserSessionData 
_currentUser  ,
;, -
private 
UserSession 
( 
) 
{ 	
} 	
public 
static 
UserSession !
Current" )
{ 	
get 
{ 
if 
( 
	_instance 
==  
null! %
)% &
{ 
lock   
(   
_lockObject   %
)  % &
{!! 
if"" 
("" 
	_instance"" %
==""& (
null"") -
)""- .
{## 
	_instance$$ %
=$$& '
new$$( +
UserSession$$, 7
($$7 8
)$$8 9
;$$9 :
}%% 
}&& 
}'' 
return)) 
	_instance))  
;))  !
}** 
}++ 	
public00 
UserSessionData00 
CurrentUser00 *
=>00+ -
_currentUser00. :
;00: ;
public55 
bool55 
IsAuthenticated55 #
=>55$ &
_currentUser55' 3
!=554 6
null557 ;
;55; <
public;; 
void;; 
SetUser;; 
(;; 
UserSessionData;; +
user;;, 0
);;0 1
{<< 	
_currentUser== 
=== 
user== 
;==  
}>> 	
publicCC 
voidCC 
ClearSessionCC  
(CC  !
)CC! "
{DD 	
_currentUserEE 
=EE 
nullEE 
;EE  
}FF 	
publicLL 
intLL 
EnsureActiveUserIdLL %
(LL% &
)LL& '
{MM 	
lockNN 
(NN 
_lockObjectNN 
)NN 
{OO 
ifPP 
(PP 
_currentUserPP  
==PP! #
nullPP$ (
)PP( )
{QQ 
intRR 
guestSuffixRR #
=RR$ %
s_randomRR& .
.RR. /
NextRR/ 3
(RR3 4
GuestIdMinimumRR4 B
,RRB C
GuestIdMaximumRRD R
)RRR S
;RRS T
_currentUserSS  
=SS! "
newSS# &
UserSessionDataSS' 6
{TT 
IdUserUU 
=UU  
-UU! "
guestSuffixUU" -
,UU- .
UsernameVV  
=VV! "
stringVV# )
.VV) *
EmptyVV* /
,VV/ 0
EmailWW 
=WW 
stringWW  &
.WW& '
EmptyWW' ,
}XX 
;XX 
}YY 
return[[ 
_currentUser[[ #
.[[# $
IdUser[[$ *
;[[* +
}\\ 
}]] 	
}^^ 
}__ Œ6
TC:\Users\oscar\source\repos\TrickTakingMissions\Client\Model\Session\LobbySession.cs
	namespace 	
Model
 
. 
Session 
{ 
public 

sealed 
class 
LobbySession $
:% &
ILobbySession' 4
{ 
private 
const 
string '
LoggingNotConfiguredMessage 8
=9 :
$str j
;j k
private 
const 
string *
StaleLobbyStateIgnoredTemplate ;
=< =
$str j
;j k
private 
const 
string '
LobbySessionClearedTemplate 8
=9 :
$str; Y
;Y Z
private 
static 
readonly 
object  &

s_syncRoot' 1
=2 3
new4 7
object8 >
(> ?
)? @
;@ A
private 
static 
LobbySession #

s_instance$ .
;. /
private 
ILoggerFactory 
_loggerFactory -
;- .
private 
ILoggerService 
_sessionLogger -
;- .
private 
ILobbyClient 
_client $
;$ %
private 
Lobby 
_currentLobby #
;# $
private 
LobbySession 
( 
) 
{ 	
} 	
public   
static   
LobbySession   "
Current  # *
{!! 	
get"" 
{## 
if$$ 
($$ 

s_instance$$ 
==$$ !
null$$" &
)$$& '
{%% 
lock&& 
(&& 

s_syncRoot&& $
)&&$ %
{'' 
if(( 
((( 

s_instance(( &
==((' )
null((* .
)((. /
{)) 

s_instance** &
=**' (
new**) ,
LobbySession**- 9
(**9 :
)**: ;
;**; <
}++ 
},, 
}-- 
return// 

s_instance// !
;//! "
}00 
}11 	
public33 
Lobby33 
CurrentLobby33 !
=>33" $
_currentLobby33% 2
;332 3
public55 
bool55 
HasActiveLobby55 "
=>55# %
_currentLobby55& 3
!=554 6
null557 ;
;55; <
public77 
ILobbyClient77 
Client77 "
{88 	
get99 
{:: 
lock;; 
(;; 

s_syncRoot;;  
);;  !
{<< 
if== 
(== 
_client== 
====  "
null==# '
)==' (
{>> #
EnsureLoggingConfigured?? /
(??/ 0
)??0 1
;??1 2
_client@@ 
=@@  !
new@@" %
LobbyClient@@& 1
(@@1 2
_loggerFactory@@2 @
.@@@ A
CreateLogger@@A M
<@@M N
LobbyClient@@N Y
>@@Y Z
(@@Z [
)@@[ \
)@@\ ]
;@@] ^
}AA 
returnCC 
_clientCC "
;CC" #
}DD 
}EE 
}FF 	
publicHH 
voidHH 
ConfigureLoggingHH $
(HH$ %
ILoggerFactoryHH% 3
loggerFactoryHH4 A
)HHA B
{II 	
ifJJ 
(JJ 
loggerFactoryJJ 
==JJ  
nullJJ! %
)JJ% &
{KK 
throwLL 
newLL !
ArgumentNullExceptionLL /
(LL/ 0
nameofLL0 6
(LL6 7
loggerFactoryLL7 D
)LLD E
)LLE F
;LLF G
}MM 
lockOO 
(OO 

s_syncRootOO 
)OO 
{PP 
_loggerFactoryQQ 
=QQ  
loggerFactoryQQ! .
;QQ. /
_sessionLoggerRR 
=RR  
loggerFactoryRR! .
.RR. /
CreateLoggerRR/ ;
<RR; <
LobbySessionRR< H
>RRH I
(RRI J
)RRJ K
;RRK L
}SS 
}TT 	
publicVV 
voidVV 
SetLobbyVV 
(VV 
LobbyVV "
lobbyVV# (
)VV( )
{WW 	
lockXX 
(XX 

s_syncRootXX 
)XX 
{YY 
boolZZ  
isCurrentOrNewerRoomZZ )
=ZZ* +
_currentLobbyZZ, 9
==ZZ: <
nullZZ= A
||ZZB D
lobbyZZE J
==ZZK M
nullZZN R
||ZZS U
_currentLobby[[ !
.[[! "
	LobbyCode[[" +
!=[[, .
lobby[[/ 4
.[[4 5
	LobbyCode[[5 >
||[[? A
lobby[[B G
.[[G H
StateVersion[[H T
>=[[U W
_currentLobby[[X e
.[[e f
StateVersion[[f r
;[[r s
if\\ 
(\\  
isCurrentOrNewerRoom\\ (
)\\( )
{]] 
_currentLobby^^ !
=^^" #
lobby^^$ )
;^^) *
}__ 
else`` 
if`` 
(`` 
_currentLobby`` &
!=``' )
null``* .
&&``/ 1
lobby``2 7
!=``8 :
null``; ?
)``? @
{aa 
_sessionLoggerbb "
?bb" #
.bb# $
Debugbb$ )
(bb) **
StaleLobbyStateIgnoredTemplatebb* H
,bbH I
lobbybbJ O
.bbO P
StateVersionbbP \
,bb\ ]
_currentLobbycc %
.cc% &
StateVersioncc& 2
)cc2 3
;cc3 4
}dd 
}ee 
}ff 	
publichh 
voidhh 

ClearLobbyhh 
(hh 
)hh  
{ii 	
lockjj 
(jj 

s_syncRootjj 
)jj 
{kk 
_currentLobbyll 
=ll 
nullll  $
;ll$ %
ifmm 
(mm 
_clientmm 
!=mm 
nullmm #
)mm# $
{nn 
_clientoo 
.oo 
Disposeoo #
(oo# $
)oo$ %
;oo% &
_clientpp 
=pp 
nullpp "
;pp" #
}qq 
_sessionLoggerss 
?ss 
.ss  
Informationss  +
(ss+ ,'
LobbySessionClearedTemplatess, G
)ssG H
;ssH I
}tt 
}uu 	
privateww 
voidww #
EnsureLoggingConfiguredww ,
(ww, -
)ww- .
{xx 	
ifyy 
(yy 
_loggerFactoryyy 
==yy !
nullyy" &
)yy& '
{zz 
throw{{ 
new{{ %
InvalidOperationException{{ 3
({{3 4'
LoggingNotConfiguredMessage{{4 O
){{O P
;{{P Q
}|| 
}}} 	
}~~ 
} ∂
UC:\Users\oscar\source\repos\TrickTakingMissions\Client\Model\Session\ILobbySession.cs
	namespace 	
Model
 
. 
Session 
{ 
public

 

	interface

 
ILobbySession

 "
{ 
Lobby 
CurrentLobby 
{ 
get  
;  !
}" #
bool 
HasActiveLobby 
{ 
get !
;! "
}# $
ILobbyClient 
Client 
{ 
get !
;! "
}# $
void 
SetLobby 
( 
Lobby 
lobby !
)! "
;" #
void 

ClearLobby 
( 
) 
; 
} 
} Ω3
YC:\Users\oscar\source\repos\TrickTakingMissions\Client\Model\Session\FriendshipSession.cs
	namespace 	
Model
 
. 
Session 
{ 
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
FriendshipSession

 )
:

* +
IFriendshipSession

, >
{ 
private 
const 
string '
LoggingNotConfiguredMessage 8
=9 :
$str o
;o p
private 
const 
string (
SocialSessionClearedTemplate 9
=: ;
$str< _
;_ `
private 
static 
readonly 
object  &

s_syncRoot' 1
=2 3
new4 7
object8 >
(> ?
)? @
;@ A
private 
static 
FriendshipSession (

s_instance) 3
;3 4
private 
ILoggerFactory 
_loggerFactory -
;- .
private 
ILoggerService 
_sessionLogger -
;- .
private 
IFriendshipClient !
_client" )
;) *
private !
IFriendsRequestClient %
_requestClient& 4
;4 5
private 
FriendshipSession !
(! "
)" #
{ 	
} 	
public 
static 
FriendshipSession '
Current( /
{ 	
get 
{ 
if   
(   

s_instance   
==   !
null  " &
)  & '
{!! 
lock"" 
("" 

s_syncRoot"" $
)""$ %
{## 
if$$ 
($$ 

s_instance$$ &
==$$' )
null$$* .
)$$. /
{%% 

s_instance&& &
=&&' (
new&&) ,
FriendshipSession&&- >
(&&> ?
)&&? @
;&&@ A
}'' 
}(( 
})) 
return++ 

s_instance++ !
;++! "
},, 
}-- 	
public// 
IFriendshipClient//  
Client//! '
{00 	
get11 
{22 
lock33 
(33 

s_syncRoot33  
)33  !
{44 
if55 
(55 
_client55 
==55  "
null55# '
)55' (
{66 #
EnsureLoggingConfigured77 /
(77/ 0
)770 1
;771 2
_client88 
=88  !
new88" %
FriendshipClient88& 6
(886 7
_loggerFactory887 E
.88E F
CreateLogger88F R
<88R S
FriendshipClient88S c
>88c d
(88d e
)88e f
)88f g
;88g h
}99 
return;; 
_client;; "
;;;" #
}<< 
}== 
}>> 	
public@@ !
IFriendsRequestClient@@ $
RequestClient@@% 2
{AA 	
getBB 
{CC 
lockDD 
(DD 

s_syncRootDD  
)DD  !
{EE 
ifFF 
(FF 
_requestClientFF &
==FF' )
nullFF* .
)FF. /
{GG #
EnsureLoggingConfiguredHH /
(HH/ 0
)HH0 1
;HH1 2
_requestClientII &
=II' (
newII) , 
FriendsRequestClientII- A
(IIA B
_loggerFactoryJJ *
.JJ* +
CreateLoggerJJ+ 7
<JJ7 8 
FriendsRequestClientJJ8 L
>JJL M
(JJM N
)JJN O
)JJO P
;JJP Q
}KK 
returnMM 
_requestClientMM )
;MM) *
}NN 
}OO 
}PP 	
publicRR 
eventRR 
ActionRR 
FriendsListChangedRR .
;RR. /
publicTT 
voidTT 
ConfigureLoggingTT $
(TT$ %
ILoggerFactoryTT% 3
loggerFactoryTT4 A
)TTA B
{UU 	
ifVV 
(VV 
loggerFactoryVV 
==VV  
nullVV! %
)VV% &
{WW 
throwXX 
newXX !
ArgumentNullExceptionXX /
(XX/ 0
nameofXX0 6
(XX6 7
loggerFactoryXX7 D
)XXD E
)XXE F
;XXF G
}YY 
lock[[ 
([[ 

s_syncRoot[[ 
)[[ 
{\\ 
_loggerFactory]] 
=]]  
loggerFactory]]! .
;]]. /
_sessionLogger^^ 
=^^  
loggerFactory^^! .
.^^. /
CreateLogger^^/ ;
<^^; <
FriendshipSession^^< M
>^^M N
(^^N O
)^^O P
;^^P Q
}__ 
}`` 	
publicbb 
voidbb $
NotifyFriendsListChangedbb ,
(bb, -
)bb- .
{cc 	
FriendsListChangeddd 
?dd 
.dd  
Invokedd  &
(dd& '
)dd' (
;dd( )
}ee 	
publicgg 
voidgg 
ClearSessiongg  
(gg  !
)gg! "
{hh 	
lockii 
(ii 

s_syncRootii 
)ii 
{jj 
ifkk 
(kk 
_clientkk 
!=kk 
nullkk #
)kk# $
{ll 
_clientmm 
.mm 
Disposemm #
(mm# $
)mm$ %
;mm% &
_clientnn 
=nn 
nullnn "
;nn" #
}oo 
ifqq 
(qq 
_requestClientqq "
!=qq# %
nullqq& *
)qq* +
{rr 
_requestClientss "
.ss" #
Disposess# *
(ss* +
)ss+ ,
;ss, -
_requestClienttt "
=tt# $
nulltt% )
;tt) *
}uu 
_sessionLoggerww 
?ww 
.ww  
Informationww  +
(ww+ ,(
SocialSessionClearedTemplateww, H
)wwH I
;wwI J
}xx 
}yy 	
private{{ 
void{{ #
EnsureLoggingConfigured{{ ,
({{, -
){{- .
{|| 	
if}} 
(}} 
_loggerFactory}} 
==}} !
null}}" &
)}}& '
{~~ 
throw 
new %
InvalidOperationException 3
(3 4'
LoggingNotConfiguredMessage4 O
)O P
;P Q
}
ÄÄ 
}
ÅÅ 	
}
ÇÇ 
}ÉÉ ¨
ZC:\Users\oscar\source\repos\TrickTakingMissions\Client\Model\Session\IFriendshipSession.cs
	namespace 	
Model
 
. 
Session 
{ 
public		 

	interface		 
IFriendshipSession		 '
{

 
event 
Action 
FriendsListChanged '
;' (
IFriendshipClient 
Client  
{! "
get# &
;& '
}( )!
IFriendsRequestClient 
RequestClient +
{, -
get. 1
;1 2
}3 4
void $
NotifyFriendsListChanged %
(% &
)& '
;' (
void 
ClearSession 
( 
) 
; 
} 
} ì+
\C:\Users\oscar\source\repos\TrickTakingMissions\Client\Model\Services\Wcf\WcfFaultHandler.cs
	namespace 	
Model
 
. 
Services 
{ 
internal 
sealed 
class 
WcfFaultHandler )
{ 
private 
const 
string '
EndpointNotFoundLogTemplate 8
=9 :
$str; k
;k l
private 
const 
string 
TimeoutLogTemplate /
=0 1
$str2 a
;a b
private 
const 
string $
CommunicationLogTemplate 5
=6 7
$str8 i
;i j
private 
static 
readonly 
IReadOnlyDictionary  3
<3 4#
AuthenticationErrorType4 K
,K L
stringM S
>S T
FaultLogTemplatesU f
=g h
new 

Dictionary 
< #
AuthenticationErrorType 2
,2 3
string4 :
>: ;
{ 
{ #
AuthenticationErrorType )
.) *
ConnectionFailed* :
,: ;'
EndpointNotFoundLogTemplate< W
}X Y
,Y Z
{ #
AuthenticationErrorType )
.) *
Timeout* 1
,1 2
TimeoutLogTemplate3 E
}F G
,G H
{ #
AuthenticationErrorType )
.) *
CommunicationError* <
,< =$
CommunicationLogTemplate> V
}W X
} 
; 
private 
readonly 
ILoggerService '
_logger( /
;/ 0
private 
readonly 
Action 
<  #
AuthenticationErrorType  7
>7 8$
_connectionErrorNotifier9 Q
;Q R
public 
WcfFaultHandler 
( 
ILoggerService -
logger. 4
,4 5
Action6 <
<< =#
AuthenticationErrorType= T
>T U#
connectionErrorNotifierV m
)m n
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
;O P$
_connectionErrorNotifier $
=% &#
connectionErrorNotifier' >
??? A
throw   
new   !
ArgumentNullException   /
(  / 0
nameof  0 6
(  6 7#
connectionErrorNotifier  7 N
)  N O
)  O P
;  P Q
}!! 	
public## 
void## 
ReportFault## 
(##  
	Exception##  )
	exception##* 3
,##3 4
string##5 ;
operationName##< I
)##I J
{$$ 	
if%% 
(%% 
	exception%% 
==%% 
null%% !
)%%! "
{&& 
throw'' 
new'' !
ArgumentNullException'' /
(''/ 0
nameof''0 6
(''6 7
	exception''7 @
)''@ A
)''A B
;''B C
}(( #
AuthenticationErrorType** #
	errorType**$ -
=**. /
ResolveErrorType**0 @
(**@ A
	exception**A J
)**J K
;**K L
string++ 
logTemplate++ 
=++  
FaultLogTemplates++! 2
[++2 3
	errorType++3 <
]++< =
;++= >
_logger,, 
.,, 
Error,, 
(,, 
	exception,, #
,,,# $
logTemplate,,% 0
,,,0 1
operationName,,2 ?
),,? @
;,,@ A$
_connectionErrorNotifier-- $
(--$ %
	errorType--% .
)--. /
;--/ 0
}.. 	
public00 
void00 
ReportFaultAndClose00 '
(00' (
	Exception00( 1
	exception002 ;
,00; <
string00= C
operationName00D Q
,00Q R 
ICommunicationObject00S g
channel00h o
)00o p
{11 	
GameChannelCloser22 
.22 
CloseChannel22 *
(22* +
channel22+ 2
,222 3
_logger224 ;
)22; <
;22< =
ReportFault33 
(33 
	exception33 !
,33! "
operationName33# 0
)330 1
;331 2
}44 	
private66 
static66 #
AuthenticationErrorType66 .
ResolveErrorType66/ ?
(66? @
	Exception66@ I
	exception66J S
)66S T
{77 	
if88 
(88 
	exception88 
is88 %
EndpointNotFoundException88 6
)886 7
{99 
return:: #
AuthenticationErrorType:: .
.::. /
ConnectionFailed::/ ?
;::? @
};; 
if== 
(== 
	exception== 
is== 
TimeoutException== -
)==- .
{>> 
return?? #
AuthenticationErrorType?? .
.??. /
Timeout??/ 6
;??6 7
}@@ 
returnBB #
AuthenticationErrorTypeBB *
.BB* +
CommunicationErrorBB+ =
;BB= >
}CC 	
}DD 
}EE ˛¸
bC:\Users\oscar\source\repos\TrickTakingMissions\Client\Model\Services\LobbyAndMatch\LobbyClient.cs
	namespace		 	
Model		
 
.		 
Services		 
{

 
[ 
CallbackBehavior 
( 
ConcurrencyMode %
=& '
ConcurrencyMode( 7
.7 8
Multiple8 @
,@ A%
UseSynchronizationContextB [
=\ ]
false^ c
)c d
]d e
public 

sealed 
partial 
class 
LobbyClient  +
:, -
ILobbyClient. :
,: ;!
ILobbyServiceCallback< Q
{ 
private 
const 
string '
ChannelDisconnectedTemplate 8
=9 :
$str; l
;l m
private 
const 
string 
CloseFaultTemplate /
=0 1
$str Z
;Z [
private 
const 
string  
CloseTimeoutTemplate 1
=2 3
$str P
;P Q
private 
const 
string &
MatchStartRejectedTemplate 7
=8 9
$str: f
;f g
private 
const 
string $
CreateLobbyOperationName 5
=6 7
$str8 J
;J K
private 
const 
string ,
 UpdateLobbySettingsOperationName =
=> ?
$str@ Z
;Z [
private 
const 
string )
AuthorizeReentryOperationName :
=; <
$str= `
;` a
private 
const 
string "
JoinLobbyOperationName 3
=4 5
$str6 L
;L M
private 
const 
string #
LeaveLobbyOperationName 4
=5 6
$str7 H
;H I
private 
const 
string #
KickPlayerOperationName 4
=5 6
$str7 H
;H I
private 
const 
string '
SetPlayerReadyOperationName 8
=9 :
$str; V
;V W
private 
const 
string (
SendChatMessageOperationName 9
=: ;
$str< W
;W X
private 
const 
string "
StartGameOperationName 3
=4 5
$str6 O
;O P
private!! 
readonly!! 
ILoggerService!! '
_logger!!( /
;!!/ 0
private"" 
readonly"" 
WcfFaultHandler"" (
_faultHandler"") 6
;""6 7
private## 
LobbyServiceClient## "
_client### *
;##* +
private$$ 
bool$$ "
_isLobbyClientDisposed$$ +
;$$+ ,
public&& 
LobbyClient&& 
(&& 
ILoggerService&& )
logger&&* 0
)&&0 1
{'' 	
_logger(( 
=(( 
logger(( 
??(( 
throw((  %
new((& )!
ArgumentNullException((* ?
(((? @
nameof((@ F
(((F G
logger((G M
)((M N
)((N O
;((O P
_faultHandler)) 
=)) 
new)) 
WcfFaultHandler))  /
())/ 0
_logger))0 7
,))7 8 
RaiseConnectionError))9 M
)))M N
;))N O
InitializeClient** 
(** 
)** 
;** 
}++ 	
public-- 
event-- 
EventHandler-- !
<--! "&
LobbyStateChangedEventArgs--" <
>--< =
LobbyStateChanged--> O
;--O P
public// 
event// 
Action// 
<// 
LobbyPlayer// '
>//' (
PlayerJoined//) 5
;//5 6
public11 
event11 
Action11 
<11 
int11 
,11  
string11! '
>11' (

PlayerLeft11) 3
;113 4
public33 
event33 
Action33 
<33 
int33 
,33  
bool33! %
>33% &$
PlayerReadyStatusChanged33' ?
;33? @
public55 
event55 
Action55 
<55 
LobbyMessage55 (
>55( )
ChatMessageReceived55* =
;55= >
public77 
event77 
EventHandler77 !
<77! "*
ChatAccountBanAppliedEventArgs77" @
>77@ A!
ChatAccountBanApplied77B W
;77W X
public99 
event99 
Action99 
<99 
int99 
>99  
GameStarted99! ,
;99, -
public;; 
event;; 
Action;; 
<;; 
string;; "
>;;" #
LobbyDisbanded;;$ 2
;;;2 3
public== 
event== 
Action== 
<== #
AuthenticationErrorType== 3
>==3 4#
ConnectionErrorOccurred==5 L
;==L M
publicEE 
asyncEE 
TaskEE 
<EE 
LobbyResultEE %
>EE% &
CreateLobbyAsyncEE' 7
(EE7 8
intEE8 ;

hostUserIdEE< F
,EEF G
LobbySettingsEEH U
lobbySettingsEEV c
)EEc d
{FF 	
LobbyResultGG 
resultGG 
=GG  
nullGG! %
;GG% &
tryHH 
{II 
EnsureClientIsOpenJJ "
(JJ" #
)JJ# $
;JJ$ %
resultKK 
=KK 
awaitKK 
_clientKK &
.KK& '
CreateLobbyAsyncKK' 7
(KK7 8

hostUserIdKK8 B
,KKB C
lobbySettingsKKD Q
)KKQ R
;KKR S#
PreserveGuestCredentialLL '
(LL' (
resultLL( .
)LL. /
;LL/ 0
}MM 
catchNN 
(NN %
EndpointNotFoundExceptionNN ,
exNN- /
)NN/ 0
{OO 
_faultHandlerPP 
.PP 
ReportFaultPP )
(PP) *
exPP* ,
,PP, -$
CreateLobbyOperationNamePP. F
)PPF G
;PPG H
}QQ 
catchRR 
(RR 
TimeoutExceptionRR #
exRR$ &
)RR& '
{SS 
_faultHandlerTT 
.TT 
ReportFaultTT )
(TT) *
exTT* ,
,TT, -$
CreateLobbyOperationNameTT. F
)TTF G
;TTG H
}UU 
catchVV 
(VV "
CommunicationExceptionVV )
exVV* ,
)VV, -
{WW 
_faultHandlerXX 
.XX 
ReportFaultXX )
(XX) *
exXX* ,
,XX, -$
CreateLobbyOperationNameXX. F
)XXF G
;XXG H
}YY 
return[[ 
result[[ 
;[[ 
}\\ 	
public__ 
async__ 
Task__ 
<__ 
LobbyResult__ %
>__% &$
UpdateLobbySettingsAsync__' ?
(__? @
string__@ F
	lobbyCode__G P
,__P Q
int__R U
requesterUserId__V e
,__e f
LobbySettings`` 
lobbySettings`` '
)``' (
{aa 	
LobbyResultbb 
configurationUpdatebb +
=bb, -
nullbb. 2
;bb2 3
trycc 
{dd 
EnsureClientIsOpenee "
(ee" #
)ee# $
;ee$ %
configurationUpdateff #
=ff$ %
awaitff& +
_clientff, 3
.ff3 4$
UpdateLobbySettingsAsyncff4 L
(ffL M
	lobbyCodeffM V
,ffV W
requesterUserIdffX g
,ffg h
lobbySettingsffi v
)ffv w
;ffw x
}gg 
catchhh 
(hh %
EndpointNotFoundExceptionhh ,
exhh- /
)hh/ 0
{ii 
_faultHandlerjj 
.jj 
ReportFaultjj )
(jj) *
exjj* ,
,jj, -,
 UpdateLobbySettingsOperationNamejj. N
)jjN O
;jjO P
}kk 
catchll 
(ll 
TimeoutExceptionll #
exll$ &
)ll& '
{mm 
_faultHandlernn 
.nn 
ReportFaultnn )
(nn) *
exnn* ,
,nn, -,
 UpdateLobbySettingsOperationNamenn. N
)nnN O
;nnO P
}oo 
catchpp 
(pp "
CommunicationExceptionpp )
expp* ,
)pp, -
{qq 
_faultHandlerrr 
.rr 
ReportFaultrr )
(rr) *
exrr* ,
,rr, -,
 UpdateLobbySettingsOperationNamerr. N
)rrN O
;rrO P
}ss 
returnuu 
configurationUpdateuu &
;uu& '
}vv 	
publicyy 
asyncyy 
Taskyy 
<yy 
LobbyResultyy %
>yy% &-
!AuthorizeKickedPlayerReentryAsyncyy' H
(yyH I
stringzz 
	lobbyCodezz 
,zz 
intzz !

hostUserIdzz" ,
,zz, -
intzz. 1
targetUserIdzz2 >
)zz> ?
{{{ 	
LobbyResult||  
reentryAuthorization|| ,
=||- .
null||/ 3
;||3 4
try}} 
{~~ 
EnsureClientIsOpen "
(" #
)# $
;$ %"
reentryAuthorization
ÄÄ $
=
ÄÄ% &
await
ÄÄ' ,
_client
ÄÄ- 4
.
ÄÄ4 5/
!AuthorizeKickedPlayerReentryAsync
ÄÄ5 V
(
ÄÄV W
	lobbyCode
ÅÅ 
,
ÅÅ 

hostUserId
ÅÅ )
,
ÅÅ) *
targetUserId
ÅÅ+ 7
)
ÅÅ7 8
;
ÅÅ8 9
}
ÇÇ 
catch
ÉÉ 
(
ÉÉ '
EndpointNotFoundException
ÉÉ ,
ex
ÉÉ- /
)
ÉÉ/ 0
{
ÑÑ 
_faultHandler
ÖÖ 
.
ÖÖ 
ReportFault
ÖÖ )
(
ÖÖ) *
ex
ÖÖ* ,
,
ÖÖ, -+
AuthorizeReentryOperationName
ÖÖ. K
)
ÖÖK L
;
ÖÖL M
}
ÜÜ 
catch
áá 
(
áá 
TimeoutException
áá #
ex
áá$ &
)
áá& '
{
àà 
_faultHandler
ââ 
.
ââ 
ReportFault
ââ )
(
ââ) *
ex
ââ* ,
,
ââ, -+
AuthorizeReentryOperationName
ââ. K
)
ââK L
;
ââL M
}
ää 
catch
ãã 
(
ãã $
CommunicationException
ãã )
ex
ãã* ,
)
ãã, -
{
åå 
_faultHandler
çç 
.
çç 
ReportFault
çç )
(
çç) *
ex
çç* ,
,
çç, -+
AuthorizeReentryOperationName
çç. K
)
ççK L
;
ççL M
}
éé 
return
êê "
reentryAuthorization
êê '
;
êê' (
}
ëë 	
public
îî 
void
îî !
OnLobbyStateChanged
îî '
(
îî' (
Lobby
îî( -
confirmedLobby
îî. <
)
îî< =
{
ïï 	
LobbyStateChanged
ññ 
?
ññ 
.
ññ 
Invoke
ññ %
(
ññ% &
this
ññ& *
,
ññ* +
new
ññ, /(
LobbyStateChangedEventArgs
ññ0 J
(
ññJ K
confirmedLobby
ññK Y
)
ññY Z
)
ññZ [
;
ññ[ \
}
óó 	
public
üü 
async
üü 
Task
üü 
<
üü 
LobbyResult
üü %
>
üü% &"
JoinLobbyByCodeAsync
üü' ;
(
üü; <
string
üü< B
	lobbyCode
üüC L
,
üüL M
int
üüN Q
userId
üüR X
)
üüX Y
{
†† 	
LobbyResult
°° 
result
°° 
=
°°  
null
°°! %
;
°°% &
try
££ 
{
§§  
EnsureClientIsOpen
•• "
(
••" #
)
••# $
;
••$ %
result
¶¶ 
=
¶¶ 
await
¶¶ 
_client
¶¶ &
.
¶¶& '"
JoinLobbyByCodeAsync
¶¶' ;
(
¶¶; <
	lobbyCode
¶¶< E
,
¶¶E F
userId
¶¶G M
)
¶¶M N
;
¶¶N O%
PreserveGuestCredential
ßß '
(
ßß' (
result
ßß( .
)
ßß. /
;
ßß/ 0
}
®® 
catch
©© 
(
©© '
EndpointNotFoundException
©© ,
ex
©©- /
)
©©/ 0
{
™™ 
_faultHandler
´´ 
.
´´ 
ReportFault
´´ )
(
´´) *
ex
´´* ,
,
´´, -$
JoinLobbyOperationName
´´. D
)
´´D E
;
´´E F
}
¨¨ 
catch
≠≠ 
(
≠≠ 
TimeoutException
≠≠ #
ex
≠≠$ &
)
≠≠& '
{
ÆÆ 
_faultHandler
ØØ 
.
ØØ 
ReportFault
ØØ )
(
ØØ) *
ex
ØØ* ,
,
ØØ, -$
JoinLobbyOperationName
ØØ. D
)
ØØD E
;
ØØE F
}
∞∞ 
catch
±± 
(
±± $
CommunicationException
±± )
ex
±±* ,
)
±±, -
{
≤≤ 
_faultHandler
≥≥ 
.
≥≥ 
ReportFault
≥≥ )
(
≥≥) *
ex
≥≥* ,
,
≥≥, -$
JoinLobbyOperationName
≥≥. D
)
≥≥D E
;
≥≥E F
}
¥¥ 
return
∂∂ 
result
∂∂ 
;
∂∂ 
}
∑∑ 	
public
ææ 
async
ææ 
Task
ææ 
LeaveLobbyAsync
ææ )
(
ææ) *
string
ææ* 0
	lobbyCode
ææ1 :
,
ææ: ;
int
ææ< ?
userId
ææ@ F
)
ææF G
{
øø 	
try
¿¿ 
{
¡¡  
EnsureClientIsOpen
¬¬ "
(
¬¬" #
)
¬¬# $
;
¬¬$ %
await
√√ 
_client
√√ 
.
√√ 
LeaveLobbyAsync
√√ -
(
√√- .
	lobbyCode
√√. 7
,
√√7 8
userId
√√9 ?
)
√√? @
;
√√@ A
}
ƒƒ 
catch
≈≈ 
(
≈≈ '
EndpointNotFoundException
≈≈ ,
ex
≈≈- /
)
≈≈/ 0
{
∆∆ 
_faultHandler
«« 
.
«« 
ReportFault
«« )
(
««) *
ex
««* ,
,
««, -%
LeaveLobbyOperationName
««. E
)
««E F
;
««F G
}
»» 
catch
…… 
(
…… 
TimeoutException
…… #
ex
……$ &
)
……& '
{
   
_faultHandler
ÀÀ 
.
ÀÀ 
ReportFault
ÀÀ )
(
ÀÀ) *
ex
ÀÀ* ,
,
ÀÀ, -%
LeaveLobbyOperationName
ÀÀ. E
)
ÀÀE F
;
ÀÀF G
}
ÃÃ 
catch
ÕÕ 
(
ÕÕ $
CommunicationException
ÕÕ )
ex
ÕÕ* ,
)
ÕÕ, -
{
ŒŒ 
_faultHandler
œœ 
.
œœ 
ReportFault
œœ )
(
œœ) *
ex
œœ* ,
,
œœ, -%
LeaveLobbyOperationName
œœ. E
)
œœE F
;
œœF G
}
–– 
}
—— 	
public
‘‘ 
async
‘‘ 
Task
‘‘ 
KickPlayerAsync
‘‘ )
(
‘‘) *
string
‘‘* 0
	lobbyCode
‘‘1 :
,
‘‘: ;
int
‘‘< ?

hostUserId
‘‘@ J
,
‘‘J K
int
‘‘L O
targetUserId
‘‘P \
)
‘‘\ ]
{
’’ 	
try
÷÷ 
{
◊◊  
EnsureClientIsOpen
ÿÿ "
(
ÿÿ" #
)
ÿÿ# $
;
ÿÿ$ %
await
ŸŸ 
_client
ŸŸ 
.
ŸŸ %
KickPlayerByUserIdAsync
ŸŸ 5
(
ŸŸ5 6
	lobbyCode
ŸŸ6 ?
,
ŸŸ? @

hostUserId
ŸŸA K
,
ŸŸK L
targetUserId
ŸŸM Y
)
ŸŸY Z
;
ŸŸZ [
}
⁄⁄ 
catch
€€ 
(
€€ '
EndpointNotFoundException
€€ ,
ex
€€- /
)
€€/ 0
{
‹‹ 
_faultHandler
›› 
.
›› 
ReportFault
›› )
(
››) *
ex
››* ,
,
››, -%
KickPlayerOperationName
››. E
)
››E F
;
››F G
}
ﬁﬁ 
catch
ﬂﬂ 
(
ﬂﬂ 
TimeoutException
ﬂﬂ #
ex
ﬂﬂ$ &
)
ﬂﬂ& '
{
‡‡ 
_faultHandler
·· 
.
·· 
ReportFault
·· )
(
··) *
ex
··* ,
,
··, -%
KickPlayerOperationName
··. E
)
··E F
;
··F G
}
‚‚ 
catch
„„ 
(
„„ $
CommunicationException
„„ )
ex
„„* ,
)
„„, -
{
‰‰ 
_faultHandler
ÂÂ 
.
ÂÂ 
ReportFault
ÂÂ )
(
ÂÂ) *
ex
ÂÂ* ,
,
ÂÂ, -%
KickPlayerOperationName
ÂÂ. E
)
ÂÂE F
;
ÂÂF G
}
ÊÊ 
}
ÁÁ 	
public
ÔÔ 
async
ÔÔ 
Task
ÔÔ '
SetPlayerReadyStatusAsync
ÔÔ 3
(
ÔÔ3 4
string
ÔÔ4 :
	lobbyCode
ÔÔ; D
,
ÔÔD E
int
ÔÔF I
userId
ÔÔJ P
,
ÔÔP Q
bool
ÔÔR V
isReady
ÔÔW ^
)
ÔÔ^ _
{
 	
try
ÒÒ 
{
ÚÚ  
EnsureClientIsOpen
ÛÛ "
(
ÛÛ" #
)
ÛÛ# $
;
ÛÛ$ %
await
ÙÙ 
_client
ÙÙ 
.
ÙÙ '
SetPlayerReadyStatusAsync
ÙÙ 7
(
ÙÙ7 8
	lobbyCode
ÙÙ8 A
,
ÙÙA B
userId
ÙÙC I
,
ÙÙI J
isReady
ÙÙK R
)
ÙÙR S
;
ÙÙS T
}
ıı 
catch
ˆˆ 
(
ˆˆ '
EndpointNotFoundException
ˆˆ ,
ex
ˆˆ- /
)
ˆˆ/ 0
{
˜˜ 
_faultHandler
¯¯ 
.
¯¯ 
ReportFault
¯¯ )
(
¯¯) *
ex
¯¯* ,
,
¯¯, -)
SetPlayerReadyOperationName
¯¯. I
)
¯¯I J
;
¯¯J K
}
˘˘ 
catch
˙˙ 
(
˙˙ 
TimeoutException
˙˙ #
ex
˙˙$ &
)
˙˙& '
{
˚˚ 
_faultHandler
¸¸ 
.
¸¸ 
ReportFault
¸¸ )
(
¸¸) *
ex
¸¸* ,
,
¸¸, -)
SetPlayerReadyOperationName
¸¸. I
)
¸¸I J
;
¸¸J K
}
˝˝ 
catch
˛˛ 
(
˛˛ $
CommunicationException
˛˛ )
ex
˛˛* ,
)
˛˛, -
{
ˇˇ 
_faultHandler
ÄÄ 
.
ÄÄ 
ReportFault
ÄÄ )
(
ÄÄ) *
ex
ÄÄ* ,
,
ÄÄ, -)
SetPlayerReadyOperationName
ÄÄ. I
)
ÄÄI J
;
ÄÄJ K
}
ÅÅ 
}
ÇÇ 	
public
ÖÖ 
async
ÖÖ 
Task
ÖÖ 
<
ÖÖ /
!LobbyChatMessageSubmissionOutcome
ÖÖ ;
>
ÖÖ; <'
SendLobbyChatMessageAsync
ÖÖ= V
(
ÖÖV W(
LobbyChatMessageSubmission
ÜÜ &#
chatMessageSubmission
ÜÜ' <
)
ÜÜ< =
{
áá 	/
!LobbyChatMessageSubmissionOutcome
àà -*
chatMessageSubmissionOutcome
àà. J
=
ààK L
null
ààM Q
;
ààQ R
try
ââ 
{
ää  
EnsureClientIsOpen
ãã "
(
ãã" #
)
ãã# $
;
ãã$ %*
chatMessageSubmissionOutcome
åå ,
=
åå- .
await
åå/ 4
_client
åå5 <
.
åå< ='
SendLobbyChatMessageAsync
åå= V
(
ååV W#
chatMessageSubmission
ååW l
)
åål m
;
ååm n
}
çç 
catch
éé 
(
éé '
EndpointNotFoundException
éé ,
ex
éé- /
)
éé/ 0
{
èè 
_faultHandler
êê 
.
êê 
ReportFault
êê )
(
êê) *
ex
êê* ,
,
êê, -*
SendChatMessageOperationName
êê. J
)
êêJ K
;
êêK L
}
ëë 
catch
íí 
(
íí 
TimeoutException
íí #
ex
íí$ &
)
íí& '
{
ìì 
_faultHandler
îî 
.
îî 
ReportFault
îî )
(
îî) *
ex
îî* ,
,
îî, -*
SendChatMessageOperationName
îî. J
)
îîJ K
;
îîK L
}
ïï 
catch
ññ 
(
ññ $
CommunicationException
ññ )
ex
ññ* ,
)
ññ, -
{
óó 
_faultHandler
òò 
.
òò 
ReportFault
òò )
(
òò) *
ex
òò* ,
,
òò, -*
SendChatMessageOperationName
òò. J
)
òòJ K
;
òòK L
}
ôô 
return
õõ *
chatMessageSubmissionOutcome
õõ /
;
õõ/ 0
}
úú 	
public
ûû 
async
ûû 
Task
ûû 
<
ûû 
bool
ûû 
>
ûû %
StartGameFromLobbyAsync
ûû  7
(
ûû7 8
string
ûû8 >
	lobbyCode
ûû? H
,
ûûH I
int
ûûJ M

hostUserId
ûûN X
)
ûûX Y
{
üü 	
bool
†† 
isStartConfirmed
†† !
=
††" #
false
††$ )
;
††) *
try
°° 
{
¢¢  
EnsureClientIsOpen
££ "
(
££" #
)
££# $
;
££$ %
await
§§ 
_client
§§ 
.
§§ %
StartGameFromLobbyAsync
§§ 5
(
§§5 6
	lobbyCode
§§6 ?
,
§§? @

hostUserId
§§A K
)
§§K L
;
§§L M
isStartConfirmed
••  
=
••! "
true
••# '
;
••' (
}
¶¶ 
catch
ßß 
(
ßß 
FaultException
ßß !
ex
ßß" $
)
ßß$ %
{
®® 
_logger
©© 
.
©© 
Warning
©© 
(
©©  (
MatchStartRejectedTemplate
©©  :
,
©©: ;
ex
©©< >
.
©©> ?
GetType
©©? F
(
©©F G
)
©©G H
.
©©H I
Name
©©I M
)
©©M N
;
©©N O
}
™™ 
catch
´´ 
(
´´ '
EndpointNotFoundException
´´ ,
ex
´´- /
)
´´/ 0
{
¨¨ 
_faultHandler
≠≠ 
.
≠≠ 
ReportFault
≠≠ )
(
≠≠) *
ex
≠≠* ,
,
≠≠, -$
StartGameOperationName
≠≠. D
)
≠≠D E
;
≠≠E F
}
ÆÆ 
catch
ØØ 
(
ØØ 
TimeoutException
ØØ #
ex
ØØ$ &
)
ØØ& '
{
∞∞ 
_faultHandler
±± 
.
±± 
ReportFault
±± )
(
±±) *
ex
±±* ,
,
±±, -$
StartGameOperationName
±±. D
)
±±D E
;
±±E F
}
≤≤ 
catch
≥≥ 
(
≥≥ $
CommunicationException
≥≥ )
ex
≥≥* ,
)
≥≥, -
{
¥¥ 
_faultHandler
µµ 
.
µµ 
ReportFault
µµ )
(
µµ) *
ex
µµ* ,
,
µµ, -$
StartGameOperationName
µµ. D
)
µµD E
;
µµE F
}
∂∂ 
return
∑∑ 
isStartConfirmed
∑∑ #
;
∑∑# $
}
∏∏ 	
public
∫∫ 
void
∫∫ %
OnChatAccountBanApplied
∫∫ +
(
∫∫+ ,"
ChatAccountBanNotice
∫∫, @"
chatAccountBanNotice
∫∫A U
)
∫∫U V
{
ªª 	#
ChatAccountBanApplied
ºº !
?
ºº! "
.
ºº" #
Invoke
ºº# )
(
ºº) *
this
ºº* .
,
ºº. /
new
ºº0 3,
ChatAccountBanAppliedEventArgs
ºº4 R
(
ººR S"
chatAccountBanNotice
ººS g
)
ººg h
)
ººh i
;
ººi j
}
ΩΩ 	
public
øø 
void
øø !
OnPlayerJoinedLobby
øø '
(
øø' (
LobbyPlayer
øø( 3
player
øø4 :
)
øø: ;
{
¿¿ 	
PlayerJoined
¡¡ 
?
¡¡ 
.
¡¡ 
Invoke
¡¡  
(
¡¡  !
player
¡¡! '
)
¡¡' (
;
¡¡( )
}
¬¬ 	
public
ƒƒ 
void
ƒƒ 
OnPlayerLeftLobby
ƒƒ %
(
ƒƒ% &
int
ƒƒ& )
userId
ƒƒ* 0
,
ƒƒ0 1
string
ƒƒ2 8
reason
ƒƒ9 ?
)
ƒƒ? @
{
≈≈ 	

PlayerLeft
∆∆ 
?
∆∆ 
.
∆∆ 
Invoke
∆∆ 
(
∆∆ 
userId
∆∆ %
,
∆∆% &
reason
∆∆' -
)
∆∆- .
;
∆∆. /
}
«« 	
public
…… 
void
…… (
OnPlayerReadyStatusChanged
…… .
(
……. /
int
……/ 2
userId
……3 9
,
……9 :
bool
……; ?
isReady
……@ G
)
……G H
{
   	&
PlayerReadyStatusChanged
ÀÀ $
?
ÀÀ$ %
.
ÀÀ% &
Invoke
ÀÀ& ,
(
ÀÀ, -
userId
ÀÀ- 3
,
ÀÀ3 4
isReady
ÀÀ5 <
)
ÀÀ< =
;
ÀÀ= >
}
ÃÃ 	
public
ŒŒ 
void
ŒŒ '
OnReceiveLobbyChatMessage
ŒŒ -
(
ŒŒ- .
LobbyMessage
ŒŒ. :
message
ŒŒ; B
)
ŒŒB C
{
œœ 	!
ChatMessageReceived
–– 
?
––  
.
––  !
Invoke
––! '
(
––' (
message
––( /
)
––/ 0
;
––0 1
}
—— 	
public
”” 
void
”” 
OnGameStarting
”” "
(
””" #
int
””# &
gameId
””' -
)
””- .
{
‘‘ 	
GameStarted
’’ 
?
’’ 
.
’’ 
Invoke
’’ 
(
’’  
gameId
’’  &
)
’’& '
;
’’' (
}
÷÷ 	
public
ÿÿ 
void
ÿÿ 
OnLobbyDisbanded
ÿÿ $
(
ÿÿ$ %
string
ÿÿ% +
reason
ÿÿ, 2
)
ÿÿ2 3
{
ŸŸ 	
LobbyDisbanded
⁄⁄ 
?
⁄⁄ 
.
⁄⁄ 
Invoke
⁄⁄ "
(
⁄⁄" #
reason
⁄⁄# )
)
⁄⁄) *
;
⁄⁄* +
}
€€ 	
public
›› 
void
›› 
Dispose
›› 
(
›› 
)
›› 
{
ﬁﬁ 	
Dispose
ﬂﬂ 
(
ﬂﬂ 
true
ﬂﬂ 
)
ﬂﬂ 
;
ﬂﬂ 
GC
‡‡ 
.
‡‡ 
SuppressFinalize
‡‡ 
(
‡‡  
this
‡‡  $
)
‡‡$ %
;
‡‡% &
}
·· 	
private
„„ 
void
„„ 
InitializeClient
„„ %
(
„„% &
)
„„& '
{
‰‰ 	
InstanceContext
ÂÂ 
instanceContext
ÂÂ +
=
ÂÂ, -
new
ÂÂ. 1
InstanceContext
ÂÂ2 A
(
ÂÂA B
this
ÂÂB F
)
ÂÂF G
;
ÂÂG H
_client
ÊÊ 
=
ÊÊ 
new
ÊÊ  
LobbyServiceClient
ÊÊ ,
(
ÊÊ, -
instanceContext
ÊÊ- <
)
ÊÊ< =
;
ÊÊ= >
_client
ÁÁ 
.
ÁÁ 
Endpoint
ÁÁ 
.
ÁÁ 
EndpointBehaviors
ÁÁ .
.
ÁÁ. /
Add
ÁÁ/ 2
(
ÁÁ2 3
new
ÁÁ3 6,
AccountSessionEndpointBehavior
ÁÁ7 U
(
ÁÁU V
)
ÁÁV W
)
ÁÁW X
;
ÁÁX Y
_client
ËË 
.
ËË 
InnerChannel
ËË  
.
ËË  !
Faulted
ËË! (
+=
ËË) +(
OnLobbyChannelDisconnected
ËË, F
;
ËËF G
_client
ÈÈ 
.
ÈÈ 
InnerChannel
ÈÈ  
.
ÈÈ  !
Closed
ÈÈ! '
+=
ÈÈ( *(
OnLobbyChannelDisconnected
ÈÈ+ E
;
ÈÈE F
}
ÍÍ 	
private
ÏÏ 
void
ÏÏ (
OnLobbyChannelDisconnected
ÏÏ /
(
ÏÏ/ 0
object
ÏÏ0 6
sender
ÏÏ7 =
,
ÏÏ= >
	EventArgs
ÏÏ? H
e
ÏÏI J
)
ÏÏJ K
{
ÌÌ 	
if
ÓÓ 
(
ÓÓ 
!
ÓÓ $
_isLobbyClientDisposed
ÓÓ '
)
ÓÓ' (
{
ÔÔ 
_logger
 
.
 
Warning
 
(
  )
ChannelDisconnectedTemplate
  ;
)
; <
;
< =%
ConnectionErrorOccurred
ÒÒ '
?
ÒÒ' (
.
ÒÒ( )
Invoke
ÒÒ) /
(
ÒÒ/ 0%
AuthenticationErrorType
ÒÒ0 G
.
ÒÒG H 
CommunicationError
ÒÒH Z
)
ÒÒZ [
;
ÒÒ[ \
}
ÚÚ 
}
ÛÛ 	
private
ıı 
void
ıı  
EnsureClientIsOpen
ıı '
(
ıı' (
)
ıı( )
{
ˆˆ 	
bool
˜˜  
shouldReinitialize
˜˜ #
=
˜˜$ %
_client
˜˜& -
==
˜˜. 0
null
˜˜1 5
||
˜˜6 8
_client
¯¯& -
.
¯¯- .
State
¯¯. 3
==
¯¯4 6 
CommunicationState
¯¯7 I
.
¯¯I J
Faulted
¯¯J Q
||
¯¯R T
_client
˘˘& -
.
˘˘- .
State
˘˘. 3
==
˘˘4 6 
CommunicationState
˘˘7 I
.
˘˘I J
Closed
˘˘J P
;
˘˘P Q
if
˚˚ 
(
˚˚  
shouldReinitialize
˚˚ "
)
˚˚" #
{
¸¸ 
InitializeClient
˝˝  
(
˝˝  !
)
˝˝! "
;
˝˝" #
}
˛˛ 
}
ˇˇ 	
private
ÅÅ 
void
ÅÅ 
Dispose
ÅÅ 
(
ÅÅ 
bool
ÅÅ !
isDisposing
ÅÅ" -
)
ÅÅ- .
{
ÇÇ 	$
_isLobbyClientDisposed
ÉÉ "
=
ÉÉ# $
true
ÉÉ% )
;
ÉÉ) *
if
ÑÑ 
(
ÑÑ 
isDisposing
ÑÑ 
&&
ÑÑ 
_client
ÑÑ &
!=
ÑÑ' )
null
ÑÑ* .
)
ÑÑ. /
{
ÖÖ  
CloseOrAbortClient
ÜÜ "
(
ÜÜ" #
)
ÜÜ# $
;
ÜÜ$ %
}
áá 
}
àà 	
private
ää 
void
ää  
CloseOrAbortClient
ää '
(
ää' (
)
ää( )
{
ãã 	
try
åå 
{
çç 
bool
éé  
canCloseGracefully
éé '
=
éé( )
_client
éé* 1
.
éé1 2
State
éé2 7
!=
éé8 : 
CommunicationState
éé; M
.
ééM N
Closed
ééN T
&&
ééU W
_client
èè* 1
.
èè1 2
State
èè2 7
!=
èè8 : 
CommunicationState
èè; M
.
èèM N
Faulted
èèN U
;
èèU V
if
ëë 
(
ëë  
canCloseGracefully
ëë &
)
ëë& '
{
íí 
_client
ìì 
.
ìì 
Close
ìì !
(
ìì! "
)
ìì" #
;
ìì# $
}
îî 
else
ïï 
{
ññ 
_client
óó 
.
óó 
Abort
óó !
(
óó! "
)
óó" #
;
óó# $
}
òò 
}
ôô 
catch
öö 
(
öö $
CommunicationException
öö )
ex
öö* ,
)
öö, -
{
õõ 
_logger
úú 
.
úú 
Warning
úú 
(
úú   
CloseFaultTemplate
úú  2
,
úú2 3
ex
úú4 6
.
úú6 7
GetType
úú7 >
(
úú> ?
)
úú? @
.
úú@ A
Name
úúA E
)
úúE F
;
úúF G
_client
ùù 
.
ùù 
Abort
ùù 
(
ùù 
)
ùù 
;
ùù  
}
ûû 
catch
üü 
(
üü 
TimeoutException
üü #
ex
üü$ &
)
üü& '
{
†† 
_logger
°° 
.
°° 
Warning
°° 
(
°°  "
CloseTimeoutTemplate
°°  4
,
°°4 5
ex
°°6 8
.
°°8 9
GetType
°°9 @
(
°°@ A
)
°°A B
.
°°B C
Name
°°C G
)
°°G H
;
°°H I
_client
¢¢ 
.
¢¢ 
Abort
¢¢ 
(
¢¢ 
)
¢¢ 
;
¢¢  
}
££ 
finally
§§ 
{
•• 
_client
¶¶ 
=
¶¶ 
null
¶¶ 
;
¶¶ 
}
ßß 
}
®® 	
private
™™ 
void
™™ "
RaiseConnectionError
™™ )
(
™™) *%
AuthenticationErrorType
™™* A
	errorType
™™B K
)
™™K L
{
´´ 	%
ConnectionErrorOccurred
¨¨ #
?
¨¨# $
.
¨¨$ %
Invoke
¨¨% +
(
¨¨+ ,
	errorType
¨¨, 5
)
¨¨5 6
;
¨¨6 7
}
≠≠ 	
}
ÆÆ 
}ØØ Ù
cC:\Users\oscar\source\repos\TrickTakingMissions\Client\Model\Services\LobbyAndMatch\ILobbyClient.cs
	namespace 	
Model
 
. 
Services 
{ 
public 

	interface 
ILobbyClient !
:" #
IDisposable$ /
,/ 0
IMatchClient1 =
{ 
event 
EventHandler 
< &
LobbyStateChangedEventArgs 5
>5 6
LobbyStateChanged7 H
;H I
event 
Action 
< 
LobbyPlayer  
>  !
PlayerJoined" .
;. /
event 
Action 
< 
int 
, 
string  
>  !

PlayerLeft" ,
;, -
event 
Action 
< 
int 
, 
bool 
> $
PlayerReadyStatusChanged  8
;8 9
event 
Action 
< 
LobbyMessage !
>! "
ChatMessageReceived# 6
;6 7
event 
EventHandler 
< *
ChatAccountBanAppliedEventArgs 9
>9 :!
ChatAccountBanApplied; P
;P Q
event 
Action 
< 
int 
> 
GameStarted %
;% &
event 
Action 
< 
string 
> 
LobbyDisbanded +
;+ ,
event 
Action 
< #
AuthenticationErrorType ,
>, -#
ConnectionErrorOccurred. E
;E F
Task 
< 
LobbyResult 
> 
CreateLobbyAsync *
(* +
int+ .

hostUserId/ 9
,9 :
LobbySettings; H
lobbySettingsI V
)V W
;W X
Task&& 
<&& 
LobbyResult&& 
>&& $
UpdateLobbySettingsAsync&& 2
(&&2 3
string&&3 9
	lobbyCode&&: C
,&&C D
int&&E H
requesterUserId&&I X
,&&X Y
LobbySettings&&Z g
lobbySettings&&h u
)&&u v
;&&v w
Task(( 
<(( 
LobbyResult(( 
>((  
JoinLobbyByCodeAsync(( .
(((. /
string((/ 5
	lobbyCode((6 ?
,((? @
int((A D
userId((E K
)((K L
;((L M
Task++ 
KickPlayerAsync++ 
(++ 
string++ #
	lobbyCode++$ -
,++- .
int++/ 2

hostUserId++3 =
,++= >
int++? B
targetUserId++C O
)++O P
;++P Q
Task.. 
<.. 
LobbyResult.. 
>.. -
!AuthorizeKickedPlayerReentryAsync.. ;
(..; <
string..< B
	lobbyCode..C L
,..L M
int..N Q

hostUserId..R \
,..\ ]
int..^ a
targetUserId..b n
)..n o
;..o p
Task00 
LeaveLobbyAsync00 
(00 
string00 #
	lobbyCode00$ -
,00- .
int00/ 2
userId003 9
)009 :
;00: ;
Task22 %
SetPlayerReadyStatusAsync22 &
(22& '
string22' -
	lobbyCode22. 7
,227 8
int229 <
userId22= C
,22C D
bool22E I
isReady22J Q
)22Q R
;22R S
Task44 
<44 -
!LobbyChatMessageSubmissionOutcome44 .
>44. /%
SendLobbyChatMessageAsync440 I
(44I J&
LobbyChatMessageSubmission55 &!
chatMessageSubmission55' <
)55< =
;55= >
Task77 
<77 
bool77 
>77 #
StartGameFromLobbyAsync77 *
(77* +
string77+ 1
	lobbyCode772 ;
,77; <
int77= @

hostUserId77A K
)77K L
;77L M
}88 
}99 ˚ã
hC:\Users\oscar\source\repos\TrickTakingMissions\Client\Model\Services\Friendship\FriendsRequestClient.cs
	namespace 	
Model
 
. 
Services 
{		 
public 

sealed 
class  
FriendsRequestClient ,
:- .!
IFriendsRequestClient/ D
{ 
private 
const 
string #
GetPendingOperationName 4
=5 6
$str7 ]
;] ^
private 
const 
string  
GetSentOperationName 1
=2 3
$str4 W
;W X
private 
const 
string $
SendRequestOperationName 5
=6 7
$str8 P
;P Q
private 
const 
string &
AcceptRequestOperationName 7
=8 9
$str: T
;T U
private 
const 
string &
RejectRequestOperationName 7
=8 9
$str: T
;T U
private 
const 
string &
CancelRequestOperationName 7
=8 9
$str: T
;T U
private 
readonly 
ILoggerService '
_logger( /
;/ 0
private 
readonly 
WcfFaultHandler (
_faultHandler) 6
;6 7
private '
FriendsRequestServiceClient +
_client, 3
;3 4
public  
FriendsRequestClient #
(# $
ILoggerService$ 2
logger3 9
)9 :
{ 	
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
;O P
_faultHandler 
= 
new 
WcfFaultHandler  /
(/ 0
_logger0 7
,7 8 
RaiseConnectionError9 M
)M N
;N O
InitializeClient 
( 
) 
; 
} 	
public!! 
event!! 
Action!! 
<!! #
AuthenticationErrorType!! 3
>!!3 4#
ConnectionErrorOccurred!!5 L
;!!L M
public## 
async## 
Task## 
<## 
IList## 
<##  
FriendRequest##  -
>##- .
>##. /0
$GetPendingFriendRequestByUserIdAsync##0 T
(##T U
int##U X
userId##Y _
)##_ `
{$$ 	
IList%% 
<%% 
FriendRequest%% 
>%%  
requests%%! )
=%%* +
new%%, /
List%%0 4
<%%4 5
FriendRequest%%5 B
>%%B C
(%%C D
)%%D E
;%%E F
try'' 
{(( 
EnsureClientIsOpen)) "
())" #
)))# $
;))$ %
FriendRequest** 
[** 
]** 
serverRequests**  .
=**/ 0
await**1 6
_client**7 >
.**> ?0
$GetPendingFriendRequestByUserIdAsync**? c
(**c d
userId**d j
)**j k
;**k l
if,, 
(,, 
serverRequests,, "
!=,,# %
null,,& *
),,* +
{-- 
requests.. 
=.. 
new.. "
List..# '
<..' (
FriendRequest..( 5
>..5 6
(..6 7
serverRequests..7 E
)..E F
;..F G
}// 
}00 
catch11 
(11 %
EndpointNotFoundException11 ,
ex11- /
)11/ 0
{22 
_faultHandler33 
.33 
ReportFaultAndClose33 1
(331 2
ex332 4
,334 5#
GetPendingOperationName336 M
,33M N
_client33O V
)33V W
;33W X
}44 
catch55 
(55 
TimeoutException55 #
ex55$ &
)55& '
{66 
_faultHandler77 
.77 
ReportFaultAndClose77 1
(771 2
ex772 4
,774 5#
GetPendingOperationName776 M
,77M N
_client77O V
)77V W
;77W X
}88 
catch99 
(99 "
CommunicationException99 )
ex99* ,
)99, -
{:: 
_faultHandler;; 
.;; 
ReportFaultAndClose;; 1
(;;1 2
ex;;2 4
,;;4 5#
GetPendingOperationName;;6 M
,;;M N
_client;;O V
);;V W
;;;W X
}<< 
return>> 
requests>> 
;>> 
}?? 	
publicAA 
asyncAA 
TaskAA 
<AA 
IListAA 
<AA  
FriendRequestAA  -
>AA- .
>AA. /-
!GetSentFriendRequestByUserIdAsyncAA0 Q
(AAQ R
intAAR U
userIdAAV \
)AA\ ]
{BB 	
IListCC 
<CC 
FriendRequestCC 
>CC  
requestsCC! )
=CC* +
newCC, /
ListCC0 4
<CC4 5
FriendRequestCC5 B
>CCB C
(CCC D
)CCD E
;CCE F
tryEE 
{FF 
EnsureClientIsOpenGG "
(GG" #
)GG# $
;GG$ %
FriendRequestHH 
[HH 
]HH 
serverRequestsHH  .
=HH/ 0
awaitHH1 6
_clientHH7 >
.HH> ?-
!GetSentFriendRequestByUserIdAsyncHH? `
(HH` a
userIdHHa g
)HHg h
;HHh i
ifJJ 
(JJ 
serverRequestsJJ "
!=JJ# %
nullJJ& *
)JJ* +
{KK 
requestsLL 
=LL 
newLL "
ListLL# '
<LL' (
FriendRequestLL( 5
>LL5 6
(LL6 7
serverRequestsLL7 E
)LLE F
;LLF G
}MM 
}NN 
catchOO 
(OO %
EndpointNotFoundExceptionOO ,
exOO- /
)OO/ 0
{PP 
_faultHandlerQQ 
.QQ 
ReportFaultAndCloseQQ 1
(QQ1 2
exQQ2 4
,QQ4 5 
GetSentOperationNameQQ6 J
,QQJ K
_clientQQL S
)QQS T
;QQT U
}RR 
catchSS 
(SS 
TimeoutExceptionSS #
exSS$ &
)SS& '
{TT 
_faultHandlerUU 
.UU 
ReportFaultAndCloseUU 1
(UU1 2
exUU2 4
,UU4 5 
GetSentOperationNameUU6 J
,UUJ K
_clientUUL S
)UUS T
;UUT U
}VV 
catchWW 
(WW "
CommunicationExceptionWW )
exWW* ,
)WW, -
{XX 
_faultHandlerYY 
.YY 
ReportFaultAndCloseYY 1
(YY1 2
exYY2 4
,YY4 5 
GetSentOperationNameYY6 J
,YYJ K
_clientYYL S
)YYS T
;YYT U
}ZZ 
return\\ 
requests\\ 
;\\ 
}]] 	
public__ 
async__ 
Task__ 
<__ 
OperationResult__ )
>__) *"
SendFriendRequestAsync__+ A
(__A B
int__B E
senderUserId__F R
,__R S
string__T Z
targetUserName__[ i
)__i j
{`` 	
OperationResultaa 
resultaa "
=aa# $
nullaa% )
;aa) *
trycc 
{dd 
EnsureClientIsOpenee "
(ee" #
)ee# $
;ee$ %
resultff 
=ff 
awaitff 
_clientff &
.ff& '"
SendFriendRequestAsyncff' =
(ff= >
senderUserIdff> J
,ffJ K
targetUserNameffL Z
)ffZ [
;ff[ \
}gg 
catchhh 
(hh %
EndpointNotFoundExceptionhh ,
exhh- /
)hh/ 0
{ii 
_faultHandlerjj 
.jj 
ReportFaultAndClosejj 1
(jj1 2
exjj2 4
,jj4 5$
SendRequestOperationNamejj6 N
,jjN O
_clientjjP W
)jjW X
;jjX Y
}kk 
catchll 
(ll 
TimeoutExceptionll #
exll$ &
)ll& '
{mm 
_faultHandlernn 
.nn 
ReportFaultAndClosenn 1
(nn1 2
exnn2 4
,nn4 5$
SendRequestOperationNamenn6 N
,nnN O
_clientnnP W
)nnW X
;nnX Y
}oo 
catchpp 
(pp "
CommunicationExceptionpp )
expp* ,
)pp, -
{qq 
_faultHandlerrr 
.rr 
ReportFaultAndCloserr 1
(rr1 2
exrr2 4
,rr4 5$
SendRequestOperationNamerr6 N
,rrN O
_clientrrP W
)rrW X
;rrX Y
}ss 
returnuu 
resultuu 
;uu 
}vv 	
publicxx 
asyncxx 
Taskxx 
<xx 
OperationResultxx )
>xx) *$
AcceptFriendRequestAsyncxx+ C
(xxC D
intxxD G
receiverUserIdxxH V
,xxV W
intxxX [
senderUserIdxx\ h
)xxh i
{yy 	
OperationResultzz 
resultzz "
=zz# $
nullzz% )
;zz) *
try|| 
{}} 
EnsureClientIsOpen~~ "
(~~" #
)~~# $
;~~$ %
result 
= 
await 
_client &
.& '$
AcceptFriendRequestAsync' ?
(? @
receiverUserId@ N
,N O
senderUserIdP \
)\ ]
;] ^
}
ÄÄ 
catch
ÅÅ 
(
ÅÅ '
EndpointNotFoundException
ÅÅ ,
ex
ÅÅ- /
)
ÅÅ/ 0
{
ÇÇ 
_faultHandler
ÉÉ 
.
ÉÉ !
ReportFaultAndClose
ÉÉ 1
(
ÉÉ1 2
ex
ÉÉ2 4
,
ÉÉ4 5(
AcceptRequestOperationName
ÉÉ6 P
,
ÉÉP Q
_client
ÉÉR Y
)
ÉÉY Z
;
ÉÉZ [
}
ÑÑ 
catch
ÖÖ 
(
ÖÖ 
TimeoutException
ÖÖ #
ex
ÖÖ$ &
)
ÖÖ& '
{
ÜÜ 
_faultHandler
áá 
.
áá !
ReportFaultAndClose
áá 1
(
áá1 2
ex
áá2 4
,
áá4 5(
AcceptRequestOperationName
áá6 P
,
ááP Q
_client
ááR Y
)
ááY Z
;
ááZ [
}
àà 
catch
ââ 
(
ââ $
CommunicationException
ââ )
ex
ââ* ,
)
ââ, -
{
ää 
_faultHandler
ãã 
.
ãã !
ReportFaultAndClose
ãã 1
(
ãã1 2
ex
ãã2 4
,
ãã4 5(
AcceptRequestOperationName
ãã6 P
,
ããP Q
_client
ããR Y
)
ããY Z
;
ããZ [
}
åå 
return
éé 
result
éé 
;
éé 
}
èè 	
public
ëë 
async
ëë 
Task
ëë 
<
ëë 
OperationResult
ëë )
>
ëë) *&
RejectFriendRequestAsync
ëë+ C
(
ëëC D
int
ëëD G
receiverUserId
ëëH V
,
ëëV W
int
ëëX [
senderUserId
ëë\ h
)
ëëh i
{
íí 	
OperationResult
ìì 
result
ìì "
=
ìì# $
null
ìì% )
;
ìì) *
try
ïï 
{
ññ  
EnsureClientIsOpen
óó "
(
óó" #
)
óó# $
;
óó$ %
result
òò 
=
òò 
await
òò 
_client
òò &
.
òò& '&
RejectFriendRequestAsync
òò' ?
(
òò? @
receiverUserId
òò@ N
,
òòN O
senderUserId
òòP \
)
òò\ ]
;
òò] ^
}
ôô 
catch
öö 
(
öö '
EndpointNotFoundException
öö ,
ex
öö- /
)
öö/ 0
{
õõ 
_faultHandler
úú 
.
úú !
ReportFaultAndClose
úú 1
(
úú1 2
ex
úú2 4
,
úú4 5(
RejectRequestOperationName
úú6 P
,
úúP Q
_client
úúR Y
)
úúY Z
;
úúZ [
}
ùù 
catch
ûû 
(
ûû 
TimeoutException
ûû #
ex
ûû$ &
)
ûû& '
{
üü 
_faultHandler
†† 
.
†† !
ReportFaultAndClose
†† 1
(
††1 2
ex
††2 4
,
††4 5(
RejectRequestOperationName
††6 P
,
††P Q
_client
††R Y
)
††Y Z
;
††Z [
}
°° 
catch
¢¢ 
(
¢¢ $
CommunicationException
¢¢ )
ex
¢¢* ,
)
¢¢, -
{
££ 
_faultHandler
§§ 
.
§§ !
ReportFaultAndClose
§§ 1
(
§§1 2
ex
§§2 4
,
§§4 5(
RejectRequestOperationName
§§6 P
,
§§P Q
_client
§§R Y
)
§§Y Z
;
§§Z [
}
•• 
return
ßß 
result
ßß 
;
ßß 
}
®® 	
public
™™ 
async
™™ 
Task
™™ 
<
™™ 
OperationResult
™™ )
>
™™) *&
CancelFriendRequestAsync
™™+ C
(
™™C D
int
™™D G
senderUserId
™™H T
,
™™T U
int
™™V Y
receiverUserId
™™Z h
)
™™h i
{
´´ 	
OperationResult
¨¨ 
result
¨¨ "
=
¨¨# $
null
¨¨% )
;
¨¨) *
try
ÆÆ 
{
ØØ  
EnsureClientIsOpen
∞∞ "
(
∞∞" #
)
∞∞# $
;
∞∞$ %
result
±± 
=
±± 
await
±± 
_client
±± &
.
±±& '&
CancelFriendRequestAsync
±±' ?
(
±±? @
senderUserId
±±@ L
,
±±L M
receiverUserId
±±N \
)
±±\ ]
;
±±] ^
}
≤≤ 
catch
≥≥ 
(
≥≥ '
EndpointNotFoundException
≥≥ ,
ex
≥≥- /
)
≥≥/ 0
{
¥¥ 
_faultHandler
µµ 
.
µµ !
ReportFaultAndClose
µµ 1
(
µµ1 2
ex
µµ2 4
,
µµ4 5(
CancelRequestOperationName
µµ6 P
,
µµP Q
_client
µµR Y
)
µµY Z
;
µµZ [
}
∂∂ 
catch
∑∑ 
(
∑∑ 
TimeoutException
∑∑ #
ex
∑∑$ &
)
∑∑& '
{
∏∏ 
_faultHandler
ππ 
.
ππ !
ReportFaultAndClose
ππ 1
(
ππ1 2
ex
ππ2 4
,
ππ4 5(
CancelRequestOperationName
ππ6 P
,
ππP Q
_client
ππR Y
)
ππY Z
;
ππZ [
}
∫∫ 
catch
ªª 
(
ªª $
CommunicationException
ªª )
ex
ªª* ,
)
ªª, -
{
ºº 
_faultHandler
ΩΩ 
.
ΩΩ !
ReportFaultAndClose
ΩΩ 1
(
ΩΩ1 2
ex
ΩΩ2 4
,
ΩΩ4 5(
CancelRequestOperationName
ΩΩ6 P
,
ΩΩP Q
_client
ΩΩR Y
)
ΩΩY Z
;
ΩΩZ [
}
ææ 
return
¿¿ 
result
¿¿ 
;
¿¿ 
}
¡¡ 	
public
√√ 
void
√√ 
Dispose
√√ 
(
√√ 
)
√√ 
{
ƒƒ 	
Dispose
≈≈ 
(
≈≈ 
true
≈≈ 
)
≈≈ 
;
≈≈ 
GC
∆∆ 
.
∆∆ 
SuppressFinalize
∆∆ 
(
∆∆  
this
∆∆  $
)
∆∆$ %
;
∆∆% &
}
«« 	
private
…… 
void
…… 
InitializeClient
…… %
(
……% &
)
……& '
{
   	
_client
ÀÀ 
=
ÀÀ 
new
ÀÀ )
FriendsRequestServiceClient
ÀÀ 5
(
ÀÀ5 6
)
ÀÀ6 7
;
ÀÀ7 8
}
ÃÃ 	
private
ŒŒ 
void
ŒŒ  
EnsureClientIsOpen
ŒŒ '
(
ŒŒ' (
)
ŒŒ( )
{
œœ 	
bool
––  
shouldReinitialize
–– #
=
––$ %
_client
––& -
==
––. 0
null
––1 5
||
––6 8
_client
——& -
.
——- .
State
——. 3
==
——4 6 
CommunicationState
——7 I
.
——I J
Faulted
——J Q
||
——R T
_client
““& -
.
““- .
State
““. 3
==
““4 6 
CommunicationState
““7 I
.
““I J
Closed
““J P
;
““P Q
if
‘‘ 
(
‘‘  
shouldReinitialize
‘‘ "
)
‘‘" #
{
’’ 
InitializeClient
÷÷  
(
÷÷  !
)
÷÷! "
;
÷÷" #
}
◊◊ 
}
ÿÿ 	
private
⁄⁄ 
void
⁄⁄ 
Dispose
⁄⁄ 
(
⁄⁄ 
bool
⁄⁄ !
isDisposing
⁄⁄" -
)
⁄⁄- .
{
€€ 	
if
‹‹ 
(
‹‹ 
isDisposing
‹‹ 
&&
‹‹ 
_client
‹‹ &
!=
‹‹' )
null
‹‹* .
)
‹‹. /
{
›› 
GameChannelCloser
ﬁﬁ !
.
ﬁﬁ! "
CloseChannel
ﬁﬁ" .
(
ﬁﬁ. /
_client
ﬁﬁ/ 6
,
ﬁﬁ6 7
_logger
ﬁﬁ8 ?
)
ﬁﬁ? @
;
ﬁﬁ@ A
_client
ﬂﬂ 
=
ﬂﬂ 
null
ﬂﬂ 
;
ﬂﬂ 
}
‡‡ 
}
·· 	
private
„„ 
void
„„ "
RaiseConnectionError
„„ )
(
„„) *%
AuthenticationErrorType
„„* A
	errorType
„„B K
)
„„K L
{
‰‰ 	%
ConnectionErrorOccurred
ÂÂ #
?
ÂÂ# $
.
ÂÂ$ %
Invoke
ÂÂ% +
(
ÂÂ+ ,
	errorType
ÂÂ, 5
)
ÂÂ5 6
;
ÂÂ6 7
}
ÊÊ 	
}
ÁÁ 
}ËË û
iC:\Users\oscar\source\repos\TrickTakingMissions\Client\Model\Services\Friendship\IFriendsRequestClient.cs
	namespace 	
Model
 
. 
Services 
{ 
public 

	interface !
IFriendsRequestClient *
:+ ,
IDisposable- 8
{ 
event 
Action 
< #
AuthenticationErrorType ,
>, -#
ConnectionErrorOccurred. E
;E F
Task 
< 
IList 
< 
FriendRequest  
>  !
>! "0
$GetPendingFriendRequestByUserIdAsync# G
(G H
intH K
userIdL R
)R S
;S T
Task 
< 
IList 
< 
FriendRequest  
>  !
>! "-
!GetSentFriendRequestByUserIdAsync# D
(D E
intE H
userIdI O
)O P
;P Q
Task 
< 
OperationResult 
> "
SendFriendRequestAsync 4
(4 5
int5 8
senderUserId9 E
,E F
stringG M
targetUserNameN \
)\ ]
;] ^
Task 
< 
OperationResult 
> $
AcceptFriendRequestAsync 6
(6 7
int7 :
receiverUserId; I
,I J
intK N
senderUserIdO [
)[ \
;\ ]
Task 
< 
OperationResult 
> $
RejectFriendRequestAsync 6
(6 7
int7 :
receiverUserId; I
,I J
intK N
senderUserIdO [
)[ \
;\ ]
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
} 
} Å¶
dC:\Users\oscar\source\repos\TrickTakingMissions\Client\Model\Services\Friendship\FriendshipClient.cs
	namespace 	
Model
 
. 
Services 
{		 
[ 
CallbackBehavior 
( 
ConcurrencyMode %
=& '
ConcurrencyMode( 7
.7 8
Multiple8 @
,@ A%
UseSynchronizationContextB [
=\ ]
false^ c
)c d
]d e
public 

sealed 
class 
FriendshipClient (
:) *
IFriendshipClient+ <
,< =&
IFriendshipServiceCallback> X
{ 
private 
const 
string "
SubscribeOperationName 3
=4 5
$str6 R
;R S
private 
const 
string $
UnsubscribeOperationName 5
=6 7
$str8 V
;V W
private 
const 
string #
GetFriendsOperationName 4
=5 6
$str7 T
;T U
private 
const 
string %
RemoveFriendOperationName 6
=7 8
$str9 L
;L M
private 
const 
string $
BlockPlayerOperationName 5
=6 7
$str8 J
;J K
private 
const 
string &
UnblockPlayerOperationName 7
=8 9
$str: N
;N O
private 
const 
string '
SendInvitationOperationName 8
=9 :
$str; T
;T U
private 
readonly 
ILoggerService '
_logger( /
;/ 0
private 
readonly 
WcfFaultHandler (
_faultHandler) 6
;6 7
private #
FriendshipServiceClient '
_client( /
;/ 0
public 
FriendshipClient 
(  
ILoggerService  .
logger/ 5
)5 6
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
;O P
_faultHandler 
= 
new 
WcfFaultHandler  /
(/ 0
_logger0 7
,7 8 
RaiseConnectionError9 M
)M N
;N O
InitializeClient   
(   
)   
;   
}!! 	
public## 
event## 
Action## 
<## 
FriendRequest## )
>##) *!
FriendRequestReceived##+ @
;##@ A
public%% 
event%% 
Action%% 
<%% 
int%% 
,%%  
bool%%! %
>%%% &
FriendStatusChanged%%' :
;%%: ;
public'' 
event'' 
Action'' 
<'' 
int'' 
>''  
FriendRemoved''! .
;''. /
public)) 
event)) 
Action)) 
<)) 
GameInvitation)) *
>))* +"
GameInvitationReceived)), B
;))B C
public++ 
event++ 
Action++ 
<++ #
AuthenticationErrorType++ 3
>++3 4#
ConnectionErrorOccurred++5 L
;++L M
public-- 
async-- 
Task-- &
SubscribeSocialEventsAsync-- 4
(--4 5
int--5 8
userId--9 ?
)--? @
{.. 	
try// 
{00 
EnsureClientIsOpen11 "
(11" #
)11# $
;11$ %
await22 
_client22 
.22 &
SubscribeSocialEventsAsync22 8
(228 9
userId229 ?
)22? @
;22@ A
}33 
catch44 
(44 %
EndpointNotFoundException44 ,
ex44- /
)44/ 0
{55 
_faultHandler66 
.66 
ReportFaultAndClose66 1
(661 2
ex662 4
,664 5"
SubscribeOperationName666 L
,66L M
_client66N U
)66U V
;66V W
}77 
catch88 
(88 
TimeoutException88 #
ex88$ &
)88& '
{99 
_faultHandler:: 
.:: 
ReportFaultAndClose:: 1
(::1 2
ex::2 4
,::4 5"
SubscribeOperationName::6 L
,::L M
_client::N U
)::U V
;::V W
};; 
catch<< 
(<< "
CommunicationException<< )
ex<<* ,
)<<, -
{== 
_faultHandler>> 
.>> 
ReportFaultAndClose>> 1
(>>1 2
ex>>2 4
,>>4 5"
SubscribeOperationName>>6 L
,>>L M
_client>>N U
)>>U V
;>>V W
}?? 
}@@ 	
publicBB 
asyncBB 
TaskBB (
UnsubscribeSocialEventsAsyncBB 6
(BB6 7
intBB7 :
userIdBB; A
)BBA B
{CC 	
tryDD 
{EE 
EnsureClientIsOpenFF "
(FF" #
)FF# $
;FF$ %
awaitGG 
_clientGG 
.GG (
UnsubscribeSocialEventsAsyncGG :
(GG: ;
userIdGG; A
)GGA B
;GGB C
}HH 
catchII 
(II %
EndpointNotFoundExceptionII ,
exII- /
)II/ 0
{JJ 
_faultHandlerKK 
.KK 
ReportFaultAndCloseKK 1
(KK1 2
exKK2 4
,KK4 5$
UnsubscribeOperationNameKK6 N
,KKN O
_clientKKP W
)KKW X
;KKX Y
}LL 
catchMM 
(MM 
TimeoutExceptionMM #
exMM$ &
)MM& '
{NN 
_faultHandlerOO 
.OO 
ReportFaultAndCloseOO 1
(OO1 2
exOO2 4
,OO4 5$
UnsubscribeOperationNameOO6 N
,OON O
_clientOOP W
)OOW X
;OOX Y
}PP 
catchQQ 
(QQ "
CommunicationExceptionQQ )
exQQ* ,
)QQ, -
{RR 
_faultHandlerSS 
.SS 
ReportFaultAndCloseSS 1
(SS1 2
exSS2 4
,SS4 5$
UnsubscribeOperationNameSS6 N
,SSN O
_clientSSP W
)SSW X
;SSX Y
}TT 
}UU 	
publicWW 
asyncWW 
TaskWW 
<WW 
IListWW 
<WW  
FriendWW  &
>WW& '
>WW' ('
GetFriendsListByUserIdAsyncWW) D
(WWD E
intWWE H
userIdWWI O
)WWO P
{XX 	
IListYY 
<YY 
FriendYY 
>YY 
friendsListYY %
=YY& '
newYY( +
ListYY, 0
<YY0 1
FriendYY1 7
>YY7 8
(YY8 9
)YY9 :
;YY: ;
try[[ 
{\\ 
EnsureClientIsOpen]] "
(]]" #
)]]# $
;]]$ %
Friend^^ 
[^^ 
]^^ 
serverFriends^^ &
=^^' (
await^^) .
_client^^/ 6
.^^6 7'
GetFriendsListByUserIdAsync^^7 R
(^^R S
userId^^S Y
)^^Y Z
;^^Z [
if`` 
(`` 
serverFriends`` !
!=``" $
null``% )
)``) *
{aa 
friendsListbb 
=bb  !
newbb" %
Listbb& *
<bb* +
Friendbb+ 1
>bb1 2
(bb2 3
serverFriendsbb3 @
)bb@ A
;bbA B
}cc 
}dd 
catchee 
(ee %
EndpointNotFoundExceptionee ,
exee- /
)ee/ 0
{ff 
_faultHandlergg 
.gg 
ReportFaultAndClosegg 1
(gg1 2
exgg2 4
,gg4 5#
GetFriendsOperationNamegg6 M
,ggM N
_clientggO V
)ggV W
;ggW X
}hh 
catchii 
(ii 
TimeoutExceptionii #
exii$ &
)ii& '
{jj 
_faultHandlerkk 
.kk 
ReportFaultAndClosekk 1
(kk1 2
exkk2 4
,kk4 5#
GetFriendsOperationNamekk6 M
,kkM N
_clientkkO V
)kkV W
;kkW X
}ll 
catchmm 
(mm "
CommunicationExceptionmm )
exmm* ,
)mm, -
{nn 
_faultHandleroo 
.oo 
ReportFaultAndCloseoo 1
(oo1 2
exoo2 4
,oo4 5#
GetFriendsOperationNameoo6 M
,ooM N
_clientooO V
)ooV W
;ooW X
}pp 
returnrr 
friendsListrr 
;rr 
}ss 	
publicuu 
asyncuu 
Taskuu 
<uu 
OperationResultuu )
>uu) *
RemoveFriendAsyncuu+ <
(uu< =
intuu= @
userIduuA G
,uuG H
intuuI L
friendUserIduuM Y
)uuY Z
{vv 	
OperationResultww 
resultww "
=ww# $
nullww% )
;ww) *
tryyy 
{zz 
EnsureClientIsOpen{{ "
({{" #
){{# $
;{{$ %
result|| 
=|| 
await|| 
_client|| &
.||& '
RemoveFriendAsync||' 8
(||8 9
userId||9 ?
,||? @
friendUserId||A M
)||M N
;||N O
}}} 
catch~~ 
(~~ %
EndpointNotFoundException~~ ,
ex~~- /
)~~/ 0
{ 
_faultHandler
ÄÄ 
.
ÄÄ !
ReportFaultAndClose
ÄÄ 1
(
ÄÄ1 2
ex
ÄÄ2 4
,
ÄÄ4 5'
RemoveFriendOperationName
ÄÄ6 O
,
ÄÄO P
_client
ÄÄQ X
)
ÄÄX Y
;
ÄÄY Z
}
ÅÅ 
catch
ÇÇ 
(
ÇÇ 
TimeoutException
ÇÇ #
ex
ÇÇ$ &
)
ÇÇ& '
{
ÉÉ 
_faultHandler
ÑÑ 
.
ÑÑ !
ReportFaultAndClose
ÑÑ 1
(
ÑÑ1 2
ex
ÑÑ2 4
,
ÑÑ4 5'
RemoveFriendOperationName
ÑÑ6 O
,
ÑÑO P
_client
ÑÑQ X
)
ÑÑX Y
;
ÑÑY Z
}
ÖÖ 
catch
ÜÜ 
(
ÜÜ $
CommunicationException
ÜÜ )
ex
ÜÜ* ,
)
ÜÜ, -
{
áá 
_faultHandler
àà 
.
àà !
ReportFaultAndClose
àà 1
(
àà1 2
ex
àà2 4
,
àà4 5'
RemoveFriendOperationName
àà6 O
,
ààO P
_client
ààQ X
)
ààX Y
;
ààY Z
}
ââ 
return
ãã 
result
ãã 
;
ãã 
}
åå 	
public
éé 
async
éé 
Task
éé 
<
éé 
OperationResult
éé )
>
éé) *
BlockPlayerAsync
éé+ ;
(
éé; <
int
éé< ?
blockerUserId
éé@ M
,
ééM N
int
ééO R
targetUserId
ééS _
)
éé_ `
{
èè 	
OperationResult
êê 
result
êê "
=
êê# $
null
êê% )
;
êê) *
try
íí 
{
ìì  
EnsureClientIsOpen
îî "
(
îî" #
)
îî# $
;
îî$ %
result
ïï 
=
ïï 
await
ïï 
_client
ïï &
.
ïï& '
BlockPlayerAsync
ïï' 7
(
ïï7 8
blockerUserId
ïï8 E
,
ïïE F
targetUserId
ïïG S
)
ïïS T
;
ïïT U
}
ññ 
catch
óó 
(
óó '
EndpointNotFoundException
óó ,
ex
óó- /
)
óó/ 0
{
òò 
_faultHandler
ôô 
.
ôô !
ReportFaultAndClose
ôô 1
(
ôô1 2
ex
ôô2 4
,
ôô4 5&
BlockPlayerOperationName
ôô6 N
,
ôôN O
_client
ôôP W
)
ôôW X
;
ôôX Y
}
öö 
catch
õõ 
(
õõ 
TimeoutException
õõ #
ex
õõ$ &
)
õõ& '
{
úú 
_faultHandler
ùù 
.
ùù !
ReportFaultAndClose
ùù 1
(
ùù1 2
ex
ùù2 4
,
ùù4 5&
BlockPlayerOperationName
ùù6 N
,
ùùN O
_client
ùùP W
)
ùùW X
;
ùùX Y
}
ûû 
catch
üü 
(
üü $
CommunicationException
üü )
ex
üü* ,
)
üü, -
{
†† 
_faultHandler
°° 
.
°° !
ReportFaultAndClose
°° 1
(
°°1 2
ex
°°2 4
,
°°4 5&
BlockPlayerOperationName
°°6 N
,
°°N O
_client
°°P W
)
°°W X
;
°°X Y
}
¢¢ 
return
§§ 
result
§§ 
;
§§ 
}
•• 	
public
ßß 
async
ßß 
Task
ßß 
<
ßß 
OperationResult
ßß )
>
ßß) * 
UnblockPlayerAsync
ßß+ =
(
ßß= >
int
ßß> A
blockerUserId
ßßB O
,
ßßO P
int
ßßQ T
targetUserId
ßßU a
)
ßßa b
{
®® 	
OperationResult
©© 
result
©© "
=
©©# $
null
©©% )
;
©©) *
try
´´ 
{
¨¨  
EnsureClientIsOpen
≠≠ "
(
≠≠" #
)
≠≠# $
;
≠≠$ %
result
ÆÆ 
=
ÆÆ 
await
ÆÆ 
_client
ÆÆ &
.
ÆÆ& ' 
UnblockPlayerAsync
ÆÆ' 9
(
ÆÆ9 :
blockerUserId
ÆÆ: G
,
ÆÆG H
targetUserId
ÆÆI U
)
ÆÆU V
;
ÆÆV W
}
ØØ 
catch
∞∞ 
(
∞∞ '
EndpointNotFoundException
∞∞ ,
ex
∞∞- /
)
∞∞/ 0
{
±± 
_faultHandler
≤≤ 
.
≤≤ !
ReportFaultAndClose
≤≤ 1
(
≤≤1 2
ex
≤≤2 4
,
≤≤4 5(
UnblockPlayerOperationName
≤≤6 P
,
≤≤P Q
_client
≤≤R Y
)
≤≤Y Z
;
≤≤Z [
}
≥≥ 
catch
¥¥ 
(
¥¥ 
TimeoutException
¥¥ #
ex
¥¥$ &
)
¥¥& '
{
µµ 
_faultHandler
∂∂ 
.
∂∂ !
ReportFaultAndClose
∂∂ 1
(
∂∂1 2
ex
∂∂2 4
,
∂∂4 5(
UnblockPlayerOperationName
∂∂6 P
,
∂∂P Q
_client
∂∂R Y
)
∂∂Y Z
;
∂∂Z [
}
∑∑ 
catch
∏∏ 
(
∏∏ $
CommunicationException
∏∏ )
ex
∏∏* ,
)
∏∏, -
{
ππ 
_faultHandler
∫∫ 
.
∫∫ !
ReportFaultAndClose
∫∫ 1
(
∫∫1 2
ex
∫∫2 4
,
∫∫4 5(
UnblockPlayerOperationName
∫∫6 P
,
∫∫P Q
_client
∫∫R Y
)
∫∫Y Z
;
∫∫Z [
}
ªª 
return
ΩΩ 
result
ΩΩ 
;
ΩΩ 
}
ææ 	
public
¿¿ 
async
¿¿ 
Task
¿¿ %
SendGameInvitationAsync
¿¿ 1
(
¿¿1 2
GameInvitation
¿¿2 @
gameInvitation
¿¿A O
)
¿¿O P
{
¡¡ 	
try
¬¬ 
{
√√  
EnsureClientIsOpen
ƒƒ "
(
ƒƒ" #
)
ƒƒ# $
;
ƒƒ$ %
await
≈≈ 
_client
≈≈ 
.
≈≈ %
SendGameInvitationAsync
≈≈ 5
(
≈≈5 6
gameInvitation
≈≈6 D
)
≈≈D E
;
≈≈E F
}
∆∆ 
catch
«« 
(
«« '
EndpointNotFoundException
«« ,
ex
««- /
)
««/ 0
{
»» 
_faultHandler
…… 
.
…… !
ReportFaultAndClose
…… 1
(
……1 2
ex
……2 4
,
……4 5)
SendInvitationOperationName
……6 Q
,
……Q R
_client
……S Z
)
……Z [
;
……[ \
}
   
catch
ÀÀ 
(
ÀÀ 
TimeoutException
ÀÀ #
ex
ÀÀ$ &
)
ÀÀ& '
{
ÃÃ 
_faultHandler
ÕÕ 
.
ÕÕ !
ReportFaultAndClose
ÕÕ 1
(
ÕÕ1 2
ex
ÕÕ2 4
,
ÕÕ4 5)
SendInvitationOperationName
ÕÕ6 Q
,
ÕÕQ R
_client
ÕÕS Z
)
ÕÕZ [
;
ÕÕ[ \
}
ŒŒ 
catch
œœ 
(
œœ $
CommunicationException
œœ )
ex
œœ* ,
)
œœ, -
{
–– 
_faultHandler
—— 
.
—— !
ReportFaultAndClose
—— 1
(
——1 2
ex
——2 4
,
——4 5)
SendInvitationOperationName
——6 Q
,
——Q R
_client
——S Z
)
——Z [
;
——[ \
}
““ 
}
”” 	
public
’’ 
void
’’ $
OnReceiveFriendRequest
’’ *
(
’’* +
FriendRequest
’’+ 8
friendRequest
’’9 F
)
’’F G
{
÷÷ 	#
FriendRequestReceived
◊◊ !
?
◊◊! "
.
◊◊" #
Invoke
◊◊# )
(
◊◊) *
friendRequest
◊◊* 7
)
◊◊7 8
;
◊◊8 9
}
ÿÿ 	
public
⁄⁄ 
void
⁄⁄ #
OnFriendStatusChanged
⁄⁄ )
(
⁄⁄) *
int
⁄⁄* -
friendUserId
⁄⁄. :
,
⁄⁄: ;
bool
⁄⁄< @
isOnline
⁄⁄A I
)
⁄⁄I J
{
€€ 	!
FriendStatusChanged
‹‹ 
?
‹‹  
.
‹‹  !
Invoke
‹‹! '
(
‹‹' (
friendUserId
‹‹( 4
,
‹‹4 5
isOnline
‹‹6 >
)
‹‹> ?
;
‹‹? @
}
›› 	
public
ﬂﬂ 
void
ﬂﬂ 
OnFriendRemoved
ﬂﬂ #
(
ﬂﬂ# $
int
ﬂﬂ$ '
friendUserId
ﬂﬂ( 4
)
ﬂﬂ4 5
{
‡‡ 	
FriendRemoved
·· 
?
·· 
.
·· 
Invoke
·· !
(
··! "
friendUserId
··" .
)
··. /
;
··/ 0
}
‚‚ 	
public
‰‰ 
void
‰‰ %
OnReceiveGameInvitation
‰‰ +
(
‰‰+ ,
GameInvitation
‰‰, :
gameInvitation
‰‰; I
)
‰‰I J
{
ÂÂ 	$
GameInvitationReceived
ÊÊ "
?
ÊÊ" #
.
ÊÊ# $
Invoke
ÊÊ$ *
(
ÊÊ* +
gameInvitation
ÊÊ+ 9
)
ÊÊ9 :
;
ÊÊ: ;
}
ÁÁ 	
public
ÈÈ 
void
ÈÈ 
Dispose
ÈÈ 
(
ÈÈ 
)
ÈÈ 
{
ÍÍ 	
Dispose
ÎÎ 
(
ÎÎ 
true
ÎÎ 
)
ÎÎ 
;
ÎÎ 
GC
ÏÏ 
.
ÏÏ 
SuppressFinalize
ÏÏ 
(
ÏÏ  
this
ÏÏ  $
)
ÏÏ$ %
;
ÏÏ% &
}
ÌÌ 	
private
ÔÔ 
void
ÔÔ 
InitializeClient
ÔÔ %
(
ÔÔ% &
)
ÔÔ& '
{
 	
InstanceContext
ÒÒ 
instanceContext
ÒÒ +
=
ÒÒ, -
new
ÒÒ. 1
InstanceContext
ÒÒ2 A
(
ÒÒA B
this
ÒÒB F
)
ÒÒF G
;
ÒÒG H
_client
ÚÚ 
=
ÚÚ 
new
ÚÚ %
FriendshipServiceClient
ÚÚ 1
(
ÚÚ1 2
instanceContext
ÚÚ2 A
)
ÚÚA B
;
ÚÚB C
}
ÛÛ 	
private
ıı 
void
ıı  
EnsureClientIsOpen
ıı '
(
ıı' (
)
ıı( )
{
ˆˆ 	
bool
˜˜  
shouldReinitialize
˜˜ #
=
˜˜$ %
_client
˜˜& -
==
˜˜. 0
null
˜˜1 5
||
˜˜6 8
_client
˜˜9 @
.
˜˜@ A
State
˜˜A F
==
˜˜G I 
CommunicationState
˜˜J \
.
˜˜\ ]
Faulted
˜˜] d
||
¯¯ 
_client
¯¯ 
.
¯¯ 
State
¯¯  
==
¯¯! # 
CommunicationState
¯¯$ 6
.
¯¯6 7
Closed
¯¯7 =
;
¯¯= >
if
˙˙ 
(
˙˙  
shouldReinitialize
˙˙ "
)
˙˙" #
{
˚˚ 
InitializeClient
¸¸  
(
¸¸  !
)
¸¸! "
;
¸¸" #
}
˝˝ 
}
˛˛ 	
private
ÄÄ 
void
ÄÄ 
Dispose
ÄÄ 
(
ÄÄ 
bool
ÄÄ !
isDisposing
ÄÄ" -
)
ÄÄ- .
{
ÅÅ 	
if
ÇÇ 
(
ÇÇ 
isDisposing
ÇÇ 
&&
ÇÇ 
_client
ÇÇ &
!=
ÇÇ' )
null
ÇÇ* .
)
ÇÇ. /
{
ÉÉ 
GameChannelCloser
ÑÑ !
.
ÑÑ! "
CloseChannel
ÑÑ" .
(
ÑÑ. /
_client
ÑÑ/ 6
,
ÑÑ6 7
_logger
ÑÑ8 ?
)
ÑÑ? @
;
ÑÑ@ A
_client
ÖÖ 
=
ÖÖ 
null
ÖÖ 
;
ÖÖ 
}
ÜÜ 
}
áá 	
private
ââ 
void
ââ "
RaiseConnectionError
ââ )
(
ââ) *%
AuthenticationErrorType
ââ* A
	errorType
ââB K
)
ââK L
{
ää 	%
ConnectionErrorOccurred
ãã #
?
ãã# $
.
ãã$ %
Invoke
ãã% +
(
ãã+ ,
	errorType
ãã, 5
)
ãã5 6
;
ãã6 7
}
åå 	
}
çç 
}éé Â
eC:\Users\oscar\source\repos\TrickTakingMissions\Client\Model\Services\Friendship\IFriendshipClient.cs
	namespace 	
Model
 
. 
Services 
{ 
public 

	interface 
IFriendshipClient &
:' (
IDisposable) 4
{ 
event 
Action 
< 
FriendRequest "
>" #!
FriendRequestReceived$ 9
;9 :
event 
Action 
< 
int 
, 
bool 
> 
FriendStatusChanged  3
;3 4
event 
Action 
< 
int 
> 
FriendRemoved '
;' (
event 
Action 
< 
GameInvitation #
># $"
GameInvitationReceived% ;
;; <
event 
Action 
< #
AuthenticationErrorType ,
>, -#
ConnectionErrorOccurred. E
;E F
Task &
SubscribeSocialEventsAsync '
(' (
int( +
userId, 2
)2 3
;3 4
Task (
UnsubscribeSocialEventsAsync )
() *
int* -
userId. 4
)4 5
;5 6
Task 
< 
IList 
< 
Friend 
> 
> '
GetFriendsListByUserIdAsync 7
(7 8
int8 ;
userId< B
)B C
;C D
Task 
< 
OperationResult 
> 
RemoveFriendAsync /
(/ 0
int0 3
userId4 :
,: ;
int< ?
friendUserId@ L
)L M
;M N
Task 
< 
OperationResult 
> 
BlockPlayerAsync .
(. /
int/ 2
blockerUserId3 @
,@ A
intB E
targetUserIdF R
)R S
;S T
Task!! 
<!! 
OperationResult!! 
>!! 
UnblockPlayerAsync!! 0
(!!0 1
int!!1 4
blockerUserId!!5 B
,!!B C
int!!D G
targetUserId!!H T
)!!T U
;!!U V
Task## #
SendGameInvitationAsync## $
(##$ %
GameInvitation##% 3
gameInvitation##4 B
)##B C
;##C D
}$$ 
}%% ˛D
eC:\Users\oscar\source\repos\TrickTakingMissions\Client\Model\Services\Account\AuthenticationClient.cs
	namespace 	
Model
 
. 
Services 
{ 
public 

enum #
AuthenticationErrorType '
{ 
ConnectionFailed 
, 
Timeout 
, 
CommunicationError 
} 
public   

sealed   
class    
AuthenticationClient   ,
:  - .
IUserLoginCallback  / A
,  A B
IDisposable  C N
{!! 
private"" 
const"" 
string"" %
DisposeCloseFaultTemplate"" 6
=""7 8
$str## r
;##r s
private$$ 
const$$ 
string$$ "
DisposeTimeoutTemplate$$ 3
=$$4 5
$str%% h
;%%h i
private&& 
const&& 
string&& "
SendLoginOperationName&& 3
=&&4 5
$str&&6 H
;&&H I
private(( 
readonly(( 
ILoggerService(( '
_logger((( /
;((/ 0
private)) 
readonly)) 
WcfFaultHandler)) (
_faultHandler))) 6
;))6 7
private** 
UserLoginClient** 
_client**  '
;**' (
public00  
AuthenticationClient00 #
(00# $
ILoggerService00$ 2
logger003 9
)009 :
{11 	
_logger22 
=22 
logger22 
??22 
throw22  %
new22& )!
ArgumentNullException22* ?
(22? @
nameof22@ F
(22F G
logger22G M
)22M N
)22N O
;22O P
_faultHandler33 
=33 
new33 
WcfFaultHandler33  /
(33/ 0
_logger330 7
,337 8 
RaiseConnectionError339 M
)33M N
;33N O
InitializeClient44 
(44 
)44 
;44 
}55 	
public:: 
event:: 
Action:: 
<:: 
bool::  
,::  !
string::" (
,::( )
User::* .
>::. /
LoginCompleted::0 >
;::> ?
public?? 
event?? 
Action?? 
<?? #
AuthenticationErrorType?? 3
>??3 4#
ConnectionErrorOccurred??5 L
;??L M
publicGG 
boolGG 
SendLoginRequestGG $
(GG$ %
stringGG% +
emailOrUsernameGG, ;
,GG; <
stringGG= C
passwordHashGGD P
)GGP Q
{HH 	
boolII 
isRequestSentII 
=II  
falseII! &
;II& '
tryKK 
{LL 
EnsureClientIsOpenMM "
(MM" #
)MM# $
;MM$ %
_clientNN 
.NN 
LoginNN 
(NN 
emailOrUsernameNN -
,NN- .
passwordHashNN/ ;
)NN; <
;NN< =
isRequestSentOO 
=OO 
trueOO  $
;OO$ %
}PP 
catchQQ 
(QQ %
EndpointNotFoundExceptionQQ ,
exQQ- /
)QQ/ 0
{RR 
_faultHandlerSS 
.SS 
ReportFaultSS )
(SS) *
exSS* ,
,SS, -"
SendLoginOperationNameSS. D
)SSD E
;SSE F
}TT 
catchUU 
(UU 
TimeoutExceptionUU #
exUU$ &
)UU& '
{VV 
_faultHandlerWW 
.WW 
ReportFaultWW )
(WW) *
exWW* ,
,WW, -"
SendLoginOperationNameWW. D
)WWD E
;WWE F
}XX 
catchYY 
(YY "
CommunicationExceptionYY )
exYY* ,
)YY, -
{ZZ 
_faultHandler[[ 
.[[ 
ReportFault[[ )
([[) *
ex[[* ,
,[[, -"
SendLoginOperationName[[. D
)[[D E
;[[E F
}\\ 
return^^ 
isRequestSent^^  
;^^  !
}__ 	
publicgg 
voidgg 
LoginResultgg 
(gg  
boolgg  $
successgg% ,
,gg, -
stringgg. 4
messagegg5 <
,gg< =
Usergg> B
userggC G
)ggG H
{hh 	
LoginCompletedii 
?ii 
.ii 
Invokeii "
(ii" #
successii# *
,ii* +
messageii, 3
,ii3 4
userii5 9
)ii9 :
;ii: ;
}jj 	
publicoo 
voidoo 
Disposeoo 
(oo 
)oo 
{pp 	
Disposeqq 
(qq 
trueqq 
)qq 
;qq 
GCrr 
.rr 
SuppressFinalizerr 
(rr  
thisrr  $
)rr$ %
;rr% &
}ss 	
privateuu 
voiduu 
InitializeClientuu %
(uu% &
)uu& '
{vv 	
InstanceContextww 
instanceContextww +
=ww, -
newww. 1
InstanceContextww2 A
(wwA B
thiswwB F
)wwF G
;wwG H
_clientxx 
=xx 
newxx 
UserLoginClientxx )
(xx) *
instanceContextxx* 9
)xx9 :
;xx: ;
}yy 	
private{{ 
void{{ 
EnsureClientIsOpen{{ '
({{' (
){{( )
{|| 	
if}} 
(}} 
_client}} 
==}} 
null}} 
||}}  "
_client}}# *
.}}* +
State}}+ 0
==}}1 3
CommunicationState}}4 F
.}}F G
Faulted}}G N
||~~ 
_client~~ 
.~~ 
State~~  
==~~! #
CommunicationState~~$ 6
.~~6 7
Closed~~7 =
)~~= >
{ 
InitializeClient
ÄÄ  
(
ÄÄ  !
)
ÄÄ! "
;
ÄÄ" #
}
ÅÅ 
}
ÇÇ 	
private
ÑÑ 
void
ÑÑ 
Dispose
ÑÑ 
(
ÑÑ 
bool
ÑÑ !
	disposing
ÑÑ" +
)
ÑÑ+ ,
{
ÖÖ 	
if
ÜÜ 
(
ÜÜ 
	disposing
ÜÜ 
&&
ÜÜ 
_client
ÜÜ $
!=
ÜÜ% '
null
ÜÜ( ,
)
ÜÜ, -
{
áá 
try
àà 
{
ââ 
if
ää 
(
ää 
_client
ää 
.
ää  
State
ää  %
!=
ää& ( 
CommunicationState
ää) ;
.
ää; <
Closed
ää< B
&&
ääC E
_client
ääF M
.
ääM N
State
ääN S
!=
ääT V 
CommunicationState
ääW i
.
ääi j
Faulted
ääj q
)
ääq r
{
ãã 
_client
åå 
.
åå  
Close
åå  %
(
åå% &
)
åå& '
;
åå' (
}
çç 
else
éé 
{
èè 
_client
êê 
.
êê  
Abort
êê  %
(
êê% &
)
êê& '
;
êê' (
}
ëë 
}
íí 
catch
ìì 
(
ìì $
CommunicationException
ìì -
ex
ìì. 0
)
ìì0 1
{
îî 
_logger
ïï 
.
ïï 
Warning
ïï #
(
ïï# $'
DisposeCloseFaultTemplate
ïï$ =
,
ïï= >
ex
ïï? A
.
ïïA B
GetType
ïïB I
(
ïïI J
)
ïïJ K
.
ïïK L
Name
ïïL P
)
ïïP Q
;
ïïQ R
_client
ññ 
.
ññ 
Abort
ññ !
(
ññ! "
)
ññ" #
;
ññ# $
}
óó 
catch
òò 
(
òò 
TimeoutException
òò '
ex
òò( *
)
òò* +
{
ôô 
_logger
öö 
.
öö 
Warning
öö #
(
öö# $$
DisposeTimeoutTemplate
öö$ :
,
öö: ;
ex
öö< >
.
öö> ?
GetType
öö? F
(
ööF G
)
ööG H
.
ööH I
Name
ööI M
)
ööM N
;
ööN O
_client
õõ 
.
õõ 
Abort
õõ !
(
õõ! "
)
õõ" #
;
õõ# $
}
úú 
finally
ùù 
{
ûû 
_client
üü 
=
üü 
null
üü "
;
üü" #
}
†† 
}
°° 
}
¢¢ 	
private
§§ 
void
§§ "
RaiseConnectionError
§§ )
(
§§) *%
AuthenticationErrorType
§§* A
	errorType
§§B K
)
§§K L
{
•• 	%
ConnectionErrorOccurred
¶¶ #
?
¶¶# $
.
¶¶$ %
Invoke
¶¶% +
(
¶¶+ ,
	errorType
¶¶, 5
)
¶¶5 6
;
¶¶6 7
}
ßß 	
}
®® 
}©© ó
iC:\Users\oscar\source\repos\TrickTakingMissions\Client\Model\Services\Account\IAccountManagementClient.cs
	namespace 	
Model
 
. 
Services 
{ 
public		 

sealed		 
class		 %
AccountRegistrationResult		 1
{

 
public 
bool 
	IsSuccess 
{ 
get  #
;# $
set% (
;( )
}* +
public 
int 
	ErrorCode 
{ 
get "
;" #
set$ '
;' (
}) *
public 
string 
Message 
{ 
get  #
;# $
set% (
;( )
}* +
} 
public 

	interface $
IAccountManagementClient -
:. /
IDisposable0 ;
{ 
event 
Action 
< #
AuthenticationErrorType ,
>, -#
ConnectionErrorOccurred. E
;E F
Task## 
<## %
AccountRegistrationResult## &
>##& '
RegisterUserAsync##( 9
(##9 :
string##: @
username##A I
,##I J
string##K Q
email##R W
,##W X
string##Y _
passwordHash##` l
)##l m
;##m n
}$$ 
}%% ìb
hC:\Users\oscar\source\repos\TrickTakingMissions\Client\Model\Services\Account\AccountManagementClient.cs
	namespace 	
Model
 
. 
Services 
{ 
[		 
DataContract		 
(		 
Name		 
=		 
$str		 '
,		' (
	Namespace

 
=

 
$str

 T
)

T U
]

U V
internal 
sealed 
class  
UserRegisterContract .
{ 
[ 	

DataMember	 
] 
public 
string 
Username 
{  
get! $
;$ %
set& )
;) *
}+ ,
[ 	

DataMember	 
] 
public 
string 
Email 
{ 
get !
;! "
set# &
;& '
}( )
[ 	

DataMember	 
] 
public 
string 
PasswordHash "
{# $
get% (
;( )
set* -
;- .
}/ 0
} 
[ 
DataContract 
( 
Name 
= 
$str *
,* +
	Namespace 
= 
$str T
)T U
]U V
internal 
class #
OperationResultContract *
{ 
[ 	

DataMember	 
] 
public 
bool 
	IsSuccess 
{ 
get  #
;# $
set% (
;( )
}* +
[ 	

DataMember	 
] 
public 
string 
Message 
{ 
get  #
;# $
set% (
;( )
}* +
[!! 	

DataMember!!	 
]!! 
public"" 
int"" 
	ErrorCode"" 
{"" 
get"" "
;""" #
set""$ '
;""' (
}"") *
}## 
[%% 
ServiceContract%% 
(%% 
Name%% 
=%% 
$str%% 7
,%%7 8
	Namespace%%9 B
=%%C D
$str%%E Z
)%%Z [
]%%[ \
internal&& 
	interface&& ,
 IAccountManagementServiceChannel&& 7
:&&8 9
IClientChannel&&: H
{'' 
[(( 	
OperationContract((	 
((( 
Action(( !
=((" #
$str(($ _
,((_ `
ReplyAction((a l
=((m n
$str	((o ≤
)
((≤ ≥
]
((≥ ¥#
OperationResultContract)) 
RegisterUser))  ,
()), - 
UserRegisterContract))- A
user))B F
)))F G
;))G H
[++ 	
OperationContract++	 
(++ 
Action++ !
=++" #
$str++$ _
,++_ `
ReplyAction++a l
=++m n
$str	++o ≤
)
++≤ ≥
]
++≥ ¥
Task,, 
<,, #
OperationResultContract,, $
>,,$ %
RegisterUserAsync,,& 7
(,,7 8 
UserRegisterContract,,8 L
user,,M Q
),,Q R
;,,R S
}-- 
public33 

sealed33 
class33 #
AccountManagementClient33 /
:330 1$
IAccountManagementClient332 J
{44 
private55 
const55 
string55 %
EndpointConfigurationName55 6
=557 8
$str559 b
;55b c
private66 
const66 
string66 "
DefaultEndpointAddress66 3
=664 5
$str666 i
;66i j
private77 
const77 
string77 '
FallbackEndpointLogTemplate77 8
=779 :
$str88 
;	88 Ä
private99 
const99 
string99 %
RegisterUserOperationName99 6
=997 8
$str999 L
;99L M
private;; 
readonly;; 
ILoggerService;; '
_logger;;( /
;;;/ 0
private<< 
readonly<< 
WcfFaultHandler<< (
_faultHandler<<) 6
;<<6 7
private== 
ChannelFactory== 
<== ,
 IAccountManagementServiceChannel== ?
>==? @
_channelFactory==A P
;==P Q
publicCC #
AccountManagementClientCC &
(CC& '
ILoggerServiceCC' 5
loggerCC6 <
)CC< =
{DD 	
_loggerEE 
=EE 
loggerEE 
??EE 
throwEE  %
newEE& )!
ArgumentNullExceptionEE* ?
(EE? @
nameofEE@ F
(EEF G
loggerEEG M
)EEM N
)EEN O
;EEO P
_faultHandlerFF 
=FF 
newFF 
WcfFaultHandlerFF  /
(FF/ 0
_loggerFF0 7
,FF7 8 
RaiseConnectionErrorFF9 M
)FFM N
;FFN O$
InitializeChannelFactoryGG $
(GG$ %
)GG% &
;GG& '
}HH 	
publicKK 
eventKK 
ActionKK 
<KK #
AuthenticationErrorTypeKK 3
>KK3 4#
ConnectionErrorOccurredKK5 L
;KKL M
publicNN 
asyncNN 
TaskNN 
<NN %
AccountRegistrationResultNN 3
>NN3 4
RegisterUserAsyncNN5 F
(NNF G
stringNNG M
usernameNNN V
,NNV W
stringNNX ^
emailNN_ d
,NNd e
stringNNf l
passwordHashNNm y
)NNy z
{OO 	%
AccountRegistrationResultPP %
registrationResultPP& 8
=PP9 :
nullPP; ?
;PP? @,
 IAccountManagementServiceChannelQQ ,
channelQQ- 4
=QQ5 6
nullQQ7 ;
;QQ; < 
UserRegisterContractSS  
payloadSS! (
=SS) *
newSS+ . 
UserRegisterContractSS/ C
{TT 
UsernameUU 
=UU 
usernameUU #
,UU# $
EmailVV 
=VV 
emailVV 
,VV 
PasswordHashWW 
=WW 
passwordHashWW +
}XX 
;XX 
tryZZ 
{[[ 
EnsureFactoryIsOpen\\ #
(\\# $
)\\$ %
;\\% &
channel]] 
=]] 
_channelFactory]] )
.]]) *
CreateChannel]]* 7
(]]7 8
)]]8 9
;]]9 :#
OperationResultContract__ '
response__( 0
=__1 2
await__3 8
channel__9 @
.__@ A
RegisterUserAsync__A R
(__R S
payload__S Z
)__Z [
;__[ \
ifaa 
(aa 
responseaa 
!=aa 
nullaa  $
)aa$ %
{bb 
registrationResultcc &
=cc' (
newcc) ,%
AccountRegistrationResultcc- F
{dd 
	IsSuccessee !
=ee" #
responseee$ ,
.ee, -
	IsSuccessee- 6
,ee6 7
	ErrorCodeff !
=ff" #
responseff$ ,
.ff, -
	ErrorCodeff- 6
,ff6 7
Messagegg 
=gg  !
responsegg" *
.gg* +
Messagegg+ 2
}hh 
;hh 
}ii 
GameChannelCloserkk !
.kk! "
CloseChannelkk" .
(kk. /
channelkk/ 6
,kk6 7
_loggerkk8 ?
)kk? @
;kk@ A
}ll 
catchmm 
(mm %
EndpointNotFoundExceptionmm ,
exmm- /
)mm/ 0
{nn 
_faultHandleroo 
.oo 
ReportFaultAndCloseoo 1
(oo1 2
exoo2 4
,oo4 5%
RegisterUserOperationNameoo6 O
,ooO P
channelooQ X
)ooX Y
;ooY Z
}pp 
catchqq 
(qq 
TimeoutExceptionqq #
exqq$ &
)qq& '
{rr 
_faultHandlerss 
.ss 
ReportFaultAndClosess 1
(ss1 2
exss2 4
,ss4 5%
RegisterUserOperationNamess6 O
,ssO P
channelssQ X
)ssX Y
;ssY Z
}tt 
catchuu 
(uu "
CommunicationExceptionuu )
exuu* ,
)uu, -
{vv 
_faultHandlerww 
.ww 
ReportFaultAndCloseww 1
(ww1 2
exww2 4
,ww4 5%
RegisterUserOperationNameww6 O
,wwO P
channelwwQ X
)wwX Y
;wwY Z
}xx 
returnzz 
registrationResultzz %
;zz% &
}{{ 	
public~~ 
void~~ 
Dispose~~ 
(~~ 
)~~ 
{ 	
Dispose
ÄÄ 
(
ÄÄ 
true
ÄÄ 
)
ÄÄ 
;
ÄÄ 
GC
ÅÅ 
.
ÅÅ 
SuppressFinalize
ÅÅ 
(
ÅÅ  
this
ÅÅ  $
)
ÅÅ$ %
;
ÅÅ% &
}
ÇÇ 	
private
ÑÑ 
void
ÑÑ &
InitializeChannelFactory
ÑÑ -
(
ÑÑ- .
)
ÑÑ. /
{
ÖÖ 	
try
ÜÜ 
{
áá 
_channelFactory
àà 
=
àà  !
new
àà" %
ChannelFactory
àà& 4
<
àà4 5.
 IAccountManagementServiceChannel
àà5 U
>
ààU V
(
ààV W'
EndpointConfigurationName
ààW p
)
ààp q
;
ààq r
}
ââ 
catch
ää 
(
ää 
	Exception
ää 
ex
ää 
)
ää  
{
ãã 
_logger
åå 
.
åå 
Warning
åå 
(
åå  )
FallbackEndpointLogTemplate
åå  ;
,
åå; <
ex
åå= ?
.
åå? @
GetType
åå@ G
(
ååG H
)
ååH I
.
ååI J
Name
ååJ N
)
ååN O
;
ååO P
NetTcpBinding
çç 
binding
çç %
=
çç& '
new
çç( +
NetTcpBinding
çç, 9
(
çç9 :
SecurityMode
çç: F
.
ççF G
	Transport
ççG P
)
ççP Q
;
ççQ R
EndpointAddress
éé 
endpointAddress
éé  /
=
éé0 1
new
éé2 5
EndpointAddress
éé6 E
(
ééE F$
DefaultEndpointAddress
ééF \
)
éé\ ]
;
éé] ^
_channelFactory
èè 
=
èè  !
new
èè" %
ChannelFactory
èè& 4
<
èè4 5.
 IAccountManagementServiceChannel
èè5 U
>
èèU V
(
èèV W
binding
èèW ^
,
èè^ _
endpointAddress
èè` o
)
èèo p
;
èèp q
}
êê 
}
ëë 	
private
ìì 
void
ìì !
EnsureFactoryIsOpen
ìì (
(
ìì( )
)
ìì) *
{
îî 	
if
ïï 
(
ïï 
_channelFactory
ïï 
==
ïï  "
null
ïï# '
||
ïï( *
_channelFactory
ññ 
.
ññ  
State
ññ  %
==
ññ& ( 
CommunicationState
ññ) ;
.
ññ; <
Faulted
ññ< C
||
ññD F
_channelFactory
óó 
.
óó  
State
óó  %
==
óó& ( 
CommunicationState
óó) ;
.
óó; <
Closed
óó< B
)
óóB C
{
òò &
InitializeChannelFactory
ôô (
(
ôô( )
)
ôô) *
;
ôô* +
}
öö 
}
õõ 	
private
ùù 
void
ùù 
Dispose
ùù 
(
ùù 
bool
ùù !
	disposing
ùù" +
)
ùù+ ,
{
ûû 	
if
üü 
(
üü 
	disposing
üü 
&&
üü 
_channelFactory
üü ,
!=
üü- /
null
üü0 4
)
üü4 5
{
†† 
GameChannelCloser
°° !
.
°°! "
CloseChannel
°°" .
(
°°. /
_channelFactory
°°/ >
,
°°> ?
_logger
°°@ G
)
°°G H
;
°°H I
_channelFactory
¢¢ 
=
¢¢  !
null
¢¢" &
;
¢¢& '
}
££ 
}
§§ 	
private
¶¶ 
void
¶¶ "
RaiseConnectionError
¶¶ )
(
¶¶) *%
AuthenticationErrorType
¶¶* A
	errorType
¶¶B K
)
¶¶K L
{
ßß 	%
ConnectionErrorOccurred
®® #
?
®®# $
.
®®$ %
Invoke
®®% +
(
®®+ ,
	errorType
®®, 5
)
®®5 6
;
®®6 7
}
©© 	
}
™™ 
}´´ º
^C:\Users\oscar\source\repos\TrickTakingMissions\Client\Model\Services\Wcf\GameChannelCloser.cs
	namespace 	
Model
 
. 
Services 
{ 
public 

static 
class 
GameChannelCloser )
{ 
private 
const 
string &
CommunicationAbortTemplate 7
=8 9
$str K
;K L
private 
const 
string  
TimeoutAbortTemplate 1
=2 3
$str J
;J K
public 
static 
void 
CloseChannel '
(' ( 
ICommunicationObject( <
channel= D
,D E
ILoggerServiceF T
loggerU [
)[ \
{ 	
if 
( 
logger 
== 
null 
) 
{ 
throw 
new !
ArgumentNullException /
(/ 0
nameof0 6
(6 7
logger7 =
)= >
)> ?
;? @
} 
if 
( 
channel 
!= 
null 
)  
{ 
try   
{!! 
if"" 
("" 
channel"" 
.""  
State""  %
==""& (
CommunicationState"") ;
.""; <
Faulted""< C
)""C D
{## 
channel$$ 
.$$  
Abort$$  %
($$% &
)$$& '
;$$' (
}%% 
else&& 
if&& 
(&& 
channel&& $
.&&$ %
State&&% *
!=&&+ -
CommunicationState&&. @
.&&@ A
Closed&&A G
)&&G H
{'' 
channel(( 
.((  
Close((  %
(((% &
)((& '
;((' (
})) 
}** 
catch++ 
(++ "
CommunicationException++ -
ex++. 0
)++0 1
{,, 
logger-- 
.-- 
Warning-- "
(--" #&
CommunicationAbortTemplate--# =
,--= >
ex--? A
.--A B
GetType--B I
(--I J
)--J K
.--K L
Name--L P
)--P Q
;--Q R
channel.. 
... 
Abort.. !
(..! "
).." #
;..# $
}// 
catch00 
(00 
TimeoutException00 '
ex00( *
)00* +
{11 
logger22 
.22 
Warning22 "
(22" # 
TimeoutAbortTemplate22# 7
,227 8
ex229 ;
.22; <
GetType22< C
(22C D
)22D E
.22E F
Name22F J
)22J K
;22K L
channel33 
.33 
Abort33 !
(33! "
)33" #
;33# $
}44 
}55 
}66 	
}77 
}88 Ç
WC:\Users\oscar\source\repos\TrickTakingMissions\Client\Model\Properties\AssemblyInfo.cs
[ 
assembly 	
:	 

AssemblyTitle 
( 
$str  
)  !
]! "
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
$str "
)" #
]# $
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
]!!) *…
WC:\Users\oscar\source\repos\TrickTakingMissions\Client\Model\Security\PasswordHasher.cs
	namespace 	
Model
 
. 
Security 
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
 
PasswordHasher

 &
{ 
public 
static 
string 
ComputeSha256Hash .
(. /
string/ 5
rawData6 =
)= >
{ 	
string 

hashResult 
= 
string  &
.& '
Empty' ,
;, -
if 
( 
rawData 
!= 
null 
)  
{ 
using 
( 
SHA256 
sha256 $
=% &
SHA256' -
.- .
Create. 4
(4 5
)5 6
)6 7
{ 
byte 
[ 
] 
bytes  
=! "
sha256# )
.) *
ComputeHash* 5
(5 6
Encoding6 >
.> ?
UTF8? C
.C D
GetBytesD L
(L M
rawDataM T
)T U
)U V
;V W
StringBuilder !
stringBuilder" /
=0 1
new2 5
StringBuilder6 C
(C D
)D E
;E F
for 
( 
int 
	byteIndex &
=' (
$num) *
;* +
	byteIndex, 5
<6 7
bytes8 =
.= >
Length> D
;D E
	byteIndexF O
++O Q
)Q R
{ 
stringBuilder %
.% &
Append& ,
(, -
bytes- 2
[2 3
	byteIndex3 <
]< =
.= >
ToString> F
(F G
$strG K
)K L
)L M
;M N
} 

hashResult!! 
=!!  
stringBuilder!!! .
.!!. /
ToString!!/ 7
(!!7 8
)!!8 9
;!!9 :
}"" 
}## 
return%% 

hashResult%% 
;%% 
}&& 	
}'' 
}((  
gC:\Users\oscar\source\repos\TrickTakingMissions\Client\Model\Security\AccountSessionEndpointBehavior.cs
	namespace 	
Model
 
. 
Security 
{		 
public 

sealed 
class *
AccountSessionEndpointBehavior 6
:7 8
IEndpointBehavior9 J
,J K#
IClientMessageInspectorL c
{ 
private 
const 
string $
AccountSessionHeaderName 5
=6 7
$str8 M
;M N
private 
const 
string )
AccountSessionHeaderNamespace :
=; <
$str= a
;a b
public 
object 
BeforeSendRequest '
(' (
ref( +
Message, 3!
accountRequestMessage4 I
,I J
IClientChannelK Y
accountChannelZ h
)h i
{ 	
string 
accountSessionToken &
=' (
UserSession) 4
.4 5
Current5 <
.< =
CurrentUser= H
?H I
.I J
AccountSessionTokenJ ]
??^ `
UserSession 
. 
Current #
.# $
CurrentUser$ /
?/ 0
.0 1
GuestSessionToken1 B
;B C
if 
( 
! 
string 
. 
IsNullOrEmpty %
(% &
accountSessionToken& 9
)9 :
): ;
{ !
accountRequestMessage %
.% &
Headers& -
.- .
Add. 1
(1 2
MessageHeader2 ?
.? @
CreateHeader@ L
(L M$
AccountSessionHeaderName ,
,, -)
AccountSessionHeaderNamespace. K
,K L
accountSessionTokenM `
)` a
)a b
;b c
} 
return 
null 
; 
} 	
public 
void 
AfterReceiveReply %
(% &
ref& )
Message* 1
accountReplyMessage2 E
,E F
objectG M*
accountRequestCorrelationStateN l
)l m
{ 	
} 	
public!! 
void!!  
AddBindingParameters!! (
(!!( )
ServiceEndpoint!!) 8
accountEndpoint!!9 H
,!!H I&
BindingParameterCollection!!J d
bindingParameters!!e v
)!!v w
{"" 	
}## 	
public%% 
void%% 
ApplyClientBehavior%% '
(%%' (
ServiceEndpoint%%( 7
accountEndpoint%%8 G
,%%G H
ClientRuntime%%I V
clientRuntime%%W d
)%%d e
{&& 	
clientRuntime'' 
.'' #
ClientMessageInspectors'' 1
.''1 2
Add''2 5
(''5 6
this''6 :
)'': ;
;''; <
}(( 	
public** 
void** !
ApplyDispatchBehavior** )
(**) *
ServiceEndpoint*** 9
accountEndpoint**: I
,**I J
EndpointDispatcher**K ]
endpointDispatcher**^ p
)**p q
{++ 	
},, 	
public.. 
void.. 
Validate.. 
(.. 
ServiceEndpoint.. ,
accountEndpoint..- <
)..< =
{// 	
}00 	
}11 
}22 ¡
uC:\Users\oscar\source\repos\TrickTakingMissions\Client\Model\Services\LobbyAndMatch\ChatAccountBanAppliedEventArgs.cs
	namespace 	
Model
 
. 
Services 
{ 
public 

sealed 
class *
ChatAccountBanAppliedEventArgs 6
:7 8
	EventArgs9 B
{		 
public

 *
ChatAccountBanAppliedEventArgs

 -
(

- . 
ChatAccountBanNotice

. B 
chatAccountBanNotice

C W
)

W X
{ 	 
ChatAccountBanNotice  
=! " 
chatAccountBanNotice# 7
;7 8
} 	
public  
ChatAccountBanNotice # 
ChatAccountBanNotice$ 8
{9 :
get; >
;> ?
}@ A
} 
} ˇ
qC:\Users\oscar\source\repos\TrickTakingMissions\Client\Model\Services\LobbyAndMatch\LobbyStateChangedEventArgs.cs
	namespace 	
Model
 
. 
Services 
{ 
public 

sealed 
class &
LobbyStateChangedEventArgs 2
:3 4
	EventArgs5 >
{		 
public

 &
LobbyStateChangedEventArgs

 )
(

) *
Lobby

* /
confirmedLobby

0 >
)

> ?
{ 	
ConfirmedLobby 
= 
confirmedLobby +
;+ ,
} 	
public 
Lobby 
ConfirmedLobby #
{$ %
get& )
;) *
}+ ,
} 
} 