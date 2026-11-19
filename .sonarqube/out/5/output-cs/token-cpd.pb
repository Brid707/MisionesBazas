¬t
C:\Users\oscar\source\repos\TrickTakingMissions\Client\ViewModel\ViewModels\Match\Board\MatchBoardViewModel.FinalPreparation.cs
	namespace		 	
	ViewModel		
 
.		 

ViewModels		 
{

 
public 

sealed 
partial 
class 
MatchBoardViewModel  3
{ 
private $
LobbyPlayerItemViewModel ()
_selectedFirstFourTrickWinner) F
;F G
private $
LobbyPlayerItemViewModel ($
_selectedLastTrickWinner) A
;A B
public  
ObservableCollection #
<# $&
PublicMissionRoleViewModel$ >
>> ?!
ConfirmedMissionRoles@ U
{V W
getX [
;[ \
}] ^
=_ `
new  
ObservableCollection $
<$ %&
PublicMissionRoleViewModel% ?
>? @
(@ A
)A B
;B C
public 
ICommand )
IdentifyHeartNineOwnerCommand 5
{6 7
get8 ;
;; <
private= D
setE H
;H I
}J K
public 
ICommand *
AssignTrickDistributionCommand 6
{7 8
get9 <
;< =
private> E
setF I
;I J
}K L
public 
bool (
IsTrickDistributionSelection 0
=>1 3
PreparationStage4 D
==E G#
MissionPreparationStage #
.# $&
TrickDistributionSelection$ >
;> ?
public 
bool *
IsHeartNineIdentificationStage 2
=>3 5
PreparationStage 
== #
MissionPreparationStage  7
.7 8#
HeartNineIdentification8 O
;O P
public 
bool )
IsHeartCaptureProgressVisible 1
=>2 4#
_confirmedMatchSnapshot #
?# $
.$ %
MissionPreparation% 7
?7 8
.8 9
MissionNumber9 F
==G I!
MissionFortySixNumberJ _
&&` b(
IsMissionPreparationComplete (
;( )
private 
static 
readonly 
int  #$
s_requiredHeartCardCount$ <
== >
TrickTakingMissions 
.  
Rules  %
.% &
Rules& +
.+ ,
	DeckRules, 5
.5 6
CreateStandardDeck6 H
(H I
)I J
.J K
CountK P
(P Q
cardQ U
=>V X
card 
. 
Suit 
== 
TrickTakingMissions 0
.0 1
Rules1 6
.6 7
Enums7 <
.< =
CardSuit= E
.E F
HeartF K
)K L
;L M
public 
string '
HeartCaptureProgressDisplay 1
=>2 4
string5 ;
.; <
Format< B
(B C
SystemC I
.I J
GlobalizationJ W
.W X
CultureInfoX c
.c d
InvariantCultured t
,t u
$str 
, #
_confirmedMatchSnapshot .
?. /
./ 0$
MissionConditionProgress0 H
?H I
.I J"
CapturedHeartCardCountJ `
??a c
$numd e
,e f$
s_requiredHeartCardCount $
)$ %
;% &
public   
bool   )
CanIdentifyHeartNineOwnership   1
=>  2 4!
CanSubmitMatchRequest  5 J
(  J K
)  K L
&&  M O
(!! #
_confirmedMatchSnapshot!! $
?!!$ %
.!!% &
MissionPreparation!!& 8
?!!8 9
.!!9 :)
CanIdentifyHeartNineOwnership!!: W
??!!X Z
false!![ `
)!!` a
;!!a b
public## $
LobbyPlayerItemViewModel## '(
SelectedFirstFourTrickWinner##( D
{$$ 	
get%% 
=>%% )
_selectedFirstFourTrickWinner%% 0
;%%0 1
set&& 
=>&& 
SetProperty&& 
(&& 
ref&& ")
_selectedFirstFourTrickWinner&&# @
,&&@ A
value&&B G
)&&G H
;&&H I
}'' 	
public(( $
LobbyPlayerItemViewModel(( '#
SelectedLastTrickWinner((( ?
{)) 	
get** 
=>** $
_selectedLastTrickWinner** +
;**+ ,
set++ 
=>++ 
SetProperty++ 
(++ 
ref++ "$
_selectedLastTrickWinner++# ;
,++; <
value++= B
)++B C
;++C D
},, 	
private.. 
void.. .
"InitializeFinalPreparationCommands.. 7
(..7 8
)..8 9
{// 	)
IdentifyHeartNineOwnerCommand00 )
=00* +
new00, /
AsyncRelayCommand000 A
(00A B'
IdentifyHeartNineOwnerAsync00B ]
,00] ^
(11 
)11 
=>11 )
CanIdentifyHeartNineOwnership11 3
)113 4
;114 5*
AssignTrickDistributionCommand22 *
=22+ ,
new22- 0
AsyncRelayCommand221 B
(22B C(
AssignTrickDistributionAsync22C _
,22_ `!
CanAssignDistribution22a v
)22v w
;22w x
}33 	
private55 
bool55 !
CanAssignDistribution55 *
(55* +
)55+ ,
{66 	
return77 !
CanSubmitMatchRequest77 (
(77( )
)77) *
&&77+ -(
IsTrickDistributionSelection77. J
&&77K M(
SelectedFirstFourTrickWinner77N j
!=77k m
null77n r
&&77s u#
SelectedLastTrickWinner88 '
!=88( *
null88+ /
&&880 2(
SelectedFirstFourTrickWinner883 O
!=88P R#
SelectedLastTrickWinner88S j
&&88k m$
EligibleRoleParticipants99 (
.99( )
Contains99) 1
(991 2(
SelectedFirstFourTrickWinner992 N
)99N O
&&99P R$
EligibleRoleParticipants:: (
.::( )
Contains::) 1
(::1 2#
SelectedLastTrickWinner::2 I
)::I J
;::J K
};; 	
private== 
async== 
Task== '
IdentifyHeartNineOwnerAsync== 6
(==6 7
)==7 8
{>> 	
if?? 
(?? )
CanIdentifyHeartNineOwnership?? -
)??- .
{@@ '
_pendingHeartIdentificationAA +
=AA, -
newAA. 1-
!HeartNineIdentificationSubmissionAA2 S
{BB 
	LobbyCodeCC 
=CC 

_lobbyCodeCC  *
,CC* +
MatchIdCC, 3
=CC4 5#
_confirmedMatchSnapshotCC6 M
.CCM N
MatchIdCCN U
,CCU V
MissionAttemptIdDD $
=DD% &#
_confirmedMatchSnapshotDD' >
.DD> ?
MissionPreparationDD? Q
.DDQ R
MissionAttemptIdDDR b
,DDb c%
MissionPreparationStageIdEE -
=EE. /#
_confirmedMatchSnapshotEE0 G
.EEG H
MissionPreparationEEH Z
.EEZ [%
MissionPreparationStageIdEE[ t
,EEt u*
MissionPreparationSubmissionIdFF 2
=FF3 4
GuidFF5 9
.FF9 :
NewGuidFF: A
(FFA B
)FFB C
,FFC D%
ExpectedMatchStateVersionFFE ^
=FF_ `
MatchStateVersionFFa r
}GG 
;GG 
awaitHH !
SynchronizeMatchAsyncHH +
(HH+ ,
)HH, -
;HH- .
}II 
}JJ 	
privateLL 
asyncLL 
TaskLL (
AssignTrickDistributionAsyncLL 7
(LL7 8
)LL8 9
{MM 	
ifNN 
(NN !
CanAssignDistributionNN %
(NN% &
)NN& '
)NN' (
{OO %
_pendingTrickDistributionPP )
=PP* +
newPP, /.
"MissionTrickDistributionSubmissionPP0 R
{QQ 
	LobbyCodeRR 
=RR 

_lobbyCodeRR  *
,RR* +
MatchIdRR, 3
=RR4 5#
_confirmedMatchSnapshotRR6 M
.RRM N
MatchIdRRN U
,RRU V
MissionAttemptIdSS $
=SS% &#
_confirmedMatchSnapshotSS' >
.SS> ?
MissionPreparationSS? Q
.SSQ R
MissionAttemptIdSSR b
,SSb c%
MissionPreparationStageIdTT -
=TT. /#
_confirmedMatchSnapshotTT0 G
.TTG H
MissionPreparationTTH Z
.TTZ [%
MissionPreparationStageIdTT[ t
,TTt u*
MissionPreparationSubmissionIdUU 2
=UU3 4
GuidUU5 9
.UU9 :
NewGuidUU: A
(UUA B
)UUB C
,UUC D%
ExpectedMatchStateVersionUUE ^
=UU_ `
MatchStateVersionUUa r
,UUr s2
&FirstFourTricksWinnerParticipantUserIdVV :
=VV; <(
SelectedFirstFourTrickWinnerVV= Y
.VVY Z
IdUserVVZ `
,VV` a,
 LastTrickWinnerParticipantUserIdWW 4
=WW5 6#
SelectedLastTrickWinnerWW7 N
.WWN O
IdUserWWO U
}XX 
;XX 
awaitYY !
SynchronizeMatchAsyncYY +
(YY+ ,
)YY, -
;YY- .
}ZZ 
}[[ 	
private]] 
Guid]] )
GetPendingPreparationIdentity]] 2
(]]2 3
)]]3 4
{^^ 	
return__ "
_pendingRoleAssignment__ )
?__) *
.__* +*
MissionPreparationSubmissionId__+ I
??__J L!
_pendingBlindResponse`` %
?``% &
.``& '*
MissionPreparationSubmissionId``' E
??``F H'
_pendingHeartIdentificationaa +
?aa+ ,
.aa, -*
MissionPreparationSubmissionIdaa- K
??aaL N%
_pendingTrickDistributionbb )
.bb) **
MissionPreparationSubmissionIdbb* H
;bbH I
}cc 	
privateee 
asyncee 
Taskee 
<ee *
MissionPreparationConfirmationee 9
>ee9 :.
"SubmitPendingFinalPreparationAsyncee; ]
(ee] ^
)ee^ _
{ff 	*
MissionPreparationConfirmationgg *
confirmationgg+ 7
;gg7 8
ifhh 
(hh '
_pendingHeartIdentificationhh +
!=hh, .
nullhh/ 3
)hh3 4
{ii 
confirmationjj 
=jj 
awaitjj $
_matchClientjj% 1
.jj1 2'
IdentifyHeartNineOwnerAsyncjj2 M
(jjM N'
_pendingHeartIdentificationjjN i
,jji j
_participantUserIdkk &
)kk& '
;kk' (
}ll 
elsemm 
{nn 
confirmationoo 
=oo 
awaitoo $
_matchClientoo% 1
.oo1 2/
#AssignMissionTrickDistributionAsyncoo2 U
(ooU V%
_pendingTrickDistributionooV o
,ooo p
_participantUserIdpp &
)pp& '
;pp' (
}qq 
returnrr 
confirmationrr 
;rr  
}ss 	
privateuu 
stringuu ,
 GetSpecialPreparationFeedbackKeyuu 7
(uu7 8
)uu8 9
{vv 	
stringww 
keyww 
=ww 
$strww 4
+ww5 6
PreparationStageww7 G
;wwG H
ifxx 
(xx 
PreparationStagexx  
==xx! ##
MissionPreparationStagexx$ ;
.xx; <
RoleSelectionxx< I
)xxI J
{yy 
intzz 
missionzz 
=zz #
_confirmedMatchSnapshotzz 5
.zz5 6
MissionPreparationzz6 H
.zzH I
MissionNumberzzI V
;zzV W
if{{ 
({{ 
mission{{ 
=={{ $
MissionThirtyThreeNumber{{ 7
){{7 8
{|| 
key}} 
=}} 
$str}} L
;}}L M
}~~ 
if 
( 
mission 
== !
MissionFortyOneNumber 4
)4 5
{
ÄÄ 
key
ÅÅ 
=
ÅÅ 
$str
ÅÅ M
;
ÅÅM N
}
ÇÇ 
}
ÉÉ 
return
ÑÑ 
key
ÑÑ 
;
ÑÑ 
}
ÖÖ 	
private
áá 
void
áá $
ApplyFinalMissionRoles
áá +
(
áá+ ,.
 PlayerMissionPreparationSnapshot
áá, L
preparation
ááM X
)
ááX Y
{
àà 	#
ConfirmedMissionRoles
ââ !
.
ââ! "
Clear
ââ" '
(
ââ' (
)
ââ( )
;
ââ) *"
AddPublicMissionRole
ää  
(
ää  !
$str
ää! A
,
ääA B
preparation
ãã 
?
ãã 
.
ãã 6
(FirstAndLastTrickWinnerParticipantUserId
ãã E
)
ããE F
;
ããF G"
AddPublicMissionRole
åå  
(
åå  !
$str
åå! >
,
åå> ?
preparation
åå@ K
?
ååK L
.
ååL M4
&FirstFourTricksWinnerParticipantUserId
ååM s
)
åås t
;
ååt u"
AddPublicMissionRole
çç  
(
çç  !
$str
çç! 9
,
çç9 :
preparation
çç; F
?
ççF G
.
ççG H.
 LastTrickWinnerParticipantUserId
ççH h
)
ççh i
;
ççi j"
AddPublicMissionRole
éé  
(
éé  !
$str
éé! C
,
ééC D
preparation
ééE P
?
ééP Q
.
ééQ R-
HeartNineOwnerParticipantUserId
ééR q
)
ééq r
;
éér s"
AddPublicMissionRole
èè  
(
èè  !
$str
èè! B
,
èèB C
preparation
èèD O
?
èèO P
.
èèP Q3
%RequiredHeartCaptureParticipantUserId
èèQ v
)
èèv w
;
èèw x
}
êê 	
private
íí 
void
íí "
AddPublicMissionRole
íí )
(
íí) *
string
íí* 0
label
íí1 6
,
íí6 7
int
íí8 ;
?
íí; <
participantUserId
íí= N
)
ííN O
{
ìì 	
if
îî 
(
îî 
participantUserId
îî !
.
îî! "
HasValue
îî" *
)
îî* +
{
ïï #
ConfirmedMissionRoles
ññ %
.
ññ% &
Add
ññ& )
(
ññ) *
new
ññ* -(
PublicMissionRoleViewModel
ññ. H
(
ññH I
label
ññI N
,
ññN O 
GetParticipantName
óó &
(
óó& '
participantUserId
óó' 8
.
óó8 9
Value
óó9 >
)
óó> ?
)
óó? @
)
óó@ A
;
óóA B
}
òò 
}
ôô 	
}
öö 
}õõ ç
zC:\Users\oscar\source\repos\TrickTakingMissions\Client\ViewModel\ViewModels\Match\Objectives\PublicMissionRoleViewModel.cs
	namespace 	
	ViewModel
 
. 

ViewModels 
{ 
public 

sealed 
class &
PublicMissionRoleViewModel 2
{ 
public &
PublicMissionRoleViewModel )
() *
string* 0
labelResourceKey1 A
,A B
stringC I
participantNameJ Y
)Y Z
{ 	
LabelResourceKey 
= 
labelResourceKey /
;/ 0
ParticipantName		 
=		 
participantName		 -
;		- .
}

 	
public 
string 
LabelResourceKey &
{' (
get) ,
;, -
}. /
public 
string 
ParticipantName %
{& '
get( +
;+ ,
}- .
} 
} ®
C:\Users\oscar\source\repos\TrickTakingMissions\Client\ViewModel\ViewModels\Match\Objectives\BlindObjectiveResponseViewModel.cs
	namespace 	
	ViewModel
 
. 

ViewModels 
{ 
public 

sealed 
class +
BlindObjectiveResponseViewModel 7
{ 
public +
BlindObjectiveResponseViewModel .
(. /
string/ 5
participantName6 E
,E F
stringG M
responseResourceKeyN a
)a b
{ 	
ParticipantName 
= 
participantName -
;- .
ResponseResourceKey		 
=		  !
responseResourceKey		" 5
;		5 6
}

 	
public 
string 
ParticipantName %
{& '
get( +
;+ ,
}- .
public 
string 
ResponseResourceKey )
{* +
get, /
;/ 0
}1 2
} 
} Ç∂
ÅC:\Users\oscar\source\repos\TrickTakingMissions\Client\ViewModel\ViewModels\Match\Board\MatchBoardViewModel.SpecialPreparation.cs
	namespace

 	
	ViewModel


 
.

 

ViewModels

 
{ 
public 

sealed 
partial 
class 
MatchBoardViewModel  3
{ 
private +
MissionRoleAssignmentSubmission /"
_pendingRoleAssignment0 F
;F G
private -
!HeartNineIdentificationSubmission 1'
_pendingHeartIdentification2 M
;M N
private .
"MissionTrickDistributionSubmission 2%
_pendingTrickDistribution3 L
;L M
private ,
 BlindObjectiveResponseSubmission 0!
_pendingBlindResponse1 F
;F G
private $
LobbyPlayerItemViewModel ($
_selectedRoleParticipant) A
;A B
private 
bool *
_isSpecialPreparationPanelOpen 3
;3 4
public 
bool )
IsSpecialPreparationPanelOpen 1
{ 	
get 
=> *
_isSpecialPreparationPanelOpen 1
;1 2
set 
=> 
SetProperty 
( 
ref "*
_isSpecialPreparationPanelOpen# A
,A B
valueC H
&&I K'
IsSpecialPreparationVisibleL g
)g h
;h i
} 	
public  
ObservableCollection #
<# $$
LobbyPlayerItemViewModel$ <
>< =$
EligibleRoleParticipants> V
{W X
getY \
;\ ]
}^ _
=` a
new  
ObservableCollection $
<$ %$
LobbyPlayerItemViewModel% =
>= >
(> ?
)? @
;@ A
public  
ObservableCollection #
<# $+
BlindObjectiveResponseViewModel$ C
>C D.
"BlindObjectiveResponseDescriptionsE g
{h i
getj m
;m n
}o p
=q r
new  
ObservableCollection $
<$ %+
BlindObjectiveResponseViewModel% D
>D E
(E F
)F G
;G H
public   
ICommand   $
AssignMissionRoleCommand   0
{  1 2
get  3 6
;  6 7
private  8 ?
set  @ C
;  C D
}  E F
public!! 
ICommand!! !
RespondCapableCommand!! -
{!!. /
get!!0 3
;!!3 4
private!!5 <
set!!= @
;!!@ A
}!!B C
public"" 
ICommand"" $
RespondNotCapableCommand"" 0
{""1 2
get""3 6
;""6 7
private""8 ?
set""@ C
;""C D
}""E F
public## 
bool## '
IsSpecialPreparationVisible## /
=>##0 2
PreparationStage##3 C
==##D F#
MissionPreparationStage##G ^
.##^ _
RoleSelection##_ l
||##m o
PreparationStage$$ 
==$$ #
MissionPreparationStage$$  7
.$$7 8
BlindResponses$$8 F
||$$G I
PreparationStage%% 
==%% #
MissionPreparationStage%%  7
.%%7 8
AssigneeSelection%%8 I
||%%J L
PreparationStage&& 
==&& #
MissionPreparationStage&&  7
.&&7 8#
HeartNineIdentification&&8 O
||&&P R
PreparationStage'' 
=='' #
MissionPreparationStage''  7
.''7 8&
TrickDistributionSelection''8 R
;''R S
public(( 
bool(( #
IsRoleAssignmentVisible(( +
=>((, .$
EligibleRoleParticipants((/ G
.((G H
Count((H M
>((N O
$num((P Q
&&((R T
!((U V(
IsTrickDistributionSelection((V r
;((r s
public)) 
bool)) (
IsBlindResponseChoiceVisible)) 0
=>))1 3#
_confirmedMatchSnapshot** #
?**# $
.**$ %
MissionPreparation**% 7
?**7 8
.**8 9'
CanRespondToBlindObjectives**9 T
??**U W
false**X ]
;**] ^
public++ 
bool++ $
AreBlindResponsesVisible++ ,
=>++- /
PreparationStage++0 @
==++A C#
MissionPreparationStage++D [
.++[ \
BlindResponses++\ j
||++k m
PreparationStage,, 
==,, #
MissionPreparationStage,,  7
.,,7 8
AssigneeSelection,,8 I
;,,I J
public-- 
bool-- %
CanRespondBlindObjectives-- -
=>--. 0!
CanSubmitMatchRequest--1 F
(--F G
)--G H
&&--I K
(.. #
_confirmedMatchSnapshot.. $
?..$ %
...% &
MissionPreparation..& 8
?..8 9
...9 :'
CanRespondToBlindObjectives..: U
??..V X
false..Y ^
)..^ _
;.._ `
public// 
bool// $
CanSelectRoleParticipant// ,
=>//- /!
CanSubmitMatchRequest//0 E
(//E F
)//F G
&&//H J$
EligibleRoleParticipants//K c
.//c d
Count//d i
>//j k
$num//l m
;//m n
public00 
string00 )
SpecialPreparationFeedbackKey00 3
=>004 6,
 GetSpecialPreparationFeedbackKey007 W
(00W X
)00X Y
;00Y Z
public11 
bool11  
HasSingleTrickWinner11 (
=>11) +#
_confirmedMatchSnapshot22 #
?22# $
.22$ %
MissionPreparation22% 7
?227 8
.228 9.
"SingleTrickWinnerParticipantUserId229 [
.22[ \
HasValue22\ d
??22e g
false22h m
;22m n
public33 
string33 ,
 SingleTrickWinnerParticipantName33 6
=>337 9
GetParticipantName33: L
(33L M#
_confirmedMatchSnapshot44 #
?44# $
.44$ %
MissionPreparation44% 7
?447 8
.448 9.
"SingleTrickWinnerParticipantUserId449 [
??44\ ^
$num44_ `
)44` a
;44a b
private55 
bool55 !
HasPendingPreparation55 *
=>55+ -"
_pendingRoleAssignment55. D
!=55E G
null55H L
||55M O!
_pendingBlindResponse55P e
!=55f h
null55i m
||55n p'
_pendingHeartIdentification66 '
!=66( *
null66+ /
||660 2%
_pendingTrickDistribution663 L
!=66M O
null66P T
;66T U
private77 #
MissionPreparationStage77 '
PreparationStage77( 8
=>779 ;#
_confirmedMatchSnapshot77< S
?77S T
.77T U
MissionPreparation77U g
?77g h
.77h i
Stage77i n
??77o q#
MissionPreparationStage88 #
.88# $
None88$ (
;88( )
public:: $
LobbyPlayerItemViewModel:: '#
SelectedRoleParticipant::( ?
{;; 	
get<< 
=><< $
_selectedRoleParticipant<< +
;<<+ ,
set== 
=>== 
SetProperty== 
(== 
ref== "$
_selectedRoleParticipant==# ;
,==; <
value=== B
)==B C
;==C D
}>> 	
private@@ 
void@@ 0
$InitializeSpecialPreparationCommands@@ 9
(@@9 :
)@@: ;
{AA 	$
AssignMissionRoleCommandBB $
=BB% &
newBB' *
AsyncRelayCommandBB+ <
(BB< ="
AssignMissionRoleAsyncBB= S
,BBS T 
CanAssignMissionRoleBBU i
)BBi j
;BBj k!
RespondCapableCommandCC !
=CC" #
newCC$ '
AsyncRelayCommandCC( 9
(CC9 :
(CC: ;
)CC; <
=>CC= ?'
RespondBlindObjectivesAsyncCC@ [
(CC[ \"
BlindObjectiveResponseCC\ r
.CCr s
YesCCs v
)CCv w
,CCw x
(DD 
)DD 
=>DD %
CanRespondBlindObjectivesDD /
)DD/ 0
;DD0 1$
RespondNotCapableCommandEE $
=EE% &
newEE' *
AsyncRelayCommandEE+ <
(EE< =
(EE= >
)EE> ?
=>EE@ B'
RespondBlindObjectivesAsyncFF +
(FF+ ,"
BlindObjectiveResponseFF, B
.FFB C
NoFFC E
)FFE F
,FFF G
(GG 
)GG 
=>GG %
CanRespondBlindObjectivesGG /
)GG/ 0
;GG0 1
}HH 	
privateJJ 
boolJJ  
CanAssignMissionRoleJJ )
(JJ) *
)JJ* +
{KK 	
returnLL $
CanSelectRoleParticipantLL +
&&LL, .#
SelectedRoleParticipantLL/ F
!=LLG I
nullLLJ N
&&LLO Q$
EligibleRoleParticipantsMM (
.MM( )
ContainsMM) 1
(MM1 2#
SelectedRoleParticipantMM2 I
)MMI J
;MMJ K
}NN 	
privatePP 
asyncPP 
TaskPP "
AssignMissionRoleAsyncPP 1
(PP1 2
)PP2 3
{QQ 	
ifRR 
(RR  
CanAssignMissionRoleRR $
(RR$ %
)RR% &
)RR& '
{SS "
_pendingRoleAssignmentTT &
=TT' (
newTT) ,+
MissionRoleAssignmentSubmissionTT- L
{UU 
	LobbyCodeVV 
=VV 

_lobbyCodeVV  *
,VV* +
MatchIdWW 
=WW #
_confirmedMatchSnapshotWW 5
.WW5 6
MatchIdWW6 =
,WW= >
MissionAttemptIdXX $
=XX% &#
_confirmedMatchSnapshotXX' >
.XX> ?
MissionPreparationXX? Q
.XXQ R
MissionAttemptIdXXR b
,XXb c%
MissionPreparationStageIdYY -
=YY. /#
_confirmedMatchSnapshotYY0 G
.YYG H
MissionPreparationYYH Z
.YYZ [%
MissionPreparationStageIdYY[ t
,YYt u*
MissionPreparationSubmissionIdZZ 2
=ZZ3 4
GuidZZ5 9
.ZZ9 :
NewGuidZZ: A
(ZZA B
)ZZB C
,ZZC D%
ExpectedMatchStateVersion[[ -
=[[. /
MatchStateVersion[[0 A
,[[A B%
SelectedParticipantUserId\\ -
=\\. /#
SelectedRoleParticipant\\0 G
.\\G H
IdUser\\H N
}]] 
;]] 
await^^ !
SynchronizeMatchAsync^^ +
(^^+ ,
)^^, -
;^^- .
}__ 
}`` 	
privatebb 
asyncbb 
Taskbb '
RespondBlindObjectivesAsyncbb 6
(bb6 7"
BlindObjectiveResponsebb7 M
responsebbN V
)bbV W
{cc 	
ifdd 
(dd %
CanRespondBlindObjectivesdd )
)dd) *
{ee !
_pendingBlindResponseff %
=ff& '
newff( +,
 BlindObjectiveResponseSubmissionff, L
{gg 
	LobbyCodehh 
=hh 

_lobbyCodehh  *
,hh* +
MatchIdii 
=ii #
_confirmedMatchSnapshotii 5
.ii5 6
MatchIdii6 =
,ii= >
MissionAttemptIdjj $
=jj% &#
_confirmedMatchSnapshotjj' >
.jj> ?
MissionPreparationjj? Q
.jjQ R
MissionAttemptIdjjR b
,jjb c%
MissionPreparationStageIdkk -
=kk. /#
_confirmedMatchSnapshotkk0 G
.kkG H
MissionPreparationkkH Z
.kkZ [%
MissionPreparationStageIdkk[ t
,kkt u*
MissionPreparationSubmissionIdll 2
=ll3 4
Guidll5 9
.ll9 :
NewGuidll: A
(llA B
)llB C
,llC D%
ExpectedMatchStateVersionmm -
=mm. /
MatchStateVersionmm0 A
,mmA B
Responsenn 
=nn 
responsenn '
}oo 
;oo 
awaitpp !
SynchronizeMatchAsyncpp +
(pp+ ,
)pp, -
;pp- .
}qq 
}rr 	
privatett 
asynctt 
Tasktt 
<tt 
stringtt !
>tt! "*
ConfirmPendingPreparationAsynctt# A
(ttA B
)ttB C
{uu 	
stringvv 
feedbackvv 
=vv 
nullvv "
;vv" #
ifww 
(ww !
HasPendingPreparationww %
)ww% &
{xx 
tryyy 
{zz 
Guid{{ 
expectedIdentity{{ )
={{* +)
GetPendingPreparationIdentity{{, I
({{I J
){{J K
;{{K L*
MissionPreparationConfirmation|| 2
confirmation||3 ?
=||@ A
await||B G)
SubmitPendingPreparationAsync||H e
(||e f
)||f g
;||g h
if}} 
(}} 
confirmation}} $
==}}% '
null}}( ,
||}}- /
confirmation}}0 <
.}}< =*
MissionPreparationSubmissionId}}= [
!=}}\ ^
expectedIdentity}}_ o
)}}o p
{~~ 
throw 
new !
FaultException" 0
<0 1
MatchAccessFault1 A
>A B
(B C
newC F
MatchAccessFaultG W
{
ÄÄ 
FailureCode
ÄÄ %
=
ÄÄ& '
nameof
ÄÄ( .
(
ÄÄ. /-
MissionPreparationFailureReason
ÄÄ/ N
.
ÄÄN O"
OperationUnavailable
ÄÄO c
)
ÄÄc d
}
ÄÄe f
)
ÄÄf g
;
ÄÄg h
}
ÅÅ %
ClearPendingPreparation
ÇÇ +
(
ÇÇ+ ,
)
ÇÇ, -
;
ÇÇ- .
}
ÉÉ 
catch
ÑÑ 
(
ÑÑ 
FaultException
ÑÑ %
<
ÑÑ% &%
MissionPreparationFault
ÑÑ& =
>
ÑÑ= >
ex
ÑÑ? A
)
ÑÑA B
{
ÖÖ 
feedback
ÜÜ 
=
ÜÜ 
$str
ÜÜ :
+
ÜÜ; <
ex
ÜÜ= ?
.
ÜÜ? @
Detail
ÜÜ@ F
.
ÜÜF G
FailureReason
ÜÜG T
;
ÜÜT U
if
áá 
(
áá 
ex
áá 
.
áá 
Detail
áá !
.
áá! "
FailureReason
áá" /
!=
áá0 2-
MissionPreparationFailureReason
áá3 R
.
ááR S"
OperationUnavailable
ááS g
)
áág h
{
àà %
ClearPendingPreparation
ââ /
(
ââ/ 0
)
ââ0 1
;
ââ1 2
}
ää 
}
ãã 
}
åå 
return
çç 
feedback
çç 
;
çç 
}
éé 	
private
êê 
async
êê 
Task
êê 
<
êê ,
MissionPreparationConfirmation
êê 9
>
êê9 :+
SubmitPendingPreparationAsync
êê; X
(
êêX Y
)
êêY Z
{
ëë 	,
MissionPreparationConfirmation
íí *
confirmation
íí+ 7
;
íí7 8
if
ìì 
(
ìì $
_pendingRoleAssignment
ìì &
!=
ìì' )
null
ìì* .
)
ìì. /
{
îî 
confirmation
ïï 
=
ïï 
await
ïï $
_matchClient
ïï% 1
.
ïï1 2$
AssignMissionRoleAsync
ïï2 H
(
ïïH I$
_pendingRoleAssignment
ïïI _
,
ïï_ ` 
_participantUserId
ïïa s
)
ïïs t
;
ïït u
}
ññ 
else
óó 
if
óó 
(
óó #
_pendingBlindResponse
óó *
!=
óó+ -
null
óó. 2
)
óó2 3
{
òò 
confirmation
ôô 
=
ôô 
await
ôô $
_matchClient
ôô% 1
.
ôô1 2+
RespondToBlindObjectivesAsync
ôô2 O
(
ôôO P#
_pendingBlindResponse
ôôP e
,
ôôe f 
_participantUserId
öö &
)
öö& '
;
öö' (
}
õõ 
else
úú 
{
ùù 
confirmation
ûû 
=
ûû 
await
ûû $0
"SubmitPendingFinalPreparationAsync
ûû% G
(
ûûG H
)
ûûH I
;
ûûI J
}
üü 
return
†† 
confirmation
†† 
;
††  
}
°° 	
private
££ 
void
££ %
ClearPendingPreparation
££ ,
(
££, -
)
££- .
{
§§ 	$
_pendingRoleAssignment
•• "
=
••# $
null
••% )
;
••) *#
_pendingBlindResponse
¶¶ !
=
¶¶" #
null
¶¶$ (
;
¶¶( ))
_pendingHeartIdentification
ßß '
=
ßß( )
null
ßß* .
;
ßß. /'
_pendingTrickDistribution
®® %
=
®®& '
null
®®( ,
;
®®, -
}
©© 	
private
´´ 
void
´´ -
ApplySpecialPreparationSnapshot
´´ 4
(
´´4 5.
 PlayerMissionPreparationSnapshot
´´5 U
preparation
´´V a
)
´´a b
{
¨¨ 	
int
≠≠ 
?
≠≠ 
selectedUserId
≠≠ 
=
≠≠  !%
SelectedRoleParticipant
≠≠" 9
?
≠≠9 :
.
≠≠: ;
IdUser
≠≠; A
;
≠≠A B&
EligibleRoleParticipants
ÆÆ $
.
ÆÆ$ %
Clear
ÆÆ% *
(
ÆÆ* +
)
ÆÆ+ ,
;
ÆÆ, -
foreach
ØØ 
(
ØØ 
int
ØØ 
userId
ØØ 
in
ØØ  "
preparation
ØØ# .
?
ØØ. /
.
ØØ/ 0,
EligibleRoleParticipantUserIds
ØØ0 N
??
ØØO Q
Array
ØØR W
.
ØØW X
Empty
ØØX ]
<
ØØ] ^
int
ØØ^ a
>
ØØa b
(
ØØb c
)
ØØc d
)
ØØd e
{
∞∞ &
LobbyPlayerItemViewModel
±± (
participant
±±) 4
=
±±5 6
_seatedPlayers
±±7 E
.
±±E F
FirstOrDefault
±±F T
(
±±T U
player
±±U [
=>
±±\ ^
player
±±_ e
.
±±e f
IdUser
±±f l
==
±±m o
userId
±±p v
)
±±v w
;
±±w x
if
≤≤ 
(
≤≤ 
participant
≤≤ 
!=
≤≤  "
null
≤≤# '
)
≤≤' (
{
≥≥ &
EligibleRoleParticipants
¥¥ ,
.
¥¥, -
Add
¥¥- 0
(
¥¥0 1
participant
¥¥1 <
)
¥¥< =
;
¥¥= >
}
µµ 
}
∂∂ %
SelectedRoleParticipant
∑∑ #
=
∑∑$ %&
EligibleRoleParticipants
∑∑& >
.
∑∑> ?
FirstOrDefault
∑∑? M
(
∑∑M N
player
∑∑N T
=>
∑∑U W
player
∑∑X ^
.
∑∑^ _
IdUser
∑∑_ e
==
∑∑f h
selectedUserId
∏∏ 
)
∏∏ 
;
∏∏  0
"BlindObjectiveResponseDescriptions
ππ .
.
ππ. /
Clear
ππ/ 4
(
ππ4 5
)
ππ5 6
;
ππ6 7
foreach
∫∫ 
(
∫∫ /
!BlindObjectiveParticipantSnapshot
∫∫ 6
response
∫∫7 ?
in
∫∫@ B
preparation
∫∫C N
?
∫∫N O
.
∫∫O P%
BlindObjectiveResponses
∫∫P g
??
∫∫h j
Array
ªª 
.
ªª 
Empty
ªª 
<
ªª /
!BlindObjectiveParticipantSnapshot
ªª =
>
ªª= >
(
ªª> ?
)
ªª? @
)
ªª@ A
{
ºº 
string
ΩΩ 
responseKey
ΩΩ "
=
ΩΩ# $
$str
ΩΩ% C
+
ΩΩD E
response
ΩΩF N
.
ΩΩN O
Response
ΩΩO W
;
ΩΩW X0
"BlindObjectiveResponseDescriptions
ææ 2
.
ææ2 3
Add
ææ3 6
(
ææ6 7
new
ææ7 :-
BlindObjectiveResponseViewModel
ææ; Z
(
ææZ [ 
GetParticipantName
øø &
(
øø& '
response
øø' /
.
øø/ 0
ParticipantUserId
øø0 A
)
øøA B
,
øøB C
responseKey
øøD O
)
øøO P
)
øøP Q
;
øøQ R
}
¿¿ 
if
¡¡ 
(
¡¡ 
!
¡¡ )
IsSpecialPreparationVisible
¡¡ ,
)
¡¡, -
{
¬¬ +
IsSpecialPreparationPanelOpen
√√ -
=
√√. /
false
√√0 5
;
√√5 6
}
ƒƒ $
ApplyFinalMissionRoles
≈≈ "
(
≈≈" #
preparation
≈≈# .
)
≈≈. /
;
≈≈/ 00
"NotifySpecialPreparationProperties
∆∆ .
(
∆∆. /
)
∆∆/ 0
;
∆∆0 1
}
«« 	
private
…… 
void
…… 0
"NotifySpecialPreparationProperties
…… 7
(
……7 8
)
……8 9
{
   	
OnPropertyChanged
ÀÀ 
(
ÀÀ 
nameof
ÀÀ $
(
ÀÀ$ %)
IsSpecialPreparationVisible
ÀÀ% @
)
ÀÀ@ A
)
ÀÀA B
;
ÀÀB C
OnPropertyChanged
ÃÃ 
(
ÃÃ 
nameof
ÃÃ $
(
ÃÃ$ %%
IsRoleAssignmentVisible
ÃÃ% <
)
ÃÃ< =
)
ÃÃ= >
;
ÃÃ> ?
OnPropertyChanged
ÕÕ 
(
ÕÕ 
nameof
ÕÕ $
(
ÕÕ$ %*
IsBlindResponseChoiceVisible
ÕÕ% A
)
ÕÕA B
)
ÕÕB C
;
ÕÕC D
OnPropertyChanged
ŒŒ 
(
ŒŒ 
nameof
ŒŒ $
(
ŒŒ$ %&
AreBlindResponsesVisible
ŒŒ% =
)
ŒŒ= >
)
ŒŒ> ?
;
ŒŒ? @
OnPropertyChanged
œœ 
(
œœ 
nameof
œœ $
(
œœ$ %'
CanRespondBlindObjectives
œœ% >
)
œœ> ?
)
œœ? @
;
œœ@ A
OnPropertyChanged
–– 
(
–– 
nameof
–– $
(
––$ %&
CanSelectRoleParticipant
––% =
)
––= >
)
––> ?
;
––? @
OnPropertyChanged
—— 
(
—— 
nameof
—— $
(
——$ %+
SpecialPreparationFeedbackKey
——% B
)
——B C
)
——C D
;
——D E
OnPropertyChanged
““ 
(
““ 
nameof
““ $
(
““$ %*
IsTrickDistributionSelection
““% A
)
““A B
)
““B C
;
““C D
OnPropertyChanged
”” 
(
”” 
nameof
”” $
(
””$ %,
IsHeartNineIdentificationStage
””% C
)
””C D
)
””D E
;
””E F
OnPropertyChanged
‘‘ 
(
‘‘ 
nameof
‘‘ $
(
‘‘$ %+
IsHeartCaptureProgressVisible
‘‘% B
)
‘‘B C
)
‘‘C D
;
‘‘D E
OnPropertyChanged
’’ 
(
’’ 
nameof
’’ $
(
’’$ %)
HeartCaptureProgressDisplay
’’% @
)
’’@ A
)
’’A B
;
’’B C
OnPropertyChanged
÷÷ 
(
÷÷ 
nameof
÷÷ $
(
÷÷$ %+
CanIdentifyHeartNineOwnership
÷÷% B
)
÷÷B C
)
÷÷C D
;
÷÷D E
OnPropertyChanged
◊◊ 
(
◊◊ 
nameof
◊◊ $
(
◊◊$ %"
HasSingleTrickWinner
◊◊% 9
)
◊◊9 :
)
◊◊: ;
;
◊◊; <
OnPropertyChanged
ÿÿ 
(
ÿÿ 
nameof
ÿÿ $
(
ÿÿ$ %.
 SingleTrickWinnerParticipantName
ÿÿ% E
)
ÿÿE F
)
ÿÿF G
;
ÿÿG H
}
ŸŸ 	
}
⁄⁄ 
}€€ ˘
|C:\Users\oscar\source\repos\TrickTakingMissions\Client\ViewModel\ViewModels\Match\Radio\PlayerRadioCommunicationViewModel.cs
	namespace 	
	ViewModel
 
. 

ViewModels 
{ 
public 

sealed 
class -
!PlayerRadioCommunicationViewModel 9
{ 
public -
!PlayerRadioCommunicationViewModel 0
(0 1,
 PlayerRadioCommunicationSnapshot1 Q
snapshotR Z
,Z [
string\ b
participantNamec r
)r s
{		 	
ParticipantName

 
=

 
participantName

 -
;

- .
CardId 
= 
snapshot 
. 
CommunicatedCardId 0
;0 1
Marker 
= 
snapshot 
. 
Marker $
;$ %)
HasCommunicatedCardBeenPlayed )
=* +
snapshot, 4
.4 5)
HasCommunicatedCardBeenPlayed5 R
;R S
} 	
public 
string 
ParticipantName %
{& '
get( +
;+ ,
}- .
public 
int 
CardId 
{ 
get 
;  
}! "
public $
RadioCommunicationMarker '
Marker( .
{/ 0
get1 4
;4 5
}6 7
public 
bool )
HasCommunicatedCardBeenPlayed 1
{2 3
get4 7
;7 8
}9 :
public 
string 
MarkerResourceKey '
=>( *
$str+ :
+; <
Marker= C
;C D
} 
} ˛
uC:\Users\oscar\source\repos\TrickTakingMissions\Client\ViewModel\ViewModels\Match\Radio\RadioMarkerOptionViewModel.cs
	namespace 	
	ViewModel
 
. 

ViewModels 
{ 
public 

sealed 
class &
RadioMarkerOptionViewModel 2
{ 
public &
RadioMarkerOptionViewModel )
() *$
RadioCommunicationMarker* B
markerC I
)I J
{		 	
Marker

 
=

 
marker

 
;

 
} 	
public $
RadioCommunicationMarker '
Marker( .
{/ 0
get1 4
;4 5
}6 7
public 
string 
ResourceKey !
=>" $
$str% 4
+5 6
Marker7 =
;= >
} 
} ∏Â
ÅC:\Users\oscar\source\repos\TrickTakingMissions\Client\ViewModel\ViewModels\Match\Board\MatchBoardViewModel.RadioCommunication.cs
	namespace 	
	ViewModel
 
. 

ViewModels 
{ 
public 

sealed 
partial 
class 
MatchBoardViewModel  3
{ 
private 
static 
readonly 
IReadOnlyDictionary  3
<3 4
RadioTokenPosition4 F
,F G$
RadioCommunicationMarkerH `
>` a"
RadioMarkersByPosition "
=# $
new% (

Dictionary) 3
<3 4
RadioTokenPosition4 F
,F G$
RadioCommunicationMarkerH `
>` a
{ 
{ 
RadioTokenPosition $
.$ %
Highest% ,
,, -$
RadioCommunicationMarker. F
.F G
HighestG N
}O P
,P Q
{ 
RadioTokenPosition $
.$ %
Only% )
,) *$
RadioCommunicationMarker+ C
.C D
OnlyD H
}I J
,J K
{ 
RadioTokenPosition $
.$ %
Lowest% +
,+ ,$
RadioCommunicationMarker- E
.E F
LowestF L
}M N
,N O
{ 
RadioTokenPosition $
.$ %
Interference% 1
,1 2$
RadioCommunicationMarker3 K
.K L
HiddenL R
}S T
} 
; 
private (
RadioCommunicationSubmission ,#
_pendingRadioSubmission- D
;D E
private 
HandCardViewModel !
_selectedRadioCard" 4
;4 5
private &
RadioMarkerOptionViewModel * 
_selectedRadioMarker+ ?
;? @
private 
bool &
_isCommunicationModeActive /
;/ 0
public    
ObservableCollection   #
<  # $&
RadioMarkerOptionViewModel  $ >
>  > ?!
AvailableRadioMarkers  @ U
{  V W
get  X [
;  [ \
}  ] ^
=  _ `
new!!  
ObservableCollection!! $
<!!$ %&
RadioMarkerOptionViewModel!!% ?
>!!? @
(!!@ A
)!!A B
;!!B C
public""  
ObservableCollection"" #
<""# $-
!PlayerRadioCommunicationViewModel""$ E
>""E F
RadioCommunications""G Z
{""[ \
get""] `
;""` a
}""b c
=""d e
new##  
ObservableCollection## $
<##$ %-
!PlayerRadioCommunicationViewModel##% F
>##F G
(##G H
)##H I
;##I J
public$$ 
ICommand$$ +
SubmitRadioCommunicationCommand$$ 7
{$$8 9
get$$: =
;$$= >
private$$? F
set$$G J
;$$J K
}$$L M
public%% 
ICommand%% *
ToggleCommunicationModeCommand%% 6
{%%7 8
get%%9 <
;%%< =
private%%> E
set%%F I
;%%I J
}%%K L
public'' 
bool'' %
IsCommunicationModeActive'' -
{(( 	
get)) 
=>)) &
_isCommunicationModeActive)) -
;))- .
set** 
{++ 
if,, 
(,, 
SetProperty,, 
(,,  
ref,,  #&
_isCommunicationModeActive,,$ >
,,,> ?
value,,@ E
),,E F
),,F G
{-- *
RefreshCommunicationHighlights.. 2
(..2 3
)..3 4
;..4 5$
MatchFeedbackResourceKey// ,
=//- .#
GetCurrentMatchFeedback/// F
(//F G
)//G H
;//H I
}00 
}11 
}22 	
public44 
HandCardViewModel44  
SelectedRadioCard44! 2
{55 	
get66 
=>66 
_selectedRadioCard66 %
;66% &
set77 
{88 
if99 
(99 
SetProperty99 
(99  
ref99  #
_selectedRadioCard99$ 6
,996 7
value998 =
)99= >
)99> ?
{:: %
RefreshRadioMarkerChoices;; -
(;;- .
);;. /
;;;/ 0
}<< 
}== 
}>> 	
public@@ &
RadioMarkerOptionViewModel@@ )
SelectedRadioMarker@@* =
{AA 	
getBB 
=>BB  
_selectedRadioMarkerBB '
;BB' (
setCC 
=>CC 
SetPropertyCC 
(CC 
refCC " 
_selectedRadioMarkerCC# 7
,CC7 8
valueCC9 >
)CC> ?
;CC? @
}DD 	
privateFF 
boolFF (
IsTrickReadyForCommunicationFF 1
{GG 	
getHH 
{II 
MatchCardPlayJJ 
[JJ 
]JJ 
playsJJ  %
=JJ& '#
_confirmedMatchSnapshotJJ( ?
?JJ? @
.JJ@ A!
CurrentTrickCardPlaysJJA V
;JJV W
returnKK 
playsKK 
==KK 
nullKK  $
||KK% '
playsKK( -
.KK- .
LengthKK. 4
==KK5 7
$numKK8 9
;KK9 :
}LL 
}MM 	
privateOO 
boolOO #
IsRadioAvailableByRulesOO ,
{PP 	
getQQ 
{RR 
boolSS 
isNotBlockedSS !
=SS" #
!SS$ %&
IsDistressSignalInProgressSS% ?
&&SS@ B
!SSC D$
IsMissionAttemptFinishedSSD \
;SS\ ]
boolTT 
isPreparationDoneTT &
=TT' ((
IsMissionPreparationCompleteTT) E
;TTE F
boolUU 
isRadioReadyUU !
=UU" ##
_confirmedMatchSnapshotUU$ ;
?UU; <
.UU< = 
OwnRadioAvailabilityUU= Q
?UUQ R
.UUR S
IsAvailableUUS ^
??UU_ a
trueUUb f
;UUf g
returnVV 
isNotBlockedVV #
&&VV$ &
isPreparationDoneVV' 8
&&VV9 ;
isRadioReadyVV< H
;VVH I
}WW 
}XX 	
publicZZ 
boolZZ 
CanCommunicateZZ "
=>ZZ# %"
IsMatchInPlayableState[[ "
&&[[# %#
IsRadioAvailableByRules\\ #
&&\\$ &(
IsTrickReadyForCommunication]] (
&&]]) +
!^^ &
HasLocalPlayerCommunicated^^ '
;^^' (
public`` 
bool`` 
CanChooseRadioCard`` &
=>``' )
CanCommunicate``* 8
;``8 9
privatebb 
voidbb "
InitializeRadioCommandbb +
(bb+ ,
)bb, -
{cc 	+
SubmitRadioCommunicationCommanddd +
=dd, -
newdd. 1
AsyncRelayCommanddd2 C
(ddC D)
SubmitRadioCommunicationAsyncddD a
,dda b
CanSubmitRadioddc q
)ddq r
;ddr s*
ToggleCommunicationModeCommandee *
=ee+ ,
newee- 0
RelayCommandee1 =
(ee= >*
ExecuteToggleCommunicationModeff .
,ff. /&
CanToggleCommunicationModeff0 J
)ffJ K
;ffK L
}gg 	
privateii 
boolii &
CanToggleCommunicationModeii /
(ii/ 0
objectii0 6
	parameterii7 @
)ii@ A
=>iiB D
CanCommunicateiiE S
;iiS T
privatekk 
voidkk *
ExecuteToggleCommunicationModekk 3
(kk3 4
objectkk4 :
	parameterkk; D
)kkD E
{ll 	
ifmm 
(mm 
CanCommunicatemm 
)mm 
{nn %
IsCommunicationModeActiveoo )
=oo* +
!oo, -%
IsCommunicationModeActiveoo- F
;ooF G
}pp 
elseqq 
{rr %
IsCommunicationModeActivess )
=ss* +
falsess, 1
;ss1 2
}tt 
}uu 	
publicww 
IReadOnlyListww 
<ww 
RadioTokenPositionww /
>ww/ 0$
GetValidPositionsForCardww1 I
(wwI J
intwwJ M
cardIdwwN T
)wwT U
{xx 	
IReadOnlyListyy 
<yy 
RadioTokenPositionyy ,
>yy, -
validPositionsyy. <
=yy= >
Arrayyy? D
.yyD E
EmptyyyE J
<yyJ K
RadioTokenPositionyyK ]
>yy] ^
(yy^ _
)yy_ `
;yy` a
ifzz 
(zz #
_confirmedMatchSnapshotzz '
?zz' (
.zz( )
OwnHandCardIdszz) 7
!=zz8 :
nullzz; ?
)zz? @
{{{ 
Card|| 
[|| 
]|| 
	handCards||  
=||! "
OwnHandCards||# /
.||/ 0
Select||0 6
(||6 7
card||7 ;
=>||< >
	DeckRules||? H
.||H I
GetCardById||I T
(||T U
card||U Y
.||Y Z
CardId||Z `
)||` a
)||a b
.||b c
ToArray||c j
(||j k
)||k l
;||l m
Card}} 
candidateCard}} "
=}}# $
	DeckRules}}% .
.}}. /
GetCardById}}/ :
(}}: ;
cardId}}; A
)}}A B
;}}B C!
CommunicationRuleType~~ %
mode~~& *
=~~+ ,#
_confirmedMatchSnapshot~~- D
.~~D E
	RadioMode~~E N
==~~O Q"
RadioCommunicationMode~~R h
.~~h i
Interference~~i u
? !
CommunicationRuleType +
.+ ,
Interference, 8
:
ÄÄ #
CommunicationRuleType
ÄÄ +
.
ÄÄ+ ,
Standard
ÄÄ, 4
;
ÄÄ4 5
validPositions
ÅÅ 
=
ÅÅ  %
RadioCommunicationRules
ÅÅ! 8
.
ÅÅ8 9&
GetValidPositionsForCard
ÅÅ9 Q
(
ÅÅQ R
	handCards
ÅÅR [
,
ÅÅ[ \
candidateCard
ÅÅ] j
,
ÅÅj k
mode
ÅÅl p
)
ÅÅp q
;
ÅÅq r
}
ÇÇ 
return
ÉÉ 
validPositions
ÉÉ !
;
ÉÉ! "
}
ÑÑ 	
public
ÜÜ 
void
ÜÜ ,
RefreshCommunicationHighlights
ÜÜ 2
(
ÜÜ2 3
)
ÜÜ3 4
{
áá 	
if
àà 
(
àà 
OwnHandCards
àà 
!=
àà 
null
àà  $
)
àà$ %
{
ââ 
foreach
ää 
(
ää 
HandCardViewModel
ää *
handCard
ää+ 3
in
ää4 6
OwnHandCards
ää7 C
)
ääC D
{
ãã 
bool
åå 

isEligible
åå #
=
åå$ %(
_isCommunicationModeActive
åå& @
&&
ååA C&
GetValidPositionsForCard
çç 0
(
çç0 1
handCard
çç1 9
.
çç9 :
CardId
çç: @
)
çç@ A
.
ççA B
Count
ççB G
>
ççH I
$num
ççJ K
;
ççK L
handCard
éé 
.
éé *
UpdateCommunicationHighlight
éé 9
(
éé9 :(
_isCommunicationModeActive
éé: T
,
ééT U

isEligible
ééV `
)
éé` a
;
ééa b
}
èè 
}
êê 
}
ëë 	
public
ìì 
async
ìì 
Task
ìì 3
%ExecuteCardCommunicationFromHandAsync
ìì ?
(
ìì? @
int
ìì@ C
cardId
ììD J
)
ììJ K
{
îî 	
if
ïï 
(
ïï %
_pendingRadioSubmission
ïï '
==
ïï( *
null
ïï+ /
)
ïï/ 0
{
ññ 
IReadOnlyList
óó 
<
óó  
RadioTokenPosition
óó 0
>
óó0 1
	positions
óó2 ;
=
óó< =&
GetValidPositionsForCard
óó> V
(
óóV W
cardId
óóW ]
)
óó] ^
;
óó^ _
if
òò 
(
òò 
	positions
òò 
!=
òò  
null
òò! %
&&
òò& (
	positions
òò) 2
.
òò2 3
Count
òò3 8
>
òò9 :
$num
òò; <
)
òò< =
{
ôô  
RadioTokenPosition
öö &
resolvedPosition
öö' 7
=
öö8 9
	positions
öö: C
[
ööC D
$num
ööD E
]
ööE F
;
ööF G'
IsCommunicationModeActive
õõ -
=
õõ. /
false
õõ0 5
;
õõ5 6&
RadioCommunicationMarker
úú ,
marker
úú- 3
=
úú4 5$
RadioMarkersByPosition
úú6 L
[
úúL M
resolvedPosition
úúM ]
]
úú] ^
;
úú^ _%
_pendingRadioSubmission
ùù +
=
ùù, -
new
ùù. 1*
RadioCommunicationSubmission
ùù2 N
{
ûû 
	LobbyCode
üü !
=
üü" #

_lobbyCode
üü$ .
,
üü. /
MatchId
†† 
=
††  !%
_confirmedMatchSnapshot
††" 9
.
††9 :
MatchId
††: A
,
††A B
MissionAttemptId
°° (
=
°°) *%
_confirmedMatchSnapshot
°°+ B
.
°°B C 
MissionPreparation
°°C U
.
°°U V
MissionAttemptId
°°V f
,
°°f g,
RadioCommunicationSubmissionId
¢¢ 6
=
¢¢7 8
Guid
¢¢9 =
.
¢¢= >
NewGuid
¢¢> E
(
¢¢E F
)
¢¢F G
,
¢¢G H'
ExpectedMatchStateVersion
££ 1
=
££2 3
MatchStateVersion
££4 E
,
££E F
CardId
§§ 
=
§§  
cardId
§§! '
,
§§' (
SelectedMarker
•• &
=
••' (
marker
••) /
}
¶¶ 
;
¶¶ 
await
ßß #
SynchronizeMatchAsync
ßß /
(
ßß/ 0
)
ßß0 1
;
ßß1 2
}
®® 
}
©© 
}
™™ 	
private
¨¨ 
bool
¨¨ 
CanSubmitRadio
¨¨ #
(
¨¨# $
)
¨¨$ %
{
≠≠ 	
return
ÆÆ  
CanChooseRadioCard
ÆÆ %
&&
ÆÆ& (
SelectedRadioCard
ÆÆ) :
!=
ÆÆ; =
null
ÆÆ> B
&&
ÆÆC E!
SelectedRadioMarker
ÆÆF Y
!=
ÆÆZ \
null
ÆÆ] a
&&
ÆÆb d
OwnHandCards
ØØ 
.
ØØ 
Contains
ØØ %
(
ØØ% &
SelectedRadioCard
ØØ& 7
)
ØØ7 8
&&
ØØ9 ;#
AvailableRadioMarkers
ØØ< Q
.
ØØQ R
Contains
ØØR Z
(
ØØZ [!
SelectedRadioMarker
ØØ[ n
)
ØØn o
;
ØØo p
}
∞∞ 	
private
≤≤ 
async
≤≤ 
Task
≤≤ +
SubmitRadioCommunicationAsync
≤≤ 8
(
≤≤8 9
)
≤≤9 :
{
≥≥ 	
if
¥¥ 
(
¥¥ 
CanSubmitRadio
¥¥ 
(
¥¥ 
)
¥¥  
)
¥¥  !
{
µµ %
_pendingRadioSubmission
∂∂ '
=
∂∂( )
new
∂∂* -*
RadioCommunicationSubmission
∂∂. J
{
∑∑ 
	LobbyCode
∏∏ 
=
∏∏ 

_lobbyCode
∏∏  *
,
∏∏* +
MatchId
ππ 
=
ππ %
_confirmedMatchSnapshot
ππ 5
.
ππ5 6
MatchId
ππ6 =
,
ππ= >
MissionAttemptId
∫∫ $
=
∫∫% &%
_confirmedMatchSnapshot
∫∫' >
.
∫∫> ? 
MissionPreparation
∫∫? Q
.
∫∫Q R
MissionAttemptId
∫∫R b
,
∫∫b c,
RadioCommunicationSubmissionId
ªª 2
=
ªª3 4
Guid
ªª5 9
.
ªª9 :
NewGuid
ªª: A
(
ªªA B
)
ªªB C
,
ªªC D'
ExpectedMatchStateVersion
ºº -
=
ºº. /
MatchStateVersion
ºº0 A
,
ººA B
CardId
ΩΩ 
=
ΩΩ 
SelectedRadioCard
ΩΩ .
.
ΩΩ. /
CardId
ΩΩ/ 5
,
ΩΩ5 6
SelectedMarker
ææ "
=
ææ# $!
SelectedRadioMarker
ææ% 8
.
ææ8 9
Marker
ææ9 ?
}
øø 
;
øø 
await
¿¿ #
SynchronizeMatchAsync
¿¿ +
(
¿¿+ ,
)
¿¿, -
;
¿¿- .
}
¡¡ 
}
¬¬ 	
private
ƒƒ 
async
ƒƒ 
Task
ƒƒ 
<
ƒƒ 
string
ƒƒ !
>
ƒƒ! "&
ConfirmPendingRadioAsync
ƒƒ# ;
(
ƒƒ; <
)
ƒƒ< =
{
≈≈ 	
string
∆∆ 
feedback
∆∆ 
=
∆∆ 
null
∆∆ "
;
∆∆" #
if
«« 
(
«« %
_pendingRadioSubmission
«« '
!=
««( *
null
««+ /
)
««/ 0
{
»» 
try
…… 
{
   ,
RadioCommunicationConfirmation
ÀÀ 2
confirmation
ÀÀ3 ?
=
ÀÀ@ A
await
ÀÀB G
_matchClient
ÀÀH T
.
ÀÀT U+
SubmitRadioCommunicationAsync
ÀÀU r
(
ÀÀr s%
_pendingRadioSubmission
ÃÃ /
,
ÃÃ/ 0 
_participantUserId
ÃÃ1 C
)
ÃÃC D
;
ÃÃD E
if
ÕÕ 
(
ÕÕ 
confirmation
ÕÕ $
.
ÕÕ$ %,
RadioCommunicationSubmissionId
ÕÕ% C
!=
ÕÕD F%
_pendingRadioSubmission
ŒŒ /
.
ŒŒ/ 0,
RadioCommunicationSubmissionId
ŒŒ0 N
)
ŒŒN O
{
œœ 
throw
–– 
new
–– !
FaultException
––" 0
<
––0 1
MatchAccessFault
––1 A
>
––A B
(
––B C
new
––C F
MatchAccessFault
––G W
{
—— 
FailureCode
—— %
=
——& '
nameof
——( .
(
——. /-
RadioCommunicationFailureReason
——/ N
.
——N O"
OperationUnavailable
——O c
)
——c d
}
——e f
)
——f g
;
——g h
}
““ %
_pendingRadioSubmission
”” +
=
””, -
null
””. 2
;
””2 3
}
‘‘ 
catch
’’ 
(
’’ 
FaultException
’’ %
<
’’% &%
RadioCommunicationFault
’’& =
>
’’= >
ex
’’? A
)
’’A B
{
÷÷ 
feedback
◊◊ 
=
◊◊ 
$str
◊◊ -
+
◊◊. /
ex
◊◊0 2
.
◊◊2 3
Detail
◊◊3 9
.
◊◊9 :
FailureReason
◊◊: G
;
◊◊G H
if
ÿÿ 
(
ÿÿ 
ex
ÿÿ 
.
ÿÿ 
Detail
ÿÿ !
.
ÿÿ! "
FailureReason
ÿÿ" /
!=
ÿÿ0 2-
RadioCommunicationFailureReason
ÿÿ3 R
.
ÿÿR S"
OperationUnavailable
ÿÿS g
)
ÿÿg h
{
ŸŸ %
_pendingRadioSubmission
⁄⁄ /
=
⁄⁄0 1
null
⁄⁄2 6
;
⁄⁄6 7
}
€€ 
}
‹‹ 
}
›› 
return
ﬁﬁ 
feedback
ﬁﬁ 
;
ﬁﬁ 
}
ﬂﬂ 	
private
·· 
void
·· '
RefreshRadioMarkerChoices
·· .
(
··. /
)
··/ 0
{
‚‚ 	#
AvailableRadioMarkers
„„ !
.
„„! "
Clear
„„" '
(
„„' (
)
„„( )
;
„„) *
if
‰‰ 
(
‰‰ 
SelectedRadioCard
‰‰ !
!=
‰‰" $
null
‰‰% )
&&
‰‰* ,%
_confirmedMatchSnapshot
‰‰- D
!=
‰‰E G
null
‰‰H L
)
‰‰L M
{
ÂÂ 
Card
ÊÊ 
[
ÊÊ 
]
ÊÊ 
hand
ÊÊ 
=
ÊÊ 
OwnHandCards
ÊÊ *
.
ÊÊ* +
Select
ÊÊ+ 1
(
ÊÊ1 2
card
ÊÊ2 6
=>
ÊÊ7 9
	DeckRules
ÊÊ: C
.
ÊÊC D
GetCardById
ÊÊD O
(
ÊÊO P
card
ÊÊP T
.
ÊÊT U
CardId
ÊÊU [
)
ÊÊ[ \
)
ÊÊ\ ]
.
ÊÊ] ^
ToArray
ÊÊ^ e
(
ÊÊe f
)
ÊÊf g
;
ÊÊg h#
CommunicationRuleType
ÁÁ %
mode
ÁÁ& *
=
ÁÁ+ ,%
_confirmedMatchSnapshot
ÁÁ- D
.
ÁÁD E
	RadioMode
ÁÁE N
==
ÁÁO Q$
RadioCommunicationMode
ÁÁR h
.
ÁÁh i
Interference
ÁÁi u
?
ËË #
CommunicationRuleType
ËË +
.
ËË+ ,
Interference
ËË, 8
:
ÈÈ #
CommunicationRuleType
ÈÈ +
.
ÈÈ+ ,
Standard
ÈÈ, 4
;
ÈÈ4 5
foreach
ÍÍ 
(
ÍÍ  
RadioTokenPosition
ÍÍ +
position
ÍÍ, 4
in
ÍÍ5 7%
RadioCommunicationRules
ÍÍ8 O
.
ÍÍO P&
GetValidPositionsForCard
ÍÍP h
(
ÍÍh i
hand
ÍÍi m
,
ÍÍm n
	DeckRules
ÎÎ 
.
ÎÎ 
GetCardById
ÎÎ )
(
ÎÎ) *
SelectedRadioCard
ÎÎ* ;
.
ÎÎ; <
CardId
ÎÎ< B
)
ÎÎB C
,
ÎÎC D
mode
ÎÎE I
)
ÎÎI J
)
ÎÎJ K
{
ÏÏ #
AvailableRadioMarkers
ÌÌ )
.
ÌÌ) *
Add
ÌÌ* -
(
ÌÌ- .
new
ÌÌ. 1(
RadioMarkerOptionViewModel
ÌÌ2 L
(
ÌÌL M$
RadioMarkersByPosition
ÌÌM c
[
ÌÌc d
position
ÌÌd l
]
ÌÌl m
)
ÌÌm n
)
ÌÌn o
;
ÌÌo p
}
ÓÓ 
}
ÔÔ !
SelectedRadioMarker
 
=
  !#
AvailableRadioMarkers
" 7
.
7 8
FirstOrDefault
8 F
(
F G
)
G H
;
H I
}
ÒÒ 	
private
ÛÛ 
void
ÛÛ  
ApplyRadioSnapshot
ÛÛ '
(
ÛÛ' (!
PlayerMatchSnapshot
ÛÛ( ;
snapshot
ÛÛ< D
)
ÛÛD E
{
ÙÙ 	!
RadioCommunications
ıı 
.
ıı  
Clear
ıı  %
(
ıı% &
)
ıı& '
;
ıı' (
foreach
ˆˆ 
(
ˆˆ .
 PlayerRadioCommunicationSnapshot
ˆˆ 5
communication
ˆˆ6 C
in
ˆˆD F
snapshot
ˆˆG O
.
ˆˆO P!
RadioCommunications
ˆˆP c
??
ˆˆd f
Array
˜˜ 
.
˜˜ 
Empty
˜˜ 
<
˜˜ .
 PlayerRadioCommunicationSnapshot
˜˜ <
>
˜˜< =
(
˜˜= >
)
˜˜> ?
)
˜˜? @
{
¯¯ !
RadioCommunications
˘˘ #
.
˘˘# $
Add
˘˘$ '
(
˘˘' (
new
˘˘( +/
!PlayerRadioCommunicationViewModel
˘˘, M
(
˘˘M N
communication
˘˘N [
,
˘˘[ \ 
GetParticipantName
˙˙ &
(
˙˙& '
communication
˙˙' 4
.
˙˙4 5
ParticipantUserId
˙˙5 F
)
˙˙F G
)
˙˙G H
)
˙˙H I
;
˙˙I J
}
˚˚ 
if
¸¸ 
(
¸¸ 
SelectedRadioCard
¸¸ !
!=
¸¸" $
null
¸¸% )
&&
¸¸* ,
!
¸¸- .
OwnHandCards
¸¸. :
.
¸¸: ;
Contains
¸¸; C
(
¸¸C D
SelectedRadioCard
¸¸D U
)
¸¸U V
)
¸¸V W
{
˝˝ 
SelectedRadioCard
˛˛ !
=
˛˛" #
null
˛˛$ (
;
˛˛( )
}
ˇˇ '
RefreshRadioMarkerChoices
ÄÄ %
(
ÄÄ% &
)
ÄÄ& '
;
ÄÄ' (.
 PlayerRadioCommunicationSnapshot
ÇÇ , 
localCommunication
ÇÇ- ?
=
ÇÇ@ A
snapshot
ÇÇB J
.
ÇÇJ K!
RadioCommunications
ÇÇK ^
?
ÇÇ^ _
.
ÉÉ 
FirstOrDefault
ÉÉ 
(
ÉÉ  
communication
ÉÉ  -
=>
ÉÉ. 0
communication
ÉÉ1 >
.
ÉÉ> ?
ParticipantUserId
ÉÉ? P
==
ÉÉQ S 
_participantUserId
ÉÉT f
)
ÉÉf g
;
ÉÉg h
foreach
ÖÖ 
(
ÖÖ 
HandCardViewModel
ÖÖ &
handCard
ÖÖ' /
in
ÖÖ0 2
OwnHandCards
ÖÖ3 ?
)
ÖÖ? @
{
ÜÜ 
bool
áá 
isCommunicated
áá #
=
áá$ % 
localCommunication
áá& 8
!=
áá9 ;
null
áá< @
&&
ááA C
!
àà  
localCommunication
àà '
.
àà' (+
HasCommunicatedCardBeenPlayed
àà( E
&&
ààF H 
localCommunication
ââ &
.
ââ& ' 
CommunicatedCardId
ââ' 9
==
ââ: <
handCard
ââ= E
.
ââE F
CardId
ââF L
;
ââL M
handCard
ää 
.
ää 
IsCommunicated
ää '
=
ää( )
isCommunicated
ää* 8
;
ää8 9
handCard
ãã 
.
ãã 
TokenPosition
ãã &
=
ãã' (
isCommunicated
ãã) 7
?
åå !
MapMarkerToPosition
åå )
(
åå) * 
localCommunication
åå* <
.
åå< =
Marker
åå= C
)
ååC D
:
çç  
RadioTokenPosition
çç (
.
çç( )
Highest
çç) 0
;
çç0 1
}
éé .
 UpdateSeatedPlayerCommunications
êê ,
(
êê, -
snapshot
êê- 5
)
êê5 6
;
êê6 7
if
íí 
(
íí 
!
íí 
CanCommunicate
íí 
&&
íí  "'
IsCommunicationModeActive
íí# <
)
íí< =
{
ìì '
IsCommunicationModeActive
îî )
=
îî* +
false
îî, 1
;
îî1 2
}
ïï ,
RefreshCommunicationHighlights
ññ *
(
ññ* +
)
ññ+ ,
;
ññ, -
OnPropertyChanged
òò 
(
òò 
nameof
òò $
(
òò$ % 
CanChooseRadioCard
òò% 7
)
òò7 8
)
òò8 9
;
òò9 :
OnPropertyChanged
ôô 
(
ôô 
nameof
ôô $
(
ôô$ %
CanCommunicate
ôô% 3
)
ôô3 4
)
ôô4 5
;
ôô5 6
OnPropertyChanged
öö 
(
öö 
nameof
öö $
(
öö$ %'
IsCommunicationModeActive
öö% >
)
öö> ?
)
öö? @
;
öö@ A
(
õõ ,
ToggleCommunicationModeCommand
õõ +
as
õõ, .
RelayCommand
õõ/ ;
)
õõ; <
?
õõ< =
.
õõ= >$
RaiseCanExecuteChanged
õõ> T
(
õõT U
)
õõU V
;
õõV W
}
úú 	
private
ûû 
static
ûû  
RadioTokenPosition
ûû )!
MapMarkerToPosition
ûû* =
(
ûû= >&
RadioCommunicationMarker
ûû> V
marker
ûûW ]
)
ûû] ^
{
üü 	
return
†† 
marker
†† 
switch
††  
{
°° &
RadioCommunicationMarker
¢¢ (
.
¢¢( )
Highest
¢¢) 0
=>
¢¢1 3 
RadioTokenPosition
¢¢4 F
.
¢¢F G
Highest
¢¢G N
,
¢¢N O&
RadioCommunicationMarker
££ (
.
££( )
Only
££) -
=>
££. 0 
RadioTokenPosition
££1 C
.
££C D
Only
££D H
,
££H I&
RadioCommunicationMarker
§§ (
.
§§( )
Lowest
§§) /
=>
§§0 2 
RadioTokenPosition
§§3 E
.
§§E F
Lowest
§§F L
,
§§L M&
RadioCommunicationMarker
•• (
.
••( )
Hidden
••) /
=>
••0 2 
RadioTokenPosition
••3 E
.
••E F
Interference
••F R
,
••R S
_
¶¶ 
=>
¶¶  
RadioTokenPosition
¶¶ '
.
¶¶' (
Highest
¶¶( /
}
ßß 
;
ßß 
}
®® 	
private
™™ 
void
™™ .
 UpdateSeatedPlayerCommunications
™™ 5
(
™™5 6!
PlayerMatchSnapshot
™™6 I
playerSnapshot
™™J X
)
™™X Y
{
´´ 	
if
¨¨ 
(
¨¨ 
_seatedPlayers
¨¨ 
!=
¨¨ !
null
¨¨" &
)
¨¨& '
{
≠≠ 
foreach
ÆÆ 
(
ÆÆ &
LobbyPlayerItemViewModel
ÆÆ 1
participant
ÆÆ2 =
in
ÆÆ> @
_seatedPlayers
ÆÆA O
)
ÆÆO P
{
ØØ .
 PlayerRadioCommunicationSnapshot
∞∞ 4
communication
∞∞5 B
=
∞∞C D
playerSnapshot
∞∞E S
.
∞∞S T!
RadioCommunications
∞∞T g
?
∞∞g h
.
±± 
FirstOrDefault
±± '
(
±±' (
item
±±( ,
=>
±±- /
item
±±0 4
.
±±4 5
ParticipantUserId
±±5 F
==
±±G I
participant
±±J U
.
±±U V
IdUser
±±V \
)
±±\ ]
;
±±] ^
if
≥≥ 
(
≥≥ 
communication
≥≥ %
!=
≥≥& (
null
≥≥) -
&&
≥≥. 0
!
≥≥1 2
communication
≥≥2 ?
.
≥≥? @+
HasCommunicatedCardBeenPlayed
≥≥@ ]
&&
≥≥^ `
communication
¥¥ %
.
¥¥% & 
CommunicatedCardId
¥¥& 8
>
¥¥9 :
$num
¥¥; <
)
¥¥< =
{
µµ 
participant
∂∂ #
.
∂∂# $$
UpdateCommunicatedCard
∂∂$ :
(
∂∂: ;
communication
∑∑ )
.
∑∑) * 
CommunicatedCardId
∑∑* <
,
∑∑< =!
MapMarkerToPosition
∑∑> Q
(
∑∑Q R
communication
∑∑R _
.
∑∑_ `
Marker
∑∑` f
)
∑∑f g
)
∑∑g h
;
∑∑h i
}
∏∏ 
else
ππ 
{
∫∫ 
participant
ªª #
.
ªª# $$
UpdateCommunicatedCard
ªª$ :
(
ªª: ;
null
ªª; ?
,
ªª? @ 
RadioTokenPosition
ªªA S
.
ªªS T
Highest
ªªT [
)
ªª[ \
;
ªª\ ]
}
ºº 
}
ΩΩ 
}
ææ 
}
øø 	
}
¿¿ 
}¡¡ Ñm
ÇC:\Users\oscar\source\repos\TrickTakingMissions\Client\ViewModel\ViewModels\Match\Board\MatchBoardViewModel.MissionInstructions.cs
	namespace 	
	ViewModel
 
. 

ViewModels 
{ 
public 

sealed 
partial 
class 
MatchBoardViewModel  3
{ 
private 
const 
int 
MissionFiveNumber +
=, -
$num. /
;/ 0
private 
const 
int 
MissionSixNumber *
=+ ,
$num- .
;. /
private 
const 
int 
MissionSevenNumber ,
=- .
$num/ 0
;0 1
private 
const 
int 
MissionEightNumber ,
=- .
$num/ 0
;0 1
private

 
const

 
int

 
MissionNineNumber

 +
=

, -
$num

. /
;

/ 0
private 
const 
int 
MissionTenNumber *
=+ ,
$num- /
;/ 0
private 
const 
int 
MissionElevenNumber -
=. /
$num0 2
;2 3
private 
const 
int 
MissionTwelveNumber -
=. /
$num0 2
;2 3
private 
const 
int !
MissionThirteenNumber /
=0 1
$num2 4
;4 5
private 
const 
int !
MissionFourteenNumber /
=0 1
$num2 4
;4 5
private 
const 
int  
MissionFifteenNumber .
=/ 0
$num1 3
;3 4
private 
const 
int  
MissionSixteenNumber .
=/ 0
$num1 3
;3 4
private 
const 
int "
MissionSeventeenNumber 0
=1 2
$num3 5
;5 6
private 
const 
int !
MissionEighteenNumber /
=0 1
$num2 4
;4 5
private 
const 
int !
MissionNineteenNumber /
=0 1
$num2 4
;4 5
private 
const 
int 
MissionTwentyNumber -
=. /
$num0 2
;2 3
private 
const 
int "
MissionTwentyOneNumber 0
=1 2
$num3 5
;5 6
private 
const 
int "
MissionTwentyTwoNumber 0
=1 2
$num3 5
;5 6
private 
const 
int $
MissionTwentyThreeNumber 2
=3 4
$num5 7
;7 8
private 
const 
int #
MissionTwentyFourNumber 1
=2 3
$num4 6
;6 7
private 
const 
int #
MissionTwentyFiveNumber 1
=2 3
$num4 6
;6 7
private 
const 
int "
MissionTwentySixNumber 0
=1 2
$num3 5
;5 6
private 
const 
int $
MissionTwentySevenNumber 2
=3 4
$num5 7
;7 8
private 
const 
int $
MissionTwentyEightNumber 2
=3 4
$num5 7
;7 8
private 
const 
int #
MissionTwentyNineNumber 1
=2 3
$num4 6
;6 7
private   
const   
int   
MissionThirtyNumber   -
=  . /
$num  0 2
;  2 3
private!! 
const!! 
int!! "
MissionThirtyOneNumber!! 0
=!!1 2
$num!!3 5
;!!5 6
private"" 
const"" 
int"" "
MissionThirtyTwoNumber"" 0
=""1 2
$num""3 5
;""5 6
private## 
const## 
int## $
MissionThirtyThreeNumber## 2
=##3 4
$num##5 7
;##7 8
private$$ 
const$$ 
int$$ #
MissionThirtyFourNumber$$ 1
=$$2 3
$num$$4 6
;$$6 7
private%% 
const%% 
int%% #
MissionThirtyFiveNumber%% 1
=%%2 3
$num%%4 6
;%%6 7
private'' 
const'' 
int'' "
MissionThirtySixNumber'' 0
=''1 2
$num''3 5
;''5 6
private(( 
const(( 
int(( $
MissionThirtySevenNumber(( 2
=((3 4
$num((5 7
;((7 8
private)) 
const)) 
int)) $
MissionThirtyEightNumber)) 2
=))3 4
$num))5 7
;))7 8
private** 
const** 
int** #
MissionThirtyNineNumber** 1
=**2 3
$num**4 6
;**6 7
private++ 
const++ 
int++ 
MissionFortyNumber++ ,
=++- .
$num++/ 1
;++1 2
private,, 
const,, 
int,, !
MissionFortyOneNumber,, /
=,,0 1
$num,,2 4
;,,4 5
private-- 
const-- 
int-- !
MissionFortyTwoNumber-- /
=--0 1
$num--2 4
;--4 5
private.. 
const.. 
int.. #
MissionFortyThreeNumber.. 1
=..2 3
$num..4 6
;..6 7
private// 
const// 
int// "
MissionFortyFourNumber// 0
=//1 2
$num//3 5
;//5 6
private00 
const00 
int00 "
MissionFortyFiveNumber00 0
=001 2
$num003 5
;005 6
private11 
const11 
int11 !
MissionFortySixNumber11 /
=110 1
$num112 4
;114 5
private22 
const22 
int22 #
MissionFortySevenNumber22 1
=222 3
$num224 6
;226 7
private33 
const33 
int33 #
MissionFortyEightNumber33 1
=332 3
$num334 6
;336 7
private44 
const44 
int44 "
MissionFortyNineNumber44 0
=441 2
$num443 5
;445 6
private55 
const55 
int55 
MissionFiftyNumber55 ,
=55- .
$num55/ 1
;551 2
private77 
static77 
readonly77 
System77  &
.77& '
Collections77' 2
.772 3
Generic773 :
.77: ;
IReadOnlyDictionary77; N
<77N O
int77O R
,77R S
string77T Z
>77Z [!
s_missionInstructions77\ q
=77r s
new88 
System88 
.88 
Collections88 "
.88" #
Generic88# *
.88* +

Dictionary88+ 5
<885 6
int886 9
,889 :
string88; A
>88A B
{99 
{:: 
MissionFiveNumber:: #
,::# $
$str::% Q
}::R S
,::S T
{;; 
MissionSixNumber;; "
,;;" #
$str;;$ O
};;P Q
,;;Q R
{<< 
MissionSevenNumber<< $
,<<$ %
$str<<& S
}<<T U
,<<U V
{== 
MissionEightNumber== $
,==$ %
$str==& S
}==T U
,==U V
{>> 
MissionNineNumber>> #
,>># $
$str>>% Q
}>>R S
,>>S T
{?? 
MissionTenNumber?? "
,??" #
$str??$ O
}??P Q
,??Q R
{@@ 
MissionElevenNumber@@ %
,@@% &
$str@@' U
}@@V W
,@@W X
{AA 
MissionTwelveNumberAA %
,AA% &
$strAA' U
}AAV W
,AAW X
{BB !
MissionThirteenNumberBB '
,BB' (
$strBB) Y
}BBZ [
,BB[ \
{CC !
MissionFourteenNumberCC '
,CC' (
$strCC) Y
}CCZ [
,CC[ \
{DD  
MissionFifteenNumberDD &
,DD& '
$strDD( W
}DDX Y
,DDY Z
{EE  
MissionSixteenNumberEE &
,EE& '
$strEE( W
}EEX Y
,EEY Z
{FF "
MissionSeventeenNumberFF (
,FF( )
$strFF* [
}FF\ ]
,FF] ^
{GG !
MissionEighteenNumberGG '
,GG' (
$strGG) Y
}GGZ [
,GG[ \
{HH !
MissionNineteenNumberHH '
,HH' (
$strHH) Y
}HHZ [
,HH[ \
{II 
MissionTwentyNumberII %
,II% &
$strII' U
}IIV W
,IIW X
{JJ "
MissionTwentyOneNumberJJ (
,JJ( )
$strJJ* [
}JJ\ ]
,JJ] ^
{KK "
MissionTwentyTwoNumberKK (
,KK( )
$strKK* [
}KK\ ]
,KK] ^
{LL $
MissionTwentyThreeNumberLL *
,LL* +
$strLL, _
}LL` a
,LLa b
{MM #
MissionTwentyFourNumberMM )
,MM) *
$strMM+ ]
}MM^ _
,MM_ `
{NN #
MissionTwentyFiveNumberNN )
,NN) *
$strNN+ ]
}NN^ _
,NN_ `
{OO "
MissionTwentySixNumberOO (
,OO( )
$strOO* [
}OO\ ]
,OO] ^
{PP $
MissionTwentySevenNumberPP *
,PP* +
$strPP, _
}PP` a
,PPa b
{QQ $
MissionTwentyEightNumberQQ *
,QQ* +
$strQQ, _
}QQ` a
,QQa b
{RR #
MissionTwentyNineNumberRR )
,RR) *
$strRR+ ]
}RR^ _
,RR_ `
{SS 
MissionThirtyNumberSS %
,SS% &
$strSS' U
}SSV W
,SSW X
{TT "
MissionThirtyOneNumberTT (
,TT( )
$strTT* [
}TT\ ]
,TT] ^
{UU "
MissionThirtyTwoNumberUU (
,UU( )
$strUU* [
}UU\ ]
,UU] ^
{VV $
MissionThirtyThreeNumberVV *
,VV* +
$strVV, _
}VV` a
,VVa b
{WW #
MissionThirtyFourNumberWW )
,WW) *
$strWW+ ]
}WW^ _
,WW_ `
{XX #
MissionThirtyFiveNumberXX )
,XX) *
$strXX+ ]
}XX^ _
,XX_ `
{YY "
MissionThirtySixNumberYY (
,YY( )
$strYY* [
}YY\ ]
,YY] ^
{ZZ $
MissionThirtySevenNumberZZ *
,ZZ* +
$strZZ, _
}ZZ` a
,ZZa b
{[[ $
MissionThirtyEightNumber[[ *
,[[* +
$str[[, _
}[[` a
,[[a b
{\\ #
MissionThirtyNineNumber\\ )
,\\) *
$str\\+ ]
}\\^ _
,\\_ `
{]] 
MissionFortyNumber]] $
,]]$ %
$str]]& S
}]]T U
,]]U V
{^^ !
MissionFortyOneNumber^^ '
,^^' (
$str^^) Y
}^^Z [
,^^[ \
{__ !
MissionFortyTwoNumber__ '
,__' (
$str__) Y
}__Z [
,__[ \
{`` #
MissionFortyThreeNumber`` )
,``) *
$str``+ ]
}``^ _
,``_ `
{aa "
MissionFortyFourNumberaa (
,aa( )
$straa* [
}aa\ ]
,aa] ^
{bb "
MissionFortyFiveNumberbb (
,bb( )
$strbb* [
}bb\ ]
,bb] ^
{cc !
MissionFortySixNumbercc '
,cc' (
$strcc) Y
}ccZ [
,cc[ \
{dd #
MissionFortySevenNumberdd )
,dd) *
$strdd+ ]
}dd^ _
,dd_ `
{ee #
MissionFortyEightNumberee )
,ee) *
$stree+ ]
}ee^ _
,ee_ `
{ff "
MissionFortyNineNumberff (
,ff( )
$strff* [
}ff\ ]
,ff] ^
{gg 
MissionFiftyNumbergg $
,gg$ %
$strgg& S
}ggT U
}hh 
;hh 
publicjj 
booljj '
IsMissionInstructionVisiblejj /
=>jj0 2!
s_missionInstructionskk !
.kk! "
ContainsKeykk" -
(kk- .#
_confirmedMatchSnapshotkk. E
?kkE F
.kkF G
MissionPreparationkkG Y
?kkY Z
.kkZ [
MissionNumberkk[ h
??kki k
$numkkl m
)kkm n
;kkn o
publicmm 
stringmm )
MissionInstructionResourceKeymm 3
=>mm4 6'
IsMissionInstructionVisiblemm7 R
?nn !
s_missionInstructionsnn #
[nn# $#
_confirmedMatchSnapshotnn$ ;
.nn; <
MissionPreparationnn< N
.nnN O
MissionNumbernnO \
]nn\ ]
:nn^ _
stringnn` f
.nnf g
Emptynng l
;nnl m
privatepp 
voidpp .
"NotifyMissionInstructionPropertiespp 7
(pp7 8
)pp8 9
{qq 	
OnPropertyChangedrr 
(rr 
nameofrr $
(rr$ %'
IsMissionInstructionVisiblerr% @
)rr@ A
)rrA B
;rrB C
OnPropertyChangedss 
(ss 
nameofss $
(ss$ %)
MissionInstructionResourceKeyss% B
)ssB C
)ssC D
;ssD E
}tt 	
}uu 
}vv ∫g
}C:\Users\oscar\source\repos\TrickTakingMissions\Client\ViewModel\ViewModels\Match\Board\MatchBoardViewModel.ObjectiveDraft.cs
	namespace		 	
	ViewModel		
 
.		 

ViewModels		 
{

 
public 

sealed 
partial 
class 
MatchBoardViewModel  3
{ 
private +
MissionObjectiveDraftSubmission /,
 _pendingObjectiveDraftSubmission0 P
;P Q
private 
Guid /
#_lastSelectionFreeCycleSubmissionId 8
;8 9
public  
ObservableCollection #
<# $%
MissionObjectiveViewModel$ =
>= >'
UnassignedMissionObjectives? Z
{[ \
get] `
;` a
}b c
=d e
new  
ObservableCollection $
<$ %%
MissionObjectiveViewModel% >
>> ?
(? @
)@ A
;A B
public 
ICommand )
SelectMissionObjectiveCommand 5
{6 7
get8 ;
;; <
private= D
setE H
;H I
}J K
public 
ICommand %
PassObjectiveDraftCommand 1
{2 3
get4 7
;7 8
private9 @
setA D
;D E
}F G
public 
bool (
IsMissionPreparationComplete 0
=>1 3#
_confirmedMatchSnapshot4 K
?K L
.L M
MissionPreparationM _
?_ `
.` a!
IsPreparationCompletea v
?? 
false 
; 
public 
bool #
IsObjectiveDraftVisible +
=>, .#
_confirmedMatchSnapshot/ F
?F G
.G H
MissionPreparationH Z
!=[ ]
null^ b
&&c e
! (
IsMissionPreparationComplete )
&&* ,
!- .'
IsSpecialPreparationVisible. I
;I J
public 
string +
CurrentObjectiveDraftPlayerName 5
=>6 8
GetParticipantName9 K
(K L#
_confirmedMatchSnapshot #
?# $
.$ %
MissionPreparation% 7
?7 8
.8 9-
!CurrentObjectiveDraftPlayerUserId9 Z
??[ ]
$num^ _
)_ `
;` a
private 
void ,
 InitializeObjectiveDraftCommands 5
(5 6
)6 7
{ 	)
SelectMissionObjectiveCommand )
=* +
new, /
AsyncRelayCommand0 A
(A B'
SelectMissionObjectiveAsync +
,+ ,%
CanSelectMissionObjective- F
)F G
;G H%
PassObjectiveDraftCommand %
=& '
new( +
AsyncRelayCommand, =
(= >#
PassObjectiveDraftAsync> U
,U V#
CanSubmitObjectiveDraftW n
)n o
;o p
}   	
private"" 
bool"" !
CanSubmitMatchRequest"" *
(""* +
)""+ ,
{## 	
return$$ 
!$$ 
_isDisposed$$ 
&&$$  "
_isMatchConnected$$# 4
&&$$5 7 
_isRequestInProgress$$8 L
==$$M O
$num$$P Q
&&$$R T,
 _pendingObjectiveDraftSubmission%% 0
==%%1 3
null%%4 8
&&%%9 ;&
_pendingCardPlaySubmission%%< V
==%%W Y
null%%Z ^
&&%%_ a#
_pendingRadioSubmission&& '
==&&( *
null&&+ /
&&&&0 2
!&&3 4!
HasPendingPreparation&&4 I
;&&I J
}'' 	
private)) 
bool)) #
CanSubmitObjectiveDraft)) ,
()), -
)))- .
{** 	
return++ !
CanSubmitMatchRequest++ (
(++( )
)++) *
&&+++ -#
IsObjectiveDraftVisible++. E
&&++F H#
_confirmedMatchSnapshot,, '
.,,' (
MissionPreparation,,( :
.,,: ;-
!CurrentObjectiveDraftPlayerUserId,,; \
==,,] _
_participantUserId,,` r
&&,,s u#
_confirmedMatchSnapshot-- '
.--' (
MissionPreparation--( :
.--: ;/
#AvailableObjectiveDraftSubmissionId--; ^
.--^ _
HasValue--_ g
;--g h
}.. 	
private00 
bool00 %
CanSelectMissionObjective00 .
(00. /
object00/ 5
selectedObjective006 G
)00G H
{11 	
return22 #
CanSubmitObjectiveDraft22 *
(22* +
)22+ ,
&&22- /
selectedObjective220 A
is22B D
Guid22E I
objectiveId22J U
&&22V X'
UnassignedMissionObjectives33 +
.33+ ,
Any33, /
(33/ 0
	objective330 9
=>33: <
	objective33= F
.33F G
MissionObjectiveId33G Y
==33Z \
objectiveId33] h
)33h i
;33i j
}44 	
private66 
async66 
Task66 '
SelectMissionObjectiveAsync66 6
(666 7
object667 =
selectedObjective66> O
)66O P
{77 	
if88 
(88 %
CanSelectMissionObjective88 )
(88) *
selectedObjective88* ;
)88; <
)88< =
{99 
await:: %
SubmitObjectiveDraftAsync:: /
(::/ 0'
MissionObjectiveDraftAction::0 K
.::K L
SelectObjective::L [
,::[ \
(::] ^
Guid::^ b
)::b c
selectedObjective::c t
)::t u
;::u v
};; 
}<< 	
private>> 
async>> 
Task>> #
PassObjectiveDraftAsync>> 2
(>>2 3
)>>3 4
{?? 	
if@@ 
(@@ #
CanSubmitObjectiveDraft@@ '
(@@' (
)@@( )
)@@) *
{AA 
awaitBB %
SubmitObjectiveDraftAsyncBB /
(BB/ 0'
MissionObjectiveDraftActionBB0 K
.BBK L
PassBBL P
,BBP Q
nullBBR V
)BBV W
;BBW X
}CC 
}DD 	
privateFF 
asyncFF 
TaskFF %
SubmitObjectiveDraftAsyncFF 4
(FF4 5'
MissionObjectiveDraftActionFF5 P
actionFFQ W
,FFW X
GuidFFY ]
?FF] ^
objectiveIdFF_ j
)FFj k
{GG 	,
 _pendingObjectiveDraftSubmissionHH ,
=HH- .
newHH/ 2+
MissionObjectiveDraftSubmissionHH3 R
{II 
	LobbyCodeJJ 
=JJ 

_lobbyCodeJJ &
,JJ& '
MatchIdKK 
=KK #
_confirmedMatchSnapshotKK 1
.KK1 2
MatchIdKK2 9
,KK9 :
MissionAttemptIdLL  
=LL! "#
_confirmedMatchSnapshotLL# :
.LL: ;
MissionPreparationLL; M
.LLM N
MissionAttemptIdLLN ^
,LL^ _&
ObjectiveDraftSubmissionIdMM *
=MM+ ,#
_confirmedMatchSnapshotNN +
.NN+ ,
MissionPreparationNN, >
.NN> ?/
#AvailableObjectiveDraftSubmissionIdNN? b
.NNb c
ValueNNc h
,NNh i%
ExpectedMatchStateVersionOO )
=OO* +
MatchStateVersionOO, =
,OO= > 
ObjectiveDraftActionPP $
=PP% &
actionPP' -
,PP- .&
SelectedMissionObjectiveIdQQ *
=QQ+ ,
objectiveIdQQ- 8
}RR 
;RR 
awaitSS !
SynchronizeMatchAsyncSS '
(SS' (
)SS( )
;SS) *
}TT 	
privateVV 
asyncVV 
TaskVV 
<VV 
stringVV !
>VV! "-
!ConfirmPendingObjectiveDraftAsyncVV# D
(VVD E
)VVE F
{WW 	
stringXX 
feedbackResourceKeyXX &
=XX' (
nullXX) -
;XX- .
ifYY 
(YY ,
 _pendingObjectiveDraftSubmissionYY 0
!=YY1 3
nullYY4 8
)YY8 9
{ZZ )
MissionObjectiveDraftDecision[[ -
decision[[. 6
=[[7 8
await[[9 >
_matchClient[[? K
.[[K L,
 ProcessObjectiveDraftActionAsync[[L l
([[l m,
 _pendingObjectiveDraftSubmission\\ 4
,\\4 5
_participantUserId\\6 H
)\\H I
;\\I J
if]] 
(]] 
!]] 
_isDisposed]]  
&&]]! #
decision]]$ ,
.]], -&
ObjectiveDraftSubmissionId]]- G
==]]H J,
 _pendingObjectiveDraftSubmission^^ 4
.^^4 5&
ObjectiveDraftSubmissionId^^5 O
)^^O P
{__ 
feedbackResourceKey`` '
=``( )-
!GetObjectiveDraftDecisionFeedback``* K
(``K L
decision``L T
)``T U
;``U V,
 _pendingObjectiveDraftSubmissionaa 4
=aa5 6
nullaa7 ;
;aa; <
}bb 
}cc 
returndd 
feedbackResourceKeydd &
;dd& '
}ee 	
privategg 
stringgg -
!GetObjectiveDraftDecisionFeedbackgg 8
(gg8 9)
MissionObjectiveDraftDecisiongg9 V
decisionggW _
)gg_ `
{hh 	
stringii 
feedbackResourceKeyii &
=ii' (
nullii) -
;ii- .
ifjj 
(jj 
!jj 
decisionjj 
.jj 

IsAcceptedjj $
)jj$ %
{kk 
feedbackResourceKeyll #
=ll$ %
$strll& ;
+ll< =
decisionll> F
.llF G
RejectionReasonllG V
;llV W
}mm 
elsenn 
ifnn 
(nn 
decisionnn 
.nn *
HasCompletedSelectionFreeCyclenn <
&&nn= ?/
#_lastSelectionFreeCycleSubmissionIdoo 3
!=oo4 6
decisionoo7 ?
.oo? @&
ObjectiveDraftSubmissionIdoo@ Z
)ooZ [
{pp /
#_lastSelectionFreeCycleSubmissionIdqq 3
=qq4 5
decisionqq6 >
.qq> ?&
ObjectiveDraftSubmissionIdqq? Y
;qqY Z
feedbackResourceKeyrr #
=rr$ %
$strrr& M
;rrM N
}ss 
returntt 
feedbackResourceKeytt &
;tt& '
}uu 	
privateww 
voidww '
ApplyObjectiveDraftSnapshotww 0
(ww0 1,
 PlayerMissionPreparationSnapshotww1 Q
preparationwwR ]
)ww] ^
{xx 	'
UnassignedMissionObjectivesyy '
.yy' (
Clearyy( -
(yy- .
)yy. /
;yy/ 0
foreachzz 
(zz $
LobbyPlayerItemViewModelzz -
participantzz. 9
inzz: <
_seatedPlayerszz= K
)zzK L
{{{ 
participant|| 
.|| 
MissionObjectives|| -
.||- .
Clear||. 3
(||3 4
)||4 5
;||5 6
}}} 
foreach~~ 
(~~ $
MissionObjectiveSnapshot~~ -
	objective~~. 7
in~~8 :
preparation~~; F
?~~F G
.~~G H

Objectives~~H R
??~~S U
new~~V Y$
MissionObjectiveSnapshot~~Z r
[~~r s
$num~~s t
]~~t u
)~~u v
{ 
var
ÄÄ  
objectiveViewModel
ÄÄ &
=
ÄÄ' (
new
ÄÄ) ,'
MissionObjectiveViewModel
ÄÄ- F
(
ÄÄF G
	objective
ÄÄG P
)
ÄÄP Q
;
ÄÄQ R
if
ÅÅ 
(
ÅÅ 
!
ÅÅ 
	objective
ÅÅ 
.
ÅÅ "
AssignedPlayerUserId
ÅÅ 3
.
ÅÅ3 4
HasValue
ÅÅ4 <
)
ÅÅ< =
{
ÇÇ )
UnassignedMissionObjectives
ÉÉ /
.
ÉÉ/ 0
Add
ÉÉ0 3
(
ÉÉ3 4 
objectiveViewModel
ÉÉ4 F
)
ÉÉF G
;
ÉÉG H
}
ÑÑ 
else
ÖÖ 
{
ÜÜ 
_seatedPlayers
áá "
.
áá" #
Find
áá# '
(
áá' (
participant
áá( 3
=>
áá4 6
participant
áá7 B
.
ááB C
IdUser
ááC I
==
ááJ L
	objective
ááM V
.
ááV W"
AssignedPlayerUserId
ááW k
)
áák l
?
àà 
.
àà 
MissionObjectives
àà +
.
àà+ ,
Add
àà, /
(
àà/ 0 
objectiveViewModel
àà0 B
)
ààB C
;
ààC D
}
ââ 
}
ää 
OnPropertyChanged
ãã 
(
ãã 
nameof
ãã $
(
ãã$ %*
IsMissionPreparationComplete
ãã% A
)
ããA B
)
ããB C
;
ããC D
OnPropertyChanged
åå 
(
åå 
nameof
åå $
(
åå$ %%
IsObjectiveDraftVisible
åå% <
)
åå< =
)
åå= >
;
åå> ?
OnPropertyChanged
çç 
(
çç 
nameof
çç $
(
çç$ %-
CurrentObjectiveDraftPlayerName
çç% D
)
ççD E
)
ççE F
;
ççF G
}
éé 	
}
èè 
}êê ÷
yC:\Users\oscar\source\repos\TrickTakingMissions\Client\ViewModel\ViewModels\Match\Objectives\MissionObjectiveViewModel.cs
	namespace 	
	ViewModel
 
. 

ViewModels 
{ 
public 

sealed 
class %
MissionObjectiveViewModel 1
{ 
public %
MissionObjectiveViewModel (
(( )$
MissionObjectiveSnapshot) A
	objectiveB K
)K L
{		 	
MissionObjectiveId

 
=

  
	objective

! *
.

* +
MissionObjectiveId

+ =
;

= >
CardId 
= 
	objective 
. 
CardId %
;% &
Token 
= 
	objective 
. 
Token #
;# $
Status 
= 
	objective 
. 
Status %
;% &"
CompletedAtTrickNumber "
=# $
	objective% .
.. /"
CompletedAtTrickNumber/ E
;E F
} 	
public 
Guid 
MissionObjectiveId &
{' (
get) ,
;, -
}. /
public 
int 
? 
CardId 
{ 
get  
;  !
}" #
public !
MissionObjectiveToken $
Token% *
{+ ,
get- 0
;0 1
}2 3
public "
MissionObjectiveStatus %
Status& ,
{- .
get/ 2
;2 3
}4 5
public 
int 
? "
CompletedAtTrickNumber *
{+ ,
get- 0
;0 1
}2 3
public 
bool 
IsCompleted 
=>  "
Status# )
==* ,"
MissionObjectiveStatus- C
.C D
	CompletedD M
;M N
public 
bool 
IsFailed 
=> 
Status  &
==' )"
MissionObjectiveStatus* @
.@ A
FailedA G
;G H
public 
string &
ObjectiveStatusResourceKey 0
=>1 3
$str4 R
+S T
StatusU [
;[ \
} 
} ®
`C:\Users\oscar\source\repos\TrickTakingMissions\Client\ViewModel\Constants\MatchTablePosition.cs
	namespace 	
	ViewModel
 
. 
	Constants 
{ 
public 

enum 
MatchTablePosition "
{ 
Local 
, 
Left 
, 
Top 
, 
Right		 
}

 
} Ω

nC:\Users\oscar\source\repos\TrickTakingMissions\Client\ViewModel\ViewModels\Match\Cards\PlayedCardViewModel.cs
	namespace 	
	ViewModel
 
. 

ViewModels 
{ 
public 

sealed 
class 
PlayedCardViewModel +
{ 
public 
PlayedCardViewModel "
(" #
int# &
cardId' -
,- .
string/ 5
playerUsername6 D
,D E
MatchTablePosition		 
tablePosition		 ,
=		- .
MatchTablePosition		/ A
.		A B
Local		B G
)		G H
{

 	
CardId 
= 
cardId 
; 
TablePosition 
= 
tablePosition )
;) *
PlayerUsername 
= 
playerUsername +
;+ ,
} 	
public 
MatchTablePosition !
TablePosition" /
{0 1
get2 5
;5 6
}7 8
public 
int 
CardId 
{ 
get 
;  
}! "
public 
string 
PlayerUsername $
{% &
get' *
;* +
}, -
} 
} º”
áC:\Users\oscar\source\repos\TrickTakingMissions\Client\ViewModel\ViewModels\Match\Board\MatchBoardViewModel.CommunicationAndDistress.cs
	namespace 	
	ViewModel
 
. 

ViewModels 
{ 
public 

sealed 
partial 
class 
MatchBoardViewModel  3
{ 
private 
bool '
_isDistressSignalDialogOpen 0
;0 1
private !
DistressPassDirection %&
_selectedDistressDirection& @
=A B!
DistressPassDirectionC X
.X Y
LeftY ]
;] ^
private 
int #
_selectedDistressCardId +
;+ ,
private 
bool ,
 _hasShownDistressRejectionNotice 5
;5 6
public  
ObservableCollection #
<# $
int$ '
>' (#
EligibleDistressCardIds) @
{A B
getC F
;F G
}H I
=J K
new  
ObservableCollection $
<$ %
int% (
>( )
() *
)* +
;+ ,
public 
ICommand +
OpenDistressSignalDialogCommand 7
{8 9
get: =
;= >
private? F
setG J
;J K
}L M
public 
ICommand ,
 CloseDistressSignalDialogCommand 8
{9 :
get; >
;> ?
private@ G
setH K
;K L
}M N
public 
ICommand %
SelectDistressCardCommand 1
{2 3
get4 7
;7 8
private9 @
setA D
;D E
}F G
public 
ICommand -
!ProposeDistressSignalUsageCommand 9
{: ;
get< ?
;? @
privateA H
setI L
;L M
}N O
public 
ICommand '
VoteDistressUsageYesCommand 3
{4 5
get6 9
;9 :
private; B
setC F
;F G
}H I
public 
ICommand &
VoteDistressUsageNoCommand 2
{3 4
get5 8
;8 9
private: A
setB E
;E F
}G H
public 
ICommand ,
 VoteDistressDirectionLeftCommand 8
{9 :
get; >
;> ?
private@ G
setH K
;K L
}M N
public   
ICommand   -
!VoteDistressDirectionRightCommand   9
{  : ;
get  < ?
;  ? @
private  A H
set  I L
;  L M
}  N O
public!! 
ICommand!! /
#ConfirmDistressCardSelectionCommand!! ;
{!!< =
get!!> A
;!!A B
private!!C J
set!!K N
;!!N O
}!!P Q
public"" 
ICommand"" )
CancelDistressProposalCommand"" 5
{""6 7
get""8 ;
;""; <
private""= D
set""E H
;""H I
}""J K
public$$ "
DistressSignalSnapshot$$ %
DistressSignal$$& 4
=>$$5 7#
_confirmedMatchSnapshot$$8 O
?$$O P
.$$P Q
DistressSignal$$Q _
;$$_ `
public&& 
bool&& !
HasUsedDistressSignal&& )
=>&&* ,
DistressSignal&&- ;
?&&; <
.&&< =!
HasUsedDistressSignal&&= R
??&&S U
false&&V [
;&&[ \
public(( 
bool(( &
IsDistressSignalInProgress(( .
=>((/ 1
DistressSignal((2 @
?((@ A
.((A B
IsInProgress((B N
??((O Q
false((R W
;((W X
public** 
DistressSignalPhase** "
CurrentDistressStep**# 6
=>**7 9
DistressSignal++ 
?++ 
.++ 
CurrentStep++ '
??++( *
DistressSignalPhase+++ >
.++> ?
None++? C
;++C D
public-- 
bool-- %
IsLocalDistressUsageVoted-- -
{.. 	
get// 
{00 
int11 
[11 
]11 
voted11 
=11 
DistressSignal11 ,
?11, -
.11- .
VotedYesUserIds11. =
;11= >
return22 
voted22 
!=22 
null22  $
&&22% '
voted22( -
.22- .
Contains22. 6
(226 7
_participantUserId227 I
)22I J
;22J K
}33 
}44 	
public66 
bool66 )
IsLocalDistressDirectionVoted66 1
{77 	
get88 
{99 
int:: 
[:: 
]:: 
voted:: 
=:: 
DistressSignal:: ,
?::, -
.::- .!
DirectionVotedUserIds::. C
;::C D
return;; 
voted;; 
!=;; 
null;;  $
&&;;% '
voted;;( -
.;;- .
Contains;;. 6
(;;6 7
_participantUserId;;7 I
);;I J
;;;J K
}<< 
}== 	
public?? 
bool?? (
IsLocalDistressCardSubmitted?? 0
{@@ 	
getAA 
{BB 
intCC 
[CC 
]CC 
	submittedCC 
=CC  !
DistressSignalCC" 0
?CC0 1
.CC1 2'
SubmittedParticipantUserIdsCC2 M
;CCM N
returnDD 
	submittedDD  
!=DD! #
nullDD$ (
&&DD) +
	submittedDD, 5
.DD5 6
ContainsDD6 >
(DD> ?
_participantUserIdDD? Q
)DDQ R
;DDR S
}EE 
}FF 	
publicHH 
boolHH -
!IsDistressInitiatorConfirmVisibleHH 5
=>HH6 8&
IsDistressSignalDialogOpenII &
&&II' )
(JJ 
!JJ &
IsDistressSignalInProgressJJ (
||JJ) +
CurrentDistressStepJJ, ?
==JJ@ B
DistressSignalPhaseJJC V
.JJV W
NoneJJW [
)JJ[ \
;JJ\ ]
publicLL 
boolLL &
IsDistressUsageVoteVisibleLL .
=>LL/ 1&
IsDistressSignalDialogOpenMM &
&&MM' )
CurrentDistressStepNN 
==NN  "
DistressSignalPhaseNN# 6
.NN6 7
VotingToUseNN7 B
&&NNC E
!OO %
IsLocalDistressUsageVotedOO &
;OO& '
publicQQ 
boolQQ *
IsDistressDirectionVoteVisibleQQ 2
=>QQ3 5&
IsDistressSignalDialogOpenRR &
&&RR' )
CurrentDistressStepSS 
==SS  "
DistressSignalPhaseSS# 6
.SS6 7
VotingDirectionSS7 F
&&SSG I
!TT )
IsLocalDistressDirectionVotedTT *
;TT* +
publicVV 
boolVV *
IsDistressCardSelectionVisibleVV 2
=>VV3 5&
IsDistressSignalDialogOpenWW &
&&WW' )
CurrentDistressStepXX 
==XX  "
DistressSignalPhaseXX# 6
.XX6 7
SelectingCardXX7 D
&&XXE G
!YY (
IsLocalDistressCardSubmittedYY )
;YY) *
public[[ 
bool[[ $
IsDistressWaitingVisible[[ ,
=>[[- /&
IsDistressSignalDialogOpen\\ &
&&\\' )
(\\* +
(]] 
CurrentDistressStep]] $
==]]% '
DistressSignalPhase]]( ;
.]]; <
VotingToUse]]< G
&&]]H J%
IsLocalDistressUsageVoted]]K d
)]]d e
||]]f h
(^^ 
CurrentDistressStep^^ $
==^^% '
DistressSignalPhase^^( ;
.^^; <
VotingDirection^^< K
&&^^L N)
IsLocalDistressDirectionVoted^^O l
)^^l m
||^^n p
(__ 
CurrentDistressStep__ $
==__% '
DistressSignalPhase__( ;
.__; <
SelectingCard__< I
&&__J L(
IsLocalDistressCardSubmitted__M i
)__i j
)__j k
;__k l
publicaa 
stringaa !
DistressInitiatorNameaa +
{bb 	
getcc 
{dd 
stringee 
initiatorNameee $
=ee% &
stringee' -
.ee- .
Emptyee. 3
;ee3 4
intff 
initiatorIdff 
=ff  !
DistressSignalff" 0
?ff0 1
.ff1 2
InitiatorUserIdff2 A
??ffB D
$numffE F
;ffF G
ifgg 
(gg 
initiatorIdgg 
!=gg  "
$numgg# $
)gg$ %
{hh $
LobbyPlayerItemViewModelii ,
matchedPlayerii- :
=ii; <
_seatedPlayersii= K
?iiK L
.jj 
FirstOrDefaultjj '
(jj' (
playerjj( .
=>jj/ 1
playerjj2 8
.jj8 9
IdUserjj9 ?
==jj@ B
initiatorIdjjC N
)jjN O
;jjO P
initiatorNamekk !
=kk" #
matchedPlayerkk$ 1
?kk1 2
.kk2 3
Usernamekk3 ;
??kk< >
GetParticipantNamekk? Q
(kkQ R
initiatorIdkkR ]
)kk] ^
;kk^ _
}ll 
returnmm 
initiatorNamemm $
;mm$ %
}nn 
}oo 	
publicqq 
intqq &
DistressUsageYesVotesCountqq -
=>qq. 0
DistressSignalqq1 ?
?qq? @
.qq@ A
VotedYesUserIdsqqA P
?qqP Q
.qqQ R
LengthqqR X
??qqY [
$numqq\ ]
;qq] ^
publicss 
intss '
DistressDirectionVotesCountss .
=>ss/ 1
DistressSignalss2 @
?ss@ A
.ssA B!
DirectionVotedUserIdsssB W
?ssW X
.ssX Y
LengthssY _
??ss` b
$numssc d
;ssd e
publicuu 
intuu '
DistressCardsSubmittedCountuu .
=>uu/ 1
DistressSignaluu2 @
?uu@ A
.uuA B'
SubmittedParticipantUserIdsuuB ]
?uu] ^
.uu^ _
Lengthuu_ e
??uuf h
$numuui j
;uuj k
publicww 
intww %
DistressTotalPlayersCountww ,
=>ww- /
_seatedPlayersww0 >
?ww> ?
.ww? @
Countww@ E
??wwF H
(xx #
_confirmedMatchSnapshotxx $
?xx$ %
.xx% &
ParticipantUserIdsxx& 8
?xx8 9
.xx9 :
Lengthxx: @
??xxA C
$numxxD E
)xxE F
;xxF G
publiczz 
stringzz '
DistressWaitingProgressTextzz 1
{{{ 	
get|| 
{}} 
int~~ 
currentCount~~  
=~~! "'
DistressCardsSubmittedCount~~# >
;~~> ?
if 
( 
CurrentDistressStep '
==( *
DistressSignalPhase+ >
.> ?
VotingToUse? J
)J K
{
ÄÄ 
currentCount
ÅÅ  
=
ÅÅ! "(
DistressUsageYesVotesCount
ÅÅ# =
;
ÅÅ= >
}
ÇÇ 
else
ÉÉ 
if
ÉÉ 
(
ÉÉ !
CurrentDistressStep
ÉÉ ,
==
ÉÉ- /!
DistressSignalPhase
ÉÉ0 C
.
ÉÉC D
VotingDirection
ÉÉD S
)
ÉÉS T
{
ÑÑ 
currentCount
ÖÖ  
=
ÖÖ! ")
DistressDirectionVotesCount
ÖÖ# >
;
ÖÖ> ?
}
ÜÜ 
return
áá 
$"
áá 
{
áá 
currentCount
áá &
}
áá& '
$str
áá' *
{
áá* +'
DistressTotalPlayersCount
áá+ D
}
ááD E
"
ááE F
;
ááF G
}
àà 
}
ââ 	
public
ãã 
string
ãã ,
DistressStepWaitingResourceKey
ãã 4
{
åå 	
get
çç 
{
éé 
string
èè 
resourceKey
èè "
=
èè# $
$str
èè% B
;
èèB C
if
êê 
(
êê !
CurrentDistressStep
êê '
==
êê( *!
DistressSignalPhase
êê+ >
.
êê> ?
VotingToUse
êê? J
)
êêJ K
{
ëë 
resourceKey
íí 
=
íí  !
$str
íí" ?
;
íí? @
}
ìì 
else
îî 
if
îî 
(
îî !
CurrentDistressStep
îî ,
==
îî- /!
DistressSignalPhase
îî0 C
.
îîC D
VotingDirection
îîD S
)
îîS T
{
ïï 
resourceKey
ññ 
=
ññ  !
$str
ññ" C
;
ññC D
}
óó 
else
òò 
if
òò 
(
òò !
CurrentDistressStep
òò ,
==
òò- /!
DistressSignalPhase
òò0 C
.
òòC D
SelectingCard
òòD Q
)
òòQ R
{
ôô 
resourceKey
öö 
=
öö  !
$str
öö" ?
;
öö? @
}
õõ 
return
úú 
resourceKey
úú "
;
úú" #
}
ùù 
}
ûû 	
public
†† 
string
†† 0
"DistressAgreedDirectionResourceKey
†† 8
=>
††9 ;
DistressSignal
°° 
?
°° 
.
°° 
AgreedDirection
°° +
==
°°, .#
DistressPassDirection
°°/ D
.
°°D E
Right
°°E J
?
¢¢ 
$str
¢¢ 2
:
££ 
$str
££ 1
;
££1 2
public
•• 
bool
•• (
IsDistressSignalDialogOpen
•• .
{
¶¶ 	
get
ßß 
=>
ßß )
_isDistressSignalDialogOpen
ßß .
;
ßß. /
set
®® 
{
©© 
if
™™ 
(
™™ 
SetProperty
™™ 
(
™™  
ref
™™  #)
_isDistressSignalDialogOpen
™™$ ?
,
™™? @
value
™™A F
)
™™F G
)
™™G H
{
´´ -
NotifyDistressPhaseVisibilities
¨¨ 3
(
¨¨3 4
)
¨¨4 5
;
¨¨5 6
}
≠≠ 
}
ÆÆ 
}
ØØ 	
public
±± #
DistressPassDirection
±± $'
SelectedDistressDirection
±±% >
{
≤≤ 	
get
≥≥ 
=>
≥≥ (
_selectedDistressDirection
≥≥ -
;
≥≥- .
set
¥¥ 
=>
¥¥ 
SetProperty
¥¥ 
(
¥¥ 
ref
¥¥ "(
_selectedDistressDirection
¥¥# =
,
¥¥= >
value
¥¥? D
)
¥¥D E
;
¥¥E F
}
µµ 	
public
∑∑ 
int
∑∑ $
SelectedDistressCardId
∑∑ )
{
∏∏ 	
get
ππ 
=>
ππ %
_selectedDistressCardId
ππ *
;
ππ* +
set
∫∫ 
{
ªª 
if
ºº 
(
ºº 
SetProperty
ºº 
(
ºº  
ref
ºº  #%
_selectedDistressCardId
ºº$ ;
,
ºº; <
value
ºº= B
)
ººB C
)
ººC D
{
ΩΩ 
OnPropertyChanged
ææ %
(
ææ% &
nameof
ææ& ,
(
ææ, -$
CanConfirmDistressCard
ææ- C
)
ææC D
)
ææD E
;
ææE F
CommandManager
øø "
.
øø" #(
InvalidateRequerySuggested
øø# =
(
øø= >
)
øø> ?
;
øø? @
}
¿¿ 
}
¡¡ 
}
¬¬ 	
public
ƒƒ 
bool
ƒƒ $
CanConfirmDistressCard
ƒƒ *
=>
ƒƒ+ -$
SelectedDistressCardId
≈≈ "
>
≈≈# $
$num
≈≈% &
&&
≈≈' )!
CurrentDistressStep
∆∆ 
==
∆∆  "!
DistressSignalPhase
∆∆# 6
.
∆∆6 7
SelectingCard
∆∆7 D
&&
∆∆E G
!
«« *
IsLocalDistressCardSubmitted
«« )
;
««) *
public
…… 
bool
…… (
HasLocalPlayerCommunicated
…… .
=>
……/ 1%
_confirmedMatchSnapshot
   #
?
  # $
.
  $ %!
RadioCommunications
  % 8
!=
  9 ;
null
  < @
&&
  A C%
_confirmedMatchSnapshot
ÀÀ #
.
ÀÀ# $!
RadioCommunications
ÀÀ$ 7
.
ÀÀ7 8
Any
ÀÀ8 ;
(
ÀÀ; <
communication
ÃÃ 
=>
ÃÃ  
communication
ÃÃ! .
.
ÃÃ. /
ParticipantUserId
ÃÃ/ @
==
ÃÃA C 
_participantUserId
ÃÃD V
)
ÃÃV W
;
ÃÃW X
public
ŒŒ 
bool
ŒŒ &
HasAnyPlayerCommunicated
ŒŒ ,
=>
ŒŒ- /%
_confirmedMatchSnapshot
œœ #
?
œœ# $
.
œœ$ %!
RadioCommunications
œœ% 8
!=
œœ9 ;
null
œœ< @
&&
œœA C%
_confirmedMatchSnapshot
–– #
.
––# $!
RadioCommunications
––$ 7
.
––7 8
Length
––8 >
>
––? @
$num
––A B
;
––B C
public
““ 
bool
““ "
CanUseDistressSignal
““ (
{
”” 	
get
‘‘ 
{
’’ 
bool
÷÷ 
isContextReady
÷÷ #
=
÷÷$ %
!
÷÷& '
_isDisposed
÷÷' 2
&&
÷÷3 5
_isMatchConnected
÷÷6 G
&&
÷÷H J%
_confirmedMatchSnapshot
◊◊ +
!=
◊◊, .
null
◊◊/ 3
&&
◊◊4 6
!
ÿÿ %
_confirmedMatchSnapshot
ÿÿ ,
.
ÿÿ, -
IsDealCompleted
ÿÿ- <
&&
ÿÿ= ?*
IsMissionPreparationComplete
ŸŸ 0
&&
ŸŸ1 3
!
⁄⁄ &
IsMissionAttemptFinished
⁄⁄ -
;
⁄⁄- .
bool
‹‹ 

isTrickOne
‹‹ 
=
‹‹  !%
_confirmedMatchSnapshot
‹‹" 9
!=
‹‹: <
null
‹‹= A
&&
‹‹B D%
_confirmedMatchSnapshot
›› +
.
››+ , 
CurrentTrickNumber
››, >
<=
››? A
$num
››B C
&&
››D F
(
ﬁﬁ %
_confirmedMatchSnapshot
ﬁﬁ ,
.
ﬁﬁ, -#
CurrentTrickCardPlays
ﬁﬁ- B
==
ﬁﬁC E
null
ﬁﬁF J
||
ﬁﬁK M%
_confirmedMatchSnapshot
ﬂﬂ ,
.
ﬂﬂ, -#
CurrentTrickCardPlays
ﬂﬂ- B
.
ﬂﬂB C
Length
ﬂﬂC I
==
ﬂﬂJ L
$num
ﬂﬂM N
)
ﬂﬂN O
;
ﬂﬂO P
return
·· 
isContextReady
·· %
&&
··& (

isTrickOne
··) 3
&&
··4 6
!
··7 8#
HasUsedDistressSignal
··8 M
&&
··N P
!
‚‚ &
HasAnyPlayerCommunicated
‚‚ -
&&
‚‚. 0
!
‚‚1 2(
IsDistressSignalInProgress
‚‚2 L
;
‚‚L M
}
„„ 
}
‰‰ 	
private
ÊÊ 
void
ÊÊ .
 InitializeDistressSignalCommands
ÊÊ 5
(
ÊÊ5 6
)
ÊÊ6 7
{
ÁÁ 	-
OpenDistressSignalDialogCommand
ËË +
=
ËË, -
new
ËË. 1
RelayCommand
ËË2 >
(
ËË> ?&
OpenDistressSignalDialog
ÈÈ (
,
ÈÈ( ))
CanOpenDistressSignalDialog
ÈÈ* E
)
ÈÈE F
;
ÈÈF G.
 CloseDistressSignalDialogCommand
ÍÍ ,
=
ÍÍ- .
new
ÍÍ/ 2
AsyncRelayCommand
ÍÍ3 D
(
ÍÍD E3
%ExecuteCloseDistressSignalDialogAsync
ÎÎ 5
)
ÎÎ5 6
;
ÎÎ6 7'
SelectDistressCardCommand
ÏÏ %
=
ÏÏ& '
new
ÏÏ( +
RelayCommand
ÏÏ, 8
(
ÏÏ8 9 
SelectDistressCard
ÏÏ9 K
)
ÏÏK L
;
ÏÏL M/
!ProposeDistressSignalUsageCommand
ÌÌ -
=
ÌÌ. /
new
ÌÌ0 3
AsyncRelayCommand
ÌÌ4 E
(
ÌÌE F4
&ExecuteProposeDistressSignalUsageAsync
ÓÓ 6
,
ÓÓ6 7-
CanExecuteProposeDistressSignal
ÓÓ8 W
)
ÓÓW X
;
ÓÓX Y)
VoteDistressUsageYesCommand
ÔÔ '
=
ÔÔ( )
new
ÔÔ* -
AsyncRelayCommand
ÔÔ. ?
(
ÔÔ? @.
 ExecuteVoteDistressUsageYesAsync
 0
,
0 1)
CanExecuteVoteDistressUsage
2 M
)
M N
;
N O(
VoteDistressUsageNoCommand
ÒÒ &
=
ÒÒ' (
new
ÒÒ) ,
AsyncRelayCommand
ÒÒ- >
(
ÒÒ> ?-
ExecuteVoteDistressUsageNoAsync
ÚÚ /
,
ÚÚ/ 0)
CanExecuteVoteDistressUsage
ÚÚ1 L
)
ÚÚL M
;
ÚÚM N.
 VoteDistressDirectionLeftCommand
ÛÛ ,
=
ÛÛ- .
new
ÛÛ/ 2
AsyncRelayCommand
ÛÛ3 D
(
ÛÛD E3
%ExecuteVoteDistressDirectionLeftAsync
ÙÙ 5
,
ÙÙ5 6-
CanExecuteVoteDistressDirection
ÙÙ7 V
)
ÙÙV W
;
ÙÙW X/
!VoteDistressDirectionRightCommand
ıı -
=
ıı. /
new
ıı0 3
AsyncRelayCommand
ıı4 E
(
ııE F4
&ExecuteVoteDistressDirectionRightAsync
ˆˆ 6
,
ˆˆ6 7-
CanExecuteVoteDistressDirection
ˆˆ8 W
)
ˆˆW X
;
ˆˆX Y1
#ConfirmDistressCardSelectionCommand
˜˜ /
=
˜˜0 1
new
˜˜2 5
AsyncRelayCommand
˜˜6 G
(
˜˜G H6
(ExecuteConfirmDistressCardSelectionAsync
¯¯ 8
,
¯¯8 9+
CanExecuteConfirmDistressCard
¯¯: W
)
¯¯W X
;
¯¯X Y+
CancelDistressProposalCommand
˘˘ )
=
˘˘* +
new
˘˘, /
AsyncRelayCommand
˘˘0 A
(
˘˘A B0
"ExecuteCancelDistressProposalAsync
˙˙ 2
,
˙˙2 3.
 CanExecuteCancelDistressProposal
˙˙4 T
)
˙˙T U
;
˙˙U V
}
˚˚ 	
private
˝˝ 
bool
˝˝ )
CanOpenDistressSignalDialog
˝˝ 0
(
˝˝0 1
object
˝˝1 7
	parameter
˝˝8 A
)
˝˝A B
{
˛˛ 	
return
ˇˇ "
CanUseDistressSignal
ˇˇ '
;
ˇˇ' (
}
ÄÄ 	
private
ÇÇ 
void
ÇÇ &
OpenDistressSignalDialog
ÇÇ -
(
ÇÇ- .
object
ÇÇ. 4
	parameter
ÇÇ5 >
)
ÇÇ> ?
{
ÉÉ 	
if
ÑÑ 
(
ÑÑ "
CanUseDistressSignal
ÑÑ $
)
ÑÑ$ %
{
ÖÖ (
IsDistressSignalDialogOpen
ÜÜ *
=
ÜÜ+ ,
true
ÜÜ- 1
;
ÜÜ1 2
}
áá 
}
àà 	
private
ää 
async
ää 
Task
ää 3
%ExecuteCloseDistressSignalDialogAsync
ää @
(
ää@ A
object
ääA G
	parameter
ääH Q
)
ääQ R
{
ãã 	
if
åå 
(
åå (
IsDistressSignalInProgress
åå *
)
åå* +
{
çç 
await
éé 0
"ExecuteCancelDistressProposalAsync
éé 8
(
éé8 9
null
éé9 =
)
éé= >
;
éé> ?
}
èè 
else
êê 
{
ëë (
IsDistressSignalDialogOpen
íí *
=
íí+ ,
false
íí- 2
;
íí2 3
}
ìì 
}
îî 	
private
ññ 
bool
ññ -
CanExecuteProposeDistressSignal
ññ 4
(
ññ4 5
object
ññ5 ;
	parameter
ññ< E
)
ññE F
{
óó 	
return
òò #
CanSubmitMatchRequest
òò (
(
òò( )
)
òò) *
&&
òò+ -"
CanUseDistressSignal
òò. B
&&
òòC E
!
òòF G(
IsDistressSignalInProgress
òòG a
;
òòa b
}
ôô 	
private
õõ 
async
õõ 
Task
õõ 4
&ExecuteProposeDistressSignalUsageAsync
õõ A
(
õõA B
object
õõB H
	parameter
õõI R
)
õõR S
{
úú 	&
DistressSignalSubmission
ùù $

submission
ùù% /
=
ùù0 1&
CreateDistressSubmission
ùù2 J
(
ùùJ K&
DistressSignalActionType
ûû (
.
ûû( )
ProposeUsage
ûû) 5
,
ûû5 6
true
ûû7 ;
)
ûû; <
;
ûû< =
await
üü )
SendDistressSubmissionAsync
üü -
(
üü- .

submission
üü. 8
)
üü8 9
;
üü9 :
}
†† 	
private
¢¢ 
bool
¢¢ )
CanExecuteVoteDistressUsage
¢¢ 0
(
¢¢0 1
object
¢¢1 7
	parameter
¢¢8 A
)
¢¢A B
{
££ 	
return
§§ #
CanSubmitMatchRequest
§§ (
(
§§( )
)
§§) *
&&
§§+ -(
IsDistressSignalInProgress
§§. H
&&
§§I K!
CurrentDistressStep
•• #
==
••$ &!
DistressSignalPhase
••' :
.
••: ;
VotingToUse
••; F
&&
••G I
!
••J K'
IsLocalDistressUsageVoted
••K d
;
••d e
}
¶¶ 	
private
®® 
async
®® 
Task
®® .
 ExecuteVoteDistressUsageYesAsync
®® ;
(
®®; <
object
®®< B
	parameter
®®C L
)
®®L M
{
©© 	&
DistressSignalSubmission
™™ $

submission
™™% /
=
™™0 1&
CreateDistressSubmission
™™2 J
(
™™J K&
DistressSignalActionType
´´ (
.
´´( )
	VoteUsage
´´) 2
,
´´2 3
true
´´4 8
)
´´8 9
;
´´9 :
await
¨¨ )
SendDistressSubmissionAsync
¨¨ -
(
¨¨- .

submission
¨¨. 8
)
¨¨8 9
;
¨¨9 :
}
≠≠ 	
private
ØØ 
async
ØØ 
Task
ØØ -
ExecuteVoteDistressUsageNoAsync
ØØ :
(
ØØ: ;
object
ØØ; A
	parameter
ØØB K
)
ØØK L
{
∞∞ 	&
DistressSignalSubmission
±± $

submission
±±% /
=
±±0 1&
CreateDistressSubmission
±±2 J
(
±±J K&
DistressSignalActionType
≤≤ (
.
≤≤( )
	VoteUsage
≤≤) 2
,
≤≤2 3
false
≤≤4 9
)
≤≤9 :
;
≤≤: ;
await
≥≥ )
SendDistressSubmissionAsync
≥≥ -
(
≥≥- .

submission
≥≥. 8
)
≥≥8 9
;
≥≥9 :
}
¥¥ 	
private
∂∂ 
bool
∂∂ -
CanExecuteVoteDistressDirection
∂∂ 4
(
∂∂4 5
object
∂∂5 ;
	parameter
∂∂< E
)
∂∂E F
{
∑∑ 	
return
∏∏ #
CanSubmitMatchRequest
∏∏ (
(
∏∏( )
)
∏∏) *
&&
∏∏+ -(
IsDistressSignalInProgress
∏∏. H
&&
∏∏I K!
CurrentDistressStep
ππ #
==
ππ$ &!
DistressSignalPhase
ππ' :
.
ππ: ;
VotingDirection
ππ; J
&&
ππK M
!
ππN O+
IsLocalDistressDirectionVoted
ππO l
;
ππl m
}
∫∫ 	
private
ºº 
async
ºº 
Task
ºº 3
%ExecuteVoteDistressDirectionLeftAsync
ºº @
(
ºº@ A
object
ººA G
	parameter
ººH Q
)
ººQ R
{
ΩΩ 	&
DistressSignalSubmission
ææ $

submission
ææ% /
=
ææ0 1&
CreateDistressSubmission
ææ2 J
(
ææJ K&
DistressSignalActionType
øø (
.
øø( )
VoteDirection
øø) 6
,
øø6 7
true
øø8 <
)
øø< =
;
øø= >

submission
¿¿ 
.
¿¿ 
SelectedDirection
¿¿ (
=
¿¿) *#
DistressPassDirection
¿¿+ @
.
¿¿@ A
Left
¿¿A E
;
¿¿E F
await
¡¡ )
SendDistressSubmissionAsync
¡¡ -
(
¡¡- .

submission
¡¡. 8
)
¡¡8 9
;
¡¡9 :
}
¬¬ 	
private
ƒƒ 
async
ƒƒ 
Task
ƒƒ 4
&ExecuteVoteDistressDirectionRightAsync
ƒƒ A
(
ƒƒA B
object
ƒƒB H
	parameter
ƒƒI R
)
ƒƒR S
{
≈≈ 	&
DistressSignalSubmission
∆∆ $

submission
∆∆% /
=
∆∆0 1&
CreateDistressSubmission
∆∆2 J
(
∆∆J K&
DistressSignalActionType
«« (
.
««( )
VoteDirection
««) 6
,
««6 7
true
««8 <
)
««< =
;
««= >

submission
»» 
.
»» 
SelectedDirection
»» (
=
»») *#
DistressPassDirection
»»+ @
.
»»@ A
Right
»»A F
;
»»F G
await
…… )
SendDistressSubmissionAsync
…… -
(
……- .

submission
……. 8
)
……8 9
;
……9 :
}
   	
private
ÃÃ 
bool
ÃÃ +
CanExecuteConfirmDistressCard
ÃÃ 2
(
ÃÃ2 3
object
ÃÃ3 9
	parameter
ÃÃ: C
)
ÃÃC D
{
ÕÕ 	
return
ŒŒ #
CanSubmitMatchRequest
ŒŒ (
(
ŒŒ( )
)
ŒŒ) *
&&
ŒŒ+ -$
CanConfirmDistressCard
ŒŒ. D
;
ŒŒD E
}
œœ 	
private
—— 
async
—— 
Task
—— 6
(ExecuteConfirmDistressCardSelectionAsync
—— C
(
——C D
object
——D J
	parameter
——K T
)
——T U
{
““ 	&
DistressSignalSubmission
”” $

submission
””% /
=
””0 1&
CreateDistressSubmission
””2 J
(
””J K&
DistressSignalActionType
‘‘ (
.
‘‘( )
SubmitPassCard
‘‘) 7
,
‘‘7 8
true
‘‘9 =
)
‘‘= >
;
‘‘> ?

submission
’’ 
.
’’ 
CardIdToPass
’’ #
=
’’$ %$
SelectedDistressCardId
’’& <
;
’’< =

submission
÷÷ 
.
÷÷ 
SelectedDirection
÷÷ (
=
÷÷) *
DistressSignal
÷÷+ 9
?
÷÷9 :
.
÷÷: ;
AgreedDirection
÷÷; J
??
÷÷K M#
DistressPassDirection
÷÷N c
.
÷÷c d
Left
÷÷d h
;
÷÷h i
await
◊◊ )
SendDistressSubmissionAsync
◊◊ -
(
◊◊- .

submission
◊◊. 8
)
◊◊8 9
;
◊◊9 :
}
ÿÿ 	
private
⁄⁄ 
bool
⁄⁄ .
 CanExecuteCancelDistressProposal
⁄⁄ 5
(
⁄⁄5 6
object
⁄⁄6 <
	parameter
⁄⁄= F
)
⁄⁄F G
{
€€ 	
return
‹‹ #
CanSubmitMatchRequest
‹‹ (
(
‹‹( )
)
‹‹) *
&&
‹‹+ -(
IsDistressSignalInProgress
‹‹. H
;
‹‹H I
}
›› 	
private
ﬂﬂ 
async
ﬂﬂ 
Task
ﬂﬂ 0
"ExecuteCancelDistressProposalAsync
ﬂﬂ =
(
ﬂﬂ= >
object
ﬂﬂ> D
	parameter
ﬂﬂE N
)
ﬂﬂN O
{
‡‡ 	&
DistressSignalSubmission
·· $

submission
··% /
=
··0 1&
CreateDistressSubmission
··2 J
(
··J K&
DistressSignalActionType
‚‚ (
.
‚‚( )
CancelProposal
‚‚) 7
,
‚‚7 8
false
‚‚9 >
)
‚‚> ?
;
‚‚? @
await
„„ )
SendDistressSubmissionAsync
„„ -
(
„„- .

submission
„„. 8
)
„„8 9
;
„„9 :
}
‰‰ 	
private
ÊÊ &
DistressSignalSubmission
ÊÊ (&
CreateDistressSubmission
ÊÊ) A
(
ÊÊA B&
DistressSignalActionType
ÁÁ $

actionType
ÁÁ% /
,
ÁÁ/ 0
bool
ÁÁ1 5
isVoteAccepted
ÁÁ6 D
)
ÁÁD E
{
ËË 	
return
ÈÈ 
new
ÈÈ &
DistressSignalSubmission
ÈÈ /
{
ÍÍ 
MatchId
ÎÎ 
=
ÎÎ %
_confirmedMatchSnapshot
ÎÎ 1
?
ÎÎ1 2
.
ÎÎ2 3
MatchId
ÎÎ3 :
??
ÎÎ; =
Guid
ÎÎ> B
.
ÎÎB C
Empty
ÎÎC H
,
ÎÎH I
	LobbyCode
ÏÏ 
=
ÏÏ 

_lobbyCode
ÏÏ &
,
ÏÏ& '
MissionAttemptId
ÌÌ  
=
ÌÌ! "%
_confirmedMatchSnapshot
ÌÌ# :
?
ÌÌ: ;
.
ÌÌ; < 
MissionPreparation
ÌÌ< N
?
ÌÌN O
.
ÌÌO P
MissionAttemptId
ÌÌP `
??
ÌÌa c
$num
ÌÌd e
,
ÌÌe f
IsVoteAccepted
ÓÓ 
=
ÓÓ  
isVoteAccepted
ÓÓ! /
,
ÓÓ/ 0

ActionType
ÔÔ 
=
ÔÔ 

actionType
ÔÔ '
}
 
;
 
}
ÒÒ 	
private
ÛÛ 
async
ÛÛ 
Task
ÛÛ 
<
ÛÛ 
bool
ÛÛ 
>
ÛÛ  )
SendDistressSubmissionAsync
ÛÛ! <
(
ÛÛ< =&
DistressSignalSubmission
ÛÛ= U

submission
ÛÛV `
)
ÛÛ` a
{
ÙÙ 	
bool
ıı 

isAccepted
ıı 
=
ıı 
false
ıı #
;
ıı# $
if
ˆˆ 
(
ˆˆ %
_confirmedMatchSnapshot
ˆˆ '
!=
ˆˆ( *
null
ˆˆ+ /
)
ˆˆ/ 0
{
˜˜ 
try
¯¯ 
{
˘˘ (
DistressSignalConfirmation
˙˙ .
confirmation
˙˙/ ;
=
˙˙< =
await
˙˙> C
_matchClient
˙˙D P
.
˙˙P Q'
SubmitDistressSignalAsync
˙˙Q j
(
˙˙j k

submission
˚˚ "
,
˚˚" # 
_participantUserId
˚˚$ 6
)
˚˚6 7
;
˚˚7 8
if
¸¸ 
(
¸¸ 
confirmation
¸¸ $
!=
¸¸% '
null
¸¸( ,
)
¸¸, -
{
˝˝ 

isAccepted
˛˛ "
=
˛˛# $
true
˛˛% )
;
˛˛) *
await
ˇˇ #
SynchronizeMatchAsync
ˇˇ 3
(
ˇˇ3 4
)
ˇˇ4 5
;
ˇˇ5 6
}
ÄÄ 
}
ÅÅ 
catch
ÇÇ 
(
ÇÇ 
FaultException
ÇÇ %
<
ÇÇ% &!
DistressSignalFault
ÇÇ& 9
>
ÇÇ9 :
ex
ÇÇ; =
)
ÇÇ= >
{
ÉÉ &
MatchFeedbackResourceKey
ÑÑ ,
=
ÑÑ- .
$str
ÑÑ/ @
+
ÑÑA B
ex
ÑÑC E
.
ÑÑE F
Detail
ÑÑF L
.
ÑÑL M
FailureReason
ÑÑM Z
;
ÑÑZ [
await
ÖÖ #
SynchronizeMatchAsync
ÖÖ /
(
ÖÖ/ 0
)
ÖÖ0 1
;
ÖÖ1 2
}
ÜÜ 
}
áá 
return
àà 

isAccepted
àà 
;
àà 
}
ââ 	
private
ãã 
void
ãã  
SelectDistressCard
ãã '
(
ãã' (
object
ãã( .
	parameter
ãã/ 8
)
ãã8 9
{
åå 	
if
çç 
(
çç 
	parameter
çç 
is
çç 
int
çç  
cardId
çç! '
)
çç' (
{
éé $
SelectedDistressCardId
èè &
=
èè' (
cardId
èè) /
;
èè/ 0
}
êê 
}
ëë 	
private
ìì 
void
ìì +
PopulateEligibleDistressCards
ìì 2
(
ìì2 3
)
ìì3 4
{
îî 	%
EligibleDistressCardIds
ïï #
.
ïï# $
Clear
ïï$ )
(
ïï) *
)
ïï* +
;
ïï+ ,
if
ññ 
(
ññ %
_confirmedMatchSnapshot
ññ '
?
ññ' (
.
ññ( )
OwnHandCardIds
ññ) 7
!=
ññ8 :
null
ññ; ?
)
ññ? @
{
óó 
foreach
òò 
(
òò 
int
òò 
cardId
òò #
in
òò$ &%
_confirmedMatchSnapshot
òò' >
.
òò> ?
OwnHandCardIds
òò? M
)
òòM N
{
ôô 
Card
öö 
card
öö 
=
öö 
	DeckRules
öö  )
.
öö) *
GetCardById
öö* 5
(
öö5 6
cardId
öö6 <
)
öö< =
;
öö= >
if
õõ 
(
õõ 
card
õõ 
.
õõ 
Suit
õõ !
!=
õõ" $
CardSuit
õõ% -
.
õõ- .
Special
õõ. 5
)
õõ5 6
{
úú %
EligibleDistressCardIds
ùù /
.
ùù/ 0
Add
ùù0 3
(
ùù3 4
cardId
ùù4 :
)
ùù: ;
;
ùù; <
}
ûû 
}
üü 
if
°° 
(
°° 
!
°° %
EligibleDistressCardIds
°° ,
.
°°, -
Contains
°°- 5
(
°°5 6$
SelectedDistressCardId
°°6 L
)
°°L M
)
°°M N
{
¢¢ $
SelectedDistressCardId
££ *
=
££+ ,%
EligibleDistressCardIds
££- D
.
££D E
FirstOrDefault
££E S
(
££S T
)
££T U
;
££U V
}
§§ 
}
•• 
}
¶¶ 	
private
®® 
void
®® &
ApplyDistressSignalState
®® -
(
®®- .!
PlayerMatchSnapshot
®®. A
playerSnapshot
®®B P
)
®®P Q
{
©© 	$
DistressSignalSnapshot
™™ "
distress
™™# +
=
™™, -
playerSnapshot
™™. <
.
™™< =
DistressSignal
™™= K
;
™™K L
if
´´ 
(
´´ 
distress
´´ 
!=
´´ 
null
´´  
&&
´´! #
distress
´´$ ,
.
´´, -
IsInProgress
´´- 9
)
´´9 :
{
¨¨ '
SelectedDistressDirection
≠≠ )
=
≠≠* +
distress
≠≠, 4
.
≠≠4 5
AgreedDirection
≠≠5 D
;
≠≠D E
if
ÆÆ 
(
ÆÆ 
distress
ÆÆ 
.
ÆÆ 
CurrentStep
ÆÆ (
==
ÆÆ) +!
DistressSignalPhase
ÆÆ, ?
.
ÆÆ? @
SelectingCard
ÆÆ@ M
)
ÆÆM N
{
ØØ +
PopulateEligibleDistressCards
∞∞ 1
(
∞∞1 2
)
∞∞2 3
;
∞∞3 4
}
±± (
IsDistressSignalDialogOpen
≤≤ *
=
≤≤+ ,
true
≤≤- 1
;
≤≤1 2
}
≥≥ 
else
¥¥ 
{
µµ 
if
∂∂ 
(
∂∂ (
IsDistressSignalDialogOpen
∂∂ .
&&
∂∂/ 1
(
∂∂2 3
!
∂∂3 4"
CanUseDistressSignal
∂∂4 H
||
∂∂I K#
HasUsedDistressSignal
∂∂L a
)
∂∂a b
)
∂∂b c
{
∑∑ (
IsDistressSignalDialogOpen
∏∏ .
=
∏∏/ 0
false
∏∏1 6
;
∏∏6 7
}
ππ 
if
∫∫ 
(
∫∫ 
distress
∫∫ 
!=
∫∫ 
null
∫∫  $
&&
∫∫% '
distress
∫∫( 0
.
∫∫0 1
HasBeenRejected
∫∫1 @
&&
∫∫A C
!
∫∫D E.
 _hasShownDistressRejectionNotice
∫∫E e
)
∫∫e f
{
ªª .
 _hasShownDistressRejectionNotice
ºº 4
=
ºº5 6
true
ºº7 ;
;
ºº; <&
MatchFeedbackResourceKey
ΩΩ ,
=
ΩΩ- .
$str
ΩΩ/ N
;
ΩΩN O
}
ææ 
}
øø 
}
¿¿ 	
private
¬¬ 
void
¬¬ -
NotifyDistressPhaseVisibilities
¬¬ 4
(
¬¬4 5
)
¬¬5 6
{
√√ 	
OnPropertyChanged
ƒƒ 
(
ƒƒ 
nameof
ƒƒ $
(
ƒƒ$ %/
!IsDistressInitiatorConfirmVisible
ƒƒ% F
)
ƒƒF G
)
ƒƒG H
;
ƒƒH I
OnPropertyChanged
≈≈ 
(
≈≈ 
nameof
≈≈ $
(
≈≈$ %(
IsDistressUsageVoteVisible
≈≈% ?
)
≈≈? @
)
≈≈@ A
;
≈≈A B
OnPropertyChanged
∆∆ 
(
∆∆ 
nameof
∆∆ $
(
∆∆$ %,
IsDistressDirectionVoteVisible
∆∆% C
)
∆∆C D
)
∆∆D E
;
∆∆E F
OnPropertyChanged
«« 
(
«« 
nameof
«« $
(
««$ %,
IsDistressCardSelectionVisible
««% C
)
««C D
)
««D E
;
««E F
OnPropertyChanged
»» 
(
»» 
nameof
»» $
(
»»$ %&
IsDistressWaitingVisible
»»% =
)
»»= >
)
»»> ?
;
»»? @
OnPropertyChanged
…… 
(
…… 
nameof
…… $
(
……$ %,
DistressStepWaitingResourceKey
……% C
)
……C D
)
……D E
;
……E F
OnPropertyChanged
   
(
   
nameof
   $
(
  $ %0
"DistressAgreedDirectionResourceKey
  % G
)
  G H
)
  H I
;
  I J
}
ÀÀ 	
private
ÕÕ 
void
ÕÕ &
NotifyDistressProperties
ÕÕ -
(
ÕÕ- .
)
ÕÕ. /
{
ŒŒ 	
OnPropertyChanged
œœ 
(
œœ 
nameof
œœ $
(
œœ$ %
DistressSignal
œœ% 3
)
œœ3 4
)
œœ4 5
;
œœ5 6
OnPropertyChanged
–– 
(
–– 
nameof
–– $
(
––$ %#
HasUsedDistressSignal
––% :
)
––: ;
)
––; <
;
––< =
OnPropertyChanged
—— 
(
—— 
nameof
—— $
(
——$ %(
IsDistressSignalInProgress
——% ?
)
——? @
)
——@ A
;
——A B
OnPropertyChanged
““ 
(
““ 
nameof
““ $
(
““$ %!
CurrentDistressStep
““% 8
)
““8 9
)
““9 :
;
““: ;
OnPropertyChanged
”” 
(
”” 
nameof
”” $
(
””$ %'
IsLocalDistressUsageVoted
””% >
)
””> ?
)
””? @
;
””@ A
OnPropertyChanged
‘‘ 
(
‘‘ 
nameof
‘‘ $
(
‘‘$ %+
IsLocalDistressDirectionVoted
‘‘% B
)
‘‘B C
)
‘‘C D
;
‘‘D E
OnPropertyChanged
’’ 
(
’’ 
nameof
’’ $
(
’’$ %*
IsLocalDistressCardSubmitted
’’% A
)
’’A B
)
’’B C
;
’’C D
OnPropertyChanged
÷÷ 
(
÷÷ 
nameof
÷÷ $
(
÷÷$ %#
DistressInitiatorName
÷÷% :
)
÷÷: ;
)
÷÷; <
;
÷÷< =
OnPropertyChanged
◊◊ 
(
◊◊ 
nameof
◊◊ $
(
◊◊$ %(
DistressUsageYesVotesCount
◊◊% ?
)
◊◊? @
)
◊◊@ A
;
◊◊A B
OnPropertyChanged
ÿÿ 
(
ÿÿ 
nameof
ÿÿ $
(
ÿÿ$ %)
DistressDirectionVotesCount
ÿÿ% @
)
ÿÿ@ A
)
ÿÿA B
;
ÿÿB C
OnPropertyChanged
ŸŸ 
(
ŸŸ 
nameof
ŸŸ $
(
ŸŸ$ %)
DistressCardsSubmittedCount
ŸŸ% @
)
ŸŸ@ A
)
ŸŸA B
;
ŸŸB C
OnPropertyChanged
⁄⁄ 
(
⁄⁄ 
nameof
⁄⁄ $
(
⁄⁄$ %'
DistressTotalPlayersCount
⁄⁄% >
)
⁄⁄> ?
)
⁄⁄? @
;
⁄⁄@ A
OnPropertyChanged
€€ 
(
€€ 
nameof
€€ $
(
€€$ %)
DistressWaitingProgressText
€€% @
)
€€@ A
)
€€A B
;
€€B C
OnPropertyChanged
‹‹ 
(
‹‹ 
nameof
‹‹ $
(
‹‹$ %,
DistressStepWaitingResourceKey
‹‹% C
)
‹‹C D
)
‹‹D E
;
‹‹E F
OnPropertyChanged
›› 
(
›› 
nameof
›› $
(
››$ %0
"DistressAgreedDirectionResourceKey
››% G
)
››G H
)
››H I
;
››I J-
NotifyDistressPhaseVisibilities
ﬁﬁ +
(
ﬁﬁ+ ,
)
ﬁﬁ, -
;
ﬁﬁ- .
OnPropertyChanged
ﬂﬂ 
(
ﬂﬂ 
nameof
ﬂﬂ $
(
ﬂﬂ$ %(
HasLocalPlayerCommunicated
ﬂﬂ% ?
)
ﬂﬂ? @
)
ﬂﬂ@ A
;
ﬂﬂA B
OnPropertyChanged
‡‡ 
(
‡‡ 
nameof
‡‡ $
(
‡‡$ %&
HasAnyPlayerCommunicated
‡‡% =
)
‡‡= >
)
‡‡> ?
;
‡‡? @
OnPropertyChanged
·· 
(
·· 
nameof
·· $
(
··$ %"
CanUseDistressSignal
··% 9
)
··9 :
)
··: ;
;
··; <
OnPropertyChanged
‚‚ 
(
‚‚ 
nameof
‚‚ $
(
‚‚$ %$
CanConfirmDistressCard
‚‚% ;
)
‚‚; <
)
‚‚< =
;
‚‚= >
CommandManager
„„ 
.
„„ (
InvalidateRequerySuggested
„„ 5
(
„„5 6
)
„„6 7
;
„„7 8
}
‰‰ 	
}
ÂÂ 
}ÊÊ ‰é
nC:\Users\oscar\source\repos\TrickTakingMissions\Client\ViewModel\ViewModels\Match\Board\MatchBoardViewModel.cs
	namespace 	
	ViewModel
 
. 

ViewModels 
{ 
public 

sealed 
partial 
class 
MatchBoardViewModel  3
:4 5
ViewModelBase6 C
,C D
IDisposableE P
{ 
private 
const 
int -
!CompletedTrickDisplayMilliseconds ;
=< =
$num> B
;B C
private 
const 
string )
LogMatchSynchronizationFailed :
=; <
$str `
+a b
$str .
;. /
private 
readonly 
string 

_lobbyCode  *
;* +
private 
readonly 
int 
_participantUserId /
;/ 0
private   
readonly   
IMatchClient   %
_matchClient  & 2
;  2 3
private!! 
readonly!! 
ILoggerService!! '
_logger!!( /
;!!/ 0
private"" 
readonly"" "
SynchronizationContext"" /

_uiContext""0 :
;"": ;
private## 
readonly## 
Timer## 
_matchRefreshTimer## 1
;##1 2
private$$ 
readonly$$ 
Timer$$ '
_completedTrickDisplayTimer$$ :
;$$: ;
private%% 
readonly%% 

Dictionary%% #
<%%# $
int%%$ '
,%%' (
string%%) /
>%%/ 0%
_participantNamesByUserId%%1 J
=%%K L
new%%M P

Dictionary%%Q [
<%%[ \
int%%\ _
,%%_ `
string%%a g
>%%g h
(%%h i
)%%i j
;%%j k
private&& 
readonly&& 
List&& 
<&& $
LobbyPlayerItemViewModel&& 6
>&&6 7
_seatedPlayers&&8 F
=&&G H
new&&I L
List&&M Q
<&&Q R$
LobbyPlayerItemViewModel&&R j
>&&j k
(&&k l
)&&l m
;&&m n
private'' 
PlayerMatchSnapshot'' ##
_confirmedMatchSnapshot''$ ;
;''; <
private(( 
CardPlaySubmission(( "&
_pendingCardPlaySubmission((# =
;((= >
private)) 
string)) %
_matchFeedbackResourceKey)) 0
=))1 2
$str))3 E
;))E F
private** 
bool** 
_isMatchConnected** &
;**& '
private++ 
bool++ 
_isDisposed++  
;++  !
private,, 
bool,, *
_isCompletedTrickDisplayActive,, 3
;,,3 4
private-- 
int--  
_isRequestInProgress-- (
;--( )
private.. 
int.. )
_announcedCompletedTrickCount.. 1
;..1 2
public00 
MatchBoardViewModel00 "
(00" #
MatchBoardContext00# 4
context005 <
,00< =
ILoggerService00> L
logger00M S
)00S T
{11 	
if22 
(22 
context22 
==22 
null22 
)22  
{33 
throw44 
new44 !
ArgumentNullException44 /
(44/ 0
nameof440 6
(446 7
context447 >
)44> ?
)44? @
;44@ A
}55 

_lobbyCode77 
=77 
context77  
.77  !
	LobbyCode77! *
;77* +
_participantUserId88 
=88  
context88! (
.88( )
ParticipantUserId88) :
;88: ;
_matchClient99 
=99 
context99 "
.99" #
MatchClient99# .
;99. /
_logger:: 
=:: 
logger:: 
??:: 
throw::  %
new::& )!
ArgumentNullException::* ?
(::? @
nameof::@ F
(::F G
logger::G M
)::M N
)::N O
;::O P

_uiContext;; 
=;; "
SynchronizationContext;; /
.;;/ 0
Current;;0 7
;;;7 8
OwnHandCards<< 
=<< 
new<<  
ObservableCollection<< 3
<<<3 4
HandCardViewModel<<4 E
><<E F
(<<F G
)<<G H
;<<H I!
CurrentTrickCardPlays== !
===" #
new==$ ' 
ObservableCollection==( <
<==< =
PlayedCardViewModel=== P
>==P Q
(==Q R
)==R S
;==S T'
LastCompletedTrickCardPlays>> '
=>>( )
new>>* - 
ObservableCollection>>. B
<>>B C
PlayedCardViewModel>>C V
>>>V W
(>>W X
)>>X Y
;>>Y Z,
 InitializeObjectiveDraftCommands?? ,
(??, -
)??- .
;??. /"
InitializeRadioCommand@@ "
(@@" #
)@@# $
;@@$ %0
$InitializeSpecialPreparationCommandsAA 0
(AA0 1
)AA1 2
;AA2 3.
"InitializeFinalPreparationCommandsBB .
(BB. /
)BB/ 0
;BB0 1,
 InitializeDistressSignalCommandsCC ,
(CC, -
)CC- .
;CC. /,
 _missionTransitionCountdownTimerDD ,
=DD- .
newDD/ 2
TimerDD3 8
(DD8 9,
 OnMissionTransitionCountdownTickDD9 Y
,DDY Z
nullDD[ _
,DD_ `
TimeSpanDDa i
.DDi j
ZeroDDj n
,DDn o
TimeSpanEE 
.EE 
FromMillisecondsEE )
(EE) *
$numEE* -
)EE- .
)EE. /
;EE/ 0
PlayCardCommandFF 
=FF 
newFF !
AsyncRelayCommandFF" 3
(FF3 4#
SubmitSelectedCardAsyncFF4 K
,FFK L
CanPlaySelectedCardFFM `
)FF` a
;FFa b+
RetryPendingMatchRequestCommandGG +
=GG, -
newGG. 1
AsyncRelayCommandGG2 C
(GGC D!
SynchronizeMatchAsyncGGD Y
,GGY Z'
CanRetryPendingMatchRequestGG[ v
)GGv w
;GGw x
_matchClientHH 
.HH 
MatchStateChangedHH *
+=HH+ -
OnMatchStateChangedHH. A
;HHA B'
_completedTrickDisplayTimerII '
=II( )
newII* -
TimerII. 3
(II3 4*
OnCompletedTrickDisplayElapsedII4 R
,IIR S
nullIIT X
,IIX Y
TimeoutJJ 
.JJ 
InfiniteJJ  
,JJ  !
TimeoutJJ" )
.JJ) *
InfiniteJJ* 2
)JJ2 3
;JJ3 4
_matchRefreshTimerKK 
=KK  
newKK! $
TimerKK% *
(KK* +
OnRefreshTimerKK+ 9
,KK9 :
nullKK; ?
,KK? @
TimeSpanKKA I
.KKI J
FromSecondsKKJ U
(KKU V
$numKKV W
)KKW X
,KKX Y
TimeSpanKKZ b
.KKb c
FromSecondsKKc n
(KKn o
$numKKo p
)KKp q
)KKq r
;KKr s
}LL 	
publicNN  
ObservableCollectionNN #
<NN# $
HandCardViewModelNN$ 5
>NN5 6
OwnHandCardsNN7 C
{NND E
getNNF I
;NNI J
}NNK L
publicOO  
ObservableCollectionOO #
<OO# $
PlayedCardViewModelOO$ 7
>OO7 8!
CurrentTrickCardPlaysOO9 N
{OOO P
getOOQ T
;OOT U
}OOV W
publicPP  
ObservableCollectionPP #
<PP# $
PlayedCardViewModelPP$ 7
>PP7 8'
LastCompletedTrickCardPlaysPP9 T
{PPU V
getPPW Z
;PPZ [
}PP\ ]
publicQQ 
ICommandQQ 
PlayCardCommandQQ '
{QQ( )
getQQ* -
;QQ- .
}QQ/ 0
publicRR 
ICommandRR +
RetryPendingMatchRequestCommandRR 7
{RR8 9
getRR: =
;RR= >
}RR? @
publicSS 
longSS 
MatchStateVersionSS %
=>SS& (#
_confirmedMatchSnapshotSS) @
?SS@ A
.SSA B
MatchStateVersionSSB S
??SST V
$numSSW X
;SSX Y
publicTT 
intTT 
CurrentTrickNumberTT %
=>TT& (#
_confirmedMatchSnapshotTT) @
?TT@ A
.TTA B
CurrentTrickNumberTTB T
??TTU W
$numTTX Y
;TTY Z
publicUU 
intUU $
MaximumMissionTrickCountUU +
=>UU, .#
_confirmedMatchSnapshotUU/ F
?UUF G
.UUG H$
MaximumMissionTrickCountUUH `
??UUa c
$numUUd e
;UUe f
publicVV 
intVV #
CurrentTurnPlayerUserIdVV *
=>VV+ -#
_confirmedMatchSnapshotVV. E
?VVE F
.VVF G#
CurrentTurnPlayerUserIdVVG ^
??VV_ a
$numVVb c
;VVc d
publicWW 
intWW !
LastTrickWinnerUserIdWW (
=>WW) +#
_confirmedMatchSnapshotWW, C
?WWC D
.WWD E!
LastTrickWinnerUserIdWWE Z
??WW[ ]
$numWW^ _
;WW_ `
publicYY 
stringYY !
CurrentTurnPlayerNameYY +
=>YY, .
GetParticipantNameYY/ A
(YYA B#
CurrentTurnPlayerUserIdYYB Y
)YYY Z
;YYZ [
publicZZ 
stringZZ 
LastTrickWinnerNameZZ )
=>ZZ* ,
GetParticipantNameZZ- ?
(ZZ? @!
LastTrickWinnerUserIdZZ@ U
)ZZU V
;ZZV W
public\\ 
string\\  
TrickProgressDisplay\\ *
=>\\+ -
string\\. 4
.\\4 5
Format\\5 ;
(\\; <
CultureInfo\\< G
.\\G H
InvariantCulture\\H X
,\\X Y
$str\\Z c
,\\c d
CurrentTrickNumber]] 
,]] $
MaximumMissionTrickCount]]  8
)]]8 9
;]]9 :
public__ 
bool__ 
HasLastTrickWinner__ &
=>__' )!
LastTrickWinnerUserId__* ?
!=__@ B
$num__C D
&&__E G
!__H I
string__I O
.__O P
IsNullOrEmpty__P ]
(__] ^
LastTrickWinnerName__^ q
)__q r
;__r s
publicaa 
boolaa (
ShouldShowLastCompletedTrickaa 0
=>aa1 3
(bb *
_isCompletedTrickDisplayActivebb +
||bb, .
IsDealCompletedbb/ >
||bb? A$
IsMissionAttemptFinishedbbB Z
)bbZ [
&&bb\ ^!
CurrentTrickCardPlayscc !
.cc! "
Countcc" '
==cc( *
$numcc+ ,
&&cc- /'
LastCompletedTrickCardPlayscc0 K
.ccK L
CountccL Q
>ccR S
$numccT U
;ccU V
publicee 
stringee $
MatchFeedbackResourceKeyee .
{ff 	
getgg 
=>gg %
_matchFeedbackResourceKeygg ,
;gg, -
privatehh 
sethh 
=>hh 
SetPropertyhh &
(hh& '
refhh' *%
_matchFeedbackResourceKeyhh+ D
,hhD E
valuehhF K
)hhK L
;hhL M
}ii 	
privatekk 
boolkk 
IsDealCompletedkk $
=>kk% '#
_confirmedMatchSnapshotkk( ?
?kk? @
.kk@ A
IsDealCompletedkkA P
??kkQ S
falsekkT Y
;kkY Z
publicmm 
voidmm %
ConfigureParticipantNamesmm -
(mm- .
IEnumerablemm. 9
<mm9 :$
LobbyPlayerItemViewModelmm: R
>mmR S
participantsmmT `
)mm` a
{nn 	
_seatedPlayersoo 
.oo 
Clearoo  
(oo  !
)oo! "
;oo" #
foreachpp 
(pp $
LobbyPlayerItemViewModelpp -
participantpp. 9
inpp: <
participantspp= I
)ppI J
{qq %
_participantNamesByUserIdrr )
[rr) *
participantrr* 5
.rr5 6
IdUserrr6 <
]rr< =
=rr> ?
participantrr@ K
.rrK L
UsernamerrL T
;rrT U
_seatedPlayersss 
.ss 
Addss "
(ss" #
participantss# .
)ss. /
;ss/ 0
}tt 
}uu 	
publicww 
asyncww 
Taskww !
SynchronizeMatchAsyncww /
(ww/ 0
)ww0 1
{xx 	
ifyy 
(yy 
!yy 
_isDisposedyy 
&&yy 
Interlockedyy  +
.yy+ ,
CompareExchangeyy, ;
(yy; <
refyy< ? 
_isRequestInProgressyy@ T
,yyT U
$numyyV W
,yyW X
$numyyY Z
)yyZ [
==yy\ ^
$numyy_ `
)yy` a
{zz 
try{{ 
{|| 
await}}  
SynchronizeCoreAsync}} .
(}}. /
)}}/ 0
;}}0 1
}~~ 
catch 
( 
FaultException %
<% &
MatchAccessFault& 6
>6 7
ex8 :
): ;
{
ÄÄ 
string
ÅÅ 
feedbackKey
ÅÅ &
=
ÅÅ' (#
GetMatchFaultFeedback
ÅÅ) >
(
ÅÅ> ?
ex
ÅÅ? A
.
ÅÅA B
Detail
ÅÅB H
)
ÅÅH I
;
ÅÅI J"
SetConnectionFailure
ÇÇ (
(
ÇÇ( )
feedbackKey
ÇÇ) 4
,
ÇÇ4 5
ex
ÇÇ6 8
)
ÇÇ8 9
;
ÇÇ9 :
}
ÉÉ 
catch
ÑÑ 
(
ÑÑ 
FaultException
ÑÑ %
ex
ÑÑ& (
)
ÑÑ( )
{
ÖÖ "
SetConnectionFailure
ÜÜ (
(
ÜÜ( )
$str
ÜÜ) B
,
ÜÜB C
ex
ÜÜD F
)
ÜÜF G
;
ÜÜG H
}
áá 
catch
àà 
(
àà $
CommunicationException
àà -
ex
àà. 0
)
àà0 1
{
ââ "
SetConnectionFailure
ää (
(
ää( )
$str
ää) ?
,
ää? @
ex
ääA C
)
ääC D
;
ääD E
}
ãã 
catch
åå 
(
åå 
TimeoutException
åå '
ex
åå( *
)
åå* +
{
çç "
SetConnectionFailure
éé (
(
éé( )
$str
éé) ?
,
éé? @
ex
ééA C
)
ééC D
;
ééD E
}
èè 
finally
êê 
{
ëë 
Interlocked
íí 
.
íí  
Exchange
íí  (
(
íí( )
ref
íí) ,"
_isRequestInProgress
íí- A
,
ííA B
$num
ííC D
)
ííD E
;
ííE F
OnPropertyChanged
ìì %
(
ìì% &
nameof
ìì& ,
(
ìì, - 
CanChooseRadioCard
ìì- ?
)
ìì? @
)
ìì@ A
;
ììA B
OnPropertyChanged
îî %
(
îî% &
nameof
îî& ,
(
îî, -
CanCommunicate
îî- ;
)
îî; <
)
îî< =
;
îî= >0
"NotifySpecialPreparationProperties
ïï 6
(
ïï6 7
)
ïï7 8
;
ïï8 9(
UpdateHandCardRaisedStates
ññ .
(
ññ. /
)
ññ/ 0
;
ññ0 1
CommandManager
óó "
.
óó" #(
InvalidateRequerySuggested
óó# =
(
óó= >
)
óó> ?
;
óó? @
}
òò 
}
ôô 
}
öö 	
public
úú 
void
úú 
Dispose
úú 
(
úú 
)
úú 
{
ùù 	
_isDisposed
ûû 
=
ûû 
true
ûû 
;
ûû  
_matchRefreshTimer
üü 
.
üü 
Dispose
üü &
(
üü& '
)
üü' (
;
üü( ).
 _missionTransitionCountdownTimer
†† ,
.
††, -
Dispose
††- 4
(
††4 5
)
††5 6
;
††6 7)
_completedTrickDisplayTimer
°° '
.
°°' (
Dispose
°°( /
(
°°/ 0
)
°°0 1
;
°°1 2
_matchClient
¢¢ 
.
¢¢ 
MatchStateChanged
¢¢ *
-=
¢¢+ -!
OnMatchStateChanged
¢¢. A
;
¢¢A B
}
££ 	
private
•• 
string
••  
GetParticipantName
•• )
(
••) *
int
••* -
participantUserId
••. ?
)
••? @
{
¶¶ 	'
_participantNamesByUserId
ßß %
.
ßß% &
TryGetValue
ßß& 1
(
ßß1 2
participantUserId
ßß2 C
,
ßßC D
out
ßßE H
string
ßßI O
participantName
ßßP _
)
ßß_ `
;
ßß` a
return
®® 
participantName
®® "
??
®®# %
string
®®& ,
.
®®, -
Empty
®®- 2
;
®®2 3
}
©© 	
private
´´ 
async
´´ 
Task
´´ "
SynchronizeCoreAsync
´´ /
(
´´/ 0
)
´´0 1
{
¨¨ 	
string
≠≠ !
preparationFeedback
≠≠ &
=
≠≠' (
await
≠≠) .,
ConfirmPendingPreparationAsync
≠≠/ M
(
≠≠M N
)
≠≠N O
;
≠≠O P
string
ÆÆ "
rejectionResourceKey
ÆÆ '
=
ÆÆ( )
await
ÆÆ* //
!ConfirmPendingObjectiveDraftAsync
ÆÆ0 Q
(
ÆÆQ R
)
ÆÆR S
??
ÆÆT V!
preparationFeedback
ÆÆW j
;
ÆÆj k
string
ØØ 
radioFeedback
ØØ  
=
ØØ! "
await
ØØ# (&
ConfirmPendingRadioAsync
ØØ) A
(
ØØA B
)
ØØB C
;
ØØC D
if
∞∞ 
(
∞∞ 
radioFeedback
∞∞ 
!=
∞∞  
null
∞∞! %
)
∞∞% &
{
±± "
rejectionResourceKey
≤≤ $
=
≤≤% &
radioFeedback
≤≤' 4
;
≤≤4 5
}
≥≥ 
if
¥¥ 
(
¥¥ (
_pendingCardPlaySubmission
¥¥ *
!=
¥¥+ -
null
¥¥. 2
)
¥¥2 3
{
µµ &
MatchFeedbackResourceKey
∂∂ (
=
∂∂) *
$str
∂∂+ =
;
∂∂= >
CardPlayDecision
∑∑  
playDecision
∑∑! -
=
∑∑. /
await
∑∑0 5
_matchClient
∑∑6 B
.
∑∑B C
PlayCardAsync
∑∑C P
(
∑∑P Q(
_pendingCardPlaySubmission
∏∏ .
,
∏∏. / 
_participantUserId
∏∏0 B
)
∏∏B C
;
∏∏C D
if
ππ 
(
ππ 
!
ππ 
_isDisposed
ππ  
&&
ππ! #
playDecision
ππ$ 0
.
ππ0 1"
CardPlaySubmissionId
ππ1 E
==
ππF H(
_pendingCardPlaySubmission
∫∫ .
.
∫∫. /"
CardPlaySubmissionId
∫∫/ C
)
∫∫C D
{
ªª "
rejectionResourceKey
ºº (
=
ºº) *
playDecision
ºº+ 7
.
ºº7 8

IsAccepted
ºº8 B
?
ººC D
null
ººE I
:
ººJ K
$str
ººL T
+
ººU V
playDecision
ººW c
.
ººc d
RejectionReason
ººd s
;
ººs t(
_pendingCardPlaySubmission
ΩΩ .
=
ΩΩ/ 0
null
ΩΩ1 5
;
ΩΩ5 6
}
ææ 
}
øø !
PlayerMatchSnapshot
¿¿ 
playerSnapshot
¿¿  .
=
¿¿/ 0
await
¿¿1 6
_matchClient
¿¿7 C
.
¿¿C D!
GetPlayerMatchAsync
¿¿D W
(
¿¿W X

_lobbyCode
¿¿X b
,
¿¿b c 
_participantUserId
¿¿d v
)
¿¿v w
;
¿¿w x
if
¡¡ 
(
¡¡ 
!
¡¡ 
_isDisposed
¡¡ 
)
¡¡ 
{
¬¬ $
ApplyConfirmedSnapshot
√√ &
(
√√& '
playerSnapshot
√√' 5
)
√√5 6
;
√√6 7
if
ƒƒ 
(
ƒƒ "
rejectionResourceKey
ƒƒ (
!=
ƒƒ) +
null
ƒƒ, 0
)
ƒƒ0 1
{
≈≈ &
MatchFeedbackResourceKey
∆∆ ,
=
∆∆- ."
rejectionResourceKey
∆∆/ C
;
∆∆C D
}
«« 
}
»» 
}
…… 	
private
ÀÀ 
bool
ÀÀ !
CanPlaySelectedCard
ÀÀ (
(
ÀÀ( )
object
ÀÀ) /
selectedCard
ÀÀ0 <
)
ÀÀ< =
{
ÃÃ 	
if
ÕÕ 
(
ÕÕ (
IsDistressSignalInProgress
ÕÕ *
)
ÕÕ* +
{
ŒŒ 
return
œœ 
false
œœ 
;
œœ 
}
–– 
if
““ 
(
““ 
selectedCard
““ 
is
““ 
int
““  #
cardId
““$ *
)
““* +
{
”” 
if
‘‘ 
(
‘‘ '
IsCommunicationModeActive
‘‘ -
)
‘‘- .
{
’’ 
return
÷÷ 
CanCommunicate
÷÷ )
&&
÷÷* ,&
GetValidPositionsForCard
÷÷- E
(
÷÷E F
cardId
÷÷F L
)
÷÷L M
.
÷÷M N
Count
÷÷N S
>
÷÷T U
$num
÷÷V W
;
÷÷W X
}
◊◊ 
return
ŸŸ  
CanPlayCurrentTurn
ŸŸ )
(
ŸŸ) *
)
ŸŸ* +
&&
ŸŸ, . 
GetPlayableCardIds
ŸŸ/ A
(
ŸŸA B
)
ŸŸB C
.
ŸŸC D
Contains
ŸŸD L
(
ŸŸL M
cardId
ŸŸM S
)
ŸŸS T
;
ŸŸT U
}
⁄⁄ 
return
‹‹ 
false
‹‹ 
;
‹‹ 
}
›› 	
private
ﬂﬂ 
bool
ﬂﬂ $
IsMatchInPlayableState
ﬂﬂ +
{
‡‡ 	
get
·· 
{
‚‚ 
bool
„„ 
isSessionActive
„„ $
=
„„% &
!
„„' (
_isDisposed
„„( 3
&&
„„4 6
_isMatchConnected
„„7 H
;
„„H I
bool
‰‰ 
isMatchLive
‰‰  
=
‰‰! "%
_confirmedMatchSnapshot
‰‰# :
!=
‰‰; =
null
‰‰> B
&&
‰‰C E
!
‰‰F G%
_confirmedMatchSnapshot
‰‰G ^
.
‰‰^ _
IsDealCompleted
‰‰_ n
;
‰‰n o
return
ÂÂ 
isSessionActive
ÂÂ &
&&
ÂÂ' )
isMatchLive
ÂÂ* 5
;
ÂÂ5 6
}
ÊÊ 
}
ÁÁ 	
private
ÈÈ 
bool
ÈÈ  
CanPlayCurrentTurn
ÈÈ '
(
ÈÈ' (
)
ÈÈ( )
{
ÍÍ 	
if
ÎÎ 
(
ÎÎ 
!
ÎÎ $
IsMatchInPlayableState
ÎÎ '
)
ÎÎ' (
{
ÏÏ 
return
ÌÌ 
false
ÌÌ 
;
ÌÌ 
}
ÓÓ 
bool
 
isTurnActive
 
=
 %
CurrentTurnPlayerUserId
  7
==
8 : 
_participantUserId
; M
;
M N
bool
ÒÒ 
isPlayAllowed
ÒÒ 
=
ÒÒ  
!
ÒÒ! "(
IsDistressSignalInProgress
ÒÒ" <
&&
ÒÒ= ?
!
ÒÒ@ A&
IsMissionAttemptFinished
ÒÒA Y
;
ÒÒY Z
bool
ÚÚ 
isPendingFree
ÚÚ 
=
ÚÚ  (
_pendingCardPlaySubmission
ÚÚ! ;
==
ÚÚ< >
null
ÚÚ? C
&&
ÚÚD F*
IsMissionPreparationComplete
ÚÚG c
;
ÚÚc d
return
ÙÙ 
isTurnActive
ÙÙ 
&&
ÙÙ  "
isPlayAllowed
ÙÙ# 0
&&
ÙÙ1 3
isPendingFree
ÙÙ4 A
;
ÙÙA B
}
ıı 	
private
˜˜ 
void
˜˜ (
UpdateHandCardRaisedStates
˜˜ /
(
˜˜/ 0
)
˜˜0 1
{
¯¯ 	
bool
˘˘ $
canRaiseForCurrentTurn
˘˘ '
=
˘˘( ) 
CanPlayCurrentTurn
˘˘* <
(
˘˘< =
)
˘˘= >
;
˘˘> ?
foreach
˙˙ 
(
˙˙ 
HandCardViewModel
˙˙ &
handCard
˙˙' /
in
˙˙0 2
OwnHandCards
˙˙3 ?
)
˙˙? @
{
˚˚ 
handCard
¸¸ 
.
¸¸ $
UpdateTurnAvailability
¸¸ /
(
¸¸/ 0$
canRaiseForCurrentTurn
¸¸0 F
)
¸¸F G
;
¸¸G H
}
˝˝ 
}
˛˛ 	
private
ÄÄ 
int
ÄÄ 
[
ÄÄ 
]
ÄÄ  
GetPlayableCardIds
ÄÄ (
(
ÄÄ( )
)
ÄÄ) *
{
ÅÅ 	
Card
ÇÇ 
[
ÇÇ 
]
ÇÇ 

playerHand
ÇÇ 
=
ÇÇ %
_confirmedMatchSnapshot
ÇÇ  7
.
ÇÇ7 8
OwnHandCardIds
ÇÇ8 F
.
ÇÇF G
Select
ÇÇG M
(
ÇÇM N
	DeckRules
ÇÇN W
.
ÇÇW X
GetCardById
ÇÇX c
)
ÇÇc d
.
ÇÇd e
ToArray
ÇÇe l
(
ÇÇl m
)
ÇÇm n
;
ÇÇn o
TrickCardPlay
ÉÉ 
[
ÉÉ 
]
ÉÉ 
publicTrick
ÉÉ '
=
ÉÉ( )%
_confirmedMatchSnapshot
ÉÉ* A
.
ÉÉA B#
CurrentTrickCardPlays
ÉÉB W
.
ÑÑ 
Select
ÑÑ 
(
ÑÑ 
(
ÑÑ 
play
ÑÑ 
,
ÑÑ 
	playOrder
ÑÑ (
)
ÑÑ( )
=>
ÑÑ* ,
new
ÑÑ- 0
TrickCardPlay
ÑÑ1 >
{
ÖÖ 
Card
ÜÜ 
=
ÜÜ 
	DeckRules
ÜÜ $
.
ÜÜ$ %
GetCardById
ÜÜ% 0
(
ÜÜ0 1
play
ÜÜ1 5
.
ÜÜ5 6
CardId
ÜÜ6 <
)
ÜÜ< =
,
ÜÜ= >
	PlayOrder
áá 
=
áá 
(
áá  !
byte
áá! %
)
áá% &
	playOrder
áá& /
}
àà 
)
àà 
.
àà 
ToArray
àà 
(
àà 
)
àà 
;
àà 
return
ââ "
TrickFollowSuitRules
ââ '
.
ââ' (
GetPlayableCards
ââ( 8
(
ââ8 9

playerHand
ââ9 C
,
ââC D
publicTrick
ââE P
)
ââP Q
.
ââQ R
ToArray
ââR Y
(
ââY Z
)
ââZ [
;
ââ[ \
}
ää 	
private
åå 
async
åå 
Task
åå %
SubmitSelectedCardAsync
åå 2
(
åå2 3
object
åå3 9
selectedCard
åå: F
)
ååF G
{
çç 	
if
éé 
(
éé 
selectedCard
éé 
is
éé 
int
éé  #
cardId
éé$ *
)
éé* +
{
èè 
if
êê 
(
êê '
IsCommunicationModeActive
êê -
)
êê- .
{
ëë 
await
íí 3
%ExecuteCardCommunicationFromHandAsync
íí ?
(
íí? @
cardId
íí@ F
)
ííF G
;
ííG H
return
ìì 
;
ìì 
}
îî 
if
ññ 
(
ññ !
CanPlaySelectedCard
ññ '
(
ññ' (
selectedCard
ññ( 4
)
ññ4 5
)
ññ5 6
{
óó (
_pendingCardPlaySubmission
òò .
=
òò/ 0
new
òò1 4 
CardPlaySubmission
òò5 G
{
ôô 
	LobbyCode
öö !
=
öö" #

_lobbyCode
öö$ .
,
öö. /
MatchId
õõ 
=
õõ  !%
_confirmedMatchSnapshot
õõ" 9
.
õõ9 :
MatchId
õõ: A
,
õõA B
MissionAttemptId
úú (
=
úú) *%
_confirmedMatchSnapshot
úú+ B
.
úúB C 
MissionPreparation
úúC U
.
úúU V
MissionAttemptId
úúV f
,
úúf g
CardId
ùù 
=
ùù  
cardId
ùù! '
,
ùù' ("
CardPlaySubmissionId
ûû ,
=
ûû- .
Guid
ûû/ 3
.
ûû3 4
NewGuid
ûû4 ;
(
ûû; <
)
ûû< =
,
ûû= >'
ExpectedMatchStateVersion
üü 1
=
üü2 3
MatchStateVersion
üü4 E
}
†† 
;
†† 
await
°° #
SynchronizeMatchAsync
°° /
(
°°/ 0
)
°°0 1
;
°°1 2
}
¢¢ 
}
££ 
}
§§ 	
private
¶¶ 
bool
¶¶ )
CanRetryPendingMatchRequest
¶¶ 0
(
¶¶0 1
)
¶¶1 2
{
ßß 	
return
®® 
!
®® 
_isDisposed
®® 
&&
®®  "
(
®®# $(
_pendingCardPlaySubmission
®®$ >
!=
®®? A
null
®®B F
||
®®G I.
 _pendingObjectiveDraftSubmission
®®J j
!=
®®k m
null
®®n r
||
®®s u%
_pendingRadioSubmission
©© '
!=
©©( *
null
©©+ /
||
©©0 2#
HasPendingPreparation
©©3 H
)
©©H I
&&
©©J L"
_isRequestInProgress
™™ $
==
™™% '
$num
™™( )
;
™™) *
}
´´ 	
private
≠≠ 
void
≠≠ $
ApplyConfirmedSnapshot
≠≠ +
(
≠≠+ ,!
PlayerMatchSnapshot
≠≠, ?
playerSnapshot
≠≠@ N
)
≠≠N O
{
ÆÆ 	
bool
ØØ 
isSameMatch
ØØ 
=
ØØ %
_confirmedMatchSnapshot
ØØ 6
==
ØØ7 9
null
ØØ: >
||
ØØ? A%
_confirmedMatchSnapshot
∞∞ '
.
∞∞' (
MatchId
∞∞( /
==
∞∞0 2
playerSnapshot
∞∞3 A
.
∞∞A B
MatchId
∞∞B I
;
∞∞I J
if
±± 
(
±± 
isSameMatch
±± 
&&
±± 
playerSnapshot
±± -
.
±±- .
MatchStateVersion
±±. ?
>=
±±@ B
MatchStateVersion
±±C T
)
±±T U
{
≤≤ /
!ResetAttemptPresentationIfChanged
≥≥ 1
(
≥≥1 2
playerSnapshot
≥≥2 @
)
≥≥@ A
;
≥≥A B%
_confirmedMatchSnapshot
¥¥ '
=
¥¥( )
playerSnapshot
¥¥* 8
;
¥¥8 9,
ApplyMissionTransitionSnapshot
µµ .
(
µµ. /
playerSnapshot
µµ/ =
.
µµ= >
MissionTransition
µµ> O
)
µµO P
;
µµP Q
_isMatchConnected
∂∂ !
=
∂∂" #
true
∂∂$ (
;
∂∂( )
HashSet
∑∑ 
<
∑∑ 
int
∑∑ 
>
∑∑ 
playableCardIds
∑∑ ,
=
∑∑- .
new
∑∑/ 2
HashSet
∑∑3 :
<
∑∑: ;
int
∑∑; >
>
∑∑> ?
(
∑∑? @ 
GetPlayableCardIds
∑∑@ R
(
∑∑R S
)
∑∑S T
)
∑∑T U
;
∑∑U V$
UpdatePublicSeatStates
∏∏ &
(
∏∏& '
playerSnapshot
∏∏' 5
)
∏∏5 6
;
∏∏6 7)
ApplyObjectiveDraftSnapshot
ππ +
(
ππ+ ,
playerSnapshot
ππ, :
.
ππ: ; 
MissionPreparation
ππ; M
)
ππM N
;
ππN O-
ApplySpecialPreparationSnapshot
∫∫ /
(
∫∫/ 0
playerSnapshot
∫∫0 >
.
∫∫> ? 
MissionPreparation
∫∫? Q
)
∫∫Q R
;
∫∫R S%
ReplaceOwnHandIfChanged
ªª '
(
ªª' (
playerSnapshot
ªª( 6
,
ªª6 7
playableCardIds
ªª8 G
)
ªªG H
;
ªªH I(
UpdateHandCardRaisedStates
ºº *
(
ºº* +
)
ºº+ ,
;
ºº, - 
ApplyRadioSnapshot
ΩΩ "
(
ΩΩ" #
playerSnapshot
ΩΩ# 1
)
ΩΩ1 2
;
ΩΩ2 3&
ApplyDistressSignalState
ææ (
(
ææ( )
playerSnapshot
ææ) 7
)
ææ7 8
;
ææ8 9 
ReplacePublicPlays
øø "
(
øø" #
playerSnapshot
øø# 1
)
øø1 2
;
øø2 3*
RefreshCompletedTrickDisplay
¿¿ ,
(
¿¿, -
playerSnapshot
¿¿- ;
)
¿¿; <
;
¿¿< =#
NotifyMatchProperties
¡¡ %
(
¡¡% &
)
¡¡& '
;
¡¡' (/
!NotifyMissionEvaluationProperties
¬¬ 1
(
¬¬1 2
)
¬¬2 3
;
¬¬3 40
"NotifyMissionInstructionProperties
√√ 2
(
√√2 3
)
√√3 4
;
√√4 5/
!NotifyMissionTransitionProperties
ƒƒ 1
(
ƒƒ1 2
)
ƒƒ2 3
;
ƒƒ3 4&
NotifyDistressProperties
≈≈ (
(
≈≈( )
)
≈≈) *
;
≈≈* +&
MatchFeedbackResourceKey
∆∆ (
=
∆∆) *%
GetCurrentMatchFeedback
∆∆+ B
(
∆∆B C
)
∆∆C D
;
∆∆D E
}
«« 
else
»» 
if
»» 
(
»» 
!
»» 
isSameMatch
»» !
)
»»! "
{
…… 
_isMatchConnected
   !
=
  " #
false
  $ )
;
  ) *&
MatchFeedbackResourceKey
ÀÀ (
=
ÀÀ) *
$str
ÀÀ+ D
;
ÀÀD E
}
ÃÃ 
}
ÕÕ 	
private
œœ 
void
œœ %
ReplaceOwnHandIfChanged
œœ ,
(
œœ, -!
PlayerMatchSnapshot
œœ- @
playerSnapshot
œœA O
,
œœO P
HashSet
œœQ X
<
œœX Y
int
œœY \
>
œœ\ ]
playableCardIds
œœ^ m
)
œœm n
{
–– 	
bool
—— 
hasSameHand
—— 
=
—— 
OwnHandCards
—— +
.
——+ ,
Select
——, 2
(
——2 3
card
——3 7
=>
——8 :
card
——; ?
.
——? @
CardId
——@ F
)
——F G
.
——G H
SequenceEqual
——H U
(
——U V
playerSnapshot
——V d
.
——d e
OwnHandCardIds
——e s
)
——s t
&&
——u w
OwnHandCards
““ 
.
““ 
All
““  
(
““  !
card
““! %
=>
““& (
card
““) -
.
““- .
IsPlayableByRules
““. ?
==
““@ B
playableCardIds
““C R
.
““R S
Contains
““S [
(
““[ \
card
““\ `
.
““` a
CardId
““a g
)
““g h
)
““h i
;
““i j
if
”” 
(
”” 
!
”” 
hasSameHand
”” 
)
”” 
{
‘‘ 
OwnHandCards
’’ 
.
’’ 
Clear
’’ "
(
’’" #
)
’’# $
;
’’$ %
foreach
÷÷ 
(
÷÷ 
int
÷÷ 
cardId
÷÷ #
in
÷÷$ &
playerSnapshot
÷÷' 5
.
÷÷5 6
OwnHandCardIds
÷÷6 D
)
÷÷D E
{
◊◊ 
OwnHandCards
ÿÿ  
.
ÿÿ  !
Add
ÿÿ! $
(
ÿÿ$ %
new
ÿÿ% (
HandCardViewModel
ÿÿ) :
(
ÿÿ: ;
cardId
ÿÿ; A
,
ÿÿA B
PlayCardCommand
ÿÿC R
,
ÿÿR S
playableCardIds
ŸŸ '
.
ŸŸ' (
Contains
ŸŸ( 0
(
ŸŸ0 1
cardId
ŸŸ1 7
)
ŸŸ7 8
)
ŸŸ8 9
)
ŸŸ9 :
;
ŸŸ: ;
}
⁄⁄ 
}
€€ ,
RefreshCommunicationHighlights
‹‹ *
(
‹‹* +
)
‹‹+ ,
;
‹‹, -
}
›› 	
private
ﬂﬂ 
void
ﬂﬂ $
UpdatePublicSeatStates
ﬂﬂ +
(
ﬂﬂ+ ,!
PlayerMatchSnapshot
ﬂﬂ, ?
playerSnapshot
ﬂﬂ@ N
)
ﬂﬂN O
{
‡‡ 	
foreach
·· 
(
·· &
LobbyPlayerItemViewModel
·· -
participant
··. 9
in
··: <
_seatedPlayers
··= K
)
··K L
{
‚‚ 
int
„„ 
participantSeat
„„ #
=
„„$ %
Array
„„& +
.
„„+ ,
IndexOf
„„, 3
(
„„3 4
playerSnapshot
„„4 B
.
„„B C 
ParticipantUserIds
„„C U
,
„„U V
participant
„„W b
.
„„b c
IdUser
„„c i
)
„„i j
;
„„j k
if
‰‰ 
(
‰‰ 
participantSeat
‰‰ #
>=
‰‰$ &
$num
‰‰' (
&&
‰‰) +
participantSeat
‰‰, ;
<
‰‰< =
playerSnapshot
‰‰> L
.
‰‰L M%
RemainingHandCardCounts
‰‰M d
.
‰‰d e
Length
‰‰e k
)
‰‰k l
{
ÂÂ 
participant
ÊÊ 
.
ÊÊ  *
UpdateRemainingHandCardCount
ÊÊ  <
(
ÊÊ< =
playerSnapshot
ÊÊ= K
.
ÊÊK L%
RemainingHandCardCounts
ÊÊL c
[
ÊÊc d
participantSeat
ÊÊd s
]
ÊÊs t
)
ÊÊt u
;
ÊÊu v
}
ÁÁ 
participant
ËË 
.
ËË "
UpdateMissionCaptain
ËË 0
(
ËË0 1
participant
ËË1 <
.
ËË< =
IdUser
ËË= C
==
ËËD F
playerSnapshot
ËËG U
.
ËËU V"
MissionCaptainUserId
ËËV j
)
ËËj k
;
ËËk l,
UpdateParticipantCapturedCards
ÈÈ .
(
ÈÈ. /
participant
ÈÈ/ :
,
ÈÈ: ;
playerSnapshot
ÈÈ< J
)
ÈÈJ K
;
ÈÈK L
}
ÍÍ 
}
ÎÎ 	
private
ÌÌ 
static
ÌÌ 
void
ÌÌ ,
UpdateParticipantCapturedCards
ÌÌ :
(
ÌÌ: ;&
LobbyPlayerItemViewModel
ÌÌ; S
participant
ÌÌT _
,
ÌÌ_ `!
PlayerMatchSnapshot
ÓÓ 
playerSnapshot
ÓÓ  .
)
ÓÓ. /
{
ÔÔ 	)
PlayerCapturedCardsSnapshot
 '
capturedCards
( 5
=
6 7
GetCapturedCards
8 H
(
H I
playerSnapshot
I W
)
W X
.
ÒÒ 
FirstOrDefault
ÒÒ 
(
ÒÒ  
captured
ÒÒ  (
=>
ÒÒ) +
captured
ÒÒ, 4
.
ÒÒ4 5
PlayerUserId
ÒÒ5 A
==
ÒÒB D
participant
ÒÒE P
.
ÒÒP Q
IdUser
ÒÒQ W
)
ÒÒW X
;
ÒÒX Y
int
ÚÚ 
wonTrickCount
ÚÚ 
=
ÚÚ 
capturedCards
ÚÚ  -
?
ÚÚ- .
.
ÚÚ. /
WonTrickCount
ÚÚ/ <
??
ÚÚ= ?
$num
ÚÚ@ A
;
ÚÚA B
int
ÛÛ 
[
ÛÛ 
]
ÛÛ 

wonCardIds
ÛÛ 
=
ÛÛ 
capturedCards
ÛÛ ,
?
ÛÛ, -
.
ÛÛ- .

WonCardIds
ÛÛ. 8
??
ÛÛ9 ;
new
ÛÛ< ?
int
ÛÛ@ C
[
ÛÛC D
$num
ÛÛD E
]
ÛÛE F
;
ÛÛF G
participant
ÙÙ 
.
ÙÙ !
UpdateCapturedCards
ÙÙ +
(
ÙÙ+ ,
wonTrickCount
ÙÙ, 9
,
ÙÙ9 :

wonCardIds
ÙÙ; E
)
ÙÙE F
;
ÙÙF G
}
ıı 	
private
˜˜ 
static
˜˜ )
PlayerCapturedCardsSnapshot
˜˜ 2
[
˜˜2 3
]
˜˜3 4
GetCapturedCards
˜˜5 E
(
˜˜E F!
PlayerMatchSnapshot
˜˜F Y
playerSnapshot
˜˜Z h
)
˜˜h i
{
¯¯ 	
return
˘˘ 
playerSnapshot
˘˘ !
.
˘˘! "#
CapturedCardsByPlayer
˘˘" 7
??
˘˘8 :
new
˘˘; >)
PlayerCapturedCardsSnapshot
˘˘? Z
[
˘˘Z [
$num
˘˘[ \
]
˘˘\ ]
;
˘˘] ^
}
˙˙ 	
private
¸¸ 
void
¸¸ *
RefreshCompletedTrickDisplay
¸¸ 1
(
¸¸1 2!
PlayerMatchSnapshot
¸¸2 E
playerSnapshot
¸¸F T
)
¸¸T U
{
˝˝ 	
int
˛˛ !
completedTrickCount
˛˛ #
=
˛˛$ %
GetCapturedCards
˛˛& 6
(
˛˛6 7
playerSnapshot
˛˛7 E
)
˛˛E F
.
˛˛F G
Sum
˛˛G J
(
˛˛J K
captured
˛˛K S
=>
˛˛T V
captured
˛˛W _
.
˛˛_ `
WonTrickCount
˛˛` m
)
˛˛m n
;
˛˛n o
if
ˇˇ 
(
ˇˇ !
completedTrickCount
ˇˇ #
>
ˇˇ$ %+
_announcedCompletedTrickCount
ˇˇ& C
)
ˇˇC D
{
ÄÄ +
_announcedCompletedTrickCount
ÅÅ -
=
ÅÅ. /!
completedTrickCount
ÅÅ0 C
;
ÅÅC D,
_isCompletedTrickDisplayActive
ÇÇ .
=
ÇÇ/ 0
true
ÇÇ1 5
;
ÇÇ5 6)
_completedTrickDisplayTimer
ÉÉ +
.
ÉÉ+ ,
Change
ÉÉ, 2
(
ÉÉ2 3/
!CompletedTrickDisplayMilliseconds
ÉÉ3 T
,
ÉÉT U
Timeout
ÉÉV ]
.
ÉÉ] ^
Infinite
ÉÉ^ f
)
ÉÉf g
;
ÉÉg h
}
ÑÑ 
}
ÖÖ 	
private
áá 
string
áá %
GetCurrentMatchFeedback
áá .
(
áá. /
)
áá/ 0
{
àà 	
return
ââ &
IsMissionAttemptFinished
ââ +
?
ââ, -2
$MissionEvaluationFeedbackResourceKey
ââ. R
:
ââS T$
GetActiveMatchFeedback
ââU k
(
ââk l
)
ââl m
;
ââm n
}
ää 	
private
åå 
string
åå $
GetActiveMatchFeedback
åå -
(
åå- .
)
åå. /
{
çç 	
string
éé !
feedbackResourceKey
éé &
=
éé' (
$str
éé) <
;
éé< =
if
èè 
(
èè %
CurrentTurnPlayerUserId
èè '
==
èè( * 
_participantUserId
èè+ =
)
èè= >
{
êê !
feedbackResourceKey
ëë #
=
ëë$ %
$str
ëë& 6
;
ëë6 7
}
íí 
if
ìì 
(
ìì %
_confirmedMatchSnapshot
ìì '
.
ìì' (
IsDealCompleted
ìì( 7
)
ìì7 8
{
îî !
feedbackResourceKey
ïï #
=
ïï$ %
$str
ïï& ;
;
ïï; <
}
ññ 
if
óó 
(
óó %
IsObjectiveDraftVisible
óó '
)
óó' (
{
òò !
feedbackResourceKey
ôô #
=
ôô$ %
$str
ôô& G
;
ôôG H
}
öö 
if
õõ 
(
õõ )
IsSpecialPreparationVisible
õõ +
)
õõ+ ,
{
úú !
feedbackResourceKey
ùù #
=
ùù$ %+
SpecialPreparationFeedbackKey
ùù& C
;
ùùC D
}
ûû 
if
üü 
(
üü '
IsCommunicationModeActive
üü )
)
üü) *
{
†† !
feedbackResourceKey
°° #
=
°°$ %
$str
°°& H
;
°°H I
}
¢¢ 
return
££ !
feedbackResourceKey
££ &
;
££& '
}
§§ 	
private
¶¶ 
void
¶¶  
ReplacePublicPlays
¶¶ '
(
¶¶' (!
PlayerMatchSnapshot
¶¶( ;
playerSnapshot
¶¶< J
)
¶¶J K
{
ßß 	#
CurrentTrickCardPlays
®® !
.
®®! "
Clear
®®" '
(
®®' (
)
®®( )
;
®®) *
foreach
©© 
(
©© 
MatchCardPlay
©© "
confirmedPlay
©©# 0
in
©©1 3
playerSnapshot
©©4 B
.
©©B C#
CurrentTrickCardPlays
©©C X
)
©©X Y
{
™™ #
CurrentTrickCardPlays
´´ %
.
´´% &
Add
´´& )
(
´´) *
new
´´* -!
PlayedCardViewModel
´´. A
(
´´A B
confirmedPlay
´´B O
.
´´O P
CardId
´´P V
,
´´V W 
GetParticipantName
¨¨ &
(
¨¨& '
confirmedPlay
¨¨' 4
.
¨¨4 5
PlayerUserId
¨¨5 A
)
¨¨A B
,
¨¨B C
GetTablePosition
¨¨D T
(
¨¨T U
confirmedPlay
¨¨U b
.
¨¨b c
PlayerUserId
¨¨c o
)
¨¨o p
)
¨¨p q
)
¨¨q r
;
¨¨r s
}
≠≠ )
LastCompletedTrickCardPlays
ÆÆ '
.
ÆÆ' (
Clear
ÆÆ( -
(
ÆÆ- .
)
ÆÆ. /
;
ÆÆ/ 0
foreach
ØØ 
(
ØØ 
MatchCardPlay
ØØ "
completedPlay
ØØ# 0
in
ØØ1 3
playerSnapshot
ØØ4 B
.
ØØB C)
LastCompletedTrickCardPlays
ØØC ^
)
ØØ^ _
{
∞∞ )
LastCompletedTrickCardPlays
±± +
.
±±+ ,
Add
±±, /
(
±±/ 0
new
±±0 3!
PlayedCardViewModel
±±4 G
(
±±G H
completedPlay
±±H U
.
±±U V
CardId
±±V \
,
±±\ ] 
GetParticipantName
≤≤ &
(
≤≤& '
completedPlay
≤≤' 4
.
≤≤4 5
PlayerUserId
≤≤5 A
)
≤≤A B
,
≤≤B C
GetTablePosition
≤≤D T
(
≤≤T U
completedPlay
≤≤U b
.
≤≤b c
PlayerUserId
≤≤c o
)
≤≤o p
)
≤≤p q
)
≤≤q r
;
≤≤r s
}
≥≥ 
}
¥¥ 	
private
∂∂  
MatchTablePosition
∂∂ "
GetTablePosition
∂∂# 3
(
∂∂3 4
int
∂∂4 7
participantUserId
∂∂8 I
)
∂∂I J
{
∑∑ 	
int
∏∏ !
relativePlayerIndex
∏∏ #
=
∏∏$ %
_seatedPlayers
∏∏& 4
.
∏∏4 5
	FindIndex
∏∏5 >
(
∏∏> ?
player
∏∏? E
=>
∏∏F H
player
∏∏I O
.
∏∏O P
IdUser
∏∏P V
==
∏∏W Y
participantUserId
∏∏Z k
)
∏∏k l
;
∏∏l m 
MatchTablePosition
ππ 
tablePosition
ππ ,
=
ππ- . 
MatchTablePosition
ππ/ A
.
ππA B
Local
ππB G
;
ππG H
if
∫∫ 
(
∫∫ !
relativePlayerIndex
∫∫ #
==
∫∫$ &
$num
∫∫' (
)
∫∫( )
{
ªª 
tablePosition
ºº 
=
ºº  
MatchTablePosition
ºº  2
.
ºº2 3
Left
ºº3 7
;
ºº7 8
}
ΩΩ 
else
ææ 
if
ææ 
(
ææ !
relativePlayerIndex
ææ (
==
ææ) +
$num
ææ, -
)
ææ- .
{
øø 
tablePosition
¿¿ 
=
¿¿ 
_seatedPlayers
¿¿  .
.
¿¿. /
Count
¿¿/ 4
==
¿¿5 7
$num
¿¿8 9
?
¿¿: ; 
MatchTablePosition
¿¿< N
.
¿¿N O
Right
¿¿O T
:
¿¿U V 
MatchTablePosition
¿¿W i
.
¿¿i j
Top
¿¿j m
;
¿¿m n
}
¡¡ 
else
¬¬ 
if
¬¬ 
(
¬¬ !
relativePlayerIndex
¬¬ (
==
¬¬) +
$num
¬¬, -
)
¬¬- .
{
√√ 
tablePosition
ƒƒ 
=
ƒƒ  
MatchTablePosition
ƒƒ  2
.
ƒƒ2 3
Right
ƒƒ3 8
;
ƒƒ8 9
}
≈≈ 
return
∆∆ 
tablePosition
∆∆  
;
∆∆  !
}
«« 	
private
…… 
void
…… #
NotifyMatchProperties
…… *
(
……* +
)
……+ ,
{
   	
OnPropertyChanged
ÀÀ 
(
ÀÀ 
nameof
ÀÀ $
(
ÀÀ$ %
MatchStateVersion
ÀÀ% 6
)
ÀÀ6 7
)
ÀÀ7 8
;
ÀÀ8 9
OnPropertyChanged
ÃÃ 
(
ÃÃ 
nameof
ÃÃ $
(
ÃÃ$ % 
CurrentTrickNumber
ÃÃ% 7
)
ÃÃ7 8
)
ÃÃ8 9
;
ÃÃ9 :
OnPropertyChanged
ÕÕ 
(
ÕÕ 
nameof
ÕÕ $
(
ÕÕ$ %&
MaximumMissionTrickCount
ÕÕ% =
)
ÕÕ= >
)
ÕÕ> ?
;
ÕÕ? @
OnPropertyChanged
ŒŒ 
(
ŒŒ 
nameof
ŒŒ $
(
ŒŒ$ %"
TrickProgressDisplay
ŒŒ% 9
)
ŒŒ9 :
)
ŒŒ: ;
;
ŒŒ; <
OnPropertyChanged
œœ 
(
œœ 
nameof
œœ $
(
œœ$ %%
CurrentTurnPlayerUserId
œœ% <
)
œœ< =
)
œœ= >
;
œœ> ?
OnPropertyChanged
–– 
(
–– 
nameof
–– $
(
––$ %#
LastTrickWinnerUserId
––% :
)
––: ;
)
––; <
;
––< =
OnPropertyChanged
—— 
(
—— 
nameof
—— $
(
——$ %#
CurrentTurnPlayerName
——% :
)
——: ;
)
——; <
;
——< =
OnPropertyChanged
““ 
(
““ 
nameof
““ $
(
““$ %!
LastTrickWinnerName
““% 8
)
““8 9
)
““9 :
;
““: ;
OnPropertyChanged
”” 
(
”” 
nameof
”” $
(
””$ % 
HasLastTrickWinner
””% 7
)
””7 8
)
””8 9
;
””9 :
OnPropertyChanged
‘‘ 
(
‘‘ 
nameof
‘‘ $
(
‘‘$ %*
ShouldShowLastCompletedTrick
‘‘% A
)
‘‘A B
)
‘‘B C
;
‘‘C D
}
’’ 	
private
◊◊ 
void
◊◊ "
SetConnectionFailure
◊◊ )
(
◊◊) *
string
◊◊* 0!
feedbackResourceKey
◊◊1 D
,
◊◊D E
	Exception
◊◊F O
ex
◊◊P R
)
◊◊R S
{
ÿÿ 	
_logger
ŸŸ 
.
ŸŸ 
Warning
ŸŸ 
(
ŸŸ +
LogMatchSynchronizationFailed
ŸŸ 9
,
ŸŸ9 :

_lobbyCode
ŸŸ; E
,
ŸŸE F!
feedbackResourceKey
ŸŸG Z
,
ŸŸZ [
ex
ŸŸ\ ^
.
ŸŸ^ _
GetType
ŸŸ_ f
(
ŸŸf g
)
ŸŸg h
.
ŸŸh i
Name
ŸŸi m
)
ŸŸm n
;
ŸŸn o
if
⁄⁄ 
(
⁄⁄ 
!
⁄⁄ 
_isDisposed
⁄⁄ 
)
⁄⁄ 
{
€€ 
_isMatchConnected
‹‹ !
=
‹‹" #
false
‹‹$ )
;
‹‹) *&
MatchFeedbackResourceKey
›› (
=
››) *!
feedbackResourceKey
››+ >
;
››> ?
}
ﬁﬁ 
}
ﬂﬂ 	
private
·· 
void
·· !
OnMatchStateChanged
·· (
(
··( )
long
··) -
matchStateVersion
··. ?
)
··? @
{
‚‚ 	%
DispatchSynchronization
„„ #
(
„„# $
)
„„$ %
;
„„% &
}
‰‰ 	
private
ÊÊ 
void
ÊÊ 
OnRefreshTimer
ÊÊ #
(
ÊÊ# $
object
ÊÊ$ *

timerState
ÊÊ+ 5
)
ÊÊ5 6
{
ÁÁ 	%
DispatchSynchronization
ËË #
(
ËË# $
)
ËË$ %
;
ËË% &
}
ÈÈ 	
private
ÎÎ 
void
ÎÎ ,
OnCompletedTrickDisplayElapsed
ÎÎ 3
(
ÎÎ3 4
object
ÎÎ4 :

timerState
ÎÎ; E
)
ÎÎE F
{
ÏÏ 	
if
ÌÌ 
(
ÌÌ 
!
ÌÌ 
_isDisposed
ÌÌ 
&&
ÌÌ 

_uiContext
ÌÌ  *
!=
ÌÌ+ -
null
ÌÌ. 2
)
ÌÌ2 3
{
ÓÓ 

_uiContext
ÔÔ 
.
ÔÔ 
Post
ÔÔ 
(
ÔÔ  
_
ÔÔ  !
=>
ÔÔ" $&
EndCompletedTrickDisplay
ÔÔ% =
(
ÔÔ= >
)
ÔÔ> ?
,
ÔÔ? @
null
ÔÔA E
)
ÔÔE F
;
ÔÔF G
}
 
}
ÒÒ 	
private
ÛÛ 
void
ÛÛ &
EndCompletedTrickDisplay
ÛÛ -
(
ÛÛ- .
)
ÛÛ. /
{
ÙÙ 	,
_isCompletedTrickDisplayActive
ıı *
=
ıı+ ,
false
ıı- 2
;
ıı2 3
OnPropertyChanged
ˆˆ 
(
ˆˆ 
nameof
ˆˆ $
(
ˆˆ$ %*
ShouldShowLastCompletedTrick
ˆˆ% A
)
ˆˆA B
)
ˆˆB C
;
ˆˆC D
}
˜˜ 	
private
˘˘ 
void
˘˘ %
DispatchSynchronization
˘˘ ,
(
˘˘, -
)
˘˘- .
{
˙˙ 	
if
˚˚ 
(
˚˚ 
!
˚˚ 
_isDisposed
˚˚ 
&&
˚˚ 

_uiContext
˚˚  *
!=
˚˚+ -
null
˚˚. 2
)
˚˚2 3
{
¸¸ 

_uiContext
˝˝ 
.
˝˝ 
Post
˝˝ 
(
˝˝  
_
˝˝  !
=>
˝˝" $"
BeginSynchronization
˝˝% 9
(
˝˝9 :
)
˝˝: ;
,
˝˝; <
null
˝˝= A
)
˝˝A B
;
˝˝B C
}
˛˛ 
}
ˇˇ 	
private
ÅÅ 
void
ÅÅ "
BeginSynchronization
ÅÅ )
(
ÅÅ) *
)
ÅÅ* +
{
ÇÇ 	
_
ÉÉ 
=
ÉÉ #
SynchronizeMatchAsync
ÉÉ %
(
ÉÉ% &
)
ÉÉ& '
;
ÉÉ' (
}
ÑÑ 	
}
ÖÖ 
}ÜÜ ¢2
lC:\Users\oscar\source\repos\TrickTakingMissions\Client\ViewModel\ViewModels\Match\Cards\HandCardViewModel.cs
	namespace 	
	ViewModel
 
. 

ViewModels 
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
HandCardViewModel

 )
:

* +
ViewModelBase

, 9
{ 
private 
bool #
_isRaisedForCurrentTurn ,
;, -
private 
bool 
_isCommunicated $
;$ %
private 
bool '
_isEligibleForCommunication 0
;0 1
private 
bool &
_isCommunicationModeActive /
;/ 0
private 
RadioTokenPosition "
_tokenPosition# 1
;1 2
public 
HandCardViewModel  
(  !
int! $
cardId% +
,+ ,
ICommand- 5
playCardCommand6 E
,E F
boolG K
isPlayableByRulesL ]
=^ _
true` d
)d e
{ 	
CardId 
= 
cardId 
; 
IsPlayableByRules 
= 
isPlayableByRules  1
;1 2
PlayCardCommand 
= 
playCardCommand -
;- .
} 	
public 
int 
CardId 
{ 
get 
;  
}! "
public 
bool 
IsPlayableByRules %
{& '
get( +
;+ ,
}- .
public 
bool "
IsRaisedForCurrentTurn *
{ 	
get 
=> #
_isRaisedForCurrentTurn *
;* +
private   
set   
=>   
SetProperty   &
(  & '
ref  ' *#
_isRaisedForCurrentTurn  + B
,  B C
value  D I
)  I J
;  J K
}!! 	
public## 
bool## 
IsCommunicated## "
{$$ 	
get%% 
=>%% 
_isCommunicated%% "
;%%" #
set&& 
=>&& 
SetProperty&& 
(&& 
ref&& "
_isCommunicated&&# 2
,&&2 3
value&&4 9
)&&9 :
;&&: ;
}'' 	
public)) 
RadioTokenPosition)) !
TokenPosition))" /
{** 	
get++ 
=>++ 
_tokenPosition++ !
;++! "
set,, 
=>,, 
SetProperty,, 
(,, 
ref,, "
_tokenPosition,,# 1
,,,1 2
value,,3 8
),,8 9
;,,9 :
}-- 	
public// 
bool// &
IsEligibleForCommunication// .
{00 	
get11 
=>11 '
_isEligibleForCommunication11 .
;11. /
private22 
set22 
{33 
if44 
(44 
SetProperty44 
(44  
ref44  #'
_isEligibleForCommunication44$ ?
,44? @
value44A F
)44F G
)44G H
{55 
OnPropertyChanged66 %
(66% &
nameof66& ,
(66, -)
IsHighlightedForCommunication66- J
)66J K
)66K L
;66L M
OnPropertyChanged77 %
(77% &
nameof77& ,
(77, -$
IsDimmedForCommunication77- E
)77E F
)77F G
;77G H
}88 
}99 
}:: 	
public<< 
bool<< %
IsCommunicationModeActive<< -
{== 	
get>> 
=>>> &
_isCommunicationModeActive>> -
;>>- .
private?? 
set?? 
{@@ 
ifAA 
(AA 
SetPropertyAA 
(AA  
refAA  #&
_isCommunicationModeActiveAA$ >
,AA> ?
valueAA@ E
)AAE F
)AAF G
{BB 
OnPropertyChangedCC %
(CC% &
nameofCC& ,
(CC, -)
IsHighlightedForCommunicationCC- J
)CCJ K
)CCK L
;CCL M
OnPropertyChangedDD %
(DD% &
nameofDD& ,
(DD, -$
IsDimmedForCommunicationDD- E
)DDE F
)DDF G
;DDG H
}EE 
}FF 
}GG 	
publicII 
boolII )
IsHighlightedForCommunicationII 1
=>II2 4&
_isCommunicationModeActiveII5 O
&&IIP R'
_isEligibleForCommunicationIIS n
;IIn o
publicKK 
boolKK $
IsDimmedForCommunicationKK ,
=>KK- /&
_isCommunicationModeActiveKK0 J
&&KKK M
!KKN O'
_isEligibleForCommunicationKKO j
;KKj k
publicMM 
ICommandMM 
PlayCardCommandMM '
{MM( )
getMM* -
;MM- .
}MM/ 0
publicOO 
voidOO "
UpdateTurnAvailabilityOO *
(OO* +
boolOO+ /"
canRaiseForCurrentTurnOO0 F
)OOF G
{PP 	"
IsRaisedForCurrentTurnQQ "
=QQ# $
IsPlayableByRulesQQ% 6
&&QQ7 9"
canRaiseForCurrentTurnQQ: P
;QQP Q
}RR 	
publicTT 
voidTT (
UpdateCommunicationHighlightTT 0
(TT0 1
boolTT1 5%
isCommunicationModeActiveTT6 O
,TTO P
boolTTQ U

isEligibleTTV `
)TT` a
{UU 	&
_isCommunicationModeActiveVV &
=VV' (%
isCommunicationModeActiveVV) B
;VVB C'
_isEligibleForCommunicationWW '
=WW( )

isEligibleWW* 4
;WW4 5
OnPropertyChangedXX 
(XX 
nameofXX $
(XX$ %%
IsCommunicationModeActiveXX% >
)XX> ?
)XX? @
;XX@ A
OnPropertyChangedYY 
(YY 
nameofYY $
(YY$ %&
IsEligibleForCommunicationYY% ?
)YY? @
)YY@ A
;YYA B
OnPropertyChangedZZ 
(ZZ 
nameofZZ $
(ZZ$ %)
IsHighlightedForCommunicationZZ% B
)ZZB C
)ZZC D
;ZZD E
OnPropertyChanged[[ 
([[ 
nameof[[ $
([[$ %$
IsDimmedForCommunication[[% =
)[[= >
)[[> ?
;[[? @
}\\ 	
}]] 
}^^ …P
ÄC:\Users\oscar\source\repos\TrickTakingMissions\Client\ViewModel\ViewModels\Match\Board\MatchBoardViewModel.MissionTransition.cs
	namespace 	
	ViewModel
 
. 

ViewModels 
{ 
public		 

sealed		 
partial		 
class		 
MatchBoardViewModel		  3
{

 
private 
readonly 
Timer ,
 _missionTransitionCountdownTimer ?
;? @
private 
long /
#_missionTransitionSnapshotTimestamp 8
;8 9
private 
int 3
'_missionTransitionRemainingMilliseconds ;
;; <
public 
int '
CurrentMissionAttemptNumber .
=>/ 1#
_confirmedMatchSnapshot2 I
?I J
.J K
MissionTransitionK \
?\ ]
.] ^
AttemptNumber^ k
??l n
$numo p
;p q
public 
string "
MissionProgressDisplay ,
=>- /#
_confirmedMatchSnapshot0 G
?G H
.H I
MissionTransitionI Z
==[ ]
null^ b
? 
string 
. 
Empty 
: 
string 
. 
Format 
( 
CultureInfo '
.' (
InvariantCulture( 8
,8 9
$str: C
,C D#
_confirmedMatchSnapshot '
.' (
MissionPreparation( :
?: ;
.; <
MissionNumber< I
,I J#
_confirmedMatchSnapshot '
.' (
MissionTransition( 9
.9 :
TargetMissionCount: L
)L M
;M N
public 
bool 
IsCampaignCompleted '
=>( *#
_confirmedMatchSnapshot+ B
?B C
.C D
MissionTransitionD U
?U V
.V W
StatusW ]
==^ `#
MissionTransitionStatus #
.# $
CampaignCompleted$ 5
;5 6
public 
bool &
IsMissionTransitionVisible .
=>/ 1#
_confirmedMatchSnapshot2 I
?I J
.J K
MissionTransitionK \
!=] _
null` d
&&e g#
_confirmedMatchSnapshot #
.# $
MissionTransition$ 5
.5 6
Status6 <
!== ?#
MissionTransitionStatus@ W
.W X
InactiveX `
;` a
public 
int -
!MissionTransitionRemainingSeconds 4
{ 	
get 
{   
double!! 
elapsedMilliseconds!! *
=!!+ ,
(!!- .
	Stopwatch!!. 7
.!!7 8
GetTimestamp!!8 D
(!!D E
)!!E F
-!!G H/
#_missionTransitionSnapshotTimestamp!!I l
)!!l m
*!!n o
$num"" 
/"" 
	Stopwatch"" &
.""& '
	Frequency""' 0
;""0 1
return## 
(## 
int## 
)## 
Math##  
.##  !
Ceiling##! (
(##( )
Math##) -
.##- .
Max##. 1
(##1 2
$num##2 3
,##3 43
'_missionTransitionRemainingMilliseconds$$ ;
-$$< =
elapsedMilliseconds$$> Q
)$$Q R
/$$S T
$num$$U [
)$$[ \
;$$\ ]
}%% 
}&& 	
public(( 
bool(( )
HasMissionTransitionCountdown(( 1
=>((2 4
_isMatchConnected((5 F
&&((G I-
!MissionTransitionRemainingSeconds((J k
>((l m
$num((n o
&&((p r
()) #
_confirmedMatchSnapshot)) $
?))$ %
.))% &
MissionTransition))& 7
?))7 8
.))8 9
Status))9 ?
==))@ B#
MissionTransitionStatus))C Z
.))Z [
CountingDown))[ g
||))h j#
_confirmedMatchSnapshot** '
?**' (
.**( )
MissionTransition**) :
?**: ;
.**; <
Status**< B
==**C E#
MissionTransitionStatus**F ]
.**] ^
PreparationFailed**^ o
)**o p
;**p q
public,, 
string,, .
"MissionTransitionStatusResourceKey,, 8
{-- 	
get.. 
{// #
MissionTransitionStatus00 '
status00( .
=00/ 0#
_confirmedMatchSnapshot001 H
?00H I
.00I J
MissionTransition00J [
?00[ \
.00\ ]
Status00] c
??00d f#
MissionTransitionStatus11 +
.11+ ,
Inactive11, 4
;114 5
string22 
resourceKey22 "
=22# $
$str22% @
+22A B
status22C I
;22I J
if33 
(33 
!33 
_isMatchConnected33 &
)33& '
{44 
resourceKey55 
=55  !
$str55" R
;55R S
}66 
else77 
if77 
(77 
(77 
status77  
==77! ##
MissionTransitionStatus77$ ;
.77; <
CountingDown77< H
||77I K
status88 
==88 #
MissionTransitionStatus88 5
.885 6
PreparationFailed886 G
)88G H
&&88I K-
!MissionTransitionRemainingSeconds88L m
==88n p
$num88q r
)88r s
{99 
resourceKey:: 
=::  !
$str::" K
;::K L
};; 
else<< 
if<< 
(<< 
status<< 
==<<  "#
MissionTransitionStatus<<# :
.<<: ;
CountingDown<<; G
&&<<H J#
_confirmedMatchSnapshot== +
?==+ ,
.==, -
MissionTransition==- >
?==> ?
.==? @
Kind==@ D
====E G!
MissionTransitionKind==H ]
.==] ^ 
AdvanceToNextMission==^ r
)==r s
{>> 
resourceKey?? 
=??  !
$str??" P
;??P Q
}@@ 
returnAA 
resourceKeyAA "
;AA" #
}BB 
}CC 	
privateEE 
voidEE *
ApplyMissionTransitionSnapshotEE 3
(EE3 4%
MissionTransitionSnapshotEE4 M
transitionSnapshotEEN `
)EE` a
{FF 	3
'_missionTransitionRemainingMillisecondsGG 3
=GG4 5
MathGG6 :
.GG: ;
MaxGG; >
(GG> ?
$numGG? @
,GG@ A
transitionSnapshotGGB T
?GGT U
.GGU V&
RemainingDelayMillisecondsGGV p
??GGq s
$numGGt u
)GGu v
;GGv w/
#_missionTransitionSnapshotTimestampHH /
=HH0 1
	StopwatchHH2 ;
.HH; <
GetTimestampHH< H
(HHH I
)HHI J
;HHJ K
}II 	
privateKK 
voidKK ,
 OnMissionTransitionCountdownTickKK 5
(KK5 6
objectKK6 <

timerStateKK= G
)KKG H
{LL 	
ifMM 
(MM 
!MM 
_isDisposedMM 
&&MM &
IsMissionTransitionVisibleMM  :
&&MM; =

_uiContextMM> H
!=MMI K
nullMML P
)MMP Q
{NN 

_uiContextOO 
.OO 
PostOO 
(OO  
_OO  !
=>OO" $-
!NotifyMissionTransitionPropertiesOO% F
(OOF G
)OOG H
,OOH I
nullOOJ N
)OON O
;OOO P
}PP 
}QQ 	
privateSS 
voidSS -
!ResetAttemptPresentationIfChangedSS 6
(SS6 7
PlayerMatchSnapshotSS7 J
playerSnapshotSSK Y
)SSY Z
{TT 	
boolUU 
hasAttemptChangedUU "
=UU# $#
_confirmedMatchSnapshotUU% <
?UU< =
.UU= >
MissionPreparationUU> P
!=UUQ S
nullUUT X
&&UUY [#
_confirmedMatchSnapshotVV '
.VV' (
MissionPreparationVV( :
.VV: ;
MissionAttemptIdVV; K
!=VVL N
playerSnapshotWW "
.WW" #
MissionPreparationWW# 5
?WW5 6
.WW6 7
MissionAttemptIdWW7 G
;WWG H
ifXX 
(XX 
hasAttemptChangedXX !
)XX! "
{YY )
_announcedCompletedTrickCountZZ -
=ZZ. /
$numZZ0 1
;ZZ1 2*
_isCompletedTrickDisplayActive[[ .
=[[/ 0
false[[1 6
;[[6 7'
_completedTrickDisplayTimer\\ +
.\\+ ,
Change\\, 2
(\\2 3
Timeout\\3 :
.\\: ;
Infinite\\; C
,\\C D
Timeout\\E L
.\\L M
Infinite\\M U
)\\U V
;\\V W
}]] 
}^^ 	
private`` 
void`` -
!NotifyMissionTransitionProperties`` 6
(``6 7
)``7 8
{aa 	
OnPropertyChangedbb 
(bb 
nameofbb $
(bb$ %&
IsMissionTransitionVisiblebb% ?
)bb? @
)bb@ A
;bbA B
OnPropertyChangedcc 
(cc 
nameofcc $
(cc$ %
IsCampaignCompletedcc% 8
)cc8 9
)cc9 :
;cc: ;
OnPropertyChangeddd 
(dd 
nameofdd $
(dd$ %"
MissionProgressDisplaydd% ;
)dd; <
)dd< =
;dd= >
OnPropertyChangedee 
(ee 
nameofee $
(ee$ %'
CurrentMissionAttemptNumberee% @
)ee@ A
)eeA B
;eeB C
OnPropertyChangedff 
(ff 
nameofff $
(ff$ %-
!MissionTransitionRemainingSecondsff% F
)ffF G
)ffG H
;ffH I
OnPropertyChangedgg 
(gg 
nameofgg $
(gg$ %)
HasMissionTransitionCountdowngg% B
)ggB C
)ggC D
;ggD E
OnPropertyChangedhh 
(hh 
nameofhh $
(hh$ %.
"MissionTransitionStatusResourceKeyhh% G
)hhG H
)hhH I
;hhI J
}ii 	
}jj 
}kk ï-
ÄC:\Users\oscar\source\repos\TrickTakingMissions\Client\ViewModel\ViewModels\Match\Board\MatchBoardViewModel.MissionEvaluation.cs
	namespace 	
	ViewModel
 
. 

ViewModels 
{ 
public 

sealed 
partial 
class 
MatchBoardViewModel  3
{ 
public 
bool $
IsMissionAttemptFinished ,
=>- /%
IsMissionAttemptSucceeded0 I
||J L"
IsMissionAttemptFailedM c
;c d
public		 
bool		 %
IsMissionAttemptSucceeded		 -
=>		. 0#
_confirmedMatchSnapshot		1 H
?		H I
.		I J
MissionEvaluation		J [
?		[ \
.		\ ] 
MissionAttemptStatus		] q
==		r t*
MissionAttemptEvaluationStatus

 *
.

* +
	Succeeded

+ 4
;

4 5
public 
bool "
IsMissionAttemptFailed *
=>+ -#
_confirmedMatchSnapshot. E
?E F
.F G
MissionEvaluationG X
?X Y
.Y Z 
MissionAttemptStatusZ n
==o q*
MissionAttemptEvaluationStatus *
.* +
Failed+ 1
;1 2
public 
bool 
IsTrickTurnVisible &
=>' )(
IsMissionPreparationComplete* F
&&G I
!J K$
IsMissionAttemptFinishedK c
;c d
public 
string 0
$MissionEvaluationFeedbackResourceKey :
{ 	
get 
{ 
string 
feedbackResourceKey *
=+ ,
$str- Q
;Q R
if 
( %
IsMissionAttemptSucceeded -
)- .
{ 
feedbackResourceKey '
=( )
$str* M
;M N
} 
else 
if 
( "
IsMissionAttemptFailed /
)/ 0
{ 
feedbackResourceKey '
=( )
$str* D
+E F#
_confirmedMatchSnapshot /
./ 0
MissionEvaluation0 A
.A B 
MissionFailureReasonB V
;V W
} 
return 
feedbackResourceKey *
;* +
}   
}!! 	
private## 
string## !
GetMatchFaultFeedback## ,
(##, -
MatchAccessFault##- =
matchAccessFault##> N
)##N O
{$$ 	
string%% 
feedbackResourceKey%% &
=%%' (
$str%%) B
;%%B C
if&& 
(&& 
matchAccessFault&&  
?&&  !
.&&! "
FailureCode&&" -
==&&. 0
nameof&&1 7
(&&7 80
$MissionObjectiveDraftRejectionReason&&8 \
.&&\ ]
RequestLimitReached&&] p
)&&p q
)&&q r
{'' 
feedbackResourceKey(( #
=(($ %
$str((& N
;((N O
})) 
else** 
if** 
(** 
matchAccessFault** %
?**% &
.**& '
FailureCode**' 2
==**3 5
$str**6 T
)**T U
{++ 
feedbackResourceKey,, #
=,,$ %
$str,,& K
;,,K L
}-- 
if.. 
(.. 
matchAccessFault..  
?..  !
...! "
FailureCode.." -
==... 0
$str..1 U
)..U V
{// 
feedbackResourceKey00 #
=00$ %
$str00& Q
;00Q R
}11 
if22 
(22 #
_pendingRadioSubmission22 '
!=22( *
null22+ /
&&220 2
(33 
matchAccessFault33 !
?33! "
.33" #
FailureCode33# .
==33/ 1
nameof332 8
(338 9+
RadioCommunicationFailureReason339 X
.33X Y 
OperationUnavailable33Y m
)33m n
||33o q
matchAccessFault44 $
?44$ %
.44% &
FailureCode44& 1
==442 4
nameof445 ;
(44; <+
RadioCommunicationFailureReason44< [
.44[ \
RequestLimitReached44\ o
)44o p
)44p q
)44q r
{55 
feedbackResourceKey66 #
=66$ %
$str66& 4
+665 6
matchAccessFault667 G
.66G H
FailureCode66H S
;66S T
}77 
if88 
(88 !
HasPendingPreparation88 %
)88% &
{99 
feedbackResourceKey:: #
=::$ %
$str::& U
;::U V
};; 
return<< 
feedbackResourceKey<< &
;<<& '
}== 	
private?? 
void?? -
!NotifyMissionEvaluationProperties?? 6
(??6 7
)??7 8
{@@ 	
OnPropertyChangedAA 
(AA 
nameofAA $
(AA$ %$
IsMissionAttemptFinishedAA% =
)AA= >
)AA> ?
;AA? @
OnPropertyChangedBB 
(BB 
nameofBB $
(BB$ %%
IsMissionAttemptSucceededBB% >
)BB> ?
)BB? @
;BB@ A
OnPropertyChangedCC 
(CC 
nameofCC $
(CC$ %"
IsMissionAttemptFailedCC% ;
)CC; <
)CC< =
;CC= >
OnPropertyChangedDD 
(DD 
nameofDD $
(DD$ %
IsTrickTurnVisibleDD% 7
)DD7 8
)DD8 9
;DD9 :
OnPropertyChangedEE 
(EE 
nameofEE $
(EE$ %0
$MissionEvaluationFeedbackResourceKeyEE% I
)EEI J
)EEJ K
;EEK L
}FF 	
}GG 
}HH √
`C:\Users\oscar\source\repos\TrickTakingMissions\Client\ViewModel\Models\ProfileImageSelection.cs
	namespace 	
	ViewModel
 
. 
Models 
{ 
public 

sealed 
class !
ProfileImageSelection -
{		 
public

 
byte

 
[

 
]

 %
SelectedProfileImageBytes

 /
{

0 1
get

2 5
;

5 6
set

7 :
;

: ;
}

< =
public  
ProfileImageFeedback #
SelectionFeedback$ 5
{6 7
get8 ;
;; <
set= @
;@ A
}B C
} 
} ‹
bC:\Users\oscar\source\repos\TrickTakingMissions\Client\ViewModel\Constants\ProfileImageFeedback.cs
	namespace 	
	ViewModel
 
. 
	Constants 
{ 
public 

enum  
ProfileImageFeedback $
{ 
None 
, 
	Uploading 
, 
UploadSucceeded 
, "
AuthenticationRequired		 
,		 
ImageServiceBusy

 
,

 
InvalidImageRequest 
, 
ImageSizeExceeded 
, 
InvalidImageFormat 
, #
ImageDimensionsExceeded 
,  
ImageNotFound 
, 
InvalidStoredImage 
, #
ImageStorageUnavailable 
,  &
ImageConnectionUnavailable "
," # 
ImageFileUnavailable 
, 
OperationFailed 
} 
} Œ*
lC:\Users\oscar\source\repos\TrickTakingMissions\Client\ViewModel\ViewModels\Profile\ProfileImageViewModel.cs
	namespace 	
	ViewModel
 
. 

ViewModels 
{ 
public 

sealed 
class !
ProfileImageViewModel -
:. /
ViewModelBase0 =
,= >
IDisposable? J
{ 
private 
readonly 
IProfileImageCache +
_profileImageCache, >
;> ?
private 
readonly 
int 
_profileOwnerUserId 0
;0 1
private 
readonly "
SynchronizationContext /

_uiContext0 :
;: ;
private 
byte 
[ 
] 
_profileImageBytes )
;) *
private 
bool 
_isDisposed  
;  !
public !
ProfileImageViewModel $
($ %
int% (
profileOwnerUserId) ;
,; <
IProfileImageCache= O
profileImageCacheP a
)a b
{ 	
_profileOwnerUserId 
=  !
profileOwnerUserId" 4
;4 5
_profileImageCache 
=  
profileImageCache! 2
;2 3

_uiContext 
= "
SynchronizationContext /
./ 0
Current0 7
;7 8
_profileImageCache 
. 
RegisterPlayer -
(- .
profileOwnerUserId. @
)@ A
;A B
_profileImageCache 
. 
ProfileImageChanged 2
+=3 5
OnImageChanged6 D
;D E
_ 
= 
LoadImageAsync 
( 
)  
;  !
} 	
public 
byte 
[ 
] 
ProfileImageBytes '
{ 	
get   
=>   
_profileImageBytes   %
;  % &
private!! 
set!! 
=>!! 
SetProperty!! &
(!!& '
ref!!' *
_profileImageBytes!!+ =
,!!= >
value!!? D
)!!D E
;!!E F
}"" 	
private$$ 
void$$ 
OnImageChanged$$ #
($$# $
int$$$ '
profileOwnerUserId$$( :
)$$: ;
{%% 	
if&& 
(&& 
profileOwnerUserId&& "
==&&# %
_profileOwnerUserId&&& 9
&&&&: <
!&&= >
_isDisposed&&> I
)&&I J
{'' 
_(( 
=(( 
LoadImageAsync(( "
(((" #
)((# $
;(($ %
})) 
}** 	
private,, 
async,, 
Task,, 
LoadImageAsync,, )
(,,) *
),,* +
{-- 	
try.. 
{// 
byte00 
[00 
]00 

imageBytes00 !
=00" #
await00$ )
_profileImageCache00* <
.00< =!
LoadProfileImageAsync00= R
(00R S
_profileOwnerUserId00S f
)00f g
;00g h 
ApplyImageOnUiThread11 $
(11$ %

imageBytes11% /
)11/ 0
;110 1
}22 
catch33 
(33 *
ProfileImageOperationException33 1
)331 2
{44  
ApplyImageOnUiThread55 $
(55$ %
null55% )
)55) *
;55* +
}66 
}77 	
private99 
void99  
ApplyImageOnUiThread99 )
(99) *
byte99* .
[99. /
]99/ 0

imageBytes991 ;
)99; <
{:: 	
if;; 
(;; 
!;; 
_isDisposed;; 
);; 
{<< 
if== 
(== 

_uiContext== 
==== !
null==" &
)==& '
{>> 
ProfileImageBytes?? %
=??& '

imageBytes??( 2
;??2 3
}@@ 
elseAA 
{BB 

_uiContextCC 
.CC 
PostCC #
(CC# $
_CC$ %
=>CC& (
ApplyImageIfActiveCC) ;
(CC; <

imageBytesCC< F
)CCF G
,CCG H
nullCCI M
)CCM N
;CCN O
}DD 
}EE 
}FF 	
privateHH 
voidHH 
ApplyImageIfActiveHH '
(HH' (
byteHH( ,
[HH, -
]HH- .

imageBytesHH/ 9
)HH9 :
{II 	
ifJJ 
(JJ 
!JJ 
_isDisposedJJ 
)JJ 
{KK 
ProfileImageBytesLL !
=LL" #

imageBytesLL$ .
;LL. /
}MM 
}NN 	
publicPP 
voidPP 
DisposePP 
(PP 
)PP 
{QQ 	
ifRR 
(RR 
!RR 
_isDisposedRR 
)RR 
{SS 
_isDisposedTT 
=TT 
trueTT "
;TT" #
_profileImageCacheUU "
.UU" #
ProfileImageChangedUU# 6
-=UU7 9
OnImageChangedUU: H
;UUH I
_profileImageCacheVV "
.VV" #
UnregisterPlayerVV# 3
(VV3 4
_profileOwnerUserIdVV4 G
)VVG H
;VVH I
}WW 
}XX 	
}YY 
}ZZ ⁄
`C:\Users\oscar\source\repos\TrickTakingMissions\Client\ViewModel\Services\IProfileImagePicker.cs
	namespace 	
	ViewModel
 
. 
Services 
{ 
public		 

	interface		 
IProfileImagePicker		 (
{

 
Task 
< !
ProfileImageSelection "
>" #!
PickProfileImageAsync$ 9
(9 :
): ;
;; <
} 
} Ëq
qC:\Users\oscar\source\repos\TrickTakingMissions\Client\ViewModel\ViewModels\Friends\SendFriendRequestViewModel.cs
	namespace 	
	ViewModel
 
. 

ViewModels 
{ 
public 

sealed 
class &
SendFriendRequestViewModel 2
:3 4
ViewModelBase5 B
{ 
private 
const 
string *
LogLoadSentRequestsUnavailable ;
=< =
$str \
;\ ]
private 
const 
string +
LogSendFriendRequestUnavailable <
== >
$str U
;U V
private 
const 
string (
LogSendFriendRequestRejected 9
=: ;
$str X
;X Y
private 
const 
string -
!LogCancelFriendRequestUnavailable >
=? @
$str f
;f g
private 
const 
string *
LogCancelFriendRequestRejected ;
=< =
$str i
;i j
private 
readonly 
INavigationService +
_navigationService, >
;> ?
private   
readonly   
IDialogService   '
_dialogService  ( 6
;  6 7
private!! 
readonly!! 
ILoggerService!! '
_logger!!( /
;!!/ 0
private"" 
readonly"" 
IFriendshipSession"" +
_friendshipSession"", >
;""> ?
private## 
string## 
	_username##  
;##  !
public)) &
SendFriendRequestViewModel)) )
())) *
ViewModelUiServices))* =

uiServices))> H
)))H I
:** 
this** 
(** 

uiServices** 
,** 
FriendshipSession** 0
.**0 1
Current**1 8
)**8 9
{++ 	
},, 	
public33 &
SendFriendRequestViewModel33 )
(33) *
ViewModelUiServices44 

uiServices44  *
,44* +
IFriendshipSession55 
friendshipSession55 0
)550 1
{66 	
if77 
(77 

uiServices77 
==77 
null77 "
)77" #
{88 
throw99 
new99 !
ArgumentNullException99 /
(99/ 0
nameof990 6
(996 7

uiServices997 A
)99A B
)99B C
;99C D
}:: 
_navigationService<< 
=<<  

uiServices<<! +
.<<+ ,
NavigationService<<, =
;<<= >
_dialogService== 
=== 

uiServices== '
.==' (
DialogService==( 5
;==5 6
_logger>> 
=>> 

uiServices>>  
.>>  !
Logger>>! '
;>>' (
_friendshipSession?? 
=??  
friendshipSession??! 2
????3 5
throw??6 ;
new??< ?!
ArgumentNullException??@ U
(??U V
nameof??V \
(??\ ]
friendshipSession??] n
)??n o
)??o p
;??p q
	_username@@ 
=@@ 
string@@ 
.@@ 
Empty@@ $
;@@$ %
SentRequestsBB 
=BB 
newBB  
ObservableCollectionBB 3
<BB3 4&
FriendRequestItemViewModelBB4 N
>BBN O
(BBO P
)BBP Q
;BBQ R
BackCommandDD 
=DD 
newDD 
RelayCommandDD *
(DD* +
ExecuteBackDD+ 6
)DD6 7
;DD7 8
SendCommandEE 
=EE 
newEE 
AsyncRelayCommandEE /
(EE/ 0
ExecuteSendAsyncEE0 @
)EE@ A
;EEA B$
CancelSentRequestCommandFF $
=FF% &
newFF' *
AsyncRelayCommandFF+ <
(FF< =)
ExecuteCancelSentRequestAsyncFF= Z
)FFZ [
;FF[ \
_HH 
=HH !
LoadSentRequestsAsyncHH %
(HH% &
)HH& '
;HH' (
}II 	
publicNN  
ObservableCollectionNN #
<NN# $&
FriendRequestItemViewModelNN$ >
>NN> ?
SentRequestsNN@ L
{NNM N
getNNO R
;NNR S
}NNT U
publicSS 
stringSS 
UsernameSS 
{TT 	
getUU 
=>UU 
	_usernameUU 
;UU 
setVV 
=>VV 
SetPropertyVV 
(VV 
refVV "
	_usernameVV# ,
,VV, -
valueVV. 3
)VV3 4
;VV4 5
}WW 	
public\\ 
ICommand\\ 
BackCommand\\ #
{\\$ %
get\\& )
;\\) *
}\\+ ,
publicaa 
ICommandaa 
SendCommandaa #
{aa$ %
getaa& )
;aa) *
}aa+ ,
publicff 
ICommandff $
CancelSentRequestCommandff 0
{ff1 2
getff3 6
;ff6 7
}ff8 9
privatehh 
asynchh 
Taskhh !
LoadSentRequestsAsynchh 0
(hh0 1
)hh1 2
{ii 	
intjj 
currentUserIdjj 
=jj "
GetAuthenticatedUserIdjj  6
(jj6 7
)jj7 8
;jj8 9
ifll 
(ll 
currentUserIdll 
>ll 
$numll  !
)ll! "
{mm 
IListnn 
<nn 
FriendRequestnn #
>nn# $
requestsFromServernn% 7
=nn8 9
awaitoo 
_friendshipSessionoo ,
.oo, -
RequestClientoo- :
.oo: ;-
!GetSentFriendRequestByUserIdAsyncoo; \
(oo\ ]
currentUserIdoo] j
)ooj k
;ook l
SentRequestsqq 
.qq 
Clearqq "
(qq" #
)qq# $
;qq$ %
ifss 
(ss 
requestsFromServerss &
!=ss' )
nullss* .
)ss. /
{tt 
foreachuu 
(uu 
FriendRequestuu *
requestuu+ 2
inuu3 5
requestsFromServeruu6 H
)uuH I
{vv 
ifww 
(ww 
requestww #
!=ww$ &
nullww' +
)ww+ ,
{xx &
FriendRequestItemViewModelyy 6
itemyy7 ;
=yy< =
newyy> A&
FriendRequestItemViewModelyyB \
(yy\ ]
requestzz  '
.zz' (
SenderUserIdzz( 4
,zz4 5
request{{  '
.{{' (
SenderUsername{{( 6
,{{6 7
request||  '
.||' (
ReceiverUserId||( 6
,||6 7
request}}  '
.}}' (
ReceiverUsername}}( 8
,}}8 9
request~~  '
.~~' (
RequestedAt~~( 3
)~~3 4
;~~4 5
SentRequests (
.( )
Add) ,
(, -
item- 1
)1 2
;2 3
}
ÄÄ 
}
ÅÅ 
}
ÇÇ 
else
ÉÉ 
{
ÑÑ 
_logger
ÖÖ 
.
ÖÖ 
Warning
ÖÖ #
(
ÖÖ# $,
LogLoadSentRequestsUnavailable
ÖÖ$ B
,
ÖÖB C
currentUserId
ÖÖD Q
)
ÖÖQ R
;
ÖÖR S
}
ÜÜ 
}
áá 
}
àà 	
private
ää 
void
ää 
ExecuteBack
ää  
(
ää  !
)
ää! "
{
ãã 	 
_navigationService
åå 
.
åå 
GoBack
åå %
(
åå% &
)
åå& '
;
åå' (
}
çç 	
private
èè 
async
èè 
Task
èè 
ExecuteSendAsync
èè +
(
èè+ ,
)
èè, -
{
êê 	
string
ëë 
trimmedUsername
ëë "
=
ëë# $
	_username
ëë% .
?
ëë. /
.
ëë/ 0
Trim
ëë0 4
(
ëë4 5
)
ëë5 6
;
ëë6 7
if
ìì 
(
ìì 
string
ìì 
.
ìì  
IsNullOrWhiteSpace
ìì )
(
ìì) *
trimmedUsername
ìì* 9
)
ìì9 :
)
ìì: ;
{
îî 
_dialogService
ïï 
.
ïï 
ShowWarning
ïï *
(
ïï* +
MessageCode
ïï+ 6
.
ïï6 7!
EmptyFriendUsername
ïï7 J
)
ïïJ K
;
ïïK L
}
ññ 
else
óó 
{
òò 
int
ôô 
currentUserId
ôô !
=
ôô" #$
GetAuthenticatedUserId
ôô$ :
(
ôô: ;
)
ôô; <
;
ôô< =
if
õõ 
(
õõ 
currentUserId
õõ !
>
õõ" #
$num
õõ$ %
)
õõ% &
{
úú 
OperationResult
ùù #
result
ùù$ *
=
ùù+ ,
await
ùù- 2 
_friendshipSession
ùù3 E
.
ùùE F
RequestClient
ùùF S
.
ùùS T$
SendFriendRequestAsync
ùùT j
(
ùùj k
currentUserId
ûû %
,
ûû% &
trimmedUsername
üü '
)
üü' (
;
üü( )
if
°° 
(
°° 
result
°° 
==
°° !
null
°°" &
)
°°& '
{
¢¢ 
_logger
££ 
.
££  
Error
££  %
(
££% &-
LogSendFriendRequestUnavailable
££& E
,
££E F
currentUserId
££G T
)
££T U
;
££U V
_dialogService
§§ &
.
§§& '
	ShowError
§§' 0
(
§§0 1
MessageCode
§§1 <
.
§§< =
ConnectionFailed
§§= M
)
§§M N
;
§§N O
}
•• 
else
¶¶ 
if
¶¶ 
(
¶¶ 
!
¶¶ 
result
¶¶ $
.
¶¶$ %
	IsSuccess
¶¶% .
)
¶¶. /
{
ßß 
_logger
®® 
.
®®  
Warning
®®  '
(
®®' (*
LogSendFriendRequestRejected
®®( D
,
®®D E
currentUserId
®®F S
,
®®S T
result
®®U [
.
®®[ \
	ErrorCode
®®\ e
)
®®e f
;
®®f g
_dialogService
©© &
.
©©& '
ShowWarning
©©' 2
(
©©2 3
MessageCode
©©3 >
.
©©> ?
UnexpectedError
©©? N
)
©©N O
;
©©O P
}
™™ 
else
´´ 
{
¨¨ 
Username
≠≠  
=
≠≠! "
string
≠≠# )
.
≠≠) *
Empty
≠≠* /
;
≠≠/ 0
await
ÆÆ #
LoadSentRequestsAsync
ÆÆ 3
(
ÆÆ3 4
)
ÆÆ4 5
;
ÆÆ5 6
}
ØØ 
}
∞∞ 
else
±± 
{
≤≤ 
_dialogService
≥≥ "
.
≥≥" #
ShowWarning
≥≥# .
(
≥≥. /
MessageCode
≥≥/ :
.
≥≥: ;
UnexpectedError
≥≥; J
)
≥≥J K
;
≥≥K L
}
¥¥ 
}
µµ 
}
∂∂ 	
private
∏∏ 
async
∏∏ 
Task
∏∏ +
ExecuteCancelSentRequestAsync
∏∏ 8
(
∏∏8 9
object
∏∏9 ?
	parameter
∏∏@ I
)
∏∏I J
{
ππ 	(
FriendRequestItemViewModel
∫∫ &
requestItem
∫∫' 2
=
∫∫3 4
	parameter
∫∫5 >
as
∫∫? A(
FriendRequestItemViewModel
∫∫B \
;
∫∫\ ]
int
ªª 
currentUserId
ªª 
=
ªª $
GetAuthenticatedUserId
ªª  6
(
ªª6 7
)
ªª7 8
;
ªª8 9
if
ΩΩ 
(
ΩΩ 
requestItem
ΩΩ 
!=
ΩΩ 
null
ΩΩ #
&&
ΩΩ$ &
currentUserId
ΩΩ' 4
>
ΩΩ5 6
$num
ΩΩ7 8
)
ΩΩ8 9
{
ææ 
OperationResult
øø 
result
øø  &
=
øø' (
await
øø) . 
_friendshipSession
øø/ A
.
øøA B
RequestClient
øøB O
.
øøO P&
CancelFriendRequestAsync
øøP h
(
øøh i
currentUserId
¿¿ !
,
¿¿! "
requestItem
¡¡ 
.
¡¡  
ReceiverUserId
¡¡  .
)
¡¡. /
;
¡¡/ 0
if
√√ 
(
√√ 
result
√√ 
==
√√ 
null
√√ "
)
√√" #
{
ƒƒ 
_logger
≈≈ 
.
≈≈ 
Error
≈≈ !
(
≈≈! "/
!LogCancelFriendRequestUnavailable
≈≈" C
,
≈≈C D
requestItem
≈≈E P
.
≈≈P Q
ReceiverUserId
≈≈Q _
)
≈≈_ `
;
≈≈` a
_dialogService
∆∆ "
.
∆∆" #
	ShowError
∆∆# ,
(
∆∆, -
MessageCode
∆∆- 8
.
∆∆8 9
ConnectionFailed
∆∆9 I
)
∆∆I J
;
∆∆J K
}
«« 
else
»» 
if
»» 
(
»» 
result
»» 
.
»»  
	IsSuccess
»»  )
)
»») *
{
…… 
SentRequests
    
.
    !
Remove
  ! '
(
  ' (
requestItem
  ( 3
)
  3 4
;
  4 5
}
ÀÀ 
else
ÃÃ 
{
ÕÕ 
_logger
ŒŒ 
.
ŒŒ 
Warning
ŒŒ #
(
ŒŒ# $,
LogCancelFriendRequestRejected
ŒŒ$ B
,
ŒŒB C
requestItem
ŒŒD O
.
ŒŒO P
ReceiverUserId
ŒŒP ^
,
ŒŒ^ _
result
ŒŒ` f
.
ŒŒf g
	ErrorCode
ŒŒg p
)
ŒŒp q
;
ŒŒq r
_dialogService
œœ "
.
œœ" #
ShowWarning
œœ# .
(
œœ. /
MessageCode
œœ/ :
.
œœ: ;
UnexpectedError
œœ; J
)
œœJ K
;
œœK L
}
–– 
}
—— 
}
““ 	
private
‘‘ 
static
‘‘ 
int
‘‘ $
GetAuthenticatedUserId
‘‘ 1
(
‘‘1 2
)
‘‘2 3
{
’’ 	
int
÷÷ 
userId
÷÷ 
=
÷÷ 
$num
÷÷ 
;
÷÷ 
if
ÿÿ 
(
ÿÿ 
UserSession
ÿÿ 
.
ÿÿ 
Current
ÿÿ #
.
ÿÿ# $
IsAuthenticated
ÿÿ$ 3
&&
ÿÿ4 6
UserSession
ÿÿ7 B
.
ÿÿB C
Current
ÿÿC J
.
ÿÿJ K
CurrentUser
ÿÿK V
!=
ÿÿW Y
null
ÿÿZ ^
)
ÿÿ^ _
{
ŸŸ 
userId
⁄⁄ 
=
⁄⁄ 
UserSession
⁄⁄ $
.
⁄⁄$ %
Current
⁄⁄% ,
.
⁄⁄, -
CurrentUser
⁄⁄- 8
.
⁄⁄8 9
IdUser
⁄⁄9 ?
;
⁄⁄? @
}
€€ 
return
›› 
userId
›› 
;
›› 
}
ﬁﬁ 	
}
ﬂﬂ 
}‡‡ Ê
kC:\Users\oscar\source\repos\TrickTakingMissions\Client\ViewModel\ViewModels\Menu\SelectLanguageViewModel.cs
	namespace 	
	ViewModel
 
. 

ViewModels 
{ 
public 

sealed 
class #
SelectLanguageViewModel /
:0 1
ViewModelBase2 ?
{ 
private 
const 
string 
SpanishCultureCode /
=0 1
$str2 9
;9 :
private 
const 
string 
EnglishCultureCode /
=0 1
$str2 9
;9 :
private 
readonly 
ILanguageService )
_languageService* :
;: ;
public 
event 
Action 
RequestClose (
;( )
public #
SelectLanguageViewModel &
(& '
ILanguageService' 7
languageService8 G
)G H
{ 	
_languageService 
= 
languageService .
??/ 1
throw2 7
new8 ;!
ArgumentNullException< Q
(Q R
nameofR X
(X Y
languageServiceY h
)h i
)i j
;j k 
SelectSpanishCommand  
=! "
new# &
RelayCommand' 3
(3 4 
ExecuteSelectSpanish4 H
)H I
;I J 
SelectEnglishCommand    
=  ! "
new  # &
RelayCommand  ' 3
(  3 4 
ExecuteSelectEnglish  4 H
)  H I
;  I J
CloseCommand!! 
=!! 
new!! 
RelayCommand!! +
(!!+ ,
ExecuteClose!!, 8
)!!8 9
;!!9 :
}"" 	
public'' 
ICommand''  
SelectSpanishCommand'' ,
{''- .
get''/ 2
;''2 3
}''4 5
public,, 
ICommand,,  
SelectEnglishCommand,, ,
{,,- .
get,,/ 2
;,,2 3
},,4 5
public11 
ICommand11 
CloseCommand11 $
{11% &
get11' *
;11* +
}11, -
private33 
void33  
ExecuteSelectSpanish33 )
(33) *
)33* +
{44 	
_languageService55 
.55 
ChangeLanguage55 +
(55+ ,
SpanishCultureCode55, >
)55> ?
;55? @
RequestClose66 
?66 
.66 
Invoke66  
(66  !
)66! "
;66" #
}77 	
private99 
void99  
ExecuteSelectEnglish99 )
(99) *
)99* +
{:: 	
_languageService;; 
.;; 
ChangeLanguage;; +
(;;+ ,
EnglishCultureCode;;, >
);;> ?
;;;? @
RequestClose<< 
?<< 
.<< 
Invoke<<  
(<<  !
)<<! "
;<<" #
}== 	
private?? 
void?? 
ExecuteClose?? !
(??! "
)??" #
{@@ 	
RequestCloseAA 
?AA 
.AA 
InvokeAA  
(AA  !
)AA! "
;AA" #
}BB 	
}CC 
}DD Õ
gC:\Users\oscar\source\repos\TrickTakingMissions\Client\ViewModel\ViewModels\Menu\ScoreBoardViewModel.cs
	namespace 	
	ViewModel
 
. 

ViewModels 
{ 
public 

sealed 
class 
UserRankingItem '
{ 
public 
int 
Position 
{ 
get !
;! "
set# &
;& '
}( )
public 
string 
Username 
{  
get! $
;$ %
set& )
;) *
}+ ,
public 
int 
TotalXP 
{ 
get  
;  !
set" %
;% &
}' (
} 
public   

sealed   
class   
ScoreBoardViewModel   +
:  , -
ViewModelBase  . ;
{!! 
public%% 
event%% 
Action%% 
RequestClose%% (
;%%( )
public** 
ScoreBoardViewModel** "
(**" #
)**# $
{++ 	
Rankings,, 
=,, 
new,,  
ObservableCollection,, /
<,,/ 0
UserRankingItem,,0 ?
>,,? @
(,,@ A
),,A B
;,,B C
CloseCommand.. 
=.. 
new.. 
RelayCommand.. +
(..+ ,
ExecuteClose.., 8
)..8 9
;..9 :
LoadSampleRankings00 
(00 
)00  
;00  !
}11 	
public66  
ObservableCollection66 #
<66# $
UserRankingItem66$ 3
>663 4
Rankings665 =
{66> ?
get66@ C
;66C D
}66E F
public;; 
ICommand;; 
CloseCommand;; $
{;;% &
get;;' *
;;;* +
};;, -
private== 
void== 
LoadSampleRankings== '
(==' (
)==( )
{>> 	
Rankings@@ 
.@@ 
Add@@ 
(@@ 
new@@ 
UserRankingItem@@ ,
{@@- .
Position@@/ 7
=@@8 9
$num@@: ;
,@@; <
Username@@= E
=@@F G
$str@@H X
,@@X Y
TotalXP@@Z a
=@@b c
$num@@d h
}@@i j
)@@j k
;@@k l
RankingsAA 
.AA 
AddAA 
(AA 
newAA 
UserRankingItemAA ,
{AA- .
PositionAA/ 7
=AA8 9
$numAA: ;
,AA; <
UsernameAA= E
=AAF G
$strAAH W
,AAW X
TotalXPAAY `
=AAa b
$numAAc g
}AAh i
)AAi j
;AAj k
RankingsBB 
.BB 
AddBB 
(BB 
newBB 
UserRankingItemBB ,
{BB- .
PositionBB/ 7
=BB8 9
$numBB: ;
,BB; <
UsernameBB= E
=BBF G
$strBBH U
,BBU V
TotalXPBBW ^
=BB_ `
$numBBa e
}BBf g
)BBg h
;BBh i
}CC 	
privateEE 
voidEE 
ExecuteCloseEE !
(EE! "
)EE" #
{FF 	
RequestCloseGG 
?GG 
.GG 
InvokeGG  
(GG  !
)GG! "
;GG" #
}HH 	
}II 
}JJ Ç†
oC:\Users\oscar\source\repos\TrickTakingMissions\Client\ViewModel\ViewModels\Authentication\RegisterViewModel.cs
	namespace 	
	ViewModel
 
. 

ViewModels 
{ 
public 

sealed 
class 
RegisterViewModel )
:* +
ViewModelBase, 9
{ 
private 
const 
int !
MinimumPasswordLength /
=0 1
$num2 3
;3 4
private 
const 
string #
SpecialCharacterPattern 4
=5 6
$str7 F
;F G
private 
const 
string 
NumberPattern *
=+ ,
$str- 5
;5 6
private 
const 
string #
LogRegistrationRejected 4
=5 6
$str7 r
;r s
private 
const 
string *
LogRegistrationConnectionError ;
=< =
$str O
;O P
private 
readonly 
INavigationService +
_navigationService, >
;> ?
private 
readonly 
IDialogService '
_dialogService( 6
;6 7
private 
readonly 
ILoggerService '
_logger( /
;/ 0
private 
readonly $
IAccountManagementClient 1$
_accountManagementClient2 J
;J K
private!! 
string!! 
_email!! 
;!! 
private"" 
string"" 
	_username""  
;""  !
private## 
string## 
	_password##  
;##  !
private$$ 
string$$ 
_passwordConfirm$$ '
;$$' (
private%% 
bool%% 

_isLoading%% 
;%%  
public,, 
RegisterViewModel,,  
(,,  !
ViewModelUiServices-- 

uiServices--  *
,--* +$
IAccountManagementClient.. $#
accountManagementClient..% <
)..< =
{// 	
if00 
(00 

uiServices00 
==00 
null00 "
)00" #
{11 
throw22 
new22 !
ArgumentNullException22 /
(22/ 0
nameof220 6
(226 7

uiServices227 A
)22A B
)22B C
;22C D
}33 
_navigationService55 
=55  

uiServices55! +
.55+ ,
NavigationService55, =
;55= >
_dialogService66 
=66 

uiServices66 '
.66' (
DialogService66( 5
;665 6
_logger77 
=77 

uiServices77  
.77  !
Logger77! '
;77' ($
_accountManagementClient88 $
=88% &#
accountManagementClient88' >
??88? A
throw88B G
new88H K!
ArgumentNullException88L a
(88a b
nameof88b h
(88h i$
accountManagementClient	88i Ä
)
88Ä Å
)
88Å Ç
;
88Ç É$
_accountManagementClient:: $
.::$ %#
ConnectionErrorOccurred::% <
+=::= ?%
OnConnectionErrorOccurred::@ Y
;::Y Z
BackCommand<< 
=<< 
new<< 
RelayCommand<< *
(<<* +
ExecuteBack<<+ 6
)<<6 7
;<<7 8
SubmitCommand== 
=== 
new== 
AsyncRelayCommand==  1
(==1 2
ExecuteSubmitAsync==2 D
,==D E
CanExecuteSubmit==F V
)==V W
;==W X
}>> 	
publicCC 
stringCC 
EmailCC 
{DD 	
getEE 
=>EE 
_emailEE 
;EE 
setFF 
=>FF 
SetPropertyFF 
(FF 
refFF "
_emailFF# )
,FF) *
valueFF+ 0
)FF0 1
;FF1 2
}GG 	
publicLL 
stringLL 
UsernameLL 
{MM 	
getNN 
=>NN 
	_usernameNN 
;NN 
setOO 
=>OO 
SetPropertyOO 
(OO 
refOO "
	_usernameOO# ,
,OO, -
valueOO. 3
)OO3 4
;OO4 5
}PP 	
publicUU 
stringUU 
PasswordUU 
{VV 	
getWW 
=>WW 
	_passwordWW 
;WW 
setXX 
=>XX 
SetPropertyXX 
(XX 
refXX "
	_passwordXX# ,
,XX, -
valueXX. 3
)XX3 4
;XX4 5
}YY 	
public^^ 
string^^ 
PasswordConfirm^^ %
{__ 	
get`` 
=>`` 
_passwordConfirm`` #
;``# $
setaa 
=>aa 
SetPropertyaa 
(aa 
refaa "
_passwordConfirmaa# 3
,aa3 4
valueaa5 :
)aa: ;
;aa; <
}bb 	
publicgg 
boolgg 
	IsLoadinggg 
{hh 	
getii 
=>ii 

_isLoadingii 
;ii 
setjj 
{kk 
ifll 
(ll 
SetPropertyll 
(ll  
refll  #

_isLoadingll$ .
,ll. /
valuell0 5
)ll5 6
)ll6 7
{mm 
CommandManagernn "
.nn" #&
InvalidateRequerySuggestednn# =
(nn= >
)nn> ?
;nn? @
}oo 
}pp 
}qq 	
publicvv 
ICommandvv 
BackCommandvv #
{vv$ %
getvv& )
;vv) *
}vv+ ,
public{{ 
ICommand{{ 
SubmitCommand{{ %
{{{& '
get{{( +
;{{+ ,
}{{- .
private}} 
bool}} 
CanExecuteSubmit}} %
(}}% &
)}}& '
{~~ 	
return 
! 
	IsLoading 
; 
}
ÄÄ 	
private
ÇÇ 
void
ÇÇ 
ExecuteBack
ÇÇ  
(
ÇÇ  !
)
ÇÇ! "
{
ÉÉ 	 
_navigationService
ÑÑ 
.
ÑÑ 
GoBack
ÑÑ %
(
ÑÑ% &
)
ÑÑ& '
;
ÑÑ' (
}
ÖÖ 	
private
áá 
async
áá 
Task
áá  
ExecuteSubmitAsync
áá -
(
áá- .
)
áá. /
{
àà 	
string
ââ 
email
ââ 
=
ââ 
Email
ââ  
?
ââ  !
.
ââ! "
Trim
ââ" &
(
ââ& '
)
ââ' (
??
ââ) +
string
ââ, 2
.
ââ2 3
Empty
ââ3 8
;
ââ8 9
string
ää 
username
ää 
=
ää 
Username
ää &
?
ää& '
.
ää' (
Trim
ää( ,
(
ää, -
)
ää- .
??
ää/ 1
string
ää2 8
.
ää8 9
Empty
ää9 >
;
ää> ?
string
ãã 
password
ãã 
=
ãã 
Password
ãã &
??
ãã' )
string
ãã* 0
.
ãã0 1
Empty
ãã1 6
;
ãã6 7
string
åå 
passwordConfirm
åå "
=
åå# $
PasswordConfirm
åå% 4
??
åå5 7
string
åå8 >
.
åå> ?
Empty
åå? D
;
ååD E
if
éé 
(
éé %
IsRegistrationDataValid
éé '
(
éé' (
email
éé( -
,
éé- .
username
éé/ 7
,
éé7 8
password
éé9 A
,
ééA B
passwordConfirm
ééC R
)
ééR S
)
ééS T
{
èè 
	IsLoading
êê 
=
êê 
true
êê  
;
êê  !
try
íí 
{
ìì 
string
îî 
passwordHash
îî '
=
îî( )
PasswordHasher
îî* 8
.
îî8 9
ComputeSha256Hash
îî9 J
(
îîJ K
password
îîK S
)
îîS T
;
îîT U'
AccountRegistrationResult
ïï -
result
ïï. 4
=
ïï5 6
await
ïï7 <&
_accountManagementClient
ïï= U
.
ïïU V
RegisterUserAsync
ïïV g
(
ïïg h
username
ïïh p
,
ïïp q
email
ññ 
,
ññ 
passwordHash
ññ +
)
ññ+ ,
;
ññ, -
if
òò 
(
òò 
result
òò 
!=
òò !
null
òò" &
)
òò& '
{
ôô 
if
öö 
(
öö 
result
öö "
.
öö" #
	IsSuccess
öö# ,
)
öö, -
{
õõ 
_dialogService
úú *
.
úú* +
ShowInformation
úú+ :
(
úú: ;
MessageCode
úú; F
.
úúF G
RegisterSuccess
úúG V
)
úúV W
;
úúW X 
_navigationService
ùù .
.
ùù. /

NavigateTo
ùù/ 9
(
ùù9 :
ViewId
ùù: @
.
ùù@ A
	LoginPage
ùùA J
)
ùùJ K
;
ùùK L
}
ûû 
else
üü 
{
†† '
HandleRegistrationFailure
°° 5
(
°°5 6
result
°°6 <
.
°°< =
	ErrorCode
°°= F
)
°°F G
;
°°G H
}
¢¢ 
}
££ 
}
§§ 
finally
•• 
{
¶¶ 
	IsLoading
ßß 
=
ßß 
false
ßß  %
;
ßß% &
}
®® 
}
©© 
}
™™ 	
private
¨¨ 
void
¨¨ '
HandleRegistrationFailure
¨¨ .
(
¨¨. /
int
¨¨/ 2
	errorCode
¨¨3 <
)
¨¨< =
{
≠≠ 	
_logger
ÆÆ 
.
ÆÆ 
Warning
ÆÆ 
(
ÆÆ %
LogRegistrationRejected
ÆÆ 3
,
ÆÆ3 4
	errorCode
ÆÆ5 >
)
ÆÆ> ?
;
ÆÆ? @
switch
∞∞ 
(
∞∞ 
	errorCode
∞∞ 
)
∞∞ 
{
±± 
case
≤≤ 
MessageCode
≤≤  
.
≤≤  !,
RegisterEmailAlreadyRegistered
≤≤! ?
:
≤≤? @
case
≥≥ 
MessageCode
≥≥  
.
≥≥  !/
!RegisterUsernameAlreadyRegistered
≥≥! B
:
≥≥B C
case
¥¥ 
MessageCode
¥¥  
.
¥¥  !-
RegisterEmailPermanentlyBlocked
¥¥! @
:
¥¥@ A
_dialogService
µµ "
.
µµ" #
ShowWarning
µµ# .
(
µµ. /
	errorCode
µµ/ 8
)
µµ8 9
;
µµ9 :
break
∂∂ 
;
∂∂ 
case
∑∑ 
MessageCode
∑∑  
.
∑∑  !'
AccountStorageUnavailable
∑∑! :
:
∑∑: ;
_dialogService
∏∏ "
.
∏∏" #
	ShowError
∏∏# ,
(
∏∏, -
MessageCode
∏∏- 8
.
∏∏8 9$
ChatStorageUnavailable
∏∏9 O
)
∏∏O P
;
∏∏P Q
break
ππ 
;
ππ 
default
∫∫ 
:
∫∫ 
_dialogService
ªª "
.
ªª" #
	ShowError
ªª# ,
(
ªª, -
MessageCode
ªª- 8
.
ªª8 9
UnexpectedError
ªª9 H
)
ªªH I
;
ªªI J
break
ºº 
;
ºº 
}
ΩΩ 
}
ææ 	
private
¿¿ 
void
¿¿ '
OnConnectionErrorOccurred
¿¿ .
(
¿¿. /%
AuthenticationErrorType
¿¿/ F
	errorType
¿¿G P
)
¿¿P Q
{
¡¡ 	
_logger
¬¬ 
.
¬¬ 
Error
¬¬ 
(
¬¬ ,
LogRegistrationConnectionError
¬¬ 8
,
¬¬8 9
	errorType
¬¬: C
)
¬¬C D
;
¬¬D E
switch
ƒƒ 
(
ƒƒ 
	errorType
ƒƒ 
)
ƒƒ 
{
≈≈ 
case
∆∆ %
AuthenticationErrorType
∆∆ ,
.
∆∆, -
ConnectionFailed
∆∆- =
:
∆∆= >
_dialogService
«« "
.
««" #
	ShowError
««# ,
(
««, -
MessageCode
««- 8
.
««8 9
ConnectionFailed
««9 I
)
««I J
;
««J K
break
»» 
;
»» 
case
   %
AuthenticationErrorType
   ,
.
  , -
Timeout
  - 4
:
  4 5
_dialogService
ÀÀ "
.
ÀÀ" #
	ShowError
ÀÀ# ,
(
ÀÀ, -
MessageCode
ÀÀ- 8
.
ÀÀ8 9
RequestTimeout
ÀÀ9 G
)
ÀÀG H
;
ÀÀH I
break
ÃÃ 
;
ÃÃ 
case
ŒŒ %
AuthenticationErrorType
ŒŒ ,
.
ŒŒ, - 
CommunicationError
ŒŒ- ?
:
ŒŒ? @
default
œœ 
:
œœ 
_dialogService
–– "
.
––" #
	ShowError
––# ,
(
––, -
MessageCode
––- 8
.
––8 9 
CommunicationError
––9 K
)
––K L
;
––L M
break
—— 
;
—— 
}
““ 
}
”” 	
private
’’ 
bool
’’ %
IsRegistrationDataValid
’’ ,
(
’’, -
string
’’- 3
email
’’4 9
,
’’9 :
string
’’; A
username
’’B J
,
’’J K
string
’’L R
password
’’S [
,
’’[ \
string
’’] c
passwordConfirm
’’d s
)
’’s t
{
÷÷ 	
bool
◊◊ 
isValid
◊◊ 
=
◊◊ 
false
◊◊  
;
◊◊  !
if
ŸŸ 
(
ŸŸ 
string
ŸŸ 
.
ŸŸ  
IsNullOrWhiteSpace
ŸŸ )
(
ŸŸ) *
email
ŸŸ* /
)
ŸŸ/ 0
)
ŸŸ0 1
{
⁄⁄ 
_dialogService
€€ 
.
€€ 
ShowWarning
€€ *
(
€€* +
MessageCode
€€+ 6
.
€€6 7 
RegisterEmptyEmail
€€7 I
)
€€I J
;
€€J K
}
‹‹ 
else
›› 
if
›› 
(
›› 
string
›› 
.
››  
IsNullOrWhiteSpace
›› .
(
››. /
username
››/ 7
)
››7 8
)
››8 9
{
ﬁﬁ 
_dialogService
ﬂﬂ 
.
ﬂﬂ 
ShowWarning
ﬂﬂ *
(
ﬂﬂ* +
MessageCode
ﬂﬂ+ 6
.
ﬂﬂ6 7#
RegisterEmptyUsername
ﬂﬂ7 L
)
ﬂﬂL M
;
ﬂﬂM N
}
‡‡ 
else
·· 
if
·· 
(
·· 
string
·· 
.
·· 
IsNullOrEmpty
·· )
(
··) *
password
··* 2
)
··2 3
)
··3 4
{
‚‚ 
_dialogService
„„ 
.
„„ 
ShowWarning
„„ *
(
„„* +
MessageCode
„„+ 6
.
„„6 7#
RegisterEmptyPassword
„„7 L
)
„„L M
;
„„M N
}
‰‰ 
else
ÂÂ 
if
ÂÂ 
(
ÂÂ 
string
ÂÂ 
.
ÂÂ 
IsNullOrEmpty
ÂÂ )
(
ÂÂ) *
passwordConfirm
ÂÂ* 9
)
ÂÂ9 :
)
ÂÂ: ;
{
ÊÊ 
_dialogService
ÁÁ 
.
ÁÁ 
ShowWarning
ÁÁ *
(
ÁÁ* +
MessageCode
ÁÁ+ 6
.
ÁÁ6 7/
!RegisterEmptyPasswordConfirmation
ÁÁ7 X
)
ÁÁX Y
;
ÁÁY Z
}
ËË 
else
ÈÈ 
if
ÈÈ 
(
ÈÈ 
!
ÈÈ  
IsValidEmailFormat
ÈÈ (
(
ÈÈ( )
email
ÈÈ) .
)
ÈÈ. /
)
ÈÈ/ 0
{
ÍÍ 
_dialogService
ÎÎ 
.
ÎÎ 
ShowWarning
ÎÎ *
(
ÎÎ* +
MessageCode
ÎÎ+ 6
.
ÎÎ6 7"
RegisterInvalidEmail
ÎÎ7 K
)
ÎÎK L
;
ÎÎL M
}
ÏÏ 
else
ÌÌ 
if
ÌÌ 
(
ÌÌ 
!
ÌÌ %
IsPasswordComplexityMet
ÌÌ -
(
ÌÌ- .
password
ÌÌ. 6
)
ÌÌ6 7
)
ÌÌ7 8
{
ÓÓ 
}
 
else
ÒÒ 
if
ÒÒ 
(
ÒÒ 
!
ÒÒ 
password
ÒÒ 
.
ÒÒ 
Equals
ÒÒ %
(
ÒÒ% &
passwordConfirm
ÒÒ& 5
,
ÒÒ5 6
StringComparison
ÒÒ7 G
.
ÒÒG H
Ordinal
ÒÒH O
)
ÒÒO P
)
ÒÒP Q
{
ÚÚ 
_dialogService
ÛÛ 
.
ÛÛ 
ShowWarning
ÛÛ *
(
ÛÛ* +
MessageCode
ÛÛ+ 6
.
ÛÛ6 7&
RegisterPasswordMismatch
ÛÛ7 O
)
ÛÛO P
;
ÛÛP Q
}
ÙÙ 
else
ıı 
{
ˆˆ 
isValid
˜˜ 
=
˜˜ 
true
˜˜ 
;
˜˜ 
}
¯¯ 
return
˙˙ 
isValid
˙˙ 
;
˙˙ 
}
˚˚ 	
private
˝˝ 
bool
˝˝  
IsValidEmailFormat
˝˝ '
(
˝˝' (
string
˝˝( .
email
˝˝/ 4
)
˝˝4 5
{
˛˛ 	
bool
ˇˇ 
isEmailValid
ˇˇ 
=
ˇˇ 
false
ˇˇ  %
;
ˇˇ% &
if
ÅÅ 
(
ÅÅ 
!
ÅÅ 
string
ÅÅ 
.
ÅÅ  
IsNullOrWhiteSpace
ÅÅ *
(
ÅÅ* +
email
ÅÅ+ 0
)
ÅÅ0 1
)
ÅÅ1 2
{
ÇÇ 
string
ÉÉ 
sanitizedEmail
ÉÉ %
=
ÉÉ& '
email
ÉÉ( -
.
ÉÉ- .
Trim
ÉÉ. 2
(
ÉÉ2 3
)
ÉÉ3 4
;
ÉÉ4 5
int
ÑÑ 
atIndex
ÑÑ 
=
ÑÑ 
sanitizedEmail
ÑÑ ,
.
ÑÑ, -
IndexOf
ÑÑ- 4
(
ÑÑ4 5
$char
ÑÑ5 8
)
ÑÑ8 9
;
ÑÑ9 :
int
ÖÖ 
dotIndex
ÖÖ 
=
ÖÖ 
sanitizedEmail
ÖÖ -
.
ÖÖ- .
LastIndexOf
ÖÖ. 9
(
ÖÖ9 :
$char
ÖÖ: =
)
ÖÖ= >
;
ÖÖ> ?
isEmailValid
áá 
=
áá 
atIndex
áá &
>
áá' (
$num
áá) *
&&
àà 
dotIndex
àà 
>
àà  !
atIndex
àà" )
+
àà* +
$num
àà, -
&&
ââ 
dotIndex
ââ 
<
ââ  !
sanitizedEmail
ââ" 0
.
ââ0 1
Length
ââ1 7
-
ââ8 9
$num
ââ: ;
&&
ää 
!
ää 
sanitizedEmail
ää &
.
ää& '
Contains
ää' /
(
ää/ 0
$str
ää0 3
)
ää3 4
&&
ãã 
sanitizedEmail
ãã %
.
ãã% &
IndexOf
ãã& -
(
ãã- .
$char
ãã. 1
)
ãã1 2
==
ãã3 5
sanitizedEmail
ãã6 D
.
ããD E
LastIndexOf
ããE P
(
ããP Q
$char
ããQ T
)
ããT U
;
ããU V
}
åå 
return
éé 
isEmailValid
éé 
;
éé  
}
èè 	
private
ëë 
bool
ëë %
IsPasswordComplexityMet
ëë ,
(
ëë, -
string
ëë- 3
password
ëë4 <
)
ëë< =
{
íí 	
bool
ìì 
	isComplex
ìì 
=
ìì 
false
ìì "
;
ìì" #
if
ïï 
(
ïï 
password
ïï 
.
ïï 
Length
ïï 
<
ïï  !#
MinimumPasswordLength
ïï" 7
)
ïï7 8
{
ññ 
_dialogService
óó 
.
óó 
ShowWarning
óó *
(
óó* +
MessageCode
óó+ 6
.
óó6 7(
RegisterPasswordRuleLength
óó7 Q
)
óóQ R
;
óóR S
}
òò 
else
ôô 
if
ôô 
(
ôô 
!
ôô 
Regex
ôô 
.
ôô 
IsMatch
ôô #
(
ôô# $
password
ôô$ ,
,
ôô, -%
SpecialCharacterPattern
ôô. E
)
ôôE F
)
ôôF G
{
öö 
_dialogService
õõ 
.
õõ 
ShowWarning
õõ *
(
õõ* +
MessageCode
õõ+ 6
.
õõ6 7-
RegisterPasswordRuleSpecialChar
õõ7 V
)
õõV W
;
õõW X
}
úú 
else
ùù 
if
ùù 
(
ùù 
!
ùù 
Regex
ùù 
.
ùù 
IsMatch
ùù #
(
ùù# $
password
ùù$ ,
,
ùù, -
NumberPattern
ùù. ;
)
ùù; <
)
ùù< =
{
ûû 
_dialogService
üü 
.
üü 
ShowWarning
üü *
(
üü* +
MessageCode
üü+ 6
.
üü6 7(
RegisterPasswordRuleNumber
üü7 Q
)
üüQ R
;
üüR S
}
†† 
else
°° 
{
¢¢ 
	isComplex
££ 
=
££ 
true
££  
;
££  !
}
§§ 
return
¶¶ 
	isComplex
¶¶ 
;
¶¶ 
}
ßß 	
}
®® 
}©© Î4
vC:\Users\oscar\source\repos\TrickTakingMissions\Client\ViewModel\ViewModels\Authentication\RecoverPasswordViewModel.cs
	namespace 	
	ViewModel
 
. 

ViewModels 
{		 
public 

sealed 
class $
RecoverPasswordViewModel 0
:1 2
ViewModelBase3 @
{ 
private 
const 
string ,
 LogOpenChangePasswordDialogError =
=> ?
$str@ f
;f g
private 
readonly 
INavigationService +
_navigationService, >
;> ?
private 
readonly 
IDialogService '
_dialogService( 6
;6 7
private 
readonly 
ILoggerService '
_logger( /
;/ 0
private 
string 
_email 
; 
private 
string 
_code 
; 
private 
bool 
_isResending !
;! "
public 
event 
Action 
RequestBack '
;' (
public!! 
event!! 
Action!! 
RequestClose!! (
;!!( )
public'' $
RecoverPasswordViewModel'' '
(''' (
ViewModelUiServices''( ;

uiServices''< F
)''F G
:(( 
this(( 
((( 

uiServices(( 
,(( 
string(( %
.((% &
Empty((& +
)((+ ,
{)) 	
}** 	
public11 $
RecoverPasswordViewModel11 '
(11' (
ViewModelUiServices11( ;

uiServices11< F
,11F G
string11H N
email11O T
)11T U
{22 	
if33 
(33 

uiServices33 
==33 
null33 "
)33" #
{44 
throw55 
new55 !
ArgumentNullException55 /
(55/ 0
nameof550 6
(556 7

uiServices557 A
)55A B
)55B C
;55C D
}66 
_navigationService88 
=88  

uiServices88! +
.88+ ,
NavigationService88, =
;88= >
_dialogService99 
=99 

uiServices99 '
.99' (
DialogService99( 5
;995 6
_logger:: 
=:: 

uiServices::  
.::  !
Logger::! '
;::' (
_email;; 
=;; 
email;; 
??;; 
string;; $
.;;$ %
Empty;;% *
;;;* +
BackCommand== 
=== 
new== 
RelayCommand== *
(==* +
ExecuteBack==+ 6
)==6 7
;==7 8
CloseCommand>> 
=>> 
new>> 
RelayCommand>> +
(>>+ ,
ExecuteClose>>, 8
)>>8 9
;>>9 :
ResendCodeCommand?? 
=?? 
new??  #
RelayCommand??$ 0
(??0 1
ExecuteResendCode??1 B
,??B C 
CanExecuteResendCode??D X
)??X Y
;??Y Z
ConfirmCodeCommand@@ 
=@@  
new@@! $
RelayCommand@@% 1
(@@1 2
ExecuteConfirmCode@@2 D
)@@D E
;@@E F
}AA 	
publicFF 
boolFF 
IsResendingFF 
{GG 	
getHH 
=>HH 
_isResendingHH 
;HH  
setII 
{JJ 
ifKK 
(KK 
SetPropertyKK 
(KK  
refKK  #
_isResendingKK$ 0
,KK0 1
valueKK2 7
)KK7 8
)KK8 9
{LL 
CommandManagerMM "
.MM" #&
InvalidateRequerySuggestedMM# =
(MM= >
)MM> ?
;MM? @
}NN 
}OO 
}PP 	
publicUU 
stringUU 
EmailUU 
{VV 	
getWW 
=>WW 
_emailWW 
;WW 
setXX 
=>XX 
SetPropertyXX 
(XX 
refXX "
_emailXX# )
,XX) *
valueXX+ 0
)XX0 1
;XX1 2
}YY 	
public^^ 
string^^ 
Code^^ 
{__ 	
get`` 
=>`` 
_code`` 
;`` 
setaa 
=>aa 
SetPropertyaa 
(aa 
refaa "
_codeaa# (
,aa( )
valueaa* /
)aa/ 0
;aa0 1
}bb 	
publicgg 
ICommandgg 
BackCommandgg #
{gg$ %
getgg& )
;gg) *
}gg+ ,
publicll 
ICommandll 
CloseCommandll $
{ll% &
getll' *
;ll* +
}ll, -
publicqq 
ICommandqq 
ResendCodeCommandqq )
{qq* +
getqq, /
;qq/ 0
}qq1 2
publicvv 
ICommandvv 
ConfirmCodeCommandvv *
{vv+ ,
getvv- 0
;vv0 1
}vv2 3
privatexx 
boolxx  
CanExecuteResendCodexx )
(xx) *
)xx* +
{yy 	
returnzz 
!zz 
_isResendingzz  
;zz  !
}{{ 	
private}} 
void}} 
ExecuteBack}}  
(}}  !
)}}! "
{~~ 	
RequestBack 
? 
. 
Invoke 
(  
)  !
;! "
}
ÄÄ 	
private
ÇÇ 
void
ÇÇ 
ExecuteClose
ÇÇ !
(
ÇÇ! "
)
ÇÇ" #
{
ÉÉ 	
RequestClose
ÑÑ 
?
ÑÑ 
.
ÑÑ 
Invoke
ÑÑ  
(
ÑÑ  !
)
ÑÑ! "
;
ÑÑ" #
}
ÖÖ 	
private
áá 
void
áá 
ExecuteResendCode
áá &
(
áá& '
)
áá' (
{
àà 	
}
ää 	
private
åå 
void
åå  
ExecuteConfirmCode
åå '
(
åå' (
)
åå( )
{
çç 	
try
éé 
{
èè  
_navigationService
ëë "
.
ëë" #

ShowDialog
ëë# -
(
ëë- .
ViewId
ëë. 4
.
ëë4 5"
ChangePasswordDialog
ëë5 I
)
ëëI J
;
ëëJ K
}
íí 
catch
ìì 
(
ìì '
InvalidOperationException
ìì ,
ex
ìì- /
)
ìì/ 0
{
îî 
_logger
ïï 
.
ïï 
Error
ïï 
(
ïï 
ex
ïï  
,
ïï  !.
 LogOpenChangePasswordDialogError
ïï" B
)
ïïB C
;
ïïC D
}
ññ 
}
óó 	
}
òò 
}ôô çs
gC:\Users\oscar\source\repos\TrickTakingMissions\Client\ViewModel\ViewModels\Profile\ProfileViewModel.cs
	namespace 	
	ViewModel
 
. 

ViewModels 
{ 
public 

sealed 
class 
ProfileViewModel (
:) *
ViewModelBase+ 8
{ 
private 
const 
string *
LogProfileImageOperationFailed ;
=< =
$str c
;c d
private 
readonly 
INavigationService +
_navigationService, >
;> ?
private 
readonly 
ILoggerService '
_logger( /
;/ 0
private 
readonly 
IProfileImagePicker ,
_profileImagePicker- @
;@ A
private 
readonly 
IProfileImageCache +
_profileImageCache, >
;> ?
private 
bool $
_isProfileImageUploading -
;- .
private  
ProfileImageFeedback $%
_profileImageFeedbackCode% >
;> ?
private !
ProfileImageViewModel %
_profileImage& 3
;3 4
private 
string 
	_username  
;  !
private 
string 
_email 
; 
private   
string    
_accountCreationDate   +
;  + ,
private!! 
int!! 
_missionsCount!! "
;!!" #
private"" 
string"" 

_biography"" !
;""! "
public** 
ProfileViewModel** 
(**  &
ViewModelNavigationLogging**  :
navigationLogging**; L
,**L M
IProfileImagePicker**N a
profileImagePicker**b t
,**t u
IProfileImageCache++ 
profileImageCache++ 0
)++0 1
{,, 	
if-- 
(-- 
navigationLogging-- !
==--" $
null--% )
)--) *
{.. 
throw// 
new// !
ArgumentNullException// /
(/// 0
nameof//0 6
(//6 7
navigationLogging//7 H
)//H I
)//I J
;//J K
}00 
_navigationService22 
=22  
navigationLogging22! 2
.222 3
NavigationService223 D
;22D E
_logger33 
=33 
navigationLogging33 '
.33' (
Logger33( .
;33. /
_profileImagePicker55 
=55  !
profileImagePicker55" 4
??555 7
throw558 =
new55> A!
ArgumentNullException55B W
(55W X
nameof55X ^
(55^ _
profileImagePicker55_ q
)55q r
)55r s
;55s t
_profileImageCache66 
=66  
profileImageCache66! 2
??663 5
throw666 ;
new66< ?!
ArgumentNullException66@ U
(66U V
nameof66V \
(66\ ]
profileImageCache66] n
)66n o
)66o p
;66p q%
ChangeProfilePhotoCommand77 %
=77& '
new77( +
AsyncRelayCommand77, =
(77= >#
ChangeProfilePhotoAsync77> U
,77U V!
CanChangeProfilePhoto77W l
)77l m
;77m n
LoadCurrentProfile88 
(88 
)88  
;88  !
CloseCommand:: 
=:: 
new:: 
RelayCommand:: +
(::+ ,
ExecuteClose::, 8
)::8 9
;::9 :(
PendingProfileEditingCommand== (
===) *
new==+ .
RelayCommand==/ ;
(==; <
(==< =
)=== >
=>==? A
{==B C
}==D E
,==E F
(==G H
)==H I
=>==J L
false==M R
)==R S
;==S T
}>> 	
publicCC 
stringCC 
UsernameCC 
{DD 	
getEE 
=>EE 
	_usernameEE 
;EE 
setFF 
=>FF 
SetPropertyFF 
(FF 
refFF "
	_usernameFF# ,
,FF, -
valueFF. 3
)FF3 4
;FF4 5
}GG 	
publicLL 
stringLL 
EmailLL 
{MM 	
getNN 
=>NN 
_emailNN 
;NN 
setOO 
=>OO 
SetPropertyOO 
(OO 
refOO "
_emailOO# )
,OO) *
valueOO+ 0
)OO0 1
;OO1 2
}PP 	
publicUU 
stringUU 
AccountCreationDateUU )
{VV 	
getWW 
=>WW  
_accountCreationDateWW '
;WW' (
setXX 
=>XX 
SetPropertyXX 
(XX 
refXX " 
_accountCreationDateXX# 7
,XX7 8
valueXX9 >
)XX> ?
;XX? @
}YY 	
public^^ 
int^^ 
MissionsCount^^  
{__ 	
get`` 
=>`` 
_missionsCount`` !
;``! "
setaa 
=>aa 
SetPropertyaa 
(aa 
refaa "
_missionsCountaa# 1
,aa1 2
valueaa3 8
)aa8 9
;aa9 :
}bb 	
publicgg 
stringgg 
	Biographygg 
{hh 	
getii 
=>ii 

_biographyii 
;ii 
setjj 
=>jj 
SetPropertyjj 
(jj 
refjj "

_biographyjj# -
,jj- .
valuejj/ 4
)jj4 5
;jj5 6
}kk 	
publicpp 
ICommandpp 
CloseCommandpp $
{pp% &
getpp' *
;pp* +
}pp, -
publicrr 
ICommandrr (
PendingProfileEditingCommandrr 4
{rr5 6
getrr7 :
;rr: ;
}rr< =
publictt 
ICommandtt %
ChangeProfilePhotoCommandtt 1
{tt2 3
gettt4 7
;tt7 8
}tt9 :
publicvv !
ProfileImageViewModelvv $
ProfileImagevv% 1
{ww 	
getxx 
=>xx 
_profileImagexx  
;xx  !
privateyy 
setyy 
=>yy 
SetPropertyyy &
(yy& '
refyy' *
_profileImageyy+ 8
,yy8 9
valueyy: ?
)yy? @
;yy@ A
}zz 	
public|| 
bool|| #
IsProfileImageUploading|| +
{}} 	
get~~ 
=>~~ $
_isProfileImageUploading~~ +
;~~+ ,
private 
set 
{
ÄÄ 
SetProperty
ÅÅ 
(
ÅÅ 
ref
ÅÅ &
_isProfileImageUploading
ÅÅ  8
,
ÅÅ8 9
value
ÅÅ: ?
)
ÅÅ? @
;
ÅÅ@ A
CommandManager
ÇÇ 
.
ÇÇ (
InvalidateRequerySuggested
ÇÇ 9
(
ÇÇ9 :
)
ÇÇ: ;
;
ÇÇ; <
}
ÉÉ 
}
ÑÑ 	
public
ÜÜ "
ProfileImageFeedback
ÜÜ #&
ProfileImageFeedbackCode
ÜÜ$ <
{
áá 	
get
àà 
=>
àà '
_profileImageFeedbackCode
àà ,
;
àà, -
private
ââ 
set
ââ 
=>
ââ 
SetProperty
ââ &
(
ââ& '
ref
ââ' *'
_profileImageFeedbackCode
ââ+ D
,
ââD E
value
ââF K
)
ââK L
;
ââL M
}
ää 	
public
åå 
void
åå "
ActivateProfileImage
åå (
(
åå( )
)
åå) *
{
çç 	
if
éé 
(
éé 
ProfileImage
éé 
==
éé 
null
éé  $
)
éé$ %
{
èè 
ProfileImage
êê 
=
êê 
new
êê "#
ProfileImageViewModel
êê# 8
(
êê8 9
UserSession
êê9 D
.
êêD E
Current
êêE L
.
êêL M
CurrentUser
êêM X
?
êêX Y
.
êêY Z
IdUser
êêZ `
??
êêa c
$num
êêd e
,
êêe f 
_profileImageCache
ëë &
)
ëë& '
;
ëë' (
}
íí 
}
ìì 	
public
ïï 
void
ïï $
DeactivateProfileImage
ïï *
(
ïï* +
)
ïï+ ,
{
ññ 	
ProfileImage
óó 
?
óó 
.
óó 
Dispose
óó !
(
óó! "
)
óó" #
;
óó# $
ProfileImage
òò 
=
òò 
null
òò 
;
òò  
}
ôô 	
private
õõ 
bool
õõ #
CanChangeProfilePhoto
õõ *
(
õõ* +
)
õõ+ ,
{
úú 	
return
ùù 
!
ùù %
IsProfileImageUploading
ùù +
&&
ùù, .
UserSession
ùù/ :
.
ùù: ;
Current
ùù; B
.
ùùB C
CurrentUser
ùùC N
?
ùùN O
.
ùùO P
IdUser
ùùP V
>
ùùW X
$num
ùùY Z
&&
ùù[ ]
!
ûû 
string
ûû 
.
ûû 
IsNullOrEmpty
ûû %
(
ûû% &
UserSession
ûû& 1
.
ûû1 2
Current
ûû2 9
.
ûû9 :
CurrentUser
ûû: E
.
ûûE F!
AccountSessionToken
ûûF Y
)
ûûY Z
;
ûûZ [
}
üü 	
private
°° 
async
°° 
Task
°° %
ChangeProfilePhotoAsync
°° 2
(
°°2 3
)
°°3 4
{
¢¢ 	%
IsProfileImageUploading
££ #
=
££$ %
true
££& *
;
££* +&
ProfileImageFeedbackCode
§§ $
=
§§% &"
ProfileImageFeedback
§§' ;
.
§§; <
None
§§< @
;
§§@ A
try
•• 
{
¶¶ #
ProfileImageSelection
ßß %#
profileImageSelection
ßß& ;
=
ßß< =
await
ßß> C!
_profileImagePicker
ßßD W
.
ßßW X#
PickProfileImageAsync
ßßX m
(
ßßm n
)
ßßn o
;
ßßo p&
ProfileImageFeedbackCode
®® (
=
®®) *#
profileImageSelection
®®+ @
.
®®@ A
SelectionFeedback
®®A R
;
®®R S
if
©© 
(
©© #
profileImageSelection
©© )
.
©©) *'
SelectedProfileImageBytes
©©* C
!=
©©D F
null
©©G K
&&
©©L N#
profileImageSelection
™™ )
.
™™) *
SelectionFeedback
™™* ;
==
™™< >"
ProfileImageFeedback
™™? S
.
™™S T
None
™™T X
)
™™X Y
{
´´ &
ProfileImageFeedbackCode
¨¨ ,
=
¨¨- ."
ProfileImageFeedback
¨¨/ C
.
¨¨C D
	Uploading
¨¨D M
;
¨¨M N
await
≠≠  
_profileImageCache
≠≠ ,
.
≠≠, -(
ChangeOwnProfileImageAsync
≠≠- G
(
≠≠G H#
profileImageSelection
ÆÆ -
.
ÆÆ- .'
SelectedProfileImageBytes
ÆÆ. G
)
ÆÆG H
;
ÆÆH I&
ProfileImageFeedbackCode
ØØ ,
=
ØØ- ."
ProfileImageFeedback
ØØ/ C
.
ØØC D
UploadSucceeded
ØØD S
;
ØØS T
}
∞∞ 
}
±± 
catch
≤≤ 
(
≤≤ ,
ProfileImageOperationException
≤≤ 1
ex
≤≤2 4
)
≤≤4 5
{
≥≥ "
ProfileImageFeedback
¥¥ $
feedbackCode
¥¥% 1
=
¥¥2 3*
ParseProfileImageFailureCode
¥¥4 P
(
¥¥P Q
ex
¥¥Q S
.
¥¥S T
FailureCode
¥¥T _
)
¥¥_ `
;
¥¥` a
_logger
µµ 
.
µµ 
Warning
µµ 
(
µµ  ,
LogProfileImageOperationFailed
µµ  >
,
µµ> ?
ex
µµ@ B
.
µµB C
FailureCode
µµC N
,
µµN O
feedbackCode
µµP \
)
µµ\ ]
;
µµ] ^&
ProfileImageFeedbackCode
∂∂ (
=
∂∂) *
feedbackCode
∂∂+ 7
;
∂∂7 8
}
∑∑ 
finally
∏∏ 
{
ππ %
IsProfileImageUploading
∫∫ '
=
∫∫( )
false
∫∫* /
;
∫∫/ 0
}
ªª 
}
ºº 	
private
ææ 
static
ææ "
ProfileImageFeedback
ææ +*
ParseProfileImageFailureCode
ææ, H
(
ææH I
string
ææI O
failureCode
ææP [
)
ææ[ \
{
øø 	"
ProfileImageFeedback
¿¿  "
profileImageFeedback
¿¿! 5
;
¿¿5 6
bool
¡¡  
isKnownFailureCode
¡¡ #
=
¡¡$ %
Enum
¡¡& *
.
¡¡* +
TryParse
¡¡+ 3
(
¡¡3 4
failureCode
¡¡4 ?
,
¡¡? @
out
¡¡A D"
profileImageFeedback
¡¡E Y
)
¡¡Y Z
;
¡¡Z [
return
¬¬  
isKnownFailureCode
¬¬ %
?
¬¬& '"
profileImageFeedback
¬¬( <
:
¬¬= >"
ProfileImageFeedback
¬¬? S
.
¬¬S T
OperationFailed
¬¬T c
;
¬¬c d
}
√√ 	
private
≈≈ 
void
≈≈  
LoadCurrentProfile
≈≈ '
(
≈≈' (
)
≈≈( )
{
∆∆ 	
UserSessionData
«« 
currentUser
«« '
=
««( )
UserSession
««* 5
.
««5 6
Current
««6 =
.
««= >
CurrentUser
««> I
;
««I J
if
»» 
(
»» 
currentUser
»» 
!=
»» 
null
»» #
)
»»# $
{
…… 
Username
   
=
   
currentUser
   &
.
  & '
Username
  ' /
;
  / 0
Email
ÀÀ 
=
ÀÀ 
currentUser
ÀÀ #
.
ÀÀ# $
Email
ÀÀ$ )
;
ÀÀ) *
}
ÃÃ 
else
ÕÕ 
{
ŒŒ 
Username
œœ 
=
œœ 
$str
œœ %
;
œœ% &
Email
–– 
=
–– 
string
–– 
.
–– 
Empty
–– $
;
––$ %
}
—— !
AccountCreationDate
”” 
=
””  !
DateTime
””" *
.
””* +
Now
””+ .
.
””. /
ToString
””/ 7
(
””7 8
$str
””8 D
)
””D E
;
””E F
MissionsCount
‘‘ 
=
‘‘ 
$num
‘‘ 
;
‘‘ 
	Biography
’’ 
=
’’ 
string
’’ 
.
’’ 
Empty
’’ $
;
’’$ %
}
÷÷ 	
private
ÿÿ 
void
ÿÿ 
ExecuteClose
ÿÿ !
(
ÿÿ! "
)
ÿÿ" #
{
ŸŸ 	 
_navigationService
⁄⁄ 
.
⁄⁄ 
GoBack
⁄⁄ %
(
⁄⁄% &
)
⁄⁄& '
;
⁄⁄' (
}
€€ 	
}
‹‹ 
}›› Çô
sC:\Users\oscar\source\repos\TrickTakingMissions\Client\ViewModel\ViewModels\Friends\ManageFriendRequestViewModel.cs
	namespace 	
	ViewModel
 
. 

ViewModels 
{ 
public 

sealed 
class (
ManageFriendRequestViewModel 4
:5 6
ViewModelBase7 D
{ 
private 
const 
string "
OperationAcceptRequest 3
=4 5
$str6 >
;> ?
private 
const 
string "
OperationRejectRequest 3
=4 5
$str6 >
;> ?
private 
const 
string -
!LogLoadPendingRequestsUnavailable >
=? @
$str	A î
;
î ï
private 
const 
string /
#LogFriendRequestDecisionUnavailable @
=A B
$str	C ¶
;
¶ ß
private 
const 
string ,
 LogFriendRequestDecisionRejected =
=> ?
$str	@ ´
;
´ ¨
private 
readonly 
IFriendshipSession +
_friendshipSession, >
;> ?
private 
readonly 
IDialogService '
_dialogService( 6
;6 7
private 
readonly 
ILoggerService '
_logger( /
;/ 0
private 
readonly "
SynchronizationContext /
_uiSyncContext0 >
;> ?
private 
bool 
_hasPendingRequests (
;( )
public%% (
ManageFriendRequestViewModel%% +
(%%+ ,
ILoggerService%%, :
logger%%; A
)%%A B
:&& 
this&& 
(&& 
FriendshipSession&& $
.&&$ %
Current&&% ,
,&&, -
null&&. 2
,&&2 3
logger&&4 :
)&&: ;
{'' 	
}(( 	
public// (
ManageFriendRequestViewModel// +
(//+ ,
IFriendshipSession//, >
friendshipSession//? P
,//P Q
ILoggerService//R `
logger//a g
)//g h
:00 
this00 
(00 
friendshipSession00 $
,00$ %
null00& *
,00* +
logger00, 2
)002 3
{11 	
}22 	
public:: (
ManageFriendRequestViewModel:: +
(::+ ,
IFriendshipSession;; 
friendshipSession;; 0
,;;0 1
IDialogService<< 
dialogService<< (
,<<( )
ILoggerService== 
logger== !
)==! "
{>> 	
_friendshipSession?? 
=??  
friendshipSession??! 2
????3 5
throw??6 ;
new??< ?!
ArgumentNullException??@ U
(??U V
nameof??V \
(??\ ]
friendshipSession??] n
)??n o
)??o p
;??p q
_dialogService@@ 
=@@ 
dialogService@@ *
;@@* +
_loggerAA 
=AA 
loggerAA 
??AA 
throwAA  %
newAA& )!
ArgumentNullExceptionAA* ?
(AA? @
nameofAA@ F
(AAF G
loggerAAG M
)AAM N
)AAN O
;AAO P
_uiSyncContextBB 
=BB "
SynchronizationContextBB 3
.BB3 4
CurrentBB4 ;
;BB; <
PendingRequestsDD 
=DD 
newDD ! 
ObservableCollectionDD" 6
<DD6 7&
FriendRequestItemViewModelDD7 Q
>DDQ R
(DDR S
)DDS T
;DDT U
_hasPendingRequestsEE 
=EE  !
falseEE" '
;EE' (
CloseCommandGG 
=GG 
newGG 
RelayCommandGG +
(GG+ ,
ExecuteCloseGG, 8
)GG8 9
;GG9 : 
AcceptRequestCommandHH  
=HH! "
newHH# &
AsyncRelayCommandHH' 8
(HH8 9%
ExecuteAcceptRequestAsyncHH9 R
)HHR S
;HHS T 
RejectRequestCommandII  
=II! "
newII# &
AsyncRelayCommandII' 8
(II8 9%
ExecuteRejectRequestAsyncII9 R
)IIR S
;IIS T
LoadRequestsCommandJJ 
=JJ  !
newJJ" %
AsyncRelayCommandJJ& 7
(JJ7 8$
LoadPendingRequestsAsyncJJ8 P
)JJP Q
;JJQ R
_friendshipSessionLL 
.LL 
ClientLL %
.LL% &!
FriendRequestReceivedLL& ;
+=LL< >)
OnServerFriendRequestReceivedLL? \
;LL\ ]
_MM 
=MM $
LoadPendingRequestsAsyncMM (
(MM( )
)MM) *
;MM* +
}NN 	
publicSS 
eventSS 
ActionSS 
RequestCloseSS (
;SS( )
publicXX  
ObservableCollectionXX #
<XX# $&
FriendRequestItemViewModelXX$ >
>XX> ?
PendingRequestsXX@ O
{XXP Q
getXXR U
;XXU V
}XXW X
public]] 
bool]] 
HasPendingRequests]] &
{^^ 	
get__ 
=>__ 
_hasPendingRequests__ &
;__& '
set`` 
{aa 
ifbb 
(bb 
SetPropertybb 
(bb  
refbb  #
_hasPendingRequestsbb$ 7
,bb7 8
valuebb9 >
)bb> ?
)bb? @
{cc 
OnPropertyChangeddd %
(dd% &
nameofdd& ,
(dd, - 
HasNoPendingRequestsdd- A
)ddA B
)ddB C
;ddC D
}ee 
}ff 
}gg 	
publicll 
boolll  
HasNoPendingRequestsll (
=>ll) +
!ll, -
_hasPendingRequestsll- @
;ll@ A
publicqq 
ICommandqq 
CloseCommandqq $
{qq% &
getqq' *
;qq* +
}qq, -
publicvv 
ICommandvv  
AcceptRequestCommandvv ,
{vv- .
getvv/ 2
;vv2 3
}vv4 5
public{{ 
ICommand{{  
RejectRequestCommand{{ ,
{{{- .
get{{/ 2
;{{2 3
}{{4 5
public
ÄÄ 
ICommand
ÄÄ !
LoadRequestsCommand
ÄÄ +
{
ÄÄ, -
get
ÄÄ. 1
;
ÄÄ1 2
}
ÄÄ3 4
private
ÇÇ 
async
ÇÇ 
Task
ÇÇ &
LoadPendingRequestsAsync
ÇÇ 3
(
ÇÇ3 4
)
ÇÇ4 5
{
ÉÉ 	
int
ÑÑ 
currentUserId
ÑÑ 
=
ÑÑ $
GetAuthenticatedUserId
ÑÑ  6
(
ÑÑ6 7
)
ÑÑ7 8
;
ÑÑ8 9
if
ÜÜ 
(
ÜÜ 
currentUserId
ÜÜ 
>
ÜÜ 
$num
ÜÜ  !
)
ÜÜ! "
{
áá 
IList
àà 
<
àà 
FriendRequest
àà #
>
àà# $ 
requestsFromServer
àà% 7
=
àà8 9
await
ââ  
_friendshipSession
ââ ,
.
ââ, -
RequestClient
ââ- :
.
ââ: ;2
$GetPendingFriendRequestByUserIdAsync
ââ; _
(
ââ_ `
currentUserId
ââ` m
)
ââm n
;
âân o
PendingRequests
ãã 
.
ãã  
Clear
ãã  %
(
ãã% &
)
ãã& '
;
ãã' (
if
çç 
(
çç  
requestsFromServer
çç &
!=
çç' )
null
çç* .
)
çç. /
{
éé 
foreach
èè 
(
èè 
FriendRequest
èè *
request
èè+ 2
in
èè3 5 
requestsFromServer
èè6 H
)
èèH I
{
êê 
if
ëë 
(
ëë 
request
ëë #
!=
ëë$ &
null
ëë' +
)
ëë+ ,
{
íí (
FriendRequestItemViewModel
ìì 6
item
ìì7 ;
=
ìì< =
new
ìì> A(
FriendRequestItemViewModel
ììB \
(
ìì\ ]
request
îî  '
.
îî' (
SenderUserId
îî( 4
,
îî4 5
request
ïï  '
.
ïï' (
SenderUsername
ïï( 6
,
ïï6 7
request
ññ  '
.
ññ' (
ReceiverUserId
ññ( 6
,
ññ6 7
request
óó  '
.
óó' (
ReceiverUsername
óó( 8
,
óó8 9
request
òò  '
.
òò' (
RequestedAt
òò( 3
)
òò3 4
;
òò4 5
PendingRequests
ôô +
.
ôô+ ,
Add
ôô, /
(
ôô/ 0
item
ôô0 4
)
ôô4 5
;
ôô5 6
}
öö 
}
õõ 
}
úú  
HasPendingRequests
ûû "
=
ûû# $
PendingRequests
ûû% 4
.
ûû4 5
Count
ûû5 :
>
ûû; <
$num
ûû= >
;
ûû> ?
}
üü 
else
†† 
{
°° 
_logger
¢¢ 
.
¢¢ 
Warning
¢¢ 
(
¢¢  /
!LogLoadPendingRequestsUnavailable
¢¢  A
,
¢¢A B
currentUserId
¢¢C P
)
¢¢P Q
;
¢¢Q R
PendingRequests
££ 
.
££  
Clear
££  %
(
££% &
)
££& '
;
££' ( 
HasPendingRequests
§§ "
=
§§# $
false
§§% *
;
§§* +
}
•• 
}
¶¶ 	
private
®® 
void
®® +
OnServerFriendRequestReceived
®® 2
(
®®2 3
Model
®®3 8
.
®®8 9 
IFriendShipService
®®9 K
.
®®K L
FriendRequest
®®L Y
incomingRequest
®®Z i
)
®®i j
{
©© 	
if
™™ 
(
™™ 
incomingRequest
™™ 
!=
™™  "
null
™™# '
)
™™' (
{
´´ (
FriendRequestItemViewModel
¨¨ *
item
¨¨+ /
=
¨¨0 1
new
¨¨2 5(
FriendRequestItemViewModel
¨¨6 P
(
¨¨P Q
incomingRequest
≠≠ #
.
≠≠# $
SenderUserId
≠≠$ 0
,
≠≠0 1
incomingRequest
ÆÆ #
.
ÆÆ# $
SenderUsername
ÆÆ$ 2
,
ÆÆ2 3
incomingRequest
ØØ #
.
ØØ# $
ReceiverUserId
ØØ$ 2
,
ØØ2 3
incomingRequest
∞∞ #
.
∞∞# $
ReceiverUsername
∞∞$ 4
,
∞∞4 5
incomingRequest
±± #
.
±±# $
RequestedAt
±±$ /
)
±±/ 0
;
±±0 1
if
≥≥ 
(
≥≥ 
_uiSyncContext
≥≥ "
!=
≥≥# %
null
≥≥& *
&&
≥≥+ -$
SynchronizationContext
≥≥. D
.
≥≥D E
Current
≥≥E L
!=
≥≥M O
_uiSyncContext
≥≥P ^
)
≥≥^ _
{
¥¥ 
_uiSyncContext
µµ "
.
µµ" #
Post
µµ# '
(
µµ' (*
AddIncomingRequestOnUiThread
µµ( D
,
µµD E
item
µµF J
)
µµJ K
;
µµK L
}
∂∂ 
else
∑∑ 
{
∏∏  
AddIncomingRequest
ππ &
(
ππ& '
item
ππ' +
)
ππ+ ,
;
ππ, -
}
∫∫ 
}
ªª 
}
ºº 	
private
ææ 
void
ææ *
AddIncomingRequestOnUiThread
ææ 1
(
ææ1 2
object
ææ2 8
state
ææ9 >
)
ææ> ?
{
øø 	
if
¿¿ 
(
¿¿ 
state
¿¿ 
is
¿¿ (
FriendRequestItemViewModel
¿¿ 3
item
¿¿4 8
)
¿¿8 9
{
¡¡  
AddIncomingRequest
¬¬ "
(
¬¬" #
item
¬¬# '
)
¬¬' (
;
¬¬( )
}
√√ 
}
ƒƒ 	
private
∆∆ 
void
∆∆  
AddIncomingRequest
∆∆ '
(
∆∆' ((
FriendRequestItemViewModel
∆∆( B
item
∆∆C G
)
∆∆G H
{
«« 	
bool
»» 
alreadyExists
»» 
=
»»  
false
»»! &
;
»»& '
foreach
   
(
   (
FriendRequestItemViewModel
   /
existing
  0 8
in
  9 ;
PendingRequests
  < K
)
  K L
{
ÀÀ 
if
ÃÃ 
(
ÃÃ 
existing
ÃÃ 
.
ÃÃ 
SenderUserId
ÃÃ )
==
ÃÃ* ,
item
ÃÃ- 1
.
ÃÃ1 2
SenderUserId
ÃÃ2 >
)
ÃÃ> ?
{
ÕÕ 
alreadyExists
ŒŒ !
=
ŒŒ" #
true
ŒŒ$ (
;
ŒŒ( )
}
œœ 
}
–– 
if
““ 
(
““ 
!
““ 
alreadyExists
““ 
)
““ 
{
”” 
PendingRequests
‘‘ 
.
‘‘  
Add
‘‘  #
(
‘‘# $
item
‘‘$ (
)
‘‘( )
;
‘‘) * 
HasPendingRequests
’’ "
=
’’# $
PendingRequests
’’% 4
.
’’4 5
Count
’’5 :
>
’’; <
$num
’’= >
;
’’> ?
}
÷÷ 
}
◊◊ 	
private
ŸŸ 
void
ŸŸ 
ExecuteClose
ŸŸ !
(
ŸŸ! "
)
ŸŸ" #
{
⁄⁄ 	 
_friendshipSession
€€ 
.
€€ 
Client
€€ %
.
€€% &#
FriendRequestReceived
€€& ;
-=
€€< >+
OnServerFriendRequestReceived
€€? \
;
€€\ ]
RequestClose
‹‹ 
?
‹‹ 
.
‹‹ 
Invoke
‹‹  
(
‹‹  !
)
‹‹! "
;
‹‹" #
}
›› 	
private
ﬂﬂ 
async
ﬂﬂ 
Task
ﬂﬂ '
ExecuteAcceptRequestAsync
ﬂﬂ 4
(
ﬂﬂ4 5
object
ﬂﬂ5 ;
	parameter
ﬂﬂ< E
)
ﬂﬂE F
{
‡‡ 	(
FriendRequestItemViewModel
·· &
requestItem
··' 2
=
··3 4
	parameter
··5 >
as
··? A(
FriendRequestItemViewModel
··B \
;
··\ ]
int
‚‚ 
currentUserId
‚‚ 
=
‚‚ $
GetAuthenticatedUserId
‚‚  6
(
‚‚6 7
)
‚‚7 8
;
‚‚8 9
if
‰‰ 
(
‰‰ 
requestItem
‰‰ 
!=
‰‰ 
null
‰‰ #
&&
‰‰$ &
currentUserId
‰‰' 4
>
‰‰5 6
$num
‰‰7 8
)
‰‰8 9
{
ÂÂ 
OperationResult
ÊÊ 
result
ÊÊ  &
=
ÊÊ' (
await
ÊÊ) . 
_friendshipSession
ÊÊ/ A
.
ÊÊA B
RequestClient
ÊÊB O
.
ÊÊO P&
AcceptFriendRequestAsync
ÊÊP h
(
ÊÊh i
currentUserId
ÁÁ !
,
ÁÁ! "
requestItem
ËË 
.
ËË  
SenderUserId
ËË  ,
)
ËË, -
;
ËË- .
if
ÍÍ 
(
ÍÍ +
TryApplyRequestDecisionResult
ÍÍ 1
(
ÍÍ1 2
result
ÍÍ2 8
,
ÍÍ8 9
requestItem
ÍÍ: E
,
ÍÍE F$
OperationAcceptRequest
ÍÍG ]
)
ÍÍ] ^
)
ÍÍ^ _
{
ÎÎ  
_friendshipSession
ÏÏ &
.
ÏÏ& '&
NotifyFriendsListChanged
ÏÏ' ?
(
ÏÏ? @
)
ÏÏ@ A
;
ÏÏA B
}
ÌÌ 
}
ÓÓ 
}
ÔÔ 	
private
ÒÒ 
async
ÒÒ 
Task
ÒÒ '
ExecuteRejectRequestAsync
ÒÒ 4
(
ÒÒ4 5
object
ÒÒ5 ;
	parameter
ÒÒ< E
)
ÒÒE F
{
ÚÚ 	(
FriendRequestItemViewModel
ÛÛ &
requestItem
ÛÛ' 2
=
ÛÛ3 4
	parameter
ÛÛ5 >
as
ÛÛ? A(
FriendRequestItemViewModel
ÛÛB \
;
ÛÛ\ ]
int
ÙÙ 
currentUserId
ÙÙ 
=
ÙÙ $
GetAuthenticatedUserId
ÙÙ  6
(
ÙÙ6 7
)
ÙÙ7 8
;
ÙÙ8 9
if
ˆˆ 
(
ˆˆ 
requestItem
ˆˆ 
!=
ˆˆ 
null
ˆˆ #
&&
ˆˆ$ &
currentUserId
ˆˆ' 4
>
ˆˆ5 6
$num
ˆˆ7 8
)
ˆˆ8 9
{
˜˜ 
OperationResult
¯¯ 
result
¯¯  &
=
¯¯' (
await
¯¯) . 
_friendshipSession
¯¯/ A
.
¯¯A B
RequestClient
¯¯B O
.
¯¯O P&
RejectFriendRequestAsync
¯¯P h
(
¯¯h i
currentUserId
¯¯i v
,
¯¯v w
requestItem
˘˘ 
.
˘˘  
SenderUserId
˘˘  ,
)
˘˘, -
;
˘˘- .+
TryApplyRequestDecisionResult
˚˚ -
(
˚˚- .
result
˚˚. 4
,
˚˚4 5
requestItem
˚˚6 A
,
˚˚A B$
OperationRejectRequest
˚˚C Y
)
˚˚Y Z
;
˚˚Z [
}
¸¸ 
}
˝˝ 	
private
ˇˇ 
bool
ˇˇ +
TryApplyRequestDecisionResult
ˇˇ 2
(
ˇˇ2 3
OperationResult
ÄÄ 
result
ÄÄ "
,
ÄÄ" #(
FriendRequestItemViewModel
ÅÅ &
requestItem
ÅÅ' 2
,
ÅÅ2 3
string
ÇÇ 
operationName
ÇÇ  
)
ÇÇ  !
{
ÉÉ 	
if
ÑÑ 
(
ÑÑ 
result
ÑÑ 
==
ÑÑ 
null
ÑÑ 
)
ÑÑ 
{
ÖÖ 
_logger
ÜÜ 
.
ÜÜ 
Error
ÜÜ 
(
ÜÜ 1
#LogFriendRequestDecisionUnavailable
ÜÜ A
,
ÜÜA B
operationName
ÜÜC P
,
ÜÜP Q
requestItem
ÜÜR ]
.
ÜÜ] ^
SenderUserId
ÜÜ^ j
)
ÜÜj k
;
ÜÜk l
_dialogService
áá 
?
áá 
.
áá  
	ShowError
áá  )
(
áá) *
MessageCode
áá* 5
.
áá5 6
ConnectionFailed
áá6 F
)
ááF G
;
ááG H
return
àà 
false
àà 
;
àà 
}
ââ 
if
ãã 
(
ãã 
result
ãã 
.
ãã 
	IsSuccess
ãã  
)
ãã  !
{
åå 
PendingRequests
çç 
.
çç  
Remove
çç  &
(
çç& '
requestItem
çç' 2
)
çç2 3
;
çç3 4 
HasPendingRequests
éé "
=
éé# $
PendingRequests
éé% 4
.
éé4 5
Count
éé5 :
>
éé; <
$num
éé= >
;
éé> ?
return
èè 
true
èè 
;
èè 
}
êê 
_logger
íí 
.
íí 
Warning
íí 
(
íí .
 LogFriendRequestDecisionRejected
íí <
,
íí< =
operationName
íí> K
,
ííK L
requestItem
ííM X
.
ííX Y
SenderUserId
ííY e
,
ííe f
result
ííg m
.
íím n
	ErrorCode
íín w
)
ííw x
;
ííx y
_dialogService
ìì 
?
ìì 
.
ìì 
ShowWarning
ìì '
(
ìì' (
MessageCode
ìì( 3
.
ìì3 4
UnexpectedError
ìì4 C
)
ììC D
;
ììD E
return
îî 
false
îî 
;
îî 
}
ïï 	
private
óó 
static
óó 
int
óó $
GetAuthenticatedUserId
óó 1
(
óó1 2
)
óó2 3
{
òò 	
int
ôô 
userId
ôô 
=
ôô 
$num
ôô 
;
ôô 
if
õõ 
(
õõ 
UserSession
õõ 
.
õõ 
Current
õõ #
.
õõ# $
IsAuthenticated
õõ$ 3
&&
õõ4 6
UserSession
õõ7 B
.
õõB C
Current
õõC J
.
õõJ K
CurrentUser
õõK V
!=
õõW Y
null
õõZ ^
)
õõ^ _
{
úú 
userId
ùù 
=
ùù 
UserSession
ùù $
.
ùù$ %
Current
ùù% ,
.
ùù, -
CurrentUser
ùù- 8
.
ùù8 9
IdUser
ùù9 ?
;
ùù? @
}
ûû 
return
†† 
userId
†† 
;
†† 
}
°° 	
}
¢¢ 
}££ £•
lC:\Users\oscar\source\repos\TrickTakingMissions\Client\ViewModel\ViewModels\Authentication\LoginViewModel.cs
	namespace 	
	ViewModel
 
. 

ViewModels 
{ 
public 

sealed 
class 
LoginViewModel &
:' (
ViewModelBase) 6
,6 7
IUserLoginCallback8 J
,J K
IDisposableL W
{ 
private 
const 
string 
LogLoginSucceeded .
=/ 0
$str1 W
;W X
private 
const 
string #
LogLoginRejectedWithBan 4
=5 6
$str7 n
;n o
private 
const 
string 
LogLoginRejected -
=. /
$str0 `
;` a
private 
const 
string $
LogLoginConnectionFailed 5
=6 7
$str8 U
;U V
private 
const 
string 
LogLoginTimedOut -
=. /
$str0 J
;J K
private 
const 
string &
LogLoginCommunicationError 7
=8 9
$str: V
;V W
private 
const 
string (
LogForgotPasswordDialogError 9
=: ;
$str< f
;f g
private 
readonly 
INavigationService +
_navigationService, >
;> ?
private   
readonly   
IDialogService   '
_dialogService  ( 6
;  6 7
private!! 
readonly!! 
ILoggerService!! '
_logger!!( /
;!!/ 0
private"" 
readonly"" $
IChatModerationPresenter"" 1$
_chatModerationPresenter""2 J
;""J K
private## 
readonly## "
SynchronizationContext## /(
_loginSynchronizationContext##0 L
;##L M
private$$ 
readonly$$ 
	Stopwatch$$ ""
_accountBanElapsedTime$$# 9
=$$: ;
new$$< ?
	Stopwatch$$@ I
($$I J
)$$J K
;$$K L
private%% 
Timer%% %
_accountBanCountdownTimer%% /
;%%/ 0
private&&  
ChatAccountBanNotice&& $
_accountBanNotice&&% 6
;&&6 7
private'' 
string'' #
_accountBanFeedbackText'' .
;''. /
private(( 
UserLoginClient(( 
_loginServiceClient((  3
;((3 4
private)) 
bool)) 
_isLoginDisposed)) %
;))% &
private++ 
string++ 
_email++ 
;++ 
private,, 
string,, 
	_password,,  
;,,  !
private-- 
bool-- 

_isLoading-- 
;--  
public44 
LoginViewModel44 
(44 
ViewModelUiServices44 1

uiServices442 <
,44< =$
IChatModerationPresenter44> V#
chatModerationPresenter44W n
)44n o
{55 	
if66 
(66 

uiServices66 
==66 
null66 "
)66" #
{77 
throw88 
new88 !
ArgumentNullException88 /
(88/ 0
nameof880 6
(886 7

uiServices887 A
)88A B
)88B C
;88C D
}99 
_navigationService;; 
=;;  

uiServices;;! +
.;;+ ,
NavigationService;;, =
;;;= >
_dialogService<< 
=<< 

uiServices<< '
.<<' (
DialogService<<( 5
;<<5 6
_logger== 
=== 

uiServices==  
.==  !
Logger==! '
;==' ($
_chatModerationPresenter>> $
=>>% &#
chatModerationPresenter>>' >
;>>> ?(
_loginSynchronizationContext?? (
=??) *"
SynchronizationContext??+ A
.??A B
Current??B I
;??I J
LoginCommandAA 
=AA 
newAA 
RelayCommandAA +
(AA+ ,
ExecuteLoginAA, 8
,AA8 9
CanExecuteLoginAA: I
)AAI J
;AAJ K
BackCommandBB 
=BB 
newBB 
RelayCommandBB *
(BB* +
ExecuteBackBB+ 6
)BB6 7
;BB7 8!
ForgotPasswordCommandCC !
=CC" #
newCC$ '
RelayCommandCC( 4
(CC4 5!
ExecuteForgotPasswordCC5 J
)CCJ K
;CCK L
}DD 	
publicFF 
stringFF "
AccountBanFeedbackTextFF ,
{GG 	
getHH 
=>HH #
_accountBanFeedbackTextHH *
;HH* +
privateII 
setII 
=>II 
SetPropertyII &
(II& '
refII' *#
_accountBanFeedbackTextII+ B
,IIB C
valueIID I
)III J
;IIJ K
}JJ 	
publicOO 
stringOO 
EmailOO 
{PP 	
getQQ 
=>QQ 
_emailQQ 
;QQ 
setRR 
=>RR 
SetPropertyRR 
(RR 
refRR "
_emailRR# )
,RR) *
valueRR+ 0
)RR0 1
;RR1 2
}SS 	
publicXX 
stringXX 
PasswordXX 
{YY 	
getZZ 
=>ZZ 
	_passwordZZ 
;ZZ 
set[[ 
=>[[ 
SetProperty[[ 
([[ 
ref[[ "
	_password[[# ,
,[[, -
value[[. 3
)[[3 4
;[[4 5
}\\ 	
publicaa 
boolaa 
	IsLoadingaa 
{bb 	
getcc 
=>cc 

_isLoadingcc 
;cc 
setdd 
{ee 
ifff 
(ff 
SetPropertyff 
(ff  
refff  #

_isLoadingff$ .
,ff. /
valueff0 5
)ff5 6
)ff6 7
{gg 
CommandManagerhh "
.hh" #&
InvalidateRequerySuggestedhh# =
(hh= >
)hh> ?
;hh? @
}ii 
}jj 
}kk 	
publicpp 
ICommandpp 
LoginCommandpp $
{pp% &
getpp' *
;pp* +
}pp, -
publicuu 
ICommanduu 
BackCommanduu #
{uu$ %
getuu& )
;uu) *
}uu+ ,
publiczz 
ICommandzz !
ForgotPasswordCommandzz -
{zz. /
getzz0 3
;zz3 4
}zz5 6
public
ÇÇ 
void
ÇÇ 
LoginResult
ÇÇ 
(
ÇÇ  
bool
ÇÇ  $
success
ÇÇ% ,
,
ÇÇ, -
string
ÇÇ. 4
message
ÇÇ5 <
,
ÇÇ< =
User
ÇÇ> B
user
ÇÇC G
)
ÇÇG H
{
ÉÉ 	
	IsLoading
ÑÑ 
=
ÑÑ 
false
ÑÑ 
;
ÑÑ 
if
ÜÜ 
(
ÜÜ 
success
ÜÜ 
)
ÜÜ 
{
áá 
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
ââ 
UserSession
ää 
.
ää  
Current
ää  '
.
ää' (
SetUser
ää( /
(
ää/ 0
new
ää0 3
UserSessionData
ää4 C
{
ãã 
IdUser
åå 
=
åå  
user
åå! %
.
åå% &
IdUser
åå& ,
,
åå, -
Username
çç  
=
çç! "
user
çç# '
.
çç' (
Username
çç( 0
,
çç0 1
Email
éé 
=
éé 
user
éé  $
.
éé$ %
Email
éé% *
,
éé* +!
AccountSessionToken
èè +
=
èè, -
user
èè. 2
.
èè2 3!
AccountSessionToken
èè3 F
}
êê 
)
êê 
;
êê 
_logger
ëë 
.
ëë 
Information
ëë '
(
ëë' (
LogLoginSucceeded
ëë( 9
,
ëë9 :
user
ëë; ?
.
ëë? @
IdUser
ëë@ F
)
ëëF G
;
ëëG H
}
íí  
_navigationService
îî "
.
îî" #

NavigateTo
îî# -
(
îî- .
ViewId
îî. 4
.
îî4 5
GameMenu
îî5 =
)
îî= >
;
îî> ?
}
ïï 
else
ññ 
{
óó #
ProcessLoginRejection
òò %
(
òò% &
message
òò& -
,
òò- .
user
òò/ 3
?
òò3 4
.
òò4 5"
ChatAccountBanNotice
òò5 I
)
òòI J
;
òòJ K
}
ôô 
}
öö 	
public
úú 
void
úú 
Dispose
úú 
(
úú 
)
úú 
{
ùù 	
_isLoginDisposed
ûû 
=
ûû 
true
ûû #
;
ûû# $'
_accountBanCountdownTimer
üü %
?
üü% &
.
üü& '
Dispose
üü' .
(
üü. /
)
üü/ 0
;
üü0 1!
_loginServiceClient
†† 
?
††  
.
††  !
Abort
††! &
(
††& '
)
††' (
;
††( )
}
°° 	
private
££ 
void
££ #
ProcessLoginRejection
££ *
(
££* +
string
££+ 1
rejectionReason
££2 A
,
££A B"
ChatAccountBanNotice
££C W
accountBanNotice
££X h
)
££h i
{
§§ 	
if
•• 
(
•• 
accountBanNotice
••  
!=
••! #
null
••$ (
)
••( )
{
¶¶ 
_logger
ßß 
.
ßß 
Warning
ßß 
(
ßß  %
LogLoginRejectedWithBan
ßß  7
,
ßß7 8
accountBanNotice
ßß9 I
.
ßßI J 
ChatAccountBanType
ßßJ \
)
ßß\ ]
;
ßß] ^
_accountBanNotice
®® !
=
®®" #
accountBanNotice
®®$ 4
;
®®4 5$
_accountBanElapsedTime
©© &
.
©©& '
Restart
©©' .
(
©©. /
)
©©/ 0
;
©©0 1'
UpdateAccountBanCountdown
™™ )
(
™™) *
)
™™* +
;
™™+ ,'
_accountBanCountdownTimer
´´ )
?
´´) *
.
´´* +
Dispose
´´+ 2
(
´´2 3
)
´´3 4
;
´´4 5
if
¨¨ 
(
¨¨ 
accountBanNotice
¨¨ $
.
¨¨$ % 
ChatAccountBanType
¨¨% 7
==
¨¨8 : 
ChatAccountBanType
¨¨; M
.
¨¨M N
	Temporary
¨¨N W
)
¨¨W X
{
≠≠ '
_accountBanCountdownTimer
ÆÆ -
=
ÆÆ. /
new
ÆÆ0 3
Timer
ÆÆ4 9
(
ÆÆ9 :'
OnAccountBanCountdownTick
ÆÆ: S
,
ÆÆS T
null
ÆÆU Y
,
ÆÆY Z
TimeSpan
ØØ  
.
ØØ  !
FromSeconds
ØØ! ,
(
ØØ, -
$num
ØØ- .
)
ØØ. /
,
ØØ/ 0
TimeSpan
ØØ1 9
.
ØØ9 :
FromSeconds
ØØ: E
(
ØØE F
$num
ØØF G
)
ØØG H
)
ØØH I
;
ØØI J
}
∞∞ 
}
±± 
else
≤≤ 
{
≥≥ 
int
¥¥ 
loginWarningCode
¥¥ $
=
¥¥% &
MessageCode
¥¥' 2
.
¥¥2 3 
InvalidCredentials
¥¥3 E
;
¥¥E F
if
µµ 
(
µµ 
rejectionReason
µµ #
==
µµ$ &
$str
µµ' ?
)
µµ? @
{
∂∂ 
loginWarningCode
∑∑ $
=
∑∑% &
MessageCode
∑∑' 2
.
∑∑2 3$
ChatStorageUnavailable
∑∑3 I
;
∑∑I J
}
∏∏ 
_logger
∫∫ 
.
∫∫ 
Warning
∫∫ 
(
∫∫  
LogLoginRejected
∫∫  0
,
∫∫0 1
loginWarningCode
∫∫2 B
)
∫∫B C
;
∫∫C D
_dialogService
ªª 
.
ªª 
ShowWarning
ªª *
(
ªª* +
loginWarningCode
ªª+ ;
)
ªª; <
;
ªª< =
}
ºº 
}
ΩΩ 	
private
øø 
void
øø '
OnAccountBanCountdownTick
øø .
(
øø. /
object
øø/ 5!
countdownTimerState
øø6 I
)
øøI J
{
¿¿ 	
if
¡¡ 
(
¡¡ *
_loginSynchronizationContext
¡¡ ,
!=
¡¡- /
null
¡¡0 4
)
¡¡4 5
{
¬¬ *
_loginSynchronizationContext
√√ ,
.
√√, -
Post
√√- 1
(
√√1 2
_
√√2 3
=>
√√4 6'
UpdateAccountBanCountdown
√√7 P
(
√√P Q
)
√√Q R
,
√√R S
null
√√T X
)
√√X Y
;
√√Y Z
}
ƒƒ 
else
≈≈ 
{
∆∆ '
UpdateAccountBanCountdown
«« )
(
««) *
)
««* +
;
««+ ,
}
»» 
}
…… 	
private
ÀÀ 
void
ÀÀ '
UpdateAccountBanCountdown
ÀÀ .
(
ÀÀ. /
)
ÀÀ/ 0
{
ÃÃ 	
if
ÕÕ 
(
ÕÕ 
!
ÕÕ 
_isLoginDisposed
ÕÕ !
&&
ÕÕ" $
_accountBanNotice
ÕÕ% 6
!=
ÕÕ7 9
null
ÕÕ: >
)
ÕÕ> ?
{
ŒŒ $
AccountBanFeedbackText
œœ &
=
œœ' (&
_chatModerationPresenter
œœ) A
.
œœA B
FormatAccountBan
œœB R
(
œœR S
new
œœS V"
ChatAccountBanNotice
œœW k
{
––  
ChatAccountBanType
—— &
=
——' (
_accountBanNotice
——) :
.
——: ; 
ChatAccountBanType
——; M
,
——M N%
ChatAccountBanEndsAtUtc
““ +
=
““, -
_accountBanNotice
““. ?
.
““? @%
ChatAccountBanEndsAtUtc
““@ W
,
““W X
EvaluatedAtUtc
”” "
=
””# $
_accountBanNotice
””% 6
.
””6 7
EvaluatedAtUtc
””7 E
+
””F G$
_accountBanElapsedTime
””H ^
.
””^ _
Elapsed
””_ f
}
‘‘ 
)
‘‘ 
;
‘‘ 
if
’’ 
(
’’ 
_accountBanNotice
’’ %
.
’’% &%
ChatAccountBanEndsAtUtc
’’& =
<=
’’> @
_accountBanNotice
÷÷ %
.
÷÷% &
EvaluatedAtUtc
÷÷& 4
+
÷÷5 6$
_accountBanElapsedTime
÷÷7 M
.
÷÷M N
Elapsed
÷÷N U
)
÷÷U V
{
◊◊ '
_accountBanCountdownTimer
ÿÿ -
?
ÿÿ- .
.
ÿÿ. /
Dispose
ÿÿ/ 6
(
ÿÿ6 7
)
ÿÿ7 8
;
ÿÿ8 9
}
ŸŸ 
}
⁄⁄ 
}
€€ 	
private
›› 
bool
›› 
CanExecuteLogin
›› $
(
››$ %
)
››% &
{
ﬁﬁ 	
return
ﬂﬂ 
!
ﬂﬂ 
	IsLoading
ﬂﬂ 
;
ﬂﬂ 
}
‡‡ 	
private
‚‚ 
void
‚‚ 
ExecuteLogin
‚‚ !
(
‚‚! "
)
‚‚" #
{
„„ 	
string
‰‰ 
email
‰‰ 
=
‰‰ 
Email
‰‰  
?
‰‰  !
.
‰‰! "
Trim
‰‰" &
(
‰‰& '
)
‰‰' (
??
‰‰) +
string
‰‰, 2
.
‰‰2 3
Empty
‰‰3 8
;
‰‰8 9
string
ÂÂ 
password
ÂÂ 
=
ÂÂ 
Password
ÂÂ &
??
ÂÂ' )
string
ÂÂ* 0
.
ÂÂ0 1
Empty
ÂÂ1 6
;
ÂÂ6 7
if
ÁÁ 
(
ÁÁ 
IsLoginInputValid
ÁÁ !
(
ÁÁ! "
email
ÁÁ" '
,
ÁÁ' (
password
ÁÁ) 1
)
ÁÁ1 2
)
ÁÁ2 3
{
ËË 
try
ÈÈ 
{
ÍÍ 
	IsLoading
ÎÎ 
=
ÎÎ 
true
ÎÎ  $
;
ÎÎ$ %
string
ÏÏ 
passwordHash
ÏÏ '
=
ÏÏ( )
PasswordHasher
ÏÏ* 8
.
ÏÏ8 9
ComputeSha256Hash
ÏÏ9 J
(
ÏÏJ K
password
ÏÏK S
)
ÏÏS T
;
ÏÏT U
InstanceContext
ÌÌ #
context
ÌÌ$ +
=
ÌÌ, -
new
ÌÌ. 1
InstanceContext
ÌÌ2 A
(
ÌÌA B
this
ÌÌB F
)
ÌÌF G
;
ÌÌG H'
_accountBanCountdownTimer
ÓÓ -
?
ÓÓ- .
.
ÓÓ. /
Dispose
ÓÓ/ 6
(
ÓÓ6 7
)
ÓÓ7 8
;
ÓÓ8 9$
AccountBanFeedbackText
ÔÔ *
=
ÔÔ+ ,
string
ÔÔ- 3
.
ÔÔ3 4
Empty
ÔÔ4 9
;
ÔÔ9 :!
_loginServiceClient
 '
?
' (
.
( )
Abort
) .
(
. /
)
/ 0
;
0 1!
_loginServiceClient
ÒÒ '
=
ÒÒ( )
new
ÒÒ* -
UserLoginClient
ÒÒ. =
(
ÒÒ= >
context
ÒÒ> E
)
ÒÒE F
;
ÒÒF G!
_loginServiceClient
ÚÚ '
.
ÚÚ' (
Login
ÚÚ( -
(
ÚÚ- .
email
ÚÚ. 3
,
ÚÚ3 4
passwordHash
ÚÚ5 A
)
ÚÚA B
;
ÚÚB C
}
ÛÛ 
catch
ÙÙ 
(
ÙÙ '
EndpointNotFoundException
ÙÙ 0
ex
ÙÙ1 3
)
ÙÙ3 4
{
ıı 
	IsLoading
ˆˆ 
=
ˆˆ 
false
ˆˆ  %
;
ˆˆ% &
_logger
˜˜ 
.
˜˜ 
Error
˜˜ !
(
˜˜! "
ex
˜˜" $
,
˜˜$ %&
LogLoginConnectionFailed
˜˜& >
)
˜˜> ?
;
˜˜? @
_dialogService
¯¯ "
.
¯¯" #
	ShowError
¯¯# ,
(
¯¯, -
MessageCode
¯¯- 8
.
¯¯8 9
ConnectionFailed
¯¯9 I
)
¯¯I J
;
¯¯J K
}
˘˘ 
catch
˙˙ 
(
˙˙ 
TimeoutException
˙˙ '
ex
˙˙( *
)
˙˙* +
{
˚˚ 
	IsLoading
¸¸ 
=
¸¸ 
false
¸¸  %
;
¸¸% &
_logger
˝˝ 
.
˝˝ 
Error
˝˝ !
(
˝˝! "
ex
˝˝" $
,
˝˝$ %
LogLoginTimedOut
˝˝& 6
)
˝˝6 7
;
˝˝7 8
_dialogService
˛˛ "
.
˛˛" #
	ShowError
˛˛# ,
(
˛˛, -
MessageCode
˛˛- 8
.
˛˛8 9
RequestTimeout
˛˛9 G
)
˛˛G H
;
˛˛H I
}
ˇˇ 
catch
ÄÄ 
(
ÄÄ $
CommunicationException
ÄÄ -
ex
ÄÄ. 0
)
ÄÄ0 1
{
ÅÅ 
	IsLoading
ÇÇ 
=
ÇÇ 
false
ÇÇ  %
;
ÇÇ% &
_logger
ÉÉ 
.
ÉÉ 
Error
ÉÉ !
(
ÉÉ! "
ex
ÉÉ" $
,
ÉÉ$ %(
LogLoginCommunicationError
ÉÉ& @
)
ÉÉ@ A
;
ÉÉA B
_dialogService
ÑÑ "
.
ÑÑ" #
	ShowError
ÑÑ# ,
(
ÑÑ, -
MessageCode
ÑÑ- 8
.
ÑÑ8 9 
CommunicationError
ÑÑ9 K
)
ÑÑK L
;
ÑÑL M
}
ÖÖ 
}
ÜÜ 
}
áá 	
private
ââ 
bool
ââ 
IsLoginInputValid
ââ &
(
ââ& '
string
ââ' -
email
ââ. 3
,
ââ3 4
string
ââ5 ;
password
ââ< D
)
ââD E
{
ää 	
bool
ãã 
isValid
ãã 
=
ãã 
false
ãã  
;
ãã  !
if
çç 
(
çç 
string
çç 
.
çç  
IsNullOrWhiteSpace
çç )
(
çç) *
email
çç* /
)
çç/ 0
)
çç0 1
{
éé 
_dialogService
èè 
.
èè 
ShowWarning
èè *
(
èè* +
MessageCode
èè+ 6
.
èè6 7

EmptyEmail
èè7 A
)
èèA B
;
èèB C
}
êê 
else
ëë 
if
ëë 
(
ëë 
string
ëë 
.
ëë 
IsNullOrEmpty
ëë )
(
ëë) *
password
ëë* 2
)
ëë2 3
)
ëë3 4
{
íí 
_dialogService
ìì 
.
ìì 
ShowWarning
ìì *
(
ìì* +
MessageCode
ìì+ 6
.
ìì6 7
EmptyPassword
ìì7 D
)
ììD E
;
ììE F
}
îî 
else
ïï 
{
ññ 
isValid
óó 
=
óó 
true
óó 
;
óó 
}
òò 
return
öö 
isValid
öö 
;
öö 
}
õõ 	
private
ùù 
void
ùù 
ExecuteBack
ùù  
(
ùù  !
)
ùù! "
{
ûû 	 
_navigationService
üü 
.
üü 
GoBack
üü %
(
üü% &
)
üü& '
;
üü' (
}
†† 	
private
¢¢ 
void
¢¢ #
ExecuteForgotPassword
¢¢ *
(
¢¢* +
)
¢¢+ ,
{
££ 	
try
§§ 
{
••  
_navigationService
¶¶ "
.
¶¶" #

ShowDialog
¶¶# -
(
¶¶- .
ViewId
¶¶. 4
.
¶¶4 5"
ForgotPasswordDialog
¶¶5 I
)
¶¶I J
;
¶¶J K
}
ßß 
catch
®® 
(
®® '
InvalidOperationException
®® ,
ex
®®- /
)
®®/ 0
{
©© 
_logger
™™ 
.
™™ 
Error
™™ 
(
™™ 
ex
™™  
,
™™  !*
LogForgotPasswordDialogError
™™" >
)
™™> ?
;
™™? @
}
´´ 
}
¨¨ 	
}
≠≠ 
}ÆÆ Æœ
cC:\Users\oscar\source\repos\TrickTakingMissions\Client\ViewModel\ViewModels\Lobby\LobbyViewModel.cs
	namespace 	
	ViewModel
 
. 

ViewModels 
{ 
public 

sealed 
class 
LobbyViewModel &
:' (
ViewModelBase) 6
,6 7
IDisposable8 C
{ 
private 
const 
byte 
WaitingLobbyStatus -
=. /
$num0 1
;1 2
private 
const 
int !
MinimumPlayersToStart /
=0 1
$num2 3
;3 4
private 
const 
string 
PlayerKickedReason /
=0 1
$str2 R
;R S
private 
const 
string !
DefaultMissionsTarget 2
=3 4
$str5 8
;8 9
private 
const 
string %
LogLobbyConnectionFailure 6
=7 8
$str J
;J K
private 
const 
string "
LogCurrentPlayerKicked 3
=4 5
$str   V
;  V W
private!! 
const!! 
string!! 
LogLobbyDisbanded!! .
=!!/ 0
$str!!1 s
;!!s t
private"" 
const"" 
string"" &
LogOpenSettingsDialogError"" 7
=""8 9
$str"": `
;""` a
private$$ 
readonly$$ 
INavigationService$$ +
_navigationService$$, >
;$$> ?
private%% 
readonly%% 
ILoggerService%% '
_logger%%( /
;%%/ 0
private&& 
readonly&& 
ILobbySession&& &
_lobbySession&&' 4
;&&4 5
private'' 
readonly'' 
ILobbyClient'' %
_lobbyClient''& 2
;''2 3
private(( 
readonly(( "
SynchronizationContext(( /
_uiSyncContext((0 >
;((> ?
private)) 
readonly)) 
int)) 
_currentUserId)) +
;))+ ,
private++ 
string++ 
_missionsTarget++ &
;++& '
private,, 
string,, 

_lobbyCode,, !
;,,! "
private-- 
bool-- 
_isReady-- 
;-- 
private.. 
IProfileImageCache.. "
_profileImageCache..# 5
;..5 6
private// 
bool// 
_isDisposed//  
;//  !
private00 
long00 $
_lastAppliedLobbyVersion00 -
;00- .
private11 
bool11 &
_hasLobbyConnectionFailure11 /
;11/ 0
private22 
bool22 !
_hasLobbyStartFailure22 *
;22* +
private33 
bool33  
_hasLobbyHostChanged33 )
;33) *
private44 
string44 %
_currentLobbyHostUsername44 0
;440 1
private55 
int55 $
_lastConfirmedHostUserId55 ,
;55, -
public77 
LobbyViewModel77 
(77 &
ViewModelNavigationLogging77 8
navigationLogging779 J
,77J K
ILobbySession77L Y
lobbySession77Z f
,77f g$
IChatModerationPresenter88 $#
chatModerationPresenter88% <
)88< =
{99 	
if:: 
(:: 
navigationLogging:: !
==::" $
null::% )
)::) *
{;; 
throw<< 
new<< !
ArgumentNullException<< /
(<</ 0
nameof<<0 6
(<<6 7
navigationLogging<<7 H
)<<H I
)<<I J
;<<J K
}== 
_navigationService?? 
=??  
navigationLogging??! 2
.??2 3
NavigationService??3 D
;??D E
_logger@@ 
=@@ 
navigationLogging@@ '
.@@' (
Logger@@( .
;@@. /
_lobbySessionAA 
=AA 
lobbySessionAA (
??AA) +
throwAA, 1
newAA2 5!
ArgumentNullExceptionAA6 K
(AAK L
nameofAAL R
(AAR S
lobbySessionAAS _
)AA_ `
)AA` a
;AAa b
_lobbyClientBB 
=BB 
lobbySessionBB '
.BB' (
ClientBB( .
;BB. /
_uiSyncContextCC 
=CC "
SynchronizationContextCC 3
.CC3 4
CurrentCC4 ;
;CC; <
_currentUserIdDD 
=DD 
UserSessionDD (
.DD( )
CurrentDD) 0
.DD0 1
EnsureActiveUserIdDD1 C
(DDC D
)DDD E
;DDE F
_missionsTargetFF 
=FF !
DefaultMissionsTargetFF 3
;FF3 4

_lobbyCodeGG 
=GG 
stringGG 
.GG  
EmptyGG  %
;GG% &
_isReadyHH 
=HH 
falseHH 
;HH 
PlayersII 
=II 
newII  
ObservableCollectionII .
<II. /$
LobbyPlayerItemViewModelII/ G
>IIG H
(IIH I
)III J
;IIJ K
PlayersJJ 
.JJ 
CollectionChangedJJ %
+=JJ& (&
OnLobbyParticipantsChangedJJ) C
;JJC D
BackCommandLL 
=LL 
newLL 
AsyncRelayCommandLL /
(LL/ 0
ExecuteBackAsyncLL0 @
)LL@ A
;LLA B
ProfileCommandMM 
=MM 
newMM  
RelayCommandMM! -
(MM- .
ExecuteProfileMM. <
)MM< =
;MM= >
SettingsCommandNN 
=NN 
newNN !
RelayCommandNN" .
(NN. /
ExecuteSettingsNN/ >
,NN> ? 
CanEditLobbySettingsNN@ T
)NNT U
;NNU V
StartGameCommandOO 
=OO 
newOO "
AsyncRelayCommandOO# 4
(OO4 5!
ExecuteStartGameAsyncOO5 J
,OOJ K
CanStartGameOOL X
)OOX Y
;OOY Z
ToggleReadyCommandPP 
=PP  
newPP! $
AsyncRelayCommandPP% 6
(PP6 7#
ExecuteToggleReadyAsyncPP7 N
)PPN O
;PPO P
ChatRR 
=RR 
newRR 
LobbyChatViewModelRR )
(RR) *
navigationLoggingRR* ;
,RR; <
lobbySessionRR= I
,RRI J#
chatModerationPresenterRRK b
)RRb c
;RRc d!
LoadInitialLobbyStateSS !
(SS! "
)SS" #
;SS# $"
SubscribeToLobbyEventsTT "
(TT" #
)TT# $
;TT$ %
}UU 	
publicZZ 
eventZZ 
EventHandlerZZ !
CurrentPlayerKickedZZ" 5
;ZZ5 6
public\\ 
bool\\ 
CanEditCurrentLobby\\ '
=>\\( *
_lobbySession\\+ 8
.\\8 9
CurrentLobby\\9 E
?\\E F
.\\F G

HostUserId\\G Q
==\\R T
_currentUserId\\U c
&&\\d f
!]] &
_hasLobbyConnectionFailure]] '
;]]' (
public__ 
bool__  
CanStartCurrentLobby__ (
=>__) +
CanEditCurrentLobby__, ?
&&__@ B
_lobbySession`` 
.`` 
CurrentLobby`` &
?``& '
.``' (
Status``( .
==``/ 1
WaitingLobbyStatus``2 D
&&``E G
Playersaa 
.aa 
Countaa 
>=aa !
MinimumPlayersToStartaa 2
&&aa3 5
Playersbb 
.bb 
Allbb 
(bb 
participantbb #
=>bb$ &
participantbb' 2
.bb2 3
IsReadybb3 :
||bb; =
participantbb> I
.bbI J
IsHostbbJ P
)bbP Q
;bbQ R
publicdd 
booldd %
HasLobbyConnectionFailuredd -
{ee 	
getff 
=>ff &
_hasLobbyConnectionFailureff -
;ff- .
privategg 
setgg 
=>gg 
SetPropertygg &
(gg& '
refgg' *&
_hasLobbyConnectionFailuregg+ E
,ggE F
valueggG L
)ggL M
;ggM N
}hh 	
publicjj 
booljj  
HasLobbyStartFailurejj (
{kk 	
getll 
=>ll !
_hasLobbyStartFailurell (
;ll( )
privatemm 
setmm 
=>mm 
SetPropertymm &
(mm& '
refmm' *!
_hasLobbyStartFailuremm+ @
,mm@ A
valuemmB G
)mmG H
;mmH I
}nn 	
publicpp 
boolpp 
HasLobbyHostChangedpp '
{qq 	
getrr 
=>rr  
_hasLobbyHostChangedrr '
;rr' (
privatess 
setss 
=>ss 
SetPropertyss &
(ss& '
refss' * 
_hasLobbyHostChangedss+ ?
,ss? @
valuessA F
)ssF G
;ssG H
}tt 	
publicvv 
stringvv $
CurrentLobbyHostUsernamevv .
{ww 	
getxx 
=>xx %
_currentLobbyHostUsernamexx ,
;xx, -
privateyy 
setyy 
=>yy 
SetPropertyyy &
(yy& '
refyy' *%
_currentLobbyHostUsernameyy+ D
,yyD E
valueyyF K
)yyK L
;yyL M
}zz 	
public|| 
int|| #
MaximumLobbyPlayerCount|| *
=>||+ -
_lobbySession||. ;
.||; <
CurrentLobby||< H
?||H I
.||I J
PlayerLimit||J U
??||V X
$num||Y Z
;||Z [
public~~ !
ProfileImageViewModel~~ $%
CurrentPlayerProfileImage~~% >
{~~? @
get~~A D
;~~D E
private~~F M
set~~N Q
;~~Q R
}~~S T
public
ÄÄ  
LobbyChatViewModel
ÄÄ !
Chat
ÄÄ" &
{
ÄÄ' (
get
ÄÄ) ,
;
ÄÄ, -
}
ÄÄ. /
public
ÇÇ "
ObservableCollection
ÇÇ #
<
ÇÇ# $&
LobbyPlayerItemViewModel
ÇÇ$ <
>
ÇÇ< =
Players
ÇÇ> E
{
ÇÇF G
get
ÇÇH K
;
ÇÇK L
}
ÇÇM N
public
ÑÑ 
IEnumerable
ÑÑ 
<
ÑÑ 
int
ÑÑ 
>
ÑÑ $
VacantLobbyPlayerSlots
ÑÑ  6
=>
ÑÑ7 9

Enumerable
ÑÑ: D
.
ÑÑD E
Range
ÑÑE J
(
ÑÑJ K
$num
ÑÑK L
,
ÑÑL M
Math
ÖÖ 
.
ÖÖ 
Max
ÖÖ 
(
ÖÖ 
$num
ÖÖ 
,
ÖÖ 
(
ÖÖ 
_lobbySession
ÖÖ &
.
ÖÖ& '
CurrentLobby
ÖÖ' 3
?
ÖÖ3 4
.
ÖÖ4 5
PlayerLimit
ÖÖ5 @
??
ÖÖA C
$num
ÖÖD E
)
ÖÖE F
-
ÖÖG H
Players
ÖÖI P
.
ÖÖP Q
Count
ÖÖQ V
)
ÖÖV W
)
ÖÖW X
;
ÖÖX Y
public
áá 
string
áá 
MissionsTarget
áá $
{
àà 	
get
ââ 
=>
ââ 
_missionsTarget
ââ "
;
ââ" #
set
ää 
=>
ää 
SetProperty
ää 
(
ää 
ref
ää "
_missionsTarget
ää# 2
,
ää2 3
value
ää4 9
)
ää9 :
;
ää: ;
}
ãã 	
public
çç 
string
çç 
	LobbyCode
çç 
{
éé 	
get
èè 
=>
èè 

_lobbyCode
èè 
;
èè 
set
êê 
=>
êê 
SetProperty
êê 
(
êê 
ref
êê "

_lobbyCode
êê# -
,
êê- .
value
êê/ 4
)
êê4 5
;
êê5 6
}
ëë 	
public
ìì 
bool
ìì 
IsReady
ìì 
{
îî 	
get
ïï 
=>
ïï 
_isReady
ïï 
;
ïï 
set
ññ 
=>
ññ 
SetProperty
ññ 
(
ññ 
ref
ññ "
_isReady
ññ# +
,
ññ+ ,
value
ññ- 2
)
ññ2 3
;
ññ3 4
}
óó 	
public
ôô 
ICommand
ôô 
BackCommand
ôô #
{
ôô$ %
get
ôô& )
;
ôô) *
}
ôô+ ,
public
õõ 
ICommand
õõ 
ProfileCommand
õõ &
{
õõ' (
get
õõ) ,
;
õõ, -
}
õõ. /
public
ùù 
ICommand
ùù 
SettingsCommand
ùù '
{
ùù( )
get
ùù* -
;
ùù- .
}
ùù/ 0
public
üü 
ICommand
üü 
StartGameCommand
üü (
{
üü) *
get
üü+ .
;
üü. /
}
üü0 1
public
°° 
ICommand
°°  
ToggleReadyCommand
°° *
{
°°+ ,
get
°°- 0
;
°°0 1
}
°°2 3
public
££ 
void
££ $
ConfigureProfileImages
££ *
(
££* + 
IProfileImageCache
££+ =
profileImageCache
££> O
)
££O P
{
§§ 	 
_profileImageCache
•• 
=
••  
profileImageCache
••! 2
;
••2 3'
CurrentPlayerProfileImage
¶¶ %
?
¶¶% &
.
¶¶& '
Dispose
¶¶' .
(
¶¶. /
)
¶¶/ 0
;
¶¶0 1'
CurrentPlayerProfileImage
ßß %
=
ßß& '
new
ßß( +#
ProfileImageViewModel
ßß, A
(
ßßA B
_currentUserId
ßßB P
,
ßßP Q
profileImageCache
ßßR c
)
ßßc d
;
ßßd e
OnPropertyChanged
®® 
(
®® 
nameof
®® $
(
®®$ %'
CurrentPlayerProfileImage
®®% >
)
®®> ?
)
®®? @
;
®®@ A
Chat
©© 
.
©© $
ConfigureProfileImages
©© '
(
©©' (
profileImageCache
©©( 9
)
©©9 :
;
©©: ;
foreach
™™ 
(
™™ &
LobbyPlayerItemViewModel
™™ -
player
™™. 4
in
™™5 7
Players
™™8 ?
)
™™? @
{
´´ 
player
¨¨ 
.
¨¨  
AttachProfileImage
¨¨ )
(
¨¨) *
profileImageCache
¨¨* ;
)
¨¨; <
;
¨¨< =
}
≠≠ 
}
ÆÆ 	
public
∞∞ 
void
∞∞ 
Dispose
∞∞ 
(
∞∞ 
)
∞∞ 
{
±± 	
_isDisposed
≤≤ 
=
≤≤ 
true
≤≤ 
;
≤≤ 
Players
≥≥ 
.
≥≥ 
CollectionChanged
≥≥ %
-=
≥≥& ((
OnLobbyParticipantsChanged
≥≥) C
;
≥≥C D(
UnsubscribeFromLobbyEvents
¥¥ &
(
¥¥& '
)
¥¥' (
;
¥¥( )
Chat
µµ 
.
µµ 
Dispose
µµ 
(
µµ 
)
µµ 
;
µµ '
CurrentPlayerProfileImage
∂∂ %
?
∂∂% &
.
∂∂& '
Dispose
∂∂' .
(
∂∂. /
)
∂∂/ 0
;
∂∂0 1
foreach
∑∑ 
(
∑∑ &
LobbyPlayerItemViewModel
∑∑ -
player
∑∑. 4
in
∑∑5 7
Players
∑∑8 ?
)
∑∑? @
{
∏∏ 
player
ππ 
.
ππ 
Dispose
ππ 
(
ππ 
)
ππ  
;
ππ  !
}
∫∫ 
}
ªª 	
private
ΩΩ 
void
ΩΩ (
OnLobbyParticipantsChanged
ΩΩ /
(
ΩΩ/ 0
object
ΩΩ0 6
sender
ΩΩ7 =
,
ΩΩ= >.
 NotifyCollectionChangedEventArgs
ΩΩ? _
e
ΩΩ` a
)
ΩΩa b
{
ææ 	
OnPropertyChanged
øø 
(
øø 
nameof
øø $
(
øø$ %$
VacantLobbyPlayerSlots
øø% ;
)
øø; <
)
øø< =
;
øø= >
}
¿¿ 	
private
¬¬ 
void
¬¬ #
LoadInitialLobbyState
¬¬ *
(
¬¬* +
)
¬¬+ ,
{
√√ 	&
ApplyConfirmedLobbyState
ƒƒ $
(
ƒƒ$ %
_lobbySession
ƒƒ% 2
.
ƒƒ2 3
CurrentLobby
ƒƒ3 ?
)
ƒƒ? @
;
ƒƒ@ A
}
≈≈ 	
private
«« 
void
«« '
OnServerLobbyStateChanged
«« .
(
««. /
object
««/ 5
sender
««6 <
,
««< =(
LobbyStateChangedEventArgs
««> X
e
««Y Z
)
««Z [
{
»» 	 
DispatchToUiThread
…… 
(
…… 
(
……  
)
……  !
=>
……" $&
ApplyConfirmedLobbyState
……% =
(
……= >
e
……> ?
.
……? @
ConfirmedLobby
……@ N
)
……N O
)
……O P
;
……P Q
}
   	
private
ÃÃ 
void
ÃÃ &
ApplyConfirmedLobbyState
ÃÃ -
(
ÃÃ- .
Lobby
ÃÃ. 3
confirmedLobby
ÃÃ4 B
)
ÃÃB C
{
ÕÕ 	
if
ŒŒ 
(
ŒŒ 
confirmedLobby
ŒŒ 
!=
ŒŒ !
null
ŒŒ" &
&&
ŒŒ' )
confirmedLobby
ŒŒ* 8
.
ŒŒ8 9
StateVersion
ŒŒ9 E
>=
ŒŒF H&
_lastAppliedLobbyVersion
ŒŒI a
)
ŒŒa b
{
œœ !
HasLobbyHostChanged
–– #
=
––$ %&
_lastConfirmedHostUserId
––& >
!=
––? A
$num
––B C
&&
––D F&
_lastConfirmedHostUserId
—— ,
!=
——- /
confirmedLobby
——0 >
.
——> ?

HostUserId
——? I
;
——I J&
_lastConfirmedHostUserId
““ (
=
““) *
confirmedLobby
““+ 9
.
““9 :

HostUserId
““: D
;
““D E&
_lastAppliedLobbyVersion
”” (
=
””) *
confirmedLobby
””+ 9
.
””9 :
StateVersion
””: F
;
””F G
_lobbySession
‘‘ 
.
‘‘ 
SetLobby
‘‘ &
(
‘‘& '
confirmedLobby
‘‘' 5
)
‘‘5 6
;
‘‘6 7
	LobbyCode
’’ 
=
’’ 
confirmedLobby
’’ *
.
’’* +
	LobbyCode
’’+ 4
;
’’4 5
MissionsTarget
÷÷ 
=
÷÷  
confirmedLobby
÷÷! /
.
÷÷/ 0 
TargetMissionCount
÷÷0 B
.
÷÷B C
ToString
÷÷C K
(
÷÷K L
CultureInfo
÷÷L W
.
÷÷W X
InvariantCulture
÷÷X h
)
÷÷h i
;
÷÷i j%
SynchronizeLobbyPlayers
◊◊ '
(
◊◊' (
confirmedLobby
◊◊( 6
)
◊◊6 7
;
◊◊7 8&
CurrentLobbyHostUsername
ÿÿ (
=
ÿÿ) *
Players
ÿÿ+ 2
.
ÿÿ2 3
FirstOrDefault
ÿÿ3 A
(
ÿÿA B
participant
ÿÿB M
=>
ÿÿN P
participant
ÿÿQ \
.
ÿÿ\ ]
IsHost
ÿÿ] c
)
ÿÿc d
?
ÿÿd e
.
ÿÿe f
Username
ÿÿf n
;
ÿÿn o
OnPropertyChanged
ŸŸ !
(
ŸŸ! "
nameof
ŸŸ" (
(
ŸŸ( )%
MaximumLobbyPlayerCount
ŸŸ) @
)
ŸŸ@ A
)
ŸŸA B
;
ŸŸB C
OnPropertyChanged
⁄⁄ !
(
⁄⁄! "
nameof
⁄⁄" (
(
⁄⁄( )$
VacantLobbyPlayerSlots
⁄⁄) ?
)
⁄⁄? @
)
⁄⁄@ A
;
⁄⁄A B
OnPropertyChanged
€€ !
(
€€! "
nameof
€€" (
(
€€( )!
CanEditCurrentLobby
€€) <
)
€€< =
)
€€= >
;
€€> ?
OnPropertyChanged
‹‹ !
(
‹‹! "
nameof
‹‹" (
(
‹‹( )"
CanStartCurrentLobby
‹‹) =
)
‹‹= >
)
‹‹> ?
;
‹‹? @
CommandManager
›› 
.
›› (
InvalidateRequerySuggested
›› 9
(
››9 :
)
››: ;
;
››; <
}
ﬁﬁ 
}
ﬂﬂ 	
private
·· 
void
·· %
SynchronizeLobbyPlayers
·· ,
(
··, -
Lobby
··- 2
confirmedLobby
··3 A
)
··A B
{
‚‚ 	
foreach
„„ 
(
„„ &
LobbyPlayerItemViewModel
„„ -
player
„„. 4
in
„„5 7
Players
„„8 ?
)
„„? @
{
‰‰ 
player
ÂÂ 
.
ÂÂ 
Dispose
ÂÂ 
(
ÂÂ 
)
ÂÂ  
;
ÂÂ  !
}
ÊÊ 
Players
ÁÁ 
.
ÁÁ 
Clear
ÁÁ 
(
ÁÁ 
)
ÁÁ 
;
ÁÁ 
foreach
ËË 
(
ËË 
LobbyPlayer
ËË  
participant
ËË! ,
in
ËË- /
confirmedLobby
ËË0 >
.
ËË> ?
Players
ËË? F
)
ËËF G
{
ÈÈ (
AddOrUpdateParticipantItem
ÍÍ *
(
ÍÍ* +
participant
ÍÍ+ 6
)
ÍÍ6 7
;
ÍÍ7 8
}
ÎÎ 
}
ÏÏ 	
private
ÓÓ 
void
ÓÓ %
OnLobbyConnectionFailed
ÓÓ ,
(
ÓÓ, -%
AuthenticationErrorType
ÓÓ- D
connectionFailure
ÓÓE V
)
ÓÓV W
{
ÔÔ 	 
DispatchToUiThread
 
(
 (
MarkLobbyConnectionFailure
 9
)
9 :
;
: ;
}
ÒÒ 	
private
ÛÛ 
void
ÛÛ (
MarkLobbyConnectionFailure
ÛÛ /
(
ÛÛ/ 0
)
ÛÛ0 1
{
ÙÙ 	
_logger
ıı 
.
ıı 
Error
ıı 
(
ıı '
LogLobbyConnectionFailure
ıı 3
,
ıı3 4

_lobbyCode
ıı5 ?
)
ıı? @
;
ıı@ A'
HasLobbyConnectionFailure
ˆˆ %
=
ˆˆ& '
true
ˆˆ( ,
;
ˆˆ, -
OnPropertyChanged
˜˜ 
(
˜˜ 
nameof
˜˜ $
(
˜˜$ %!
CanEditCurrentLobby
˜˜% 8
)
˜˜8 9
)
˜˜9 :
;
˜˜: ;
OnPropertyChanged
¯¯ 
(
¯¯ 
nameof
¯¯ $
(
¯¯$ %"
CanStartCurrentLobby
¯¯% 9
)
¯¯9 :
)
¯¯: ;
;
¯¯; <
CommandManager
˘˘ 
.
˘˘ (
InvalidateRequerySuggested
˘˘ 5
(
˘˘5 6
)
˘˘6 7
;
˘˘7 8
}
˙˙ 	
private
¸¸ 
bool
¸¸ "
CanEditLobbySettings
¸¸ )
(
¸¸) *
)
¸¸* +
{
˝˝ 	
return
˛˛ !
CanEditCurrentLobby
˛˛ &
;
˛˛& '
}
ˇˇ 	
private
ÅÅ 
bool
ÅÅ 
CanStartGame
ÅÅ !
(
ÅÅ! "
)
ÅÅ" #
{
ÇÇ 	
return
ÉÉ "
CanStartCurrentLobby
ÉÉ '
;
ÉÉ' (
}
ÑÑ 	
private
ÜÜ 
void
ÜÜ $
SubscribeToLobbyEvents
ÜÜ +
(
ÜÜ+ ,
)
ÜÜ, -
{
áá 	
ILobbyClient
àà 
client
àà 
=
àà  !
_lobbyClient
àà" .
;
àà. /
client
ââ 
.
ââ 

PlayerLeft
ââ 
+=
ââ   
OnServerPlayerLeft
ââ! 3
;
ââ3 4
client
ää 
.
ää 
LobbyStateChanged
ää $
+=
ää% ''
OnServerLobbyStateChanged
ää( A
;
ääA B
client
ãã 
.
ãã %
ConnectionErrorOccurred
ãã *
+=
ãã+ -%
OnLobbyConnectionFailed
ãã. E
;
ããE F
client
åå 
.
åå 
LobbyDisbanded
åå !
+=
åå" $$
OnServerLobbyDisbanded
åå% ;
;
åå; <
client
çç 
.
çç 
GameStarted
çç 
+=
çç !!
OnServerGameStarted
çç" 5
;
çç5 6
}
éé 	
private
êê 
void
êê (
UnsubscribeFromLobbyEvents
êê /
(
êê/ 0
)
êê0 1
{
ëë 	
ILobbyClient
íí 
client
íí 
=
íí  !
_lobbyClient
íí" .
;
íí. /
client
ìì 
.
ìì 

PlayerLeft
ìì 
-=
ìì   
OnServerPlayerLeft
ìì! 3
;
ìì3 4
client
îî 
.
îî 
LobbyStateChanged
îî $
-=
îî% ''
OnServerLobbyStateChanged
îî( A
;
îîA B
client
ïï 
.
ïï %
ConnectionErrorOccurred
ïï *
-=
ïï+ -%
OnLobbyConnectionFailed
ïï. E
;
ïïE F
client
ññ 
.
ññ 
LobbyDisbanded
ññ !
-=
ññ" $$
OnServerLobbyDisbanded
ññ% ;
;
ññ; <
client
óó 
.
óó 
GameStarted
óó 
-=
óó !!
OnServerGameStarted
óó" 5
;
óó5 6
}
òò 	
private
öö 
void
öö !
OnServerGameStarted
öö (
(
öö( )
int
öö) ,
gameId
öö- 3
)
öö3 4
{
õõ 	 
DispatchToUiThread
úú 
(
úú 
HandleGameStarted
úú 0
)
úú0 1
;
úú1 2
}
ùù 	
private
üü 
void
üü 
HandleGameStarted
üü &
(
üü& '
)
üü' (
{
†† 	
if
°° 
(
°° 
!
°° 
_isDisposed
°° 
)
°° 
{
¢¢ (
UnsubscribeFromLobbyEvents
££ *
(
££* +
)
££+ ,
;
££, -%
SyncSessionLobbyPlayers
§§ '
(
§§' (
)
§§( )
;
§§) * 
_navigationService
•• "
.
••" #

NavigateTo
••# -
(
••- .
ViewId
••. 4
.
••4 5
	GameMatch
••5 >
)
••> ?
;
••? @
}
¶¶ 
}
ßß 	
private
©© 
void
©©  
OnServerPlayerLeft
©© '
(
©©' (
int
©©( +
participantUserId
©©, =
,
©©= >
string
©©? E
departureReason
©©F U
)
©©U V
{
™™ 	
if
´´ 
(
´´ 
participantUserId
´´ !
==
´´" $
_currentUserId
´´% 3
&&
´´4 6
departureReason
´´7 F
==
´´G I 
PlayerKickedReason
´´J \
)
´´\ ]
{
¨¨  
DispatchToUiThread
≠≠ "
(
≠≠" #%
HandleCurrentPlayerKick
≠≠# :
)
≠≠: ;
;
≠≠; <
}
ÆÆ 
}
ØØ 	
private
±± 
void
±± %
HandleCurrentPlayerKick
±± ,
(
±±, -
)
±±- .
{
≤≤ 	
if
≥≥ 
(
≥≥ 
!
≥≥ 
_isDisposed
≥≥ 
)
≥≥ 
{
¥¥ 
_logger
µµ 
.
µµ 
Warning
µµ 
(
µµ  $
LogCurrentPlayerKicked
µµ  6
,
µµ6 7
_currentUserId
µµ8 F
,
µµF G

_lobbyCode
µµH R
)
µµR S
;
µµS T(
UnsubscribeFromLobbyEvents
∂∂ *
(
∂∂* +
)
∂∂+ ,
;
∂∂, -
_lobbySession
∑∑ 
.
∑∑ 

ClearLobby
∑∑ (
(
∑∑( )
)
∑∑) *
;
∑∑* +!
CurrentPlayerKicked
∏∏ #
?
∏∏# $
.
∏∏$ %
Invoke
∏∏% +
(
∏∏+ ,
this
∏∏, 0
,
∏∏0 1
	EventArgs
∏∏2 ;
.
∏∏; <
Empty
∏∏< A
)
∏∏A B
;
∏∏B C 
_navigationService
ππ "
.
ππ" #

NavigateTo
ππ# -
(
ππ- .
ViewId
ππ. 4
.
ππ4 5
GameMenu
ππ5 =
)
ππ= >
;
ππ> ?
}
∫∫ 
}
ªª 	
private
ΩΩ 
bool
ΩΩ  
CanKickLobbyPlayer
ΩΩ '
(
ΩΩ' (
int
ΩΩ( +
targetUserId
ΩΩ, 8
)
ΩΩ8 9
{
ææ 	
return
øø 
!
øø 
_isDisposed
øø 
&&
øø  "!
CanEditCurrentLobby
øø# 6
&&
øø7 9
targetUserId
øø: F
!=
øøG I
_currentUserId
øøJ X
&&
øøY [
_lobbySession
¿¿ 
.
¿¿ 
CurrentLobby
¿¿ *
?
¿¿* +
.
¿¿+ ,
Status
¿¿, 2
==
¿¿3 5 
WaitingLobbyStatus
¿¿6 H
&&
¿¿I K
Players
¡¡ 
.
¡¡ 
Any
¡¡ 
(
¡¡ 
participant
¡¡ '
=>
¡¡( *
participant
¡¡+ 6
.
¡¡6 7
IdUser
¡¡7 =
==
¡¡> @
targetUserId
¡¡A M
&&
¡¡N P
!
¡¡Q R
participant
¡¡R ]
.
¡¡] ^
IsHost
¡¡^ d
)
¡¡d e
;
¡¡e f
}
¬¬ 	
private
ƒƒ 
async
ƒƒ 
Task
ƒƒ "
KickLobbyPlayerAsync
ƒƒ /
(
ƒƒ/ 0
int
ƒƒ0 3
targetUserId
ƒƒ4 @
)
ƒƒ@ A
{
≈≈ 	
if
∆∆ 
(
∆∆  
CanKickLobbyPlayer
∆∆ "
(
∆∆" #
targetUserId
∆∆# /
)
∆∆/ 0
)
∆∆0 1
{
«« 
await
»» 
_lobbyClient
»» "
.
»»" #
KickPlayerAsync
»»# 2
(
»»2 3

_lobbyCode
»»3 =
,
»»= >
_currentUserId
»»? M
,
»»M N
targetUserId
»»O [
)
»»[ \
;
»»\ ]
}
…… 
}
   	
private
ÃÃ 
void
ÃÃ $
OnServerLobbyDisbanded
ÃÃ +
(
ÃÃ+ ,
string
ÃÃ, 2
reason
ÃÃ3 9
)
ÃÃ9 :
{
ÕÕ 	 
DispatchToUiThread
ŒŒ 
(
ŒŒ 
(
ŒŒ  
)
ŒŒ  !
=>
ŒŒ" $
{
œœ 
_logger
–– 
.
–– 
Information
–– #
(
––# $
LogLobbyDisbanded
––$ 5
,
––5 6

_lobbyCode
––7 A
,
––A B
reason
––C I
)
––I J
;
––J K(
UnsubscribeFromLobbyEvents
—— *
(
——* +
)
——+ ,
;
——, -
_lobbySession
““ 
.
““ 

ClearLobby
““ (
(
““( )
)
““) *
;
““* + 
_navigationService
”” "
.
””" #

NavigateTo
””# -
(
””- .
ViewId
””. 4
.
””4 5
GameMenu
””5 =
)
””= >
;
””> ?
}
‘‘ 
)
‘‘ 
;
‘‘ 
}
’’ 	
private
◊◊ 
void
◊◊ (
AddOrUpdateParticipantItem
◊◊ /
(
◊◊/ 0
LobbyPlayer
◊◊0 ;
participant
◊◊< G
)
◊◊G H
{
ÿÿ 	&
LobbyPlayerItemViewModel
ŸŸ $
existing
ŸŸ% -
=
ŸŸ. /
Players
ŸŸ0 7
.
ŸŸ7 8
FirstOrDefault
ŸŸ8 F
(
ŸŸF G
item
ŸŸG K
=>
ŸŸL N
item
ŸŸO S
.
ŸŸS T
IdUser
ŸŸT Z
==
ŸŸ[ ]
participant
ŸŸ^ i
.
ŸŸi j
IdUser
ŸŸj p
)
ŸŸp q
;
ŸŸq r
bool
⁄⁄ 
isLocalPlayer
⁄⁄ 
=
⁄⁄  
participant
⁄⁄! ,
.
⁄⁄, -
IdUser
⁄⁄- 3
==
⁄⁄4 6
_currentUserId
⁄⁄7 E
;
⁄⁄E F
if
‹‹ 
(
‹‹ 
existing
‹‹ 
==
‹‹ 
null
‹‹  
)
‹‹  !
{
›› &
LobbyPlayerItemViewModel
ﬁﬁ (
newItem
ﬁﬁ) 0
=
ﬁﬁ1 2
new
ﬁﬁ3 6&
LobbyPlayerItemViewModel
ﬁﬁ7 O
(
ﬁﬁO P
participant
ﬂﬂ 
.
ﬂﬂ  
IdUser
ﬂﬂ  &
,
ﬂﬂ& '
participant
‡‡ 
.
‡‡  
Username
‡‡  (
,
‡‡( )
participant
·· 
.
··  
IsHost
··  &
)
··& '
{
‚‚ &
CanBeKickedByCurrentHost
„„ ,
=
„„- .!
CanEditCurrentLobby
„„/ B
&&
„„C E
!
„„F G
isLocalPlayer
„„G T
&&
„„U W
!
„„X Y
participant
„„Y d
.
„„d e
IsHost
„„e k
&&
„„l n
_lobbySession
‰‰ %
.
‰‰% &
CurrentLobby
‰‰& 2
?
‰‰2 3
.
‰‰3 4
Status
‰‰4 :
==
‰‰; = 
WaitingLobbyStatus
‰‰> P
,
‰‰P Q
KickPlayerCommand
ÂÂ %
=
ÂÂ& '
new
ÂÂ( +
AsyncRelayCommand
ÂÂ, =
(
ÂÂ= >
(
ÊÊ 
)
ÊÊ 
=>
ÊÊ "
KickLobbyPlayerAsync
ÊÊ 2
(
ÊÊ2 3
participant
ÊÊ3 >
.
ÊÊ> ?
IdUser
ÊÊ? E
)
ÊÊE F
,
ÊÊF G
(
ÁÁ 
)
ÁÁ 
=>
ÁÁ  
CanKickLobbyPlayer
ÁÁ 0
(
ÁÁ0 1
participant
ÁÁ1 <
.
ÁÁ< =
IdUser
ÁÁ= C
)
ÁÁC D
)
ÁÁD E
,
ÁÁE F
IsCurrentPlayer
ËË #
=
ËË$ %
isLocalPlayer
ËË& 3
,
ËË3 4
IsReady
ÈÈ 
=
ÈÈ 
participant
ÈÈ )
.
ÈÈ) *
IsReady
ÈÈ* 1
}
ÍÍ 
;
ÍÍ 
if
ÎÎ 
(
ÎÎ  
_profileImageCache
ÎÎ &
!=
ÎÎ' )
null
ÎÎ* .
)
ÎÎ. /
{
ÏÏ 
newItem
ÌÌ 
.
ÌÌ  
AttachProfileImage
ÌÌ .
(
ÌÌ. / 
_profileImageCache
ÌÌ/ A
)
ÌÌA B
;
ÌÌB C
}
ÓÓ 
Players
ÔÔ 
.
ÔÔ 
Add
ÔÔ 
(
ÔÔ 
newItem
ÔÔ #
)
ÔÔ# $
;
ÔÔ$ %
}
 
else
ÒÒ 
{
ÚÚ 
existing
ÛÛ 
.
ÛÛ 
IsReady
ÛÛ  
=
ÛÛ! "
participant
ÛÛ# .
.
ÛÛ. /
IsReady
ÛÛ/ 6
;
ÛÛ6 7
}
ÙÙ 
if
ˆˆ 
(
ˆˆ 
isLocalPlayer
ˆˆ 
)
ˆˆ 
{
˜˜ 
IsReady
¯¯ 
=
¯¯ 
participant
¯¯ %
.
¯¯% &
IsReady
¯¯& -
;
¯¯- .
}
˘˘ %
SyncSessionLobbyPlayers
˚˚ #
(
˚˚# $
)
˚˚$ %
;
˚˚% &
}
¸¸ 	
private
˛˛ 
void
˛˛ #
RemoveParticipantItem
˛˛ *
(
˛˛* +
int
˛˛+ .
userId
˛˛/ 5
)
˛˛5 6
{
ˇˇ 	&
LobbyPlayerItemViewModel
ÄÄ $
existing
ÄÄ% -
=
ÄÄ. /
Players
ÄÄ0 7
.
ÄÄ7 8
FirstOrDefault
ÄÄ8 F
(
ÄÄF G
item
ÄÄG K
=>
ÄÄL N
item
ÄÄO S
.
ÄÄS T
IdUser
ÄÄT Z
==
ÄÄ[ ]
userId
ÄÄ^ d
)
ÄÄd e
;
ÄÄe f
if
ÅÅ 
(
ÅÅ 
existing
ÅÅ 
!=
ÅÅ 
null
ÅÅ  
)
ÅÅ  !
{
ÇÇ 
existing
ÉÉ 
.
ÉÉ 
Dispose
ÉÉ  
(
ÉÉ  !
)
ÉÉ! "
;
ÉÉ" #
Players
ÑÑ 
.
ÑÑ 
Remove
ÑÑ 
(
ÑÑ 
existing
ÑÑ '
)
ÑÑ' (
;
ÑÑ( )%
SyncSessionLobbyPlayers
ÖÖ '
(
ÖÖ' (
)
ÖÖ( )
;
ÖÖ) *
}
ÜÜ 
}
áá 	
private
ââ 
void
ââ %
SyncSessionLobbyPlayers
ââ ,
(
ââ, -
)
ââ- .
{
ää 	
Lobby
ãã 
activeLobby
ãã 
=
ãã 
_lobbySession
ãã  -
.
ãã- .
CurrentLobby
ãã. :
;
ãã: ;
if
åå 
(
åå 
activeLobby
åå 
!=
åå 
null
åå #
)
åå# $
{
çç 
LobbyPlayer
éé 
[
éé 
]
éé 
updatedPlayers
éé ,
=
éé- .
new
éé/ 2
LobbyPlayer
éé3 >
[
éé> ?
Players
éé? F
.
ééF G
Count
ééG L
]
ééL M
;
ééM N
for
èè 
(
èè 
int
èè 
index
èè 
=
èè  
$num
èè! "
;
èè" #
index
èè$ )
<
èè* +
Players
èè, 3
.
èè3 4
Count
èè4 9
;
èè9 :
index
èè; @
++
èè@ B
)
èèB C
{
êê &
LobbyPlayerItemViewModel
ëë ,
item
ëë- 1
=
ëë2 3
Players
ëë4 ;
[
ëë; <
index
ëë< A
]
ëëA B
;
ëëB C
updatedPlayers
íí "
[
íí" #
index
íí# (
]
íí( )
=
íí* +
new
íí, /
LobbyPlayer
íí0 ;
{
ìì 
IdUser
îî 
=
îî  
item
îî! %
.
îî% &
IdUser
îî& ,
,
îî, -
Username
ïï  
=
ïï! "
item
ïï# '
.
ïï' (
Username
ïï( 0
,
ïï0 1
IsHost
ññ 
=
ññ  
item
ññ! %
.
ññ% &
IsHost
ññ& ,
,
ññ, -
IsReady
óó 
=
óó  !
item
óó" &
.
óó& '
IsReady
óó' .
}
òò 
;
òò 
}
ôô 
activeLobby
õõ 
.
õõ 
Players
õõ #
=
õõ$ %
updatedPlayers
õõ& 4
;
õõ4 5
}
úú 
}
ùù 	
private
üü 
void
üü )
UpdateParticipantReadyState
üü 0
(
üü0 1
int
üü1 4
userId
üü5 ;
,
üü; <
bool
üü= A
isReady
üüB I
)
üüI J
{
†† 	&
LobbyPlayerItemViewModel
°° $
existing
°°% -
=
°°. /
Players
°°0 7
.
°°7 8
FirstOrDefault
°°8 F
(
°°F G
item
°°G K
=>
°°L N
item
°°O S
.
°°S T
IdUser
°°T Z
==
°°[ ]
userId
°°^ d
)
°°d e
;
°°e f
if
¢¢ 
(
¢¢ 
existing
¢¢ 
!=
¢¢ 
null
¢¢  
)
¢¢  !
{
££ 
existing
§§ 
.
§§ 
IsReady
§§  
=
§§! "
isReady
§§# *
;
§§* +
}
•• 
if
ßß 
(
ßß 
userId
ßß 
==
ßß 
_currentUserId
ßß (
)
ßß( )
{
®® 
IsReady
©© 
=
©© 
isReady
©© !
;
©©! "
}
™™ 
OnPropertyChanged
¨¨ 
(
¨¨ 
nameof
¨¨ $
(
¨¨$ %"
CanStartCurrentLobby
¨¨% 9
)
¨¨9 :
)
¨¨: ;
;
¨¨; <
CommandManager
≠≠ 
.
≠≠ (
InvalidateRequerySuggested
≠≠ 5
(
≠≠5 6
)
≠≠6 7
;
≠≠7 8
}
ÆÆ 	
private
∞∞ 
void
∞∞  
DispatchToUiThread
∞∞ '
(
∞∞' (
Action
∞∞( .
uiAction
∞∞/ 7
)
∞∞7 8
{
±± 	
if
≤≤ 
(
≤≤ 
_uiSyncContext
≤≤ 
!=
≤≤ !
null
≤≤" &
&&
≤≤' )$
SynchronizationContext
≤≤* @
.
≤≤@ A
Current
≤≤A H
!=
≤≤I K
_uiSyncContext
≤≤L Z
)
≤≤Z [
{
≥≥ 
_uiSyncContext
¥¥ 
.
¥¥ 
Post
¥¥ #
(
¥¥# $
_
¥¥$ %
=>
¥¥& (
uiAction
¥¥) 1
(
¥¥1 2
)
¥¥2 3
,
¥¥3 4
null
¥¥5 9
)
¥¥9 :
;
¥¥: ;
}
µµ 
else
∂∂ 
{
∑∑ 
uiAction
∏∏ 
(
∏∏ 
)
∏∏ 
;
∏∏ 
}
ππ 
}
∫∫ 	
private
ºº 
async
ºº 
Task
ºº 
ExecuteBackAsync
ºº +
(
ºº+ ,
)
ºº, -
{
ΩΩ 	(
UnsubscribeFromLobbyEvents
ææ &
(
ææ& '
)
ææ' (
;
ææ( )
string
øø 
codeToLeave
øø 
=
øø  

_lobbyCode
øø! +
;
øø+ ,
if
¡¡ 
(
¡¡ 
!
¡¡ 
string
¡¡ 
.
¡¡  
IsNullOrWhiteSpace
¡¡ *
(
¡¡* +
codeToLeave
¡¡+ 6
)
¡¡6 7
)
¡¡7 8
{
¬¬ 
await
√√ 
_lobbyClient
√√ "
.
√√" #
LeaveLobbyAsync
√√# 2
(
√√2 3
codeToLeave
√√3 >
,
√√> ?
_currentUserId
√√@ N
)
√√N O
;
√√O P
}
ƒƒ 
_lobbySession
∆∆ 
.
∆∆ 

ClearLobby
∆∆ $
(
∆∆$ %
)
∆∆% &
;
∆∆& ' 
_navigationService
«« 
.
«« 

NavigateTo
«« )
(
««) *
ViewId
««* 0
.
««0 1
GameMenu
««1 9
)
««9 :
;
««: ;
}
»» 	
private
   
void
   
ExecuteProfile
   #
(
  # $
)
  $ %
{
ÀÀ 	 
_navigationService
ÃÃ 
.
ÃÃ 

NavigateTo
ÃÃ )
(
ÃÃ) *
ViewId
ÃÃ* 0
.
ÃÃ0 1
Profile
ÃÃ1 8
)
ÃÃ8 9
;
ÃÃ9 :
}
ÕÕ 	
private
œœ 
void
œœ 
ExecuteSettings
œœ $
(
œœ$ %
)
œœ% &
{
–– 	
try
—— 
{
““  
_navigationService
”” "
.
””" #

ShowDialog
””# -
(
””- .
ViewId
””. 4
.
””4 5 
GameSettingsDialog
””5 G
)
””G H
;
””H I
}
‘‘ 
catch
’’ 
(
’’ '
InvalidOperationException
’’ ,
ex
’’- /
)
’’/ 0
{
÷÷ 
_logger
◊◊ 
.
◊◊ 
Error
◊◊ 
(
◊◊ 
ex
◊◊  
,
◊◊  !(
LogOpenSettingsDialogError
◊◊" <
)
◊◊< =
;
◊◊= >
}
ÿÿ 
}
ŸŸ 	
private
€€ 
async
€€ 
Task
€€ #
ExecuteStartGameAsync
€€ 0
(
€€0 1
)
€€1 2
{
‹‹ 	
if
›› 
(
›› 
CanStartGame
›› 
(
›› 
)
›› 
&&
›› !
!
››" #
string
››# )
.
››) * 
IsNullOrWhiteSpace
››* <
(
››< =

_lobbyCode
››= G
)
››G H
)
››H I
{
ﬁﬁ "
HasLobbyStartFailure
ﬂﬂ $
=
ﬂﬂ% &
false
ﬂﬂ' ,
;
ﬂﬂ, -
bool
‡‡ 
isStartConfirmed
‡‡ %
=
‡‡& '
await
‡‡( -
_lobbyClient
‡‡. :
.
‡‡: ;%
StartGameFromLobbyAsync
‡‡; R
(
‡‡R S

_lobbyCode
‡‡S ]
,
‡‡] ^
_currentUserId
‡‡_ m
)
‡‡m n
;
‡‡n o"
HasLobbyStartFailure
·· $
=
··% &
!
··' (
isStartConfirmed
··( 8
;
··8 9
}
‚‚ 
}
„„ 	
private
ÂÂ 
async
ÂÂ 
Task
ÂÂ %
ExecuteToggleReadyAsync
ÂÂ 2
(
ÂÂ2 3
)
ÂÂ3 4
{
ÊÊ 	
bool
ÁÁ 
newReadyState
ÁÁ 
=
ÁÁ  
!
ÁÁ! "
IsReady
ÁÁ" )
;
ÁÁ) *)
UpdateParticipantReadyState
ËË '
(
ËË' (
_currentUserId
ËË( 6
,
ËË6 7
newReadyState
ËË8 E
)
ËËE F
;
ËËF G
if
ÍÍ 
(
ÍÍ 
!
ÍÍ 
string
ÍÍ 
.
ÍÍ  
IsNullOrWhiteSpace
ÍÍ *
(
ÍÍ* +

_lobbyCode
ÍÍ+ 5
)
ÍÍ5 6
)
ÍÍ6 7
{
ÎÎ 
await
ÏÏ 
_lobbyClient
ÏÏ "
.
ÏÏ" #'
SetPlayerReadyStatusAsync
ÏÏ# <
(
ÏÏ< =

_lobbyCode
ÌÌ 
,
ÌÌ 
_currentUserId
ÓÓ "
,
ÓÓ" #
newReadyState
ÔÔ !
)
ÔÔ! "
;
ÔÔ" #
}
 
}
ÒÒ 	
}
ÚÚ 
}ÛÛ ôR
mC:\Users\oscar\source\repos\TrickTakingMissions\Client\ViewModel\ViewModels\Lobby\LobbyPlayerItemViewModel.cs
	namespace

 	
	ViewModel


 
.

 

ViewModels

 
{ 
public 

sealed 
class $
LobbyPlayerItemViewModel 0
:1 2
ViewModelBase3 @
,@ A
IDisposableB M
{ 
private 
const 
int '
MaximumVisibleHandCardCount 5
=6 7
$num8 :
;: ;
private 
bool 
_isReady 
; 
private 
bool 
_isMissionCaptain &
;& '
private 
int #
_remainingHandCardCount +
;+ ,
private 
int 
_wonTrickCount "
;" #
private 
int 
? 
_communicatedCardId (
;( )
private 
RadioTokenPosition "&
_communicatedTokenPosition# =
;= >
public $
LobbyPlayerItemViewModel '
(' (
int( +
idUser, 2
,2 3
string4 :
username; C
,C D
boolE I
isHostJ P
)P Q
{ 	
IdUser 
= 
idUser 
; 
Username 
= 
username 
??  "
string# )
.) *
Empty* /
;/ 0
IsHost 
= 
isHost 
; 

WonCardIds 
= 
new  
ObservableCollection 1
<1 2
int2 5
>5 6
(6 7
)7 8
;8 9
} 	
public!! 
IEnumerable!! 
<!! 
int!! 
>!! 
HiddenCardSlots!!  /
=>!!0 2

Enumerable!!3 =
.!!= >
Range!!> C
(!!C D
$num!!D E
,!!E F#
_remainingHandCardCount!!G ^
)!!^ _
;!!_ `
public##  
ObservableCollection## #
<### $%
MissionObjectiveViewModel##$ =
>##= >
MissionObjectives##? P
{##Q R
get##S V
;##V W
}##X Y
=##Z [
new$$  
ObservableCollection$$ $
<$$$ %%
MissionObjectiveViewModel$$% >
>$$> ?
($$? @
)$$@ A
;$$A B
public&&  
ObservableCollection&& #
<&&# $
int&&$ '
>&&' (

WonCardIds&&) 3
{&&4 5
get&&6 9
;&&9 :
}&&; <
public(( !
ProfileImageViewModel(( $
ProfileImage((% 1
{((2 3
get((4 7
;((7 8
private((9 @
set((A D
;((D E
}((F G
public** 
int** 
IdUser** 
{** 
get** 
;**  
}**! "
public,, 
string,, 
Username,, 
{,,  
get,,! $
;,,$ %
},,& '
public.. 
bool.. 
IsHost.. 
{.. 
get..  
;..  !
}.." #
public00 
bool00 
IsCurrentPlayer00 #
{00$ %
get00& )
;00) *
set00+ .
;00. /
}000 1
public55 
bool55 $
CanBeKickedByCurrentHost55 ,
{55- .
get55/ 2
;552 3
set554 7
;557 8
}559 :
public:: 
ICommand:: 
KickPlayerCommand:: )
{::* +
get::, /
;::/ 0
set::1 4
;::4 5
}::6 7
public<< 
bool<< 
IsOtherPlayer<< !
=><<" $
!<<% &
IsCurrentPlayer<<& 5
;<<5 6
public>> 
bool>> 
IsReady>> 
{?? 	
get@@ 
=>@@ 
_isReady@@ 
;@@ 
setAA 
=>AA 
SetPropertyAA 
(AA 
refAA "
_isReadyAA# +
,AA+ ,
valueAA- 2
)AA2 3
;AA3 4
}BB 	
publicDD 
boolDD 
IsMissionCaptainDD $
{EE 	
getFF 
=>FF 
_isMissionCaptainFF $
;FF$ %
privateGG 
setGG 
=>GG 
SetPropertyGG &
(GG& '
refGG' *
_isMissionCaptainGG+ <
,GG< =
valueGG> C
)GGC D
;GGD E
}HH 	
publicJJ 
intJJ 
WonTrickCountJJ  
{KK 	
getLL 
=>LL 
_wonTrickCountLL !
;LL! "
privateMM 
setMM 
{NN 
ifOO 
(OO 
SetPropertyOO 
(OO  
refOO  #
_wonTrickCountOO$ 2
,OO2 3
valueOO4 9
)OO9 :
)OO: ;
{PP 
OnPropertyChangedQQ %
(QQ% &
nameofQQ& ,
(QQ, -
HasWonTricksQQ- 9
)QQ9 :
)QQ: ;
;QQ; <
}RR 
}SS 
}TT 	
publicVV 
boolVV 
HasWonTricksVV  
=>VV! #
WonTrickCountVV$ 1
>VV2 3
$numVV4 5
;VV5 6
publicXX 
intXX 
?XX 
CommunicatedCardIdXX &
{YY 	
getZZ 
=>ZZ 
_communicatedCardIdZZ &
;ZZ& '
private[[ 
set[[ 
{\\ 
if]] 
(]] 
SetProperty]] 
(]]  
ref]]  #
_communicatedCardId]]$ 7
,]]7 8
value]]9 >
)]]> ?
)]]? @
{^^ 
OnPropertyChanged__ %
(__% &
nameof__& ,
(__, -
HasCommunicatedCard__- @
)__@ A
)__A B
;__B C
}`` 
}aa 
}bb 	
publicdd 
RadioTokenPositiondd !%
CommunicatedTokenPositiondd" ;
{ee 	
getff 
=>ff &
_communicatedTokenPositionff -
;ff- .
privategg 
setgg 
=>gg 
SetPropertygg &
(gg& '
refgg' *&
_communicatedTokenPositiongg+ E
,ggE F
valueggG L
)ggL M
;ggM N
}hh 	
publicjj 
booljj 
HasCommunicatedCardjj '
=>jj( *
CommunicatedCardIdjj+ =
.jj= >
HasValuejj> F
;jjF G
publicll 
voidll "
UpdateCommunicatedCardll *
(ll* +
intll+ .
?ll. /
cardIdll0 6
,ll6 7
RadioTokenPositionll8 J
tokenPositionllK X
)llX Y
{mm 	
CommunicatedCardIdnn 
=nn  
cardIdnn! '
;nn' (%
CommunicatedTokenPositionoo %
=oo& '
tokenPositionoo( 5
;oo5 6
}pp 	
publicrr 
voidrr (
UpdateRemainingHandCardCountrr 0
(rr0 1
intrr1 4"
remainingHandCardCountrr5 K
)rrK L
{ss 	#
_remainingHandCardCounttt #
=tt$ %
Mathtt& *
.tt* +
Maxtt+ .
(tt. /
$numtt/ 0
,tt0 1
Mathtt2 6
.tt6 7
Mintt7 :
(tt: ;'
MaximumVisibleHandCardCounttt; V
,ttV W"
remainingHandCardCountttX n
)ttn o
)tto p
;ttp q
OnPropertyChangeduu 
(uu 
nameofuu $
(uu$ %
HiddenCardSlotsuu% 4
)uu4 5
)uu5 6
;uu6 7
}vv 	
publicxx 
voidxx  
UpdateMissionCaptainxx (
(xx( )
boolxx) -
isMissionCaptainxx. >
)xx> ?
{yy 	
IsMissionCaptainzz 
=zz 
isMissionCaptainzz /
;zz/ 0
}{{ 	
public}} 
void}} 
UpdateCapturedCards}} '
(}}' (
int}}( +
wonTrickCount}}, 9
,}}9 :
IReadOnlyList}}; H
<}}H I
int}}I L
>}}L M

wonCardIds}}N X
)}}X Y
{~~ 	
WonTrickCount 
= 
Math  
.  !
Max! $
($ %
$num% &
,& '
wonTrickCount( 5
)5 6
;6 7
IReadOnlyList
ÄÄ 
<
ÄÄ 
int
ÄÄ 
>
ÄÄ !
confirmedWonCardIds
ÄÄ 2
=
ÄÄ3 4

wonCardIds
ÄÄ5 ?
??
ÄÄ@ B
new
ÄÄC F
int
ÄÄG J
[
ÄÄJ K
$num
ÄÄK L
]
ÄÄL M
;
ÄÄM N
if
ÇÇ 
(
ÇÇ 
!
ÇÇ 

WonCardIds
ÇÇ 
.
ÇÇ 
SequenceEqual
ÇÇ )
(
ÇÇ) *!
confirmedWonCardIds
ÇÇ* =
)
ÇÇ= >
)
ÇÇ> ?
{
ÉÉ 

WonCardIds
ÑÑ 
.
ÑÑ 
Clear
ÑÑ  
(
ÑÑ  !
)
ÑÑ! "
;
ÑÑ" #
foreach
ÖÖ 
(
ÖÖ 
int
ÖÖ 
	wonCardId
ÖÖ &
in
ÖÖ' )!
confirmedWonCardIds
ÖÖ* =
)
ÖÖ= >
{
ÜÜ 

WonCardIds
áá 
.
áá 
Add
áá "
(
áá" #
	wonCardId
áá# ,
)
áá, -
;
áá- .
}
àà 
}
ââ 
}
ää 	
public
åå 
void
åå  
AttachProfileImage
åå &
(
åå& ' 
IProfileImageCache
åå' 9
profileImageCache
åå: K
)
ååK L
{
çç 	
ProfileImage
éé 
?
éé 
.
éé 
Dispose
éé !
(
éé! "
)
éé" #
;
éé# $
ProfileImage
èè 
=
èè 
new
èè #
ProfileImageViewModel
èè 4
(
èè4 5
IdUser
èè5 ;
,
èè; <
profileImageCache
èè= N
)
èèN O
;
èèO P
OnPropertyChanged
êê 
(
êê 
nameof
êê $
(
êê$ %
ProfileImage
êê% 1
)
êê1 2
)
êê2 3
;
êê3 4
}
ëë 	
public
ìì 
void
ìì 
Dispose
ìì 
(
ìì 
)
ìì 
{
îî 	
ProfileImage
ïï 
?
ïï 
.
ïï 
Dispose
ïï !
(
ïï! "
)
ïï" #
;
ïï# $
}
ññ 	
}
òò 
}ôô ﬂ
fC:\Users\oscar\source\repos\TrickTakingMissions\Client\ViewModel\ViewModels\Menu\HowToPlayViewModel.cs
	namespace 	
	ViewModel
 
. 

ViewModels 
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
HowToPlayViewModel

 *
:

+ ,
ViewModelBase

- :
{ 
public 
event 
Action 
RequestClose (
;( )
public 
HowToPlayViewModel !
(! "
)" #
{ 	
CloseCommand 
= 
new 
RelayCommand +
(+ ,
ExecuteClose, 8
)8 9
;9 :
} 	
public 
ICommand 
CloseCommand $
{% &
get' *
;* +
}, -
private 
void 
ExecuteClose !
(! "
)" #
{ 	
RequestClose   
?   
.   
Invoke    
(    !
)  ! "
;  " #
}!! 	
}"" 
}## à$
gC:\Users\oscar\source\repos\TrickTakingMissions\Client\ViewModel\ViewModels\Menu\HomeScreenViewModel.cs
	namespace		 	
	ViewModel		
 
.		 

ViewModels		 
{

 
public 

sealed 
class 
HomeScreenViewModel +
:, -
ViewModelBase. ;
{ 
private 
const 
string (
LogOpenLanguageSelectorError 9
=: ;
$str< e
;e f
private 
readonly 
INavigationService +
_navigationService, >
;> ?
private 
readonly 
ILoggerService '
_logger( /
;/ 0
public 
HomeScreenViewModel "
(" #
INavigationService# 5
navigationService6 G
,G H
ILoggerServiceI W
loggerX ^
)^ _
{ 	
_navigationService 
=  
navigationService! 2
??3 5
throw6 ;
new< ?!
ArgumentNullException@ U
(U V
nameofV \
(\ ]
navigationService] n
)n o
)o p
;p q
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
SignUpCommand   
=   
new   
RelayCommand    ,
(  , -
ExecuteSignUp  - :
)  : ;
;  ; <
LoginCommand!! 
=!! 
new!! 
RelayCommand!! +
(!!+ ,
ExecuteLogin!!, 8
)!!8 9
;!!9 :
GuestCommand"" 
="" 
new"" 
RelayCommand"" +
(""+ ,
ExecuteGuest"", 8
)""8 9
;""9 :!
SelectLanguageCommand## !
=##" #
new##$ '
RelayCommand##( 4
(##4 5!
ExecuteSelectLanguage##5 J
)##J K
;##K L
}$$ 	
public)) 
ICommand)) 
SignUpCommand)) %
{))& '
get))( +
;))+ ,
}))- .
public.. 
ICommand.. 
LoginCommand.. $
{..% &
get..' *
;..* +
}.., -
public33 
ICommand33 
GuestCommand33 $
{33% &
get33' *
;33* +
}33, -
public88 
ICommand88 !
SelectLanguageCommand88 -
{88. /
get880 3
;883 4
}885 6
private:: 
void:: 
ExecuteSignUp:: "
(::" #
)::# $
{;; 	
_navigationService<< 
.<< 

NavigateTo<< )
(<<) *
ViewId<<* 0
.<<0 1
RegisterPage<<1 =
)<<= >
;<<> ?
}== 	
private?? 
void?? 
ExecuteLogin?? !
(??! "
)??" #
{@@ 	
_navigationServiceAA 
.AA 

NavigateToAA )
(AA) *
ViewIdAA* 0
.AA0 1
	LoginPageAA1 :
)AA: ;
;AA; <
}BB 	
privateDD 
voidDD 
ExecuteGuestDD !
(DD! "
)DD" #
{EE 	
UserSessionFF 
.FF 
CurrentFF 
.FF  
EnsureActiveUserIdFF  2
(FF2 3
)FF3 4
;FF4 5
_navigationServiceGG 
.GG 

NavigateToGG )
(GG) *
ViewIdGG* 0
.GG0 1
GameMenuGG1 9
)GG9 :
;GG: ;
}HH 	
privateJJ 
voidJJ !
ExecuteSelectLanguageJJ *
(JJ* +
)JJ+ ,
{KK 	
tryLL 
{MM 
_navigationServiceNN "
.NN" #

ShowDialogNN# -
(NN- .
ViewIdNN. 4
.NN4 5 
SelectLanguageDialogNN5 I
)NNI J
;NNJ K
_navigationServiceOO "
.OO" #

NavigateToOO# -
(OO- .
ViewIdOO. 4
.OO4 5

HomeScreenOO5 ?
)OO? @
;OO@ A
}PP 
catchQQ 
(QQ %
InvalidOperationExceptionQQ ,
exQQ- /
)QQ/ 0
{RR 
_loggerSS 
.SS 
ErrorSS 
(SS 
exSS  
,SS  !(
LogOpenLanguageSelectorErrorSS" >
)SS> ?
;SS? @
}TT 
}UU 	
}VV 
}WW ∑~
iC:\Users\oscar\source\repos\TrickTakingMissions\Client\ViewModel\ViewModels\Menu\GameSettingsViewModel.cs
	namespace 	
	ViewModel
 
. 

ViewModels 
{ 
public 

sealed 
class !
GameSettingsViewModel -
:. /
ViewModelBase0 =
{ 
private 
const 
int 
MinimumPlayerCount ,
=- .
$num/ 0
;0 1
private 
const 
int "
HostRequiredServerCode 0
=1 2
$num3 6
;6 7
private 
const 
int %
MatchInProgressServerCode 3
=4 5
$num6 9
;9 :
private 
const 
int 
MaximumPlayerCount ,
=- .
$num/ 0
;0 1
private 
const 
int 
MinimumMissionCount -
=. /
$num0 1
;1 2
private 
const 
int 
MaximumMissionCount -
=. /
$num0 2
;2 3
private 
const 
int 
DefaultMissionCount -
=. /
$num0 1
;1 2
private 
const 
string (
LogLobbyOperationUnavailable 9
=: ;
$str< v
;v w
private 
const 
string %
LogLobbyOperationRejected 6
=7 8
$str9 {
;{ |
private 
const 
string  
OperationCreateLobby 1
=2 3
$str4 A
;A B
private 
const 
string (
OperationUpdateLobbySettings 9
=: ;
$str< Q
;Q R
private   
readonly   
IDialogService   '
_dialogService  ( 6
;  6 7
private!! 
readonly!! 
ILobbySession!! &
_lobbySession!!' 4
;!!4 5
private"" 
readonly"" 
ILoggerService"" '
_logger""( /
;""/ 0
private## 
int##  
_selectedPlayerCount## (
;##( )
private$$ 
int$$ !
_selectedMissionCount$$ )
;$$) *
private%% 
bool%% 

_isPrivate%% 
;%%  
public'' !
GameSettingsViewModel'' $
(''$ %
IDialogService''% 3
dialogService''4 A
,''A B
ILobbySession''C P
lobbySession''Q ]
,''] ^
ILoggerService''_ m
logger''n t
)''t u
{(( 	
_dialogService)) 
=)) 
dialogService)) *
??))+ -
throw)). 3
new))4 7!
ArgumentNullException))8 M
())M N
nameof))N T
())T U
dialogService))U b
)))b c
)))c d
;))d e
_lobbySession** 
=** 
lobbySession** (
??**) +
throw**, 1
new**2 5!
ArgumentNullException**6 K
(**K L
nameof**L R
(**R S
lobbySession**S _
)**_ `
)**` a
;**a b
_logger++ 
=++ 
logger++ 
??++ 
throw++  %
new++& )!
ArgumentNullException++* ?
(++? @
nameof++@ F
(++F G
logger++G M
)++M N
)++N O
;++O P!
AvailablePlayerCounts-- !
=--" #
new--$ '
List--( ,
<--, -
int--- 0
>--0 1
{--2 3
MinimumPlayerCount--4 F
,--F G
MaximumPlayerCount--H Z
}--[ \
;--\ ] 
_selectedPlayerCount..  
=..! "
MaximumPlayerCount..# 5
;..5 6"
AvailableMissionCounts00 "
=00# $
new00% (
List00) -
<00- .
int00. 1
>001 2
(002 3
)003 4
;004 5
for11 
(11 
int11 
count11 
=11 
MinimumMissionCount11 0
;110 1
count112 7
<=118 :
MaximumMissionCount11; N
;11N O
count11P U
++11U W
)11W X
{22 "
AvailableMissionCounts33 &
.33& '
Add33' *
(33* +
count33+ 0
)330 1
;331 2
}44 !
_selectedMissionCount66 !
=66" #
DefaultMissionCount66$ 7
;667 8

_isPrivate77 
=77 
true77 
;77 )
LoadCurrentLobbyConfiguration88 )
(88) *
)88* +
;88+ ,
CloseCommand:: 
=:: 
new:: 
RelayCommand:: +
(::+ ,
ExecuteClose::, 8
)::8 9
;::9 :
ConfirmCommand;; 
=;; 
new;;  
AsyncRelayCommand;;! 2
(;;2 3
ExecuteConfirmAsync;;3 F
);;F G
;;;G H
}<< 	
public>> 
event>> 
Action>> 
<>> 
bool>>  
>>>  !
RequestClose>>" .
;>>. /
public@@ 
List@@ 
<@@ 
int@@ 
>@@ !
AvailablePlayerCounts@@ .
{@@/ 0
get@@1 4
;@@4 5
}@@6 7
publicBB 
intBB 
SelectedPlayerCountBB &
{CC 	
getDD 
=>DD  
_selectedPlayerCountDD '
;DD' (
setEE 
=>EE 
SetPropertyEE 
(EE 
refEE " 
_selectedPlayerCountEE# 7
,EE7 8
valueEE9 >
)EE> ?
;EE? @
}FF 	
publicHH 
ListHH 
<HH 
intHH 
>HH "
AvailableMissionCountsHH /
{HH0 1
getHH2 5
;HH5 6
}HH7 8
publicJJ 
intJJ  
SelectedMissionCountJJ '
{KK 	
getLL 
=>LL !
_selectedMissionCountLL (
;LL( )
setMM 
=>MM 
SetPropertyMM 
(MM 
refMM "!
_selectedMissionCountMM# 8
,MM8 9
valueMM: ?
)MM? @
;MM@ A
}NN 	
publicPP 
boolPP 
	IsPrivatePP 
{QQ 	
getRR 
=>RR 

_isPrivateRR 
;RR 
setSS 
{TT 
SetPropertyUU 
(UU 
refUU 

_isPrivateUU  *
,UU* +
valueUU, 1
)UU1 2
;UU2 3
OnPropertyChangedVV !
(VV! "
nameofVV" (
(VV( )
IsPublicVV) 1
)VV1 2
)VV2 3
;VV3 4
}WW 
}XX 	
publicZZ 
boolZZ 
IsPublicZZ 
{[[ 	
get\\ 
=>\\ 
!\\ 
	IsPrivate\\ 
;\\ 
set]] 
=>]] 
	IsPrivate]] 
=]] 
!]]  
value]]  %
;]]% &
}^^ 	
public`` 
ICommand`` 
CloseCommand`` $
{``% &
get``' *
;``* +
}``, -
publicbb 
ICommandbb 
ConfirmCommandbb &
{bb' (
getbb) ,
;bb, -
}bb. /
privatedd 
voiddd 
ExecuteClosedd !
(dd! "
)dd" #
{ee 	
RequestCloseff 
?ff 
.ff 
Invokeff  
(ff  !
falseff! &
)ff& '
;ff' (
}gg 	
privateii 
asyncii 
Taskii 
ExecuteConfirmAsyncii .
(ii. /
)ii/ 0
{jj 	
ifkk 
(kk 
_lobbySessionkk 
.kk 
HasActiveLobbykk ,
)kk, -
{ll 
awaitmm #
UpdateCurrentLobbyAsyncmm -
(mm- .
)mm. /
;mm/ 0
}nn 
elseoo 
{pp 
awaitqq 
CreateNewLobbyAsyncqq )
(qq) *
)qq* +
;qq+ ,
}rr 
}ss 	
privateuu 
voiduu )
LoadCurrentLobbyConfigurationuu 2
(uu2 3
)uu3 4
{vv 	
Lobbyww 
activeLobbyww 
=ww 
_lobbySessionww  -
.ww- .
CurrentLobbyww. :
;ww: ;
ifxx 
(xx 
activeLobbyxx 
!=xx 
nullxx #
)xx# $
{yy 
SelectedPlayerCountzz #
=zz$ %
activeLobbyzz& 1
.zz1 2
PlayerLimitzz2 =
;zz= > 
SelectedMissionCount{{ $
={{% &
activeLobby{{' 2
.{{2 3
TargetMissionCount{{3 E
;{{E F
	IsPrivate|| 
=|| 
activeLobby|| '
.||' (
	IsPrivate||( 1
;||1 2
}}} 
}~~ 	
private
ÄÄ 
LobbySettings
ÄÄ (
BuildSelectedLobbySettings
ÄÄ 8
(
ÄÄ8 9
)
ÄÄ9 :
{
ÅÅ 	
return
ÇÇ 
new
ÇÇ 
LobbySettings
ÇÇ $
{
ÉÉ 
PlayerLimit
ÑÑ 
=
ÑÑ 
(
ÑÑ 
byte
ÑÑ #
)
ÑÑ# $!
SelectedPlayerCount
ÑÑ$ 7
,
ÑÑ7 8 
TargetMissionCount
ÖÖ "
=
ÖÖ# $
(
ÖÖ% &
byte
ÖÖ& *
)
ÖÖ* +"
SelectedMissionCount
ÖÖ+ ?
,
ÖÖ? @
	IsPrivate
ÜÜ 
=
ÜÜ 
	IsPrivate
ÜÜ %
}
áá 
;
áá 
}
àà 	
private
ää 
async
ää 
Task
ää %
UpdateCurrentLobbyAsync
ää 2
(
ää2 3
)
ää3 4
{
ãã 	
LobbyResult
åå !
configurationUpdate
åå +
=
åå, -
await
åå. 3
_lobbySession
åå4 A
.
ååA B
Client
ååB H
.
ååH I&
UpdateLobbySettingsAsync
ååI a
(
ååa b
_lobbySession
çç 
.
çç 
CurrentLobby
çç *
.
çç* +
	LobbyCode
çç+ 4
,
çç4 5
UserSession
çç6 A
.
ççA B
Current
ççB I
.
ççI J 
EnsureActiveUserId
ççJ \
(
çç\ ]
)
çç] ^
,
çç^ _(
BuildSelectedLobbySettings
éé *
(
éé* +
)
éé+ ,
)
éé, -
;
éé- .
if
èè 
(
èè !
configurationUpdate
èè #
?
èè# $
.
èè$ %
	IsSuccess
èè% .
==
èè/ 1
true
èè2 6
&&
èè7 9!
configurationUpdate
èè: M
.
èèM N
Lobby
èèN S
!=
èèT V
null
èèW [
)
èè[ \
{
êê 
_lobbySession
ëë 
.
ëë 
SetLobby
ëë &
(
ëë& '!
configurationUpdate
ëë' :
.
ëë: ;
Lobby
ëë; @
)
ëë@ A
;
ëëA B
RequestClose
íí 
?
íí 
.
íí 
Invoke
íí $
(
íí$ %
true
íí% )
)
íí) *
;
íí* +
}
ìì 
else
îî 
{
ïï (
ShowConfigurationRejection
ññ *
(
ññ* +!
configurationUpdate
ññ+ >
)
ññ> ?
;
ññ? @
}
óó 
}
òò 	
private
öö 
void
öö (
ShowConfigurationRejection
öö /
(
öö/ 0
LobbyResult
öö0 ;!
configurationUpdate
öö< O
)
ööO P
{
õõ 	
int
úú $
configurationErrorCode
úú &
=
úú' (
MessageCode
úú) 4
.
úú4 5
ConnectionFailed
úú5 E
;
úúE F
if
ùù 
(
ùù !
configurationUpdate
ùù #
!=
ùù$ &
null
ùù' +
)
ùù+ ,
{
ûû 
_logger
üü 
.
üü 
Warning
üü 
(
üü  '
LogLobbyOperationRejected
üü  9
,
üü9 :*
OperationUpdateLobbySettings
üü; W
,
üüW X!
configurationUpdate
üüY l
.
üül m
	ErrorCode
üüm v
)
üüv w
;
üüw x$
configurationErrorCode
†† &
=
††' (
MessageCode
††) 4
.
††4 5'
LobbyConfigurationInvalid
††5 N
;
††N O
if
°° 
(
°° !
configurationUpdate
°° '
.
°°' (
	ErrorCode
°°( 1
==
°°2 4$
HostRequiredServerCode
°°5 K
)
°°K L
{
¢¢ $
configurationErrorCode
££ *
=
££+ ,
MessageCode
££- 8
.
££8 9
LobbyHostRequired
££9 J
;
££J K
}
§§ 
else
•• 
if
•• 
(
•• !
configurationUpdate
•• ,
.
••, -
	ErrorCode
••- 6
==
••7 9'
MatchInProgressServerCode
••: S
)
••S T
{
¶¶ $
configurationErrorCode
ßß *
=
ßß+ ,
MessageCode
ßß- 8
.
ßß8 9"
LobbyMatchInProgress
ßß9 M
;
ßßM N
}
®® 
}
©© 
else
™™ 
{
´´ 
_logger
¨¨ 
.
¨¨ 
Error
¨¨ 
(
¨¨ *
LogLobbyOperationUnavailable
¨¨ :
,
¨¨: ;*
OperationUpdateLobbySettings
¨¨< X
)
¨¨X Y
;
¨¨Y Z
}
≠≠ 
_dialogService
ØØ 
.
ØØ 
ShowWarning
ØØ &
(
ØØ& '$
configurationErrorCode
ØØ' =
)
ØØ= >
;
ØØ> ?
}
∞∞ 	
private
≤≤ 
async
≤≤ 
Task
≤≤ !
CreateNewLobbyAsync
≤≤ .
(
≤≤. /
)
≤≤/ 0
{
≥≥ 	
int
¥¥ 

hostUserId
¥¥ 
=
¥¥ 
UserSession
¥¥ (
.
¥¥( )
Current
¥¥) 0
.
¥¥0 1 
EnsureActiveUserId
¥¥1 C
(
¥¥C D
)
¥¥D E
;
¥¥E F
LobbyResult
∂∂ 
result
∂∂ 
=
∂∂  
await
∂∂! &
_lobbySession
∂∂' 4
.
∂∂4 5
Client
∂∂5 ;
.
∂∂; <
CreateLobbyAsync
∂∂< L
(
∂∂L M

hostUserId
∑∑ 
,
∑∑ (
BuildSelectedLobbySettings
∑∑ 6
(
∑∑6 7
)
∑∑7 8
)
∑∑8 9
;
∑∑9 :
if
ππ 
(
ππ 
result
ππ 
==
ππ 
null
ππ 
)
ππ 
{
∫∫ 
_logger
ªª 
.
ªª 
Error
ªª 
(
ªª *
LogLobbyOperationUnavailable
ªª :
,
ªª: ;"
OperationCreateLobby
ªª< P
)
ªªP Q
;
ªªQ R
_dialogService
ºº 
.
ºº 
	ShowError
ºº (
(
ºº( )
MessageCode
ºº) 4
.
ºº4 5
ConnectionFailed
ºº5 E
)
ººE F
;
ººF G
}
ΩΩ 
else
ææ 
if
ææ 
(
ææ 
!
ææ 
result
ææ 
.
ææ 
	IsSuccess
ææ &
||
ææ' )
result
ææ* 0
.
ææ0 1
Lobby
ææ1 6
==
ææ7 9
null
ææ: >
)
ææ> ?
{
øø 
_logger
¿¿ 
.
¿¿ 
Warning
¿¿ 
(
¿¿  '
LogLobbyOperationRejected
¿¿  9
,
¿¿9 :"
OperationCreateLobby
¿¿; O
,
¿¿O P
result
¿¿Q W
.
¿¿W X
	ErrorCode
¿¿X a
)
¿¿a b
;
¿¿b c
_dialogService
¡¡ 
.
¡¡ 
ShowWarning
¡¡ *
(
¡¡* +
MessageCode
¡¡+ 6
.
¡¡6 7
UnexpectedError
¡¡7 F
)
¡¡F G
;
¡¡G H
}
¬¬ 
else
√√ 
{
ƒƒ 
_lobbySession
≈≈ 
.
≈≈ 
SetLobby
≈≈ &
(
≈≈& '
result
≈≈' -
.
≈≈- .
Lobby
≈≈. 3
)
≈≈3 4
;
≈≈4 5
RequestClose
∆∆ 
?
∆∆ 
.
∆∆ 
Invoke
∆∆ $
(
∆∆$ %
true
∆∆% )
)
∆∆) *
;
∆∆* +
}
«« 
}
»» 	
}
…… 
}   âY
eC:\Users\oscar\source\repos\TrickTakingMissions\Client\ViewModel\ViewModels\Menu\GameMenuViewModel.cs
	namespace 	
	ViewModel
 
. 

ViewModels 
{ 
public 

sealed 
class 
GameMenuViewModel )
:* +
ViewModelBase, 9
,9 :
IDisposable; F
{ 
private 
const 
string !
LogDialogDisplayError 2
=3 4
$str5 _
;_ `
private 
readonly 
INavigationService +
_navigationService, >
;> ?
private 
readonly 
ILobbySession &
_lobbySession' 4
;4 5
private 
readonly 
ILoggerService '
_logger( /
;/ 0
private 
string 
	_username  
;  !
public 
GameMenuViewModel  
(  !
INavigationService! 3
navigationService4 E
,E F
ILobbySessionG T
lobbySessionU a
,a b
ILoggerService   
logger   !
)  ! "
{!! 	
_navigationService"" 
=""  
navigationService""! 2
??""3 5
throw""6 ;
new""< ?!
ArgumentNullException""@ U
(""U V
nameof""V \
(""\ ]
navigationService""] n
)""n o
)""o p
;""p q
_lobbySession## 
=## 
lobbySession## (
??##) +
throw##, 1
new##2 5!
ArgumentNullException##6 K
(##K L
nameof##L R
(##R S
lobbySession##S _
)##_ `
)##` a
;##a b
_logger$$ 
=$$ 
logger$$ 
??$$ 
throw$$  %
new$$& )!
ArgumentNullException$$* ?
($$? @
nameof$$@ F
($$F G
logger$$G M
)$$M N
)$$N O
;$$O P
LoadCurrentUsername&& 
(&&  
)&&  !
;&&! "
ProfileCommand(( 
=(( 
new((  
RelayCommand((! -
(((- .
ExecuteProfile((. <
)((< =
;((= >
ScoreBoardCommand)) 
=)) 
new))  #
RelayCommand))$ 0
())0 1
ExecuteScoreBoard))1 B
)))B C
;))C D
CreateRoomCommand** 
=** 
new**  #
RelayCommand**$ 0
(**0 1
ExecuteCreateRoom**1 B
)**B C
;**C D
JoinLobbyCommand++ 
=++ 
new++ "
RelayCommand++# /
(++/ 0
ExecuteJoinLobby++0 @
)++@ A
;++A B
HowToPlayCommand,, 
=,, 
new,, "
RelayCommand,,# /
(,,/ 0
ExecuteHowToPlay,,0 @
),,@ A
;,,A B
SignOutCommand-- 
=-- 
new--  
AsyncRelayCommand--! 2
(--2 3
ExecuteSignOutAsync--3 F
)--F G
;--G H
}.. 	
public33 
string33 
Username33 
{44 	
get55 
=>55 
	_username55 
;55 
set66 
=>66 
SetProperty66 
(66 
ref66 "
	_username66# ,
,66, -
value66. 3
)663 4
;664 5
}77 	
public<< 
ICommand<< 
ProfileCommand<< &
{<<' (
get<<) ,
;<<, -
}<<. /
publicAA 
ICommandAA 
ScoreBoardCommandAA )
{AA* +
getAA, /
;AA/ 0
}AA1 2
publicFF 
ICommandFF 
CreateRoomCommandFF )
{FF* +
getFF, /
;FF/ 0
}FF1 2
publicKK 
ICommandKK 
JoinLobbyCommandKK (
{KK) *
getKK+ .
;KK. /
}KK0 1
publicPP 
ICommandPP 
HowToPlayCommandPP (
{PP) *
getPP+ .
;PP. /
}PP0 1
publicUU 
ICommandUU 
SignOutCommandUU &
{UU' (
getUU) ,
;UU, -
}UU. /
publicWW !
ProfileImageViewModelWW $%
CurrentPlayerProfileImageWW% >
{WW? @
getWWA D
;WWD E
privateWWF M
setWWN Q
;WWQ R
}WWS T
publicYY 
voidYY "
ConfigureProfileImagesYY *
(YY* +
IProfileImageCacheYY+ =
profileImageCacheYY> O
)YYO P
{ZZ 	%
CurrentPlayerProfileImage[[ %
?[[% &
.[[& '
Dispose[[' .
([[. /
)[[/ 0
;[[0 1%
CurrentPlayerProfileImage\\ %
=\\& '
new\\( +!
ProfileImageViewModel\\, A
(\\A B
UserSession\\B M
.\\M N
Current\\N U
.\\U V
EnsureActiveUserId\\V h
(\\h i
)\\i j
,\\j k
profileImageCache]] !
)]]! "
;]]" #
OnPropertyChanged^^ 
(^^ 
nameof^^ $
(^^$ %%
CurrentPlayerProfileImage^^% >
)^^> ?
)^^? @
;^^@ A
}__ 	
publicaa 
voidaa 
Disposeaa 
(aa 
)aa 
{bb 	%
CurrentPlayerProfileImagecc %
?cc% &
.cc& '
Disposecc' .
(cc. /
)cc/ 0
;cc0 1
}dd 	
privateff 
voidff 
LoadCurrentUsernameff (
(ff( )
)ff) *
{gg 	
UserSessionDatahh 
currentUserhh '
=hh( )
UserSessionhh* 5
.hh5 6
Currenthh6 =
.hh= >
CurrentUserhh> I
;hhI J
ifii 
(ii 
currentUserii 
!=ii 
nullii #
&&ii$ &
!ii' (
stringii( .
.ii. /
IsNullOrWhiteSpaceii/ A
(iiA B
currentUseriiB M
.iiM N
UsernameiiN V
)iiV W
)iiW X
{jj 
Usernamekk 
=kk 
currentUserkk &
.kk& '
Usernamekk' /
;kk/ 0
}ll 
elsemm 
{nn 
Usernameoo 
=oo 
stringoo !
.oo! "
Emptyoo" '
;oo' (
}pp 
}qq 	
privatess 
voidss 
ExecuteProfiless #
(ss# $
)ss$ %
{tt 	
_navigationServiceuu 
.uu 

NavigateTouu )
(uu) *
ViewIduu* 0
.uu0 1
Profileuu1 8
)uu8 9
;uu9 :
}vv 	
privatexx 
voidxx 
ExecuteScoreBoardxx &
(xx& '
)xx' (
{yy 	!
ShowModalDialogSafelyzz !
(zz! "
ViewIdzz" (
.zz( )
ScoreBoardDialogzz) 9
,zz9 :
nullzz; ?
)zz? @
;zz@ A
}{{ 	
private}} 
void}} 
ExecuteCreateRoom}} &
(}}& '
)}}' (
{~~ 	
_lobbySession 
. 

ClearLobby $
($ %
)% &
;& '#
ShowModalDialogSafely
ÄÄ !
(
ÄÄ! "
ViewId
ÄÄ" (
.
ÄÄ( ) 
GameSettingsDialog
ÄÄ) ;
,
ÄÄ; <,
NavigateToActiveLobbyIfPresent
ÄÄ= [
)
ÄÄ[ \
;
ÄÄ\ ]
}
ÅÅ 	
private
ÉÉ 
void
ÉÉ 
ExecuteJoinLobby
ÉÉ %
(
ÉÉ% &
)
ÉÉ& '
{
ÑÑ 	
_lobbySession
ÖÖ 
.
ÖÖ 

ClearLobby
ÖÖ $
(
ÖÖ$ %
)
ÖÖ% &
;
ÖÖ& '#
ShowModalDialogSafely
ÜÜ !
(
ÜÜ! "
ViewId
ÜÜ" (
.
ÜÜ( )!
EnterGameCodeDialog
ÜÜ) <
,
ÜÜ< =,
NavigateToActiveLobbyIfPresent
ÜÜ> \
)
ÜÜ\ ]
;
ÜÜ] ^
}
áá 	
private
ââ 
void
ââ 
ExecuteHowToPlay
ââ %
(
ââ% &
)
ââ& '
{
ää 	#
ShowModalDialogSafely
ãã !
(
ãã! "
ViewId
ãã" (
.
ãã( )
HowToPlayDialog
ãã) 8
,
ãã8 9
null
ãã: >
)
ãã> ?
;
ãã? @
}
åå 	
private
éé 
void
éé ,
NavigateToActiveLobbyIfPresent
éé 3
(
éé3 4
)
éé4 5
{
èè 	
if
êê 
(
êê 
_lobbySession
êê 
.
êê 
HasActiveLobby
êê ,
)
êê, -
{
ëë  
_navigationService
íí "
.
íí" #

NavigateTo
íí# -
(
íí- .
ViewId
íí. 4
.
íí4 5
Lobby
íí5 :
)
íí: ;
;
íí; <
}
ìì 
}
îî 	
private
ññ 
void
ññ #
ShowModalDialogSafely
ññ *
(
ññ* +
int
ññ+ .
dialogViewId
ññ/ ;
,
ññ; <
Action
ññ= C
onDialogCompleted
ññD U
)
ññU V
{
óó 	
try
òò 
{
ôô  
_navigationService
öö "
.
öö" #

ShowDialog
öö# -
(
öö- .
dialogViewId
öö. :
)
öö: ;
;
öö; <
onDialogCompleted
õõ !
?
õõ! "
.
õõ" #
Invoke
õõ# )
(
õõ) *
)
õõ* +
;
õõ+ ,
}
úú 
catch
ùù 
(
ùù '
InvalidOperationException
ùù ,
ex
ùù- /
)
ùù/ 0
{
ûû 
_logger
üü 
.
üü 
Error
üü 
(
üü 
ex
üü  
,
üü  !#
LogDialogDisplayError
üü" 7
,
üü7 8
dialogViewId
üü9 E
)
üüE F
;
üüF G
}
†† 
}
°° 	
private
££ 
async
££ 
Task
££ !
ExecuteSignOutAsync
££ .
(
££. /
)
££/ 0
{
§§ 	
UserSessionData
•• 
currentUser
•• '
=
••( )
UserSession
••* 5
.
••5 6
Current
••6 =
.
••= >
CurrentUser
••> I
;
••I J
if
¶¶ 
(
¶¶ 
currentUser
¶¶ 
!=
¶¶ 
null
¶¶ #
&&
¶¶$ &
currentUser
¶¶' 2
.
¶¶2 3
IdUser
¶¶3 9
>
¶¶: ;
$num
¶¶< =
)
¶¶= >
{
ßß 
await
®® 
FriendshipSession
®® '
.
®®' (
Current
®®( /
.
®®/ 0
Client
®®0 6
.
®®6 7*
UnsubscribeSocialEventsAsync
®®7 S
(
®®S T
currentUser
®®T _
.
®®_ `
IdUser
®®` f
)
®®f g
;
®®g h
}
©© 
FriendshipSession
´´ 
.
´´ 
Current
´´ %
.
´´% &
ClearSession
´´& 2
(
´´2 3
)
´´3 4
;
´´4 5
UserSession
¨¨ 
.
¨¨ 
Current
¨¨ 
.
¨¨  
ClearSession
¨¨  ,
(
¨¨, -
)
¨¨- .
;
¨¨. / 
_navigationService
≠≠ 
.
≠≠ 

NavigateTo
≠≠ )
(
≠≠) *
ViewId
≠≠* 0
.
≠≠0 1

HomeScreen
≠≠1 ;
)
≠≠; <
;
≠≠< =
}
ÆÆ 	
}
ØØ 
}∞∞ ∫¢
gC:\Users\oscar\source\repos\TrickTakingMissions\Client\ViewModel\ViewModels\Match\GameMatchViewModel.cs
	namespace 	
	ViewModel
 
. 

ViewModels 
{ 
public 

sealed 
class 
GameMatchViewModel *
:+ ,
ViewModelBase- :
,: ;
IDisposable< G
{ 
private 
const 
int "
DefaultStartingMission 0
=1 2
$num3 4
;4 5
private 
const 
int !
DefaultTargetMissions /
=0 1
$num2 4
;4 5
private 
const 
int  
DefaultStartingTrick .
=/ 0
$num1 2
;2 3
private 
const 
int #
DefaultTricksPerMission 1
=2 3
$num4 5
;5 6
private 
const 
string '
LogOpenHowToPlayDialogError 8
=9 :
$str; l
;l m
private 
readonly 
INavigationService +
_navigationService, >
;> ?
private 
readonly 
ILobbySession &
_lobbySession' 4
;4 5
private 
readonly 
ILoggerService '
_logger( /
;/ 0
private 
readonly 
int 
_currentUserId +
;+ ,
private!! 
int!! !
_currentMissionNumber!! )
;!!) *
private"" 
int"" 
_targetMissionCount"" '
;""' (
private## 
int## 
_currentTrickNumber## '
;##' (
private$$ 
int$$ 
_totalTricksCount$$ %
;$$% &
private%% $
LobbyPlayerItemViewModel%% (
_bottomPlayer%%) 6
;%%6 7
private&& $
LobbyPlayerItemViewModel&& (
_leftPlayer&&) 4
;&&4 5
private'' $
LobbyPlayerItemViewModel'' (

_topPlayer'') 3
;''3 4
private(( $
LobbyPlayerItemViewModel(( (
_rightPlayer(() 5
;((5 6
public** 
GameMatchViewModel** !
(**! "
INavigationService++ 
navigationService++ 0
,++0 1
ILobbySession,, 
lobbySession,, &
,,,& '
ILoggerService-- 
logger-- !
)--! "
{.. 	
_navigationService// 
=//  
navigationService//! 2
??//3 5
throw//6 ;
new//< ?!
ArgumentNullException//@ U
(//U V
nameof//V \
(//\ ]
navigationService//] n
)//n o
)//o p
;//p q
_lobbySession00 
=00 
lobbySession00 (
??00) +
throw00, 1
new002 5!
ArgumentNullException006 K
(00K L
nameof00L R
(00R S
lobbySession00S _
)00_ `
)00` a
;00a b
_logger11 
=11 
logger11 
??11 
throw11  %
new11& )!
ArgumentNullException11* ?
(11? @
nameof11@ F
(11F G
logger11G M
)11M N
)11N O
;11O P
_currentUserId22 
=22 
UserSession22 (
.22( )
Current22) 0
.220 1
EnsureActiveUserId221 C
(22C D
)22D E
;22E F!
_currentMissionNumber44 !
=44" #"
DefaultStartingMission44$ :
;44: ;
_targetMissionCount55 
=55  !!
DefaultTargetMissions55" 7
;557 8
_currentTrickNumber66 
=66  ! 
DefaultStartingTrick66" 6
;666 7
_totalTricksCount77 
=77 #
DefaultTricksPerMission77  7
;777 8
Players99 
=99 
new99  
ObservableCollection99 .
<99. /$
LobbyPlayerItemViewModel99/ G
>99G H
(99H I
)99I J
;99J K
HowToPlayCommand:: 
=:: 
new:: "
RelayCommand::# /
(::/ 0
ExecuteHowToPlay::0 @
)::@ A
;::A B$
LoadTransportedLobbyData<< $
(<<$ %
)<<% &
;<<& '
}== 	
public??  
ObservableCollection?? #
<??# $$
LobbyPlayerItemViewModel??$ <
>??< =
Players??> E
{??F G
get??H K
;??K L
}??M N
publicAA 
intAA  
CurrentMissionNumberAA '
{BB 	
getCC 
=>CC !
_currentMissionNumberCC (
;CC( )
setDD 
{EE 
ifFF 
(FF 
SetPropertyFF 
(FF  
refFF  #!
_currentMissionNumberFF$ 9
,FF9 :
valueFF; @
)FF@ A
)FFA B
{GG 
OnPropertyChangedHH %
(HH% &
nameofHH& ,
(HH, -"
MissionProgressDisplayHH- C
)HHC D
)HHD E
;HHE F
}II 
}JJ 
}KK 	
publicMM 
intMM 
TargetMissionCountMM %
{NN 	
getOO 
=>OO 
_targetMissionCountOO &
;OO& '
setPP 
{QQ 
ifRR 
(RR 
SetPropertyRR 
(RR  
refRR  #
_targetMissionCountRR$ 7
,RR7 8
valueRR9 >
)RR> ?
)RR? @
{SS 
OnPropertyChangedTT %
(TT% &
nameofTT& ,
(TT, -"
MissionProgressDisplayTT- C
)TTC D
)TTD E
;TTE F
}UU 
}VV 
}WW 	
publicYY 
stringYY "
MissionProgressDisplayYY ,
=>YY- /
stringYY0 6
.YY6 7
FormatYY7 =
(YY= >
CultureInfoYY> I
.YYI J
InvariantCultureYYJ Z
,YYZ [
$strYY\ e
,YYe f 
CurrentMissionNumberZZ  
,ZZ  !
TargetMissionCountZZ" 4
)ZZ4 5
;ZZ5 6
public\\ 
int\\ 
CurrentTrickNumber\\ %
{]] 	
get^^ 
=>^^ 
_currentTrickNumber^^ &
;^^& '
set__ 
{`` 
ifaa 
(aa 
SetPropertyaa 
(aa  
refaa  #
_currentTrickNumberaa$ 7
,aa7 8
valueaa9 >
)aa> ?
)aa? @
{bb 
OnPropertyChangedcc %
(cc% &
nameofcc& ,
(cc, - 
TrickProgressDisplaycc- A
)ccA B
)ccB C
;ccC D
}dd 
}ee 
}ff 	
publichh 
inthh 
TotalTricksCounthh #
{ii 	
getjj 
=>jj 
_totalTricksCountjj $
;jj$ %
setkk 
{ll 
ifmm 
(mm 
SetPropertymm 
(mm  
refmm  #
_totalTricksCountmm$ 5
,mm5 6
valuemm7 <
)mm< =
)mm= >
{nn 
OnPropertyChangedoo %
(oo% &
nameofoo& ,
(oo, - 
TrickProgressDisplayoo- A
)ooA B
)ooB C
;ooC D
}pp 
}qq 
}rr 	
publictt 
stringtt  
TrickProgressDisplaytt *
=>tt+ -
stringtt. 4
.tt4 5
Formattt5 ;
(tt; <
CultureInfott< G
.ttG H
InvariantCulturettH X
,ttX Y
$strttZ c
,ttc d
CurrentTrickNumberuu 
,uu 
TotalTricksCountuu  0
)uu0 1
;uu1 2
publicww $
LobbyPlayerItemViewModelww '
BottomPlayerww( 4
{xx 	
getyy 
=>yy 
_bottomPlayeryy  
;yy  !
privatezz 
setzz 
{{{ 
if|| 
(|| 
SetProperty|| 
(||  
ref||  #
_bottomPlayer||$ 1
,||1 2
value||3 8
)||8 9
)||9 :
{}} 
OnPropertyChanged~~ %
(~~% &
nameof~~& ,
(~~, -
HasBottomPlayer~~- <
)~~< =
)~~= >
;~~> ?
} 
}
ÄÄ 
}
ÅÅ 	
public
ÉÉ &
LobbyPlayerItemViewModel
ÉÉ '

LeftPlayer
ÉÉ( 2
{
ÑÑ 	
get
ÖÖ 
=>
ÖÖ 
_leftPlayer
ÖÖ 
;
ÖÖ 
private
ÜÜ 
set
ÜÜ 
{
áá 
if
àà 
(
àà 
SetProperty
àà 
(
àà  
ref
àà  #
_leftPlayer
àà$ /
,
àà/ 0
value
àà1 6
)
àà6 7
)
àà7 8
{
ââ 
OnPropertyChanged
ää %
(
ää% &
nameof
ää& ,
(
ää, -
HasLeftPlayer
ää- :
)
ää: ;
)
ää; <
;
ää< =
}
ãã 
}
åå 
}
çç 	
public
èè &
LobbyPlayerItemViewModel
èè '
	TopPlayer
èè( 1
{
êê 	
get
ëë 
=>
ëë 

_topPlayer
ëë 
;
ëë 
private
íí 
set
íí 
{
ìì 
if
îî 
(
îî 
SetProperty
îî 
(
îî  
ref
îî  #

_topPlayer
îî$ .
,
îî. /
value
îî0 5
)
îî5 6
)
îî6 7
{
ïï 
OnPropertyChanged
ññ %
(
ññ% &
nameof
ññ& ,
(
ññ, -
HasTopPlayer
ññ- 9
)
ññ9 :
)
ññ: ;
;
ññ; <
}
óó 
}
òò 
}
ôô 	
public
õõ &
LobbyPlayerItemViewModel
õõ '
RightPlayer
õõ( 3
{
úú 	
get
ùù 
=>
ùù 
_rightPlayer
ùù 
;
ùù  
private
ûû 
set
ûû 
{
üü 
if
†† 
(
†† 
SetProperty
†† 
(
††  
ref
††  #
_rightPlayer
††$ 0
,
††0 1
value
††2 7
)
††7 8
)
††8 9
{
°° 
OnPropertyChanged
¢¢ %
(
¢¢% &
nameof
¢¢& ,
(
¢¢, -
HasRightPlayer
¢¢- ;
)
¢¢; <
)
¢¢< =
;
¢¢= >
}
££ 
}
§§ 
}
•• 	
public
ßß 
bool
ßß 
HasBottomPlayer
ßß #
=>
ßß$ &
BottomPlayer
ßß' 3
!=
ßß4 6
null
ßß7 ;
;
ßß; <
public
©© 
bool
©© 
HasLeftPlayer
©© !
=>
©©" $

LeftPlayer
©©% /
!=
©©0 2
null
©©3 7
;
©©7 8
public
´´ 
bool
´´ 
HasTopPlayer
´´  
=>
´´! #
	TopPlayer
´´$ -
!=
´´. 0
null
´´1 5
;
´´5 6
public
≠≠ 
bool
≠≠ 
HasRightPlayer
≠≠ "
=>
≠≠# %
RightPlayer
≠≠& 1
!=
≠≠2 4
null
≠≠5 9
;
≠≠9 :
public
ØØ 
ICommand
ØØ 
HowToPlayCommand
ØØ (
{
ØØ) *
get
ØØ+ .
;
ØØ. /
}
ØØ0 1
public
±± !
MatchBoardViewModel
±± "

MatchBoard
±±# -
{
±±. /
get
±±0 3
;
±±3 4
private
±±5 <
set
±±= @
;
±±@ A
}
±±B C
public
≥≥ 
void
≥≥ 
ConfigureMatch
≥≥ "
(
≥≥" #
IMatchClient
≥≥# /
matchClient
≥≥0 ;
)
≥≥; <
{
¥¥ 	

MatchBoard
µµ 
?
µµ 
.
µµ 
Dispose
µµ 
(
µµ  
)
µµ  !
;
µµ! "
MatchBoardContext
∂∂ 
context
∂∂ %
=
∂∂& '
new
∂∂( +
MatchBoardContext
∂∂, =
(
∂∂= >
_lobbySession
∂∂> K
.
∂∂K L
CurrentLobby
∂∂L X
.
∂∂X Y
	LobbyCode
∂∂Y b
,
∂∂b c
_currentUserId
∂∂d r
,
∂∂r s
matchClient
∑∑ 
)
∑∑ 
;
∑∑ 

MatchBoard
∏∏ 
=
∏∏ 
new
∏∏ !
MatchBoardViewModel
∏∏ 0
(
∏∏0 1
context
∏∏1 8
,
∏∏8 9
_logger
∏∏: A
)
∏∏A B
;
∏∏B C

MatchBoard
ππ 
.
ππ '
ConfigureParticipantNames
ππ 0
(
ππ0 1
Players
ππ1 8
)
ππ8 9
;
ππ9 :
OnPropertyChanged
∫∫ 
(
∫∫ 
nameof
∫∫ $
(
∫∫$ %

MatchBoard
∫∫% /
)
∫∫/ 0
)
∫∫0 1
;
∫∫1 2
_
ªª 
=
ªª 

MatchBoard
ªª 
.
ªª #
SynchronizeMatchAsync
ªª 0
(
ªª0 1
)
ªª1 2
;
ªª2 3
}
ºº 	
public
ææ 
void
ææ $
ConfigureProfileImages
ææ *
(
ææ* + 
IProfileImageCache
ææ+ =
profileImageCache
ææ> O
)
ææO P
{
øø 	
foreach
¿¿ 
(
¿¿ &
LobbyPlayerItemViewModel
¿¿ -
player
¿¿. 4
in
¿¿5 7
Players
¿¿8 ?
)
¿¿? @
{
¡¡ 
player
¬¬ 
.
¬¬  
AttachProfileImage
¬¬ )
(
¬¬) *
profileImageCache
¬¬* ;
)
¬¬; <
;
¬¬< =
}
√√ 
}
ƒƒ 	
public
∆∆ 
void
∆∆ 
Dispose
∆∆ 
(
∆∆ 
)
∆∆ 
{
«« 	

MatchBoard
»» 
?
»» 
.
»» 
Dispose
»» 
(
»»  
)
»»  !
;
»»! "
foreach
…… 
(
…… &
LobbyPlayerItemViewModel
…… -
player
……. 4
in
……5 7
Players
……8 ?
)
……? @
{
   
player
ÀÀ 
.
ÀÀ 
Dispose
ÀÀ 
(
ÀÀ 
)
ÀÀ  
;
ÀÀ  !
}
ÃÃ 
}
ÕÕ 	
private
œœ 
void
œœ &
LoadTransportedLobbyData
œœ -
(
œœ- .
)
œœ. /
{
–– 	
Lobby
—— 
activeLobby
—— 
=
—— 
_lobbySession
——  -
.
——- .
CurrentLobby
——. :
;
——: ;
if
““ 
(
““ 
activeLobby
““ 
!=
““ 
null
““ #
)
““# $
{
””  
TargetMissionCount
‘‘ "
=
‘‘# $
activeLobby
‘‘% 0
.
‘‘0 1 
TargetMissionCount
‘‘1 C
>
‘‘D E
$num
‘‘F G
?
’’ 
activeLobby
’’ !
.
’’! " 
TargetMissionCount
’’" 4
:
÷÷ #
DefaultTargetMissions
÷÷ +
;
÷÷+ ,
if
ÿÿ 
(
ÿÿ 
activeLobby
ÿÿ 
.
ÿÿ  
Players
ÿÿ  '
!=
ÿÿ( *
null
ÿÿ+ /
&&
ÿÿ0 2
activeLobby
ÿÿ3 >
.
ÿÿ> ?
Players
ÿÿ? F
.
ÿÿF G
Length
ÿÿG M
>
ÿÿN O
$num
ÿÿP Q
)
ÿÿQ R
{
ŸŸ 
AssignTableSeats
⁄⁄ $
(
⁄⁄$ %
activeLobby
⁄⁄% 0
.
⁄⁄0 1
Players
⁄⁄1 8
)
⁄⁄8 9
;
⁄⁄9 :
}
€€ 
}
‹‹ 
}
›› 	
private
ﬂﬂ 
void
ﬂﬂ 
AssignTableSeats
ﬂﬂ %
(
ﬂﬂ% &
IList
ﬂﬂ& +
<
ﬂﬂ+ ,
LobbyPlayer
ﬂﬂ, 7
>
ﬂﬂ7 8
lobbyPlayers
ﬂﬂ9 E
)
ﬂﬂE F
{
‡‡ 	
Players
·· 
.
·· 
Clear
·· 
(
·· 
)
·· 
;
·· 
List
‚‚ 
<
‚‚ &
LobbyPlayerItemViewModel
‚‚ )
>
‚‚) *
orderedItems
‚‚+ 7
=
‚‚8 9
new
‚‚: =
List
‚‚> B
<
‚‚B C&
LobbyPlayerItemViewModel
‚‚C [
>
‚‚[ \
(
‚‚\ ]
)
‚‚] ^
;
‚‚^ _
int
‰‰ 

localIndex
‰‰ 
=
‰‰ 
$num
‰‰ 
;
‰‰ 
for
ÂÂ 
(
ÂÂ 
int
ÂÂ 
i
ÂÂ 
=
ÂÂ 
$num
ÂÂ 
;
ÂÂ 
i
ÂÂ 
<
ÂÂ 
lobbyPlayers
ÂÂ  ,
.
ÂÂ, -
Count
ÂÂ- 2
;
ÂÂ2 3
i
ÂÂ4 5
++
ÂÂ5 7
)
ÂÂ7 8
{
ÊÊ 
if
ÁÁ 
(
ÁÁ 
lobbyPlayers
ÁÁ  
[
ÁÁ  !
i
ÁÁ! "
]
ÁÁ" #
!=
ÁÁ$ &
null
ÁÁ' +
&&
ÁÁ, .
lobbyPlayers
ÁÁ/ ;
[
ÁÁ; <
i
ÁÁ< =
]
ÁÁ= >
.
ÁÁ> ?
IdUser
ÁÁ? E
==
ÁÁF H
_currentUserId
ÁÁI W
)
ÁÁW X
{
ËË 

localIndex
ÈÈ 
=
ÈÈ  
i
ÈÈ! "
;
ÈÈ" #
break
ÍÍ 
;
ÍÍ 
}
ÎÎ 
}
ÏÏ 
for
ÓÓ 
(
ÓÓ 
int
ÓÓ 
offset
ÓÓ 
=
ÓÓ 
$num
ÓÓ 
;
ÓÓ  
offset
ÓÓ! '
<
ÓÓ( )
lobbyPlayers
ÓÓ* 6
.
ÓÓ6 7
Count
ÓÓ7 <
;
ÓÓ< =
offset
ÓÓ> D
++
ÓÓD F
)
ÓÓF G
{
ÔÔ 
LobbyPlayer
 
participant
 '
=
( )
lobbyPlayers
* 6
[
6 7
(
7 8

localIndex
8 B
+
C D
offset
E K
)
K L
%
M N
lobbyPlayers
O [
.
[ \
Count
\ a
]
a b
;
b c
if
ÒÒ 
(
ÒÒ 
participant
ÒÒ 
!=
ÒÒ  "
null
ÒÒ# '
)
ÒÒ' (
{
ÚÚ &
LobbyPlayerItemViewModel
ÛÛ ,
item
ÛÛ- 1
=
ÛÛ2 3
new
ÛÛ4 7&
LobbyPlayerItemViewModel
ÛÛ8 P
(
ÛÛP Q
participant
ÙÙ #
.
ÙÙ# $
IdUser
ÙÙ$ *
,
ÙÙ* +
participant
ıı #
.
ıı# $
Username
ıı$ ,
,
ıı, -
participant
ˆˆ #
.
ˆˆ# $
IsHost
ˆˆ$ *
)
ˆˆ* +
{
˜˜ 
IsCurrentPlayer
¯¯ '
=
¯¯( )
participant
¯¯* 5
.
¯¯5 6
IdUser
¯¯6 <
==
¯¯= ?
_currentUserId
¯¯@ N
,
¯¯N O
IsReady
˘˘ 
=
˘˘  !
participant
˘˘" -
.
˘˘- .
IsReady
˘˘. 5
}
˙˙ 
;
˙˙ 
Players
˚˚ 
.
˚˚ 
Add
˚˚ 
(
˚˚  
item
˚˚  $
)
˚˚$ %
;
˚˚% &
orderedItems
¸¸  
.
¸¸  !
Add
¸¸! $
(
¸¸$ %
item
¸¸% )
)
¸¸) *
;
¸¸* +
}
˝˝ 
}
˛˛ 
BottomPlayer
ÄÄ 
=
ÄÄ 
orderedItems
ÄÄ '
.
ÄÄ' ( 
ElementAtOrDefault
ÄÄ( :
(
ÄÄ: ;
$num
ÄÄ; <
)
ÄÄ< =
;
ÄÄ= >

LeftPlayer
ÅÅ 
=
ÅÅ 
orderedItems
ÅÅ %
.
ÅÅ% & 
ElementAtOrDefault
ÅÅ& 8
(
ÅÅ8 9
$num
ÅÅ9 :
)
ÅÅ: ;
;
ÅÅ; <
	TopPlayer
ÇÇ 
=
ÇÇ 
orderedItems
ÇÇ $
.
ÇÇ$ %
Count
ÇÇ% *
==
ÇÇ+ -
$num
ÇÇ. /
?
ÉÉ 
orderedItems
ÉÉ 
.
ÉÉ  
ElementAtOrDefault
ÉÉ 1
(
ÉÉ1 2
$num
ÉÉ2 3
)
ÉÉ3 4
:
ÑÑ 
null
ÑÑ 
;
ÑÑ 
RightPlayer
ÖÖ 
=
ÖÖ 
orderedItems
ÖÖ &
.
ÖÖ& '
Count
ÖÖ' ,
==
ÖÖ- /
$num
ÖÖ0 1
?
ÜÜ 
orderedItems
ÜÜ 
.
ÜÜ  
ElementAtOrDefault
ÜÜ 1
(
ÜÜ1 2
$num
ÜÜ2 3
)
ÜÜ3 4
:
áá 
orderedItems
áá 
.
áá  
ElementAtOrDefault
áá 1
(
áá1 2
$num
áá2 3
)
áá3 4
;
áá4 5
}
àà 	
private
ää 
void
ää 
ExecuteHowToPlay
ää %
(
ää% &
)
ää& '
{
ãã 	
try
åå 
{
çç  
_navigationService
éé "
.
éé" #

ShowDialog
éé# -
(
éé- .
ViewId
éé. 4
.
éé4 5
HowToPlayDialog
éé5 D
)
ééD E
;
ééE F
}
èè 
catch
êê 
(
êê '
InvalidOperationException
êê ,
ex
êê- /
)
êê/ 0
{
ëë 
_logger
íí 
.
íí 
Error
íí 
(
íí 
ex
íí  
,
íí  !)
LogOpenHowToPlayDialogError
íí" =
)
íí= >
;
íí> ?
}
ìì 
}
îî 	
}
ïï 
}ññ »
pC:\Users\oscar\source\repos\TrickTakingMissions\Client\ViewModel\ViewModels\Lobby\GameInvitationItemViewModel.cs
	namespace 	
	ViewModel
 
. 

ViewModels 
{ 
public		 

sealed		 
class		 '
GameInvitationItemViewModel		 3
:		4 5
ViewModelBase		6 C
{

 
public '
GameInvitationItemViewModel *
(* +
int+ .
senderUserId/ ;
,; <
string= C
senderUsernameD R
,R S
stringT Z
	lobbyCode[ d
,d e
byte 
targetMissionCount #
,# $
int% (
currentPlayerCount) ;
,; <
byte= A
playerLimitB M
)M N
{ 	
SenderUserId 
= 
senderUserId '
;' (
SenderUsername 
= 
senderUsername +
??, .
string/ 5
.5 6
Empty6 ;
;; <
	LobbyCode 
= 
	lobbyCode !
??" $
string% +
.+ ,
Empty, 1
;1 2
TargetMissionCount 
=  
targetMissionCount! 3
;3 4
CurrentPlayerCount 
=  
currentPlayerCount! 3
;3 4
PlayerLimit 
= 
playerLimit %
;% &
PlayersCountDisplay 
=  !
string" (
.( )
Format) /
(/ 0
CultureInfo0 ;
.; <
InvariantCulture< L
,L M
$strN W
,W X
currentPlayerCount "
," #
playerLimit$ /
)/ 0
;0 1
} 	
public 
int 
SenderUserId 
{  !
get" %
;% &
}' (
public 
string 
SenderUsername $
{% &
get' *
;* +
}, -
public 
string 
	LobbyCode 
{  !
get" %
;% &
}' (
public 
byte 
TargetMissionCount &
{' (
get) ,
;, -
}. /
public   
int   
CurrentPlayerCount   %
{  & '
get  ( +
;  + ,
}  - .
public"" 
byte"" 
PlayerLimit"" 
{""  !
get""" %
;""% &
}""' (
public$$ 
string$$ 
PlayersCountDisplay$$ )
{$$* +
get$$, /
;$$/ 0
}$$1 2
}%% 
}&& ∏¥
gC:\Users\oscar\source\repos\TrickTakingMissions\Client\ViewModel\ViewModels\Friends\FriendsViewModel.cs
	namespace 	
	ViewModel
 
. 

ViewModels 
{ 
public 

sealed 
class 
FriendsViewModel (
:) *
ViewModelBase+ 8
{ 
private 
const 
int $
ServerErrorCodeLobbyFull 2
=3 4
$num5 8
;8 9
private 
const 
string %
LogLoadFriendsUnavailable 6
=7 8
$str T
;T U
private 
const 
string ,
 LogOpenFriendRequestsDialogError =
=> ?
$str@ g
;g h
private 
const 
string &
LogDeleteFriendUnavailable 7
=8 9
$str P
;P Q
private 
const 
string #
LogDeleteFriendRejected 4
=5 6
$str U
;U V
private 
const 
string *
LogJoinInvitedLobbyUnavailable ;
=< =
$str H
;H I
private   
const   
string   '
LogJoinInvitedLobbyRejected   8
=  9 :
$str!! N
;!!N O
private## 
readonly## 
INavigationService## +
_navigationService##, >
;##> ?
private$$ 
readonly$$ 
IDialogService$$ '
_dialogService$$( 6
;$$6 7
private%% 
readonly%% 
ILoggerService%% '
_logger%%( /
;%%/ 0
private&& 
readonly&& 
IFriendshipSession&& +
_friendshipSession&&, >
;&&> ?
private'' 
readonly'' 
ILobbySession'' &
_lobbySession''' 4
;''4 5
private(( 
readonly(( "
SynchronizationContext(( /
_uiSyncContext((0 >
;((> ?
private)) 
readonly)) 
List)) 
<)) 
FriendItemViewModel)) 1
>))1 2
_allFriends))3 >
;))> ?
private++ 
bool++ 

_isInLobby++ 
;++  
private,, 
bool,, "
_isFilteringOnlineOnly,, +
;,,+ ,
public22 
FriendsViewModel22 
(22  
ViewModelUiServices22  3

uiServices224 >
)22> ?
:33 
this33 
(33 

uiServices33 
,33 
FriendshipSession33 0
.330 1
Current331 8
,338 9
LobbySession33: F
.33F G
Current33G N
)33N O
{44 	
}55 	
public== 
FriendsViewModel== 
(==  
ViewModelUiServices==  3

uiServices==4 >
,==> ?
IFriendshipSession>> 
friendshipSession>> 0
,>>0 1
ILobbySession>>2 ?
lobbySession>>@ L
)>>L M
{?? 	
if@@ 
(@@ 

uiServices@@ 
==@@ 
null@@ "
)@@" #
{AA 
throwBB 
newBB !
ArgumentNullExceptionBB /
(BB/ 0
nameofBB0 6
(BB6 7

uiServicesBB7 A
)BBA B
)BBB C
;BBC D
}CC 
_navigationServiceEE 
=EE  

uiServicesEE! +
.EE+ ,
NavigationServiceEE, =
;EE= >
_dialogServiceFF 
=FF 

uiServicesFF '
.FF' (
DialogServiceFF( 5
;FF5 6
_loggerGG 
=GG 

uiServicesGG  
.GG  !
LoggerGG! '
;GG' (
_friendshipSessionHH 
=HH  
friendshipSessionHH! 2
??HH3 5
throwHH6 ;
newHH< ?!
ArgumentNullExceptionHH@ U
(HHU V
nameofHHV \
(HH\ ]
friendshipSessionHH] n
)HHn o
)HHo p
;HHp q
_lobbySessionII 
=II 
lobbySessionII (
??II) +
throwII, 1
newII2 5!
ArgumentNullExceptionII6 K
(IIK L
nameofIIL R
(IIR S
lobbySessionIIS _
)II_ `
)II` a
;IIa b
_uiSyncContextJJ 
=JJ "
SynchronizationContextJJ 3
.JJ3 4
CurrentJJ4 ;
;JJ; <
_allFriendsLL 
=LL 
newLL 
ListLL "
<LL" #
FriendItemViewModelLL# 6
>LL6 7
(LL7 8
)LL8 9
;LL9 :
FriendsMM 
=MM 
newMM  
ObservableCollectionMM .
<MM. /
FriendItemViewModelMM/ B
>MMB C
(MMC D
)MMD E
;MME F
GameInvitationsNN 
=NN 
newNN ! 
ObservableCollectionNN" 6
<NN6 7'
GameInvitationItemViewModelNN7 R
>NNR S
(NNS T
)NNT U
;NNU V

_isInLobbyOO 
=OO 
falseOO 
;OO "
_isFilteringOnlineOnlyPP "
=PP# $
falsePP% *
;PP* ++
OpenManageFriendRequestsCommandRR +
=RR, -
newRR. 1
AsyncRelayCommandRR2 C
(RRC D0
$ExecuteOpenManageFriendRequestsAsyncRRD h
)RRh i
;RRi j
AddFriendCommandSS 
=SS 
newSS "
RelayCommandSS# /
(SS/ 0
ExecuteAddFriendSS0 @
)SS@ A
;SSA B
ViewProfileCommandTT 
=TT  
newTT! $
RelayCommandTT% 1
(TT1 2
ExecuteViewProfileTT2 D
)TTD E
;TTE F
DeleteFriendCommandUU 
=UU  !
newUU" %
AsyncRelayCommandUU& 7
(UU7 8$
ExecuteDeleteFriendAsyncUU8 P
)UUP Q
;UUQ R
InviteFriendCommandVV 
=VV  !
newVV" %
AsyncRelayCommandVV& 7
(VV7 8$
ExecuteInviteFriendAsyncVV8 P
)VVP Q
;VVQ R'
AcceptGameInvitationCommandWW '
=WW( )
newWW* -
AsyncRelayCommandWW. ?
(WW? @,
 ExecuteAcceptGameInvitationAsyncWW@ `
)WW` a
;WWa b'
RejectGameInvitationCommandXX '
=XX( )
newXX* -
RelayCommandXX. :
(XX: ;'
ExecuteRejectGameInvitationXX; V
)XXV W
;XXW X 
FilterFriendsCommandYY  
=YY! "
newYY# &
AsyncRelayCommandYY' 8
(YY8 9%
ExecuteFilterFriendsAsyncYY9 R
)YYR S
;YYS T#
SubscribeToSocialEvents[[ #
([[# $
)[[$ %
;[[% &
_\\ 
=\\ &
InitializeSocialStateAsync\\ *
(\\* +
)\\+ ,
;\\, -
}]] 	
publicbb  
ObservableCollectionbb #
<bb# $
FriendItemViewModelbb$ 7
>bb7 8
Friendsbb9 @
{bbA B
getbbC F
;bbF G
}bbH I
publicgg  
ObservableCollectiongg #
<gg# $'
GameInvitationItemViewModelgg$ ?
>gg? @
GameInvitationsggA P
{ggQ R
getggS V
;ggV W
}ggX Y
publicll 
boolll 
	IsInLobbyll 
{mm 	
getnn 
=>nn 

_isInLobbynn 
;nn 
setoo 
=>oo 
SetPropertyoo 
(oo 
refoo "

_isInLobbyoo# -
,oo- .
valueoo/ 4
)oo4 5
;oo5 6
}pp 	
publicuu 
ICommanduu +
OpenManageFriendRequestsCommanduu 7
{uu8 9
getuu: =
;uu= >
}uu? @
publiczz 
ICommandzz 
AddFriendCommandzz (
{zz) *
getzz+ .
;zz. /
}zz0 1
public 
ICommand 
ViewProfileCommand *
{+ ,
get- 0
;0 1
}2 3
public
ÑÑ 
ICommand
ÑÑ !
DeleteFriendCommand
ÑÑ +
{
ÑÑ, -
get
ÑÑ. 1
;
ÑÑ1 2
}
ÑÑ3 4
public
ââ 
ICommand
ââ !
InviteFriendCommand
ââ +
{
ââ, -
get
ââ. 1
;
ââ1 2
}
ââ3 4
public
éé 
ICommand
éé )
AcceptGameInvitationCommand
éé 3
{
éé4 5
get
éé6 9
;
éé9 :
}
éé; <
public
ìì 
ICommand
ìì )
RejectGameInvitationCommand
ìì 3
{
ìì4 5
get
ìì6 9
;
ìì9 :
}
ìì; <
public
òò 
ICommand
òò "
FilterFriendsCommand
òò ,
{
òò- .
get
òò/ 2
;
òò2 3
}
òò4 5
private
öö 
async
öö 
Task
öö (
InitializeSocialStateAsync
öö 5
(
öö5 6
)
öö6 7
{
õõ 	
int
úú 
currentUserId
úú 
=
úú $
GetAuthenticatedUserId
úú  6
(
úú6 7
)
úú7 8
;
úú8 9
if
ûû 
(
ûû 
IsValidUserId
ûû 
(
ûû 
currentUserId
ûû +
)
ûû+ ,
)
ûû, -
{
üü 
await
††  
_friendshipSession
†† (
.
††( )
Client
††) /
.
††/ 0(
SubscribeSocialEventsAsync
††0 J
(
††J K
currentUserId
††K X
)
††X Y
;
††Y Z
await
°° "
LoadFriendsListAsync
°° *
(
°°* +
)
°°+ ,
;
°°, -
}
¢¢ 
}
££ 	
private
•• 
async
•• 
Task
•• "
LoadFriendsListAsync
•• /
(
••/ 0
)
••0 1
{
¶¶ 	
int
ßß 
currentUserId
ßß 
=
ßß $
GetAuthenticatedUserId
ßß  6
(
ßß6 7
)
ßß7 8
;
ßß8 9
if
©© 
(
©© 
IsValidUserId
©© 
(
©© 
currentUserId
©© +
)
©©+ ,
)
©©, -
{
™™ 
IList
´´ 
<
´´ 
Friend
´´ 
>
´´ 
friendsFromServer
´´ /
=
´´0 1
await
´´1 6 
_friendshipSession
¨¨ &
.
¨¨& '
Client
¨¨' -
.
¨¨- .)
GetFriendsListByUserIdAsync
¨¨. I
(
¨¨I J
currentUserId
¨¨J W
)
¨¨W X
;
¨¨X Y
_allFriends
ÆÆ 
.
ÆÆ 
Clear
ÆÆ !
(
ÆÆ! "
)
ÆÆ" #
;
ÆÆ# $
if
∞∞ 
(
∞∞ 
friendsFromServer
∞∞ %
!=
∞∞& (
null
∞∞) -
)
∞∞- .
{
±± 
foreach
≤≤ 
(
≤≤ 
Friend
≤≤ #
friend
≤≤$ *
in
≤≤+ -
friendsFromServer
≤≤. ?
)
≤≤? @
{
≥≥ 
if
¥¥ 
(
¥¥ 
friend
¥¥ "
!=
¥¥# %
null
¥¥& *
)
¥¥* +
{
µµ !
FriendItemViewModel
∂∂ /
item
∂∂0 4
=
∂∂5 6
new
∂∂7 :!
FriendItemViewModel
∂∂; N
(
∂∂N O
friend
∑∑  &
.
∑∑& '
UserId
∑∑' -
,
∑∑- .
friend
∏∏  &
.
∏∏& '
Username
∏∏' /
,
∏∏/ 0
friend
ππ  &
.
ππ& '
IsOnline
ππ' /
)
ππ/ 0
;
ππ0 1
_allFriends
∫∫ '
.
∫∫' (
Add
∫∫( +
(
∫∫+ ,
item
∫∫, 0
)
∫∫0 1
;
∫∫1 2
}
ªª 
}
ºº 
}
ΩΩ 
else
ææ 
{
øø 
_logger
¿¿ 
.
¿¿ 
Warning
¿¿ #
(
¿¿# $'
LogLoadFriendsUnavailable
¿¿$ =
,
¿¿= >
currentUserId
¿¿? L
)
¿¿L M
;
¿¿M N
}
¡¡  
ApplyFriendsFilter
√√ "
(
√√" #
)
√√# $
;
√√$ %
}
ƒƒ 
}
≈≈ 	
private
«« 
void
««  
ApplyFriendsFilter
«« '
(
««' (
)
««( )
{
»» 	
Friends
…… 
.
…… 
Clear
…… 
(
…… 
)
…… 
;
…… 
foreach
ÀÀ 
(
ÀÀ !
FriendItemViewModel
ÀÀ (

friendItem
ÀÀ) 3
in
ÀÀ4 6
_allFriends
ÀÀ7 B
)
ÀÀB C
{
ÃÃ 
bool
ÕÕ 
shouldInclude
ÕÕ "
=
ÕÕ# $
!
ÕÕ% &$
_isFilteringOnlineOnly
ÕÕ& <
||
ÕÕ= ?

friendItem
ÕÕ@ J
.
ÕÕJ K
IsOnline
ÕÕK S
;
ÕÕS T
if
ŒŒ 
(
ŒŒ 
shouldInclude
ŒŒ !
)
ŒŒ! "
{
œœ 
Friends
–– 
.
–– 
Add
–– 
(
––  

friendItem
––  *
)
––* +
;
––+ ,
}
—— 
}
““ 
}
”” 	
private
’’ 
void
’’ %
SubscribeToSocialEvents
’’ ,
(
’’, -
)
’’- .
{
÷÷ 	
IFriendshipClient
◊◊ 
client
◊◊ $
=
◊◊% & 
_friendshipSession
◊◊' 9
.
◊◊9 :
Client
◊◊: @
;
◊◊@ A
client
ÿÿ 
.
ÿÿ !
FriendStatusChanged
ÿÿ &
-=
ÿÿ' ))
OnServerFriendStatusChanged
ÿÿ* E
;
ÿÿE F
client
ŸŸ 
.
ŸŸ !
FriendStatusChanged
ŸŸ &
+=
ŸŸ' ))
OnServerFriendStatusChanged
ŸŸ* E
;
ŸŸE F
client
⁄⁄ 
.
⁄⁄ 
FriendRemoved
⁄⁄  
-=
⁄⁄! ##
OnServerFriendRemoved
⁄⁄$ 9
;
⁄⁄9 :
client
€€ 
.
€€ 
FriendRemoved
€€  
+=
€€! ##
OnServerFriendRemoved
€€$ 9
;
€€9 :
client
‹‹ 
.
‹‹ $
GameInvitationReceived
‹‹ )
-=
‹‹* ,,
OnServerGameInvitationReceived
‹‹- K
;
‹‹K L
client
›› 
.
›› $
GameInvitationReceived
›› )
+=
››* ,,
OnServerGameInvitationReceived
››- K
;
››K L 
_friendshipSession
ﬁﬁ 
.
ﬁﬁ  
FriendsListChanged
ﬁﬁ 1
-=
ﬁﬁ2 4)
OnSessionFriendsListChanged
ﬁﬁ5 P
;
ﬁﬁP Q 
_friendshipSession
ﬂﬂ 
.
ﬂﬂ  
FriendsListChanged
ﬂﬂ 1
+=
ﬂﬂ2 4)
OnSessionFriendsListChanged
ﬂﬂ5 P
;
ﬂﬂP Q
}
‡‡ 	
private
‚‚ 
void
‚‚ )
OnSessionFriendsListChanged
‚‚ 0
(
‚‚0 1
)
‚‚1 2
{
„„ 	
_
‰‰ 
=
‰‰ "
LoadFriendsListAsync
‰‰ $
(
‰‰$ %
)
‰‰% &
;
‰‰& '
}
ÂÂ 	
private
ÁÁ 
void
ÁÁ )
OnServerFriendStatusChanged
ÁÁ 0
(
ÁÁ0 1
int
ÁÁ1 4
friendUserId
ÁÁ5 A
,
ÁÁA B
bool
ÁÁC G
isOnline
ÁÁH P
)
ÁÁP Q
{
ËË 	!
FriendItemViewModel
ÈÈ 
statusSnapshot
ÈÈ  .
=
ÈÈ/ 0
new
ÈÈ1 4!
FriendItemViewModel
ÈÈ5 H
(
ÈÈH I
friendUserId
ÈÈI U
,
ÈÈU V
string
ÈÈW ]
.
ÈÈ] ^
Empty
ÈÈ^ c
,
ÈÈc d
isOnline
ÈÈe m
)
ÈÈm n
;
ÈÈn o
if
ÎÎ 
(
ÎÎ 
_uiSyncContext
ÎÎ 
!=
ÎÎ !
null
ÎÎ" &
&&
ÎÎ' )$
SynchronizationContext
ÎÎ* @
.
ÎÎ@ A
Current
ÎÎA H
!=
ÎÎI K
_uiSyncContext
ÎÎL Z
)
ÎÎZ [
{
ÏÏ 
_uiSyncContext
ÌÌ 
.
ÌÌ 
Post
ÌÌ #
(
ÌÌ# $-
ApplyFriendStatusUpdateCallback
ÌÌ$ C
,
ÌÌC D
statusSnapshot
ÌÌE S
)
ÌÌS T
;
ÌÌT U
}
ÓÓ 
else
ÔÔ 
{
 %
ApplyFriendStatusUpdate
ÒÒ '
(
ÒÒ' (
statusSnapshot
ÒÒ( 6
.
ÒÒ6 7
UserId
ÒÒ7 =
,
ÒÒ= >
statusSnapshot
ÒÒ? M
.
ÒÒM N
IsOnline
ÒÒN V
)
ÒÒV W
;
ÒÒW X
}
ÚÚ 
}
ÛÛ 	
private
ıı 
void
ıı -
ApplyFriendStatusUpdateCallback
ıı 4
(
ıı4 5
object
ıı5 ;
stateObject
ıı< G
)
ııG H
{
ˆˆ 	
if
˜˜ 
(
˜˜ 
stateObject
˜˜ 
is
˜˜ !
FriendItemViewModel
˜˜ 2
statusSnapshot
˜˜3 A
)
˜˜A B
{
¯¯ %
ApplyFriendStatusUpdate
˘˘ '
(
˘˘' (
statusSnapshot
˘˘( 6
.
˘˘6 7
UserId
˘˘7 =
,
˘˘= >
statusSnapshot
˘˘? M
.
˘˘M N
IsOnline
˘˘N V
)
˘˘V W
;
˘˘W X
}
˙˙ 
}
˚˚ 	
private
˝˝ 
void
˝˝ %
ApplyFriendStatusUpdate
˝˝ ,
(
˝˝, -
int
˝˝- 0
friendUserId
˝˝1 =
,
˝˝= >
bool
˝˝? C
isOnline
˝˝D L
)
˝˝L M
{
˛˛ 	!
FriendItemViewModel
ˇˇ 
matchingFriend
ˇˇ  .
=
ˇˇ/ 0
FindFriendById
ˇˇ1 ?
(
ˇˇ? @
friendUserId
ˇˇ@ L
)
ˇˇL M
;
ˇˇM N
if
ÅÅ 
(
ÅÅ 
matchingFriend
ÅÅ 
!=
ÅÅ !
null
ÅÅ" &
)
ÅÅ& '
{
ÇÇ 
matchingFriend
ÉÉ 
.
ÉÉ 
IsOnline
ÉÉ '
=
ÉÉ( )
isOnline
ÉÉ* 2
;
ÉÉ2 3
if
ÑÑ 
(
ÑÑ $
_isFilteringOnlineOnly
ÑÑ *
)
ÑÑ* +
{
ÖÖ  
ApplyFriendsFilter
ÜÜ &
(
ÜÜ& '
)
ÜÜ' (
;
ÜÜ( )
}
áá 
}
àà 
else
ââ 
{
ää 
_
ãã 
=
ãã "
LoadFriendsListAsync
ãã (
(
ãã( )
)
ãã) *
;
ãã* +
}
åå 
}
çç 	
private
èè 
void
èè #
OnServerFriendRemoved
èè *
(
èè* +
int
èè+ .
friendUserId
èè/ ;
)
èè; <
{
êê 	
if
ëë 
(
ëë 
_uiSyncContext
ëë 
!=
ëë !
null
ëë" &
&&
ëë' )$
SynchronizationContext
ëë* @
.
ëë@ A
Current
ëëA H
!=
ëëI K
_uiSyncContext
ëëL Z
)
ëëZ [
{
íí 
_uiSyncContext
ìì 
.
ìì 
Post
ìì #
(
ìì# $*
RemoveFriendFromListCallback
ìì$ @
,
ìì@ A
friendUserId
ììB N
)
ììN O
;
ììO P
}
îî 
else
ïï 
{
ññ "
RemoveFriendFromList
óó $
(
óó$ %
friendUserId
óó% 1
)
óó1 2
;
óó2 3
}
òò 
}
ôô 	
private
õõ 
void
õõ *
RemoveFriendFromListCallback
õõ 1
(
õõ1 2
object
õõ2 8
stateObject
õõ9 D
)
õõD E
{
úú 	
if
ùù 
(
ùù 
stateObject
ùù 
is
ùù 
int
ùù "
friendUserId
ùù# /
)
ùù/ 0
{
ûû "
RemoveFriendFromList
üü $
(
üü$ %
friendUserId
üü% 1
)
üü1 2
;
üü2 3
}
†† 
}
°° 	
private
££ 
void
££ "
RemoveFriendFromList
££ )
(
££) *
int
££* -
friendUserId
££. :
)
££: ;
{
§§ 	!
FriendItemViewModel
•• 
matchingFriend
••  .
=
••/ 0
FindFriendById
••1 ?
(
••? @
friendUserId
••@ L
)
••L M
;
••M N
if
ßß 
(
ßß 
matchingFriend
ßß 
!=
ßß !
null
ßß" &
)
ßß& '
{
®® 
_allFriends
©© 
.
©© 
Remove
©© "
(
©©" #
matchingFriend
©©# 1
)
©©1 2
;
©©2 3
Friends
™™ 
.
™™ 
Remove
™™ 
(
™™ 
matchingFriend
™™ -
)
™™- .
;
™™. /
}
´´ 
}
¨¨ 	
private
ÆÆ 
void
ÆÆ ,
OnServerGameInvitationReceived
ÆÆ 3
(
ÆÆ3 4
GameInvitation
ÆÆ4 B
gameInvitation
ÆÆC Q
)
ÆÆQ R
{
ØØ 	
if
∞∞ 
(
∞∞ 
gameInvitation
∞∞ 
!=
∞∞ !
null
∞∞" &
)
∞∞& '
{
±± )
GameInvitationItemViewModel
≤≤ +
invitationItem
≤≤, :
=
≤≤; <
new
≤≤= @)
GameInvitationItemViewModel
≤≤A \
(
≤≤\ ]
gameInvitation
≥≥ "
.
≥≥" #
SenderUserId
≥≥# /
,
≥≥/ 0
gameInvitation
¥¥ "
.
¥¥" #
SenderUsername
¥¥# 1
,
¥¥1 2
gameInvitation
µµ "
.
µµ" #
	LobbyCode
µµ# ,
,
µµ, -
gameInvitation
∂∂ "
.
∂∂" # 
TargetMissionCount
∂∂# 5
,
∂∂5 6
gameInvitation
∑∑ "
.
∑∑" # 
CurrentPlayerCount
∑∑# 5
,
∑∑5 6
gameInvitation
∏∏ "
.
∏∏" #
PlayerLimit
∏∏# .
)
∏∏. /
;
∏∏/ 0
if
∫∫ 
(
∫∫ 
_uiSyncContext
∫∫ "
!=
∫∫# %
null
∫∫& *
&&
∫∫+ -$
SynchronizationContext
∫∫. D
.
∫∫D E
Current
∫∫E L
!=
∫∫M O
_uiSyncContext
∫∫P ^
)
∫∫^ _
{
ªª 
_uiSyncContext
ºº "
.
ºº" #
Post
ºº# '
(
ºº' ('
AddGameInvitationCallback
ºº( A
,
ººA B
invitationItem
ººC Q
)
ººQ R
;
ººR S
}
ΩΩ 
else
ææ 
{
øø (
AddOrReplaceGameInvitation
¿¿ .
(
¿¿. /
invitationItem
¿¿/ =
)
¿¿= >
;
¿¿> ?
}
¡¡ 
}
¬¬ 
}
√√ 	
private
≈≈ 
void
≈≈ '
AddGameInvitationCallback
≈≈ .
(
≈≈. /
object
≈≈/ 5
stateObject
≈≈6 A
)
≈≈A B
{
∆∆ 	
if
«« 
(
«« 
stateObject
«« 
is
«« )
GameInvitationItemViewModel
«« :
invitationItem
««; I
)
««I J
{
»» (
AddOrReplaceGameInvitation
…… *
(
……* +
invitationItem
……+ 9
)
……9 :
;
……: ;
}
   
}
ÀÀ 	
private
ÕÕ 
void
ÕÕ (
AddOrReplaceGameInvitation
ÕÕ /
(
ÕÕ/ 0)
GameInvitationItemViewModel
ÕÕ0 K
newInvitation
ÕÕL Y
)
ÕÕY Z
{
ŒŒ 	)
GameInvitationItemViewModel
œœ '
existing
œœ( 0
=
œœ1 2
null
œœ3 7
;
œœ7 8
foreach
—— 
(
—— )
GameInvitationItemViewModel
—— 0
item
——1 5
in
——6 8
GameInvitations
——9 H
)
——H I
{
““ 
if
”” 
(
”” 
item
”” 
.
”” 
SenderUserId
”” %
==
””& (
newInvitation
””) 6
.
””6 7
SenderUserId
””7 C
&&
””D F
string
‘‘ 
.
‘‘ 
Equals
‘‘ !
(
‘‘! "
item
‘‘" &
.
‘‘& '
	LobbyCode
‘‘' 0
,
‘‘0 1
newInvitation
‘‘2 ?
.
‘‘? @
	LobbyCode
‘‘@ I
,
‘‘I J
StringComparison
‘‘K [
.
‘‘[ \
OrdinalIgnoreCase
‘‘\ m
)
‘‘m n
)
‘‘n o
{
’’ 
existing
÷÷ 
=
÷÷ 
item
÷÷ #
;
÷÷# $
}
◊◊ 
}
ÿÿ 
if
⁄⁄ 
(
⁄⁄ 
existing
⁄⁄ 
!=
⁄⁄ 
null
⁄⁄  
)
⁄⁄  !
{
€€ 
GameInvitations
‹‹ 
.
‹‹  
Remove
‹‹  &
(
‹‹& '
existing
‹‹' /
)
‹‹/ 0
;
‹‹0 1
}
›› 
GameInvitations
ﬂﬂ 
.
ﬂﬂ 
Add
ﬂﬂ 
(
ﬂﬂ  
newInvitation
ﬂﬂ  -
)
ﬂﬂ- .
;
ﬂﬂ. /
}
‡‡ 	
private
‚‚ !
FriendItemViewModel
‚‚ #
FindFriendById
‚‚$ 2
(
‚‚2 3
int
‚‚3 6
friendUserId
‚‚7 C
)
‚‚C D
{
„„ 	!
FriendItemViewModel
‰‰ 
found
‰‰  %
=
‰‰& '
null
‰‰( ,
;
‰‰, -
foreach
ÊÊ 
(
ÊÊ !
FriendItemViewModel
ÊÊ (
item
ÊÊ) -
in
ÊÊ. 0
_allFriends
ÊÊ1 <
)
ÊÊ< =
{
ÁÁ 
if
ËË 
(
ËË 
item
ËË 
.
ËË 
UserId
ËË 
==
ËË  "
friendUserId
ËË# /
)
ËË/ 0
{
ÈÈ 
found
ÍÍ 
=
ÍÍ 
item
ÍÍ  
;
ÍÍ  !
}
ÎÎ 
}
ÏÏ 
return
ÓÓ 
found
ÓÓ 
;
ÓÓ 
}
ÔÔ 	
private
ÒÒ 
async
ÒÒ 
Task
ÒÒ 2
$ExecuteOpenManageFriendRequestsAsync
ÒÒ ?
(
ÒÒ? @
)
ÒÒ@ A
{
ÚÚ 	
try
ÛÛ 
{
ÙÙ  
_navigationService
ıı "
.
ıı" #

ShowDialog
ıı# -
(
ıı- .
ViewId
ıı. 4
.
ıı4 5'
ManageFriendRequestDialog
ıı5 N
)
ııN O
;
ııO P
await
ˆˆ "
LoadFriendsListAsync
ˆˆ *
(
ˆˆ* +
)
ˆˆ+ ,
;
ˆˆ, -
}
˜˜ 
catch
¯¯ 
(
¯¯ '
InvalidOperationException
¯¯ ,
ex
¯¯- /
)
¯¯/ 0
{
˘˘ 
_logger
˙˙ 
.
˙˙ 
Error
˙˙ 
(
˙˙ 
ex
˙˙  
,
˙˙  !.
 LogOpenFriendRequestsDialogError
˙˙" B
)
˙˙B C
;
˙˙C D
}
˚˚ 
}
¸¸ 	
private
˛˛ 
void
˛˛ 
ExecuteAddFriend
˛˛ %
(
˛˛% &
)
˛˛& '
{
ˇˇ 	 
_navigationService
ÄÄ 
.
ÄÄ 

NavigateTo
ÄÄ )
(
ÄÄ) *
ViewId
ÄÄ* 0
.
ÄÄ0 1
SendFriendRequest
ÄÄ1 B
)
ÄÄB C
;
ÄÄC D
}
ÅÅ 	
private
ÉÉ 
void
ÉÉ  
ExecuteViewProfile
ÉÉ '
(
ÉÉ' (
)
ÉÉ( )
{
ÑÑ 	 
_navigationService
ÖÖ 
.
ÖÖ 

NavigateTo
ÖÖ )
(
ÖÖ) *
ViewId
ÖÖ* 0
.
ÖÖ0 1
Profile
ÖÖ1 8
)
ÖÖ8 9
;
ÖÖ9 :
}
ÜÜ 	
private
àà 
async
àà 
Task
àà &
ExecuteDeleteFriendAsync
àà 3
(
àà3 4
object
àà4 :
	parameter
àà; D
)
ààD E
{
ââ 	!
FriendItemViewModel
ää 
targetFriend
ää  ,
=
ää- .
	parameter
ää/ 8
as
ää9 ;!
FriendItemViewModel
ää< O
;
ääO P
int
ãã 
currentUserId
ãã 
=
ãã $
GetAuthenticatedUserId
ãã  6
(
ãã6 7
)
ãã7 8
;
ãã8 9
if
çç 
(
çç 
targetFriend
çç 
!=
çç 
null
çç  $
&&
çç% '
IsValidUserId
çç( 5
(
çç5 6
currentUserId
çç6 C
)
ççC D
)
ççD E
{
éé 
OperationResult
èè 
result
èè  &
=
èè' (
await
èè) . 
_friendshipSession
èè/ A
.
èèA B
Client
èèB H
.
èèH I
RemoveFriendAsync
èèI Z
(
èèZ [
currentUserId
èè[ h
,
èèh i
targetFriend
êê  
.
êê  !
UserId
êê! '
)
êê' (
;
êê( )
if
íí 
(
íí 
result
íí 
==
íí 
null
íí "
)
íí" #
{
ìì 
_logger
îî 
.
îî 
Error
îî !
(
îî! "(
LogDeleteFriendUnavailable
îî" <
,
îî< =
targetFriend
îî> J
.
îîJ K
UserId
îîK Q
)
îîQ R
;
îîR S
_dialogService
ïï "
?
ïï" #
.
ïï# $
	ShowError
ïï$ -
(
ïï- .
MessageCode
ïï. 9
.
ïï9 :
ConnectionFailed
ïï: J
)
ïïJ K
;
ïïK L
}
ññ 
else
óó 
if
óó 
(
óó 
result
óó 
.
óó  
	IsSuccess
óó  )
)
óó) *
{
òò 
_allFriends
ôô 
.
ôô  
Remove
ôô  &
(
ôô& '
targetFriend
ôô' 3
)
ôô3 4
;
ôô4 5
Friends
öö 
.
öö 
Remove
öö "
(
öö" #
targetFriend
öö# /
)
öö/ 0
;
öö0 1
}
õõ 
else
úú 
{
ùù 
_logger
ûû 
.
ûû 
Warning
ûû #
(
ûû# $%
LogDeleteFriendRejected
ûû$ ;
,
ûû; <
targetFriend
ûû= I
.
ûûI J
UserId
ûûJ P
,
ûûP Q
result
ûûR X
.
ûûX Y
	ErrorCode
ûûY b
)
ûûb c
;
ûûc d
_dialogService
üü "
?
üü" #
.
üü# $
ShowWarning
üü$ /
(
üü/ 0
MessageCode
üü0 ;
.
üü; <
UnexpectedError
üü< K
)
üüK L
;
üüL M
}
†† 
}
°° 
}
¢¢ 	
private
§§ 
async
§§ 
Task
§§ &
ExecuteInviteFriendAsync
§§ 3
(
§§3 4
object
§§4 :
	parameter
§§; D
)
§§D E
{
•• 	!
FriendItemViewModel
¶¶ 
targetFriend
¶¶  ,
=
¶¶- .
	parameter
¶¶/ 8
as
¶¶9 ;!
FriendItemViewModel
¶¶< O
;
¶¶O P
int
ßß 
currentUserId
ßß 
=
ßß $
GetAuthenticatedUserId
ßß  6
(
ßß6 7
)
ßß7 8
;
ßß8 9
Model
®® 
.
®® 
GameServices
®® 
.
®® 
Lobby
®® $
activeLobby
®®% 0
=
®®1 2
_lobbySession
®®3 @
.
®®@ A
CurrentLobby
®®A M
;
®®M N
bool
©© 
canSendInvitation
©© "
=
©©# $
targetFriend
©©% 1
!=
©©2 4
null
©©5 9
&&
©©: <
IsValidUserId
©©= J
(
©©J K
currentUserId
©©K X
)
©©X Y
&&
™™ 
_lobbySession
™™  
.
™™  !
HasActiveLobby
™™! /
&&
™™0 2
activeLobby
™™3 >
!=
™™? A
null
™™B F
;
™™F G
if
¨¨ 
(
¨¨ 
canSendInvitation
¨¨ !
)
¨¨! "
{
≠≠ 
string
ÆÆ 
senderUsername
ÆÆ %
;
ÆÆ% &
int
ØØ  
currentPlayerCount
ØØ &
=
ØØ' (
activeLobby
ØØ) 4
.
ØØ4 5
Players
ØØ5 <
!=
ØØ= ?
null
ØØ@ D
?
∞∞ 
activeLobby
∞∞ !
.
∞∞! "
Players
∞∞" )
.
∞∞) *
Length
∞∞* 0
:
±± 
$num
±± 
;
±± 
if
≥≥ 
(
≥≥ 
UserSession
≥≥ 
.
≥≥  
Current
≥≥  '
.
≥≥' (
CurrentUser
≥≥( 3
!=
≥≥4 6
null
≥≥7 ;
)
≥≥; <
{
¥¥ 
senderUsername
µµ "
=
µµ# $
UserSession
µµ% 0
.
µµ0 1
Current
µµ1 8
.
µµ8 9
CurrentUser
µµ9 D
.
µµD E
Username
µµE M
;
µµM N
}
∂∂ 
else
∑∑ 
{
∏∏ 
senderUsername
ππ "
=
ππ# $
string
ππ% +
.
ππ+ ,
Empty
ππ, 1
;
ππ1 2
}
∫∫ 
GameInvitation
ºº 

invitation
ºº )
=
ºº* +
new
ºº, /
GameInvitation
ºº0 >
{
ΩΩ 
SenderUserId
ææ  
=
ææ! "
currentUserId
ææ# 0
,
ææ0 1
SenderUsername
øø "
=
øø# $
senderUsername
øø% 3
,
øø3 4
ReceiverUserId
¿¿ "
=
¿¿# $
targetFriend
¿¿% 1
.
¿¿1 2
UserId
¿¿2 8
,
¿¿8 9
	LobbyCode
¡¡ 
=
¡¡ 
activeLobby
¡¡  +
.
¡¡+ ,
	LobbyCode
¡¡, 5
,
¡¡5 6 
TargetMissionCount
¬¬ &
=
¬¬' (
activeLobby
¬¬) 4
.
¬¬4 5 
TargetMissionCount
¬¬5 G
,
¬¬G H 
CurrentPlayerCount
√√ &
=
√√' ( 
currentPlayerCount
√√) ;
,
√√; <
PlayerLimit
ƒƒ 
=
ƒƒ  !
activeLobby
ƒƒ" -
.
ƒƒ- .
PlayerLimit
ƒƒ. 9
}
≈≈ 
;
≈≈ 
await
««  
_friendshipSession
«« (
.
««( )
Client
««) /
.
««/ 0%
SendGameInvitationAsync
««0 G
(
««G H

invitation
««H R
)
««R S
;
««S T
}
»» 
}
…… 	
private
ÀÀ 
async
ÀÀ 
Task
ÀÀ .
 ExecuteAcceptGameInvitationAsync
ÀÀ ;
(
ÀÀ; <
object
ÀÀ< B
	parameter
ÀÀC L
)
ÀÀL M
{
ÃÃ 	)
GameInvitationItemViewModel
ÕÕ '
invitationItem
ÕÕ( 6
=
ÕÕ7 8
	parameter
ÕÕ9 B
as
ÕÕC E)
GameInvitationItemViewModel
ÕÕF a
;
ÕÕa b
int
ŒŒ 
currentUserId
ŒŒ 
=
ŒŒ 
UserSession
ŒŒ  +
.
ŒŒ+ ,
Current
ŒŒ, 3
.
ŒŒ3 4 
EnsureActiveUserId
ŒŒ4 F
(
ŒŒF G
)
ŒŒG H
;
ŒŒH I
if
–– 
(
–– 
invitationItem
–– 
!=
–– !
null
––" &
&&
––' )
!
––* +
string
––+ 1
.
––1 2 
IsNullOrWhiteSpace
––2 D
(
––D E
invitationItem
––E S
.
––S T
	LobbyCode
––T ]
)
––] ^
)
––^ _
{
—— 
_lobbySession
““ 
.
““ 

ClearLobby
““ (
(
““( )
)
““) *
;
““* +
Model
”” 
.
”” 
GameServices
”” "
.
””" #
LobbyResult
””# .
result
””/ 5
=
””6 7
await
””8 =
_lobbySession
””> K
.
””K L
Client
””L R
.
””R S"
JoinLobbyByCodeAsync
””S g
(
””g h
invitationItem
‘‘ "
.
‘‘" #
	LobbyCode
‘‘# ,
.
‘‘, -
Trim
‘‘- 1
(
‘‘1 2
)
‘‘2 3
.
‘‘3 4
ToUpperInvariant
‘‘4 D
(
‘‘D E
)
‘‘E F
,
‘‘F G
currentUserId
‘‘H U
)
‘‘U V
;
‘‘V W
if
÷÷ 
(
÷÷ 
result
÷÷ 
==
÷÷ 
null
÷÷ "
)
÷÷" #
{
◊◊ 
_logger
ÿÿ 
.
ÿÿ 
Error
ÿÿ !
(
ÿÿ! ",
LogJoinInvitedLobbyUnavailable
ÿÿ" @
,
ÿÿ@ A
invitationItem
ÿÿB P
.
ÿÿP Q
	LobbyCode
ÿÿQ Z
)
ÿÿZ [
;
ÿÿ[ \
_dialogService
ŸŸ "
?
ŸŸ" #
.
ŸŸ# $
	ShowError
ŸŸ$ -
(
ŸŸ- .
MessageCode
ŸŸ. 9
.
ŸŸ9 :
ConnectionFailed
ŸŸ: J
)
ŸŸJ K
;
ŸŸK L
}
⁄⁄ 
else
€€ 
if
€€ 
(
€€ 
!
€€ 
result
€€  
.
€€  !
	IsSuccess
€€! *
||
€€+ -
result
€€. 4
.
€€4 5
Lobby
€€5 :
==
€€; =
null
€€> B
)
€€B C
{
‹‹ 
_logger
›› 
.
›› 
Warning
›› #
(
››# $)
LogJoinInvitedLobbyRejected
››$ ?
,
››? @
invitationItem
››A O
.
››O P
	LobbyCode
››P Y
,
››Y Z
result
››[ a
.
››a b
	ErrorCode
››b k
)
››k l
;
››l m
int
ﬁﬁ 
messageCode
ﬁﬁ #
=
ﬁﬁ$ %
result
ﬁﬁ& ,
.
ﬁﬁ, -
	ErrorCode
ﬁﬁ- 6
==
ﬁﬁ7 9&
ServerErrorCodeLobbyFull
ﬁﬁ: R
?
ﬂﬂ 
MessageCode
ﬂﬂ %
.
ﬂﬂ% &+
EnterGameCodeLobbyAlreadyFull
ﬂﬂ& C
:
‡‡ 
MessageCode
‡‡ %
.
‡‡% &&
EnterGameCodeInvalidCode
‡‡& >
;
‡‡> ?
_dialogService
·· "
?
··" #
.
··# $
ShowWarning
··$ /
(
··/ 0
messageCode
··0 ;
)
··; <
;
··< =
GameInvitations
‚‚ #
.
‚‚# $
Remove
‚‚$ *
(
‚‚* +
invitationItem
‚‚+ 9
)
‚‚9 :
;
‚‚: ;
}
„„ 
else
‰‰ 
{
ÂÂ 
_lobbySession
ÊÊ !
.
ÊÊ! "
SetLobby
ÊÊ" *
(
ÊÊ* +
result
ÊÊ+ 1
.
ÊÊ1 2
Lobby
ÊÊ2 7
)
ÊÊ7 8
;
ÊÊ8 9
GameInvitations
ÁÁ #
.
ÁÁ# $
Remove
ÁÁ$ *
(
ÁÁ* +
invitationItem
ÁÁ+ 9
)
ÁÁ9 :
;
ÁÁ: ; 
_navigationService
ËË &
.
ËË& '

NavigateTo
ËË' 1
(
ËË1 2
ViewId
ËË2 8
.
ËË8 9
Lobby
ËË9 >
)
ËË> ?
;
ËË? @
}
ÈÈ 
}
ÍÍ 
}
ÎÎ 	
private
ÌÌ 
void
ÌÌ )
ExecuteRejectGameInvitation
ÌÌ 0
(
ÌÌ0 1
object
ÌÌ1 7
	parameter
ÌÌ8 A
)
ÌÌA B
{
ÓÓ 	
if
ÔÔ 
(
ÔÔ 
	parameter
ÔÔ 
is
ÔÔ )
GameInvitationItemViewModel
ÔÔ 8
invitationItem
ÔÔ9 G
)
ÔÔG H
{
 
GameInvitations
ÒÒ 
.
ÒÒ  
Remove
ÒÒ  &
(
ÒÒ& '
invitationItem
ÒÒ' 5
)
ÒÒ5 6
;
ÒÒ6 7
}
ÚÚ 
}
ÛÛ 	
private
ıı 
async
ıı 
Task
ıı '
ExecuteFilterFriendsAsync
ıı 4
(
ıı4 5
)
ıı5 6
{
ˆˆ 	$
_isFilteringOnlineOnly
˜˜ "
=
˜˜# $
!
˜˜% &$
_isFilteringOnlineOnly
˜˜& <
;
˜˜< =
await
¯¯ "
LoadFriendsListAsync
¯¯ &
(
¯¯& '
)
¯¯' (
;
¯¯( )
}
˘˘ 	
private
˚˚ 
static
˚˚ 
int
˚˚ $
GetAuthenticatedUserId
˚˚ 1
(
˚˚1 2
)
˚˚2 3
{
¸¸ 	
int
˝˝ 
userId
˝˝ 
=
˝˝ 
$num
˝˝ 
;
˝˝ 
if
ˇˇ 
(
ˇˇ 
UserSession
ˇˇ 
.
ˇˇ 
Current
ˇˇ #
.
ˇˇ# $
IsAuthenticated
ˇˇ$ 3
&&
ˇˇ4 6
UserSession
ˇˇ7 B
.
ˇˇB C
Current
ˇˇC J
.
ˇˇJ K
CurrentUser
ˇˇK V
!=
ˇˇW Y
null
ˇˇZ ^
)
ˇˇ^ _
{
ÄÄ 
userId
ÅÅ 
=
ÅÅ 
UserSession
ÅÅ $
.
ÅÅ$ %
Current
ÅÅ% ,
.
ÅÅ, -
CurrentUser
ÅÅ- 8
.
ÅÅ8 9
IdUser
ÅÅ9 ?
;
ÅÅ? @
}
ÇÇ 
return
ÑÑ 
userId
ÑÑ 
;
ÑÑ 
}
ÖÖ 	
private
áá 
bool
áá 
IsValidUserId
áá "
(
áá" #
int
áá# &
userId
áá' -
)
áá- .
{
àà 	
return
ââ 
userId
ââ 
>
ââ 
$num
ââ 
;
ââ 
}
ää 	
}
ãã 
}åå ﬂ
qC:\Users\oscar\source\repos\TrickTakingMissions\Client\ViewModel\ViewModels\Friends\FriendRequestItemViewModel.cs
	namespace 	
	ViewModel
 
. 

ViewModels 
{ 
public		 

sealed		 
class		 &
FriendRequestItemViewModel		 2
:		3 4
ViewModelBase		5 B
{

 
public &
FriendRequestItemViewModel )
() *
int* -
senderUserId. :
,: ;
string< B
senderUsernameC Q
,Q R
intS V
receiverUserIdW e
,e f
string 
receiverUsername #
,# $
DateTime% -
requestedAt. 9
)9 :
{ 	
SenderUserId 
= 
senderUserId '
;' (
SenderUsername 
= 
senderUsername +
??, .
string/ 5
.5 6
Empty6 ;
;; <
ReceiverUserId 
= 
receiverUserId +
;+ ,
ReceiverUsername 
= 
receiverUsername /
??0 2
string3 9
.9 :
Empty: ?
;? @
RequestedAt 
= 
requestedAt %
;% &
} 	
public 
int 
SenderUserId 
{  !
get" %
;% &
}' (
public 
string 
SenderUsername $
{% &
get' *
;* +
}, -
public 
int 
ReceiverUserId !
{" #
get$ '
;' (
}) *
public 
string 
ReceiverUsername &
{' (
get) ,
;, -
}. /
public 
DateTime 
RequestedAt #
{$ %
get& )
;) *
}+ ,
} 
} ∂
jC:\Users\oscar\source\repos\TrickTakingMissions\Client\ViewModel\ViewModels\Friends\FriendItemViewModel.cs
	namespace 	
	ViewModel
 
. 

ViewModels 
{ 
public 

sealed 
class 
FriendItemViewModel +
:, -
ViewModelBase. ;
{		 
private

 
bool

 
	_isOnline

 
;

 
public 
FriendItemViewModel "
(" #
int# &
userId' -
,- .
string/ 5
username6 >
,> ?
bool@ D
isOnlineE M
)M N
{ 	
UserId 
= 
userId 
; 
Username 
= 
username 
??  "
string# )
.) *
Empty* /
;/ 0
	_isOnline 
= 
isOnline  
;  !
} 	
public 
int 
UserId 
{ 
get 
;  
}! "
public 
string 
Username 
{  
get! $
;$ %
}& '
public 
bool 
IsOnline 
{ 	
get 
=> 
	_isOnline 
; 
set 
=> 
SetProperty 
( 
ref "
	_isOnline# ,
,, -
value. 3
)3 4
;4 5
} 	
} 
} ≠
uC:\Users\oscar\source\repos\TrickTakingMissions\Client\ViewModel\ViewModels\Authentication\ForgotPasswordViewModel.cs
	namespace 	
	ViewModel
 
. 

ViewModels 
{ 
public 

sealed 
class #
ForgotPasswordViewModel /
:0 1
ViewModelBase2 ?
{ 
private 
readonly 
IDialogService '
_dialogService( 6
;6 7
private 
string 
_email 
; 
public 
event 
Action 
RequestClose (
;( )
public 
event 
Action 
< 
string "
>" #
EmailSubmitted$ 2
;2 3
public #
ForgotPasswordViewModel &
(& '
IDialogService' 5
dialogService6 C
)C D
{   	
_dialogService!! 
=!! 
dialogService!! *
??!!+ -
throw!!. 3
new!!4 7!
ArgumentNullException!!8 M
(!!M N
nameof!!N T
(!!T U
dialogService!!U b
)!!b c
)!!c d
;!!d e
CloseCommand## 
=## 
new## 
RelayCommand## +
(##+ ,
ExecuteClose##, 8
)##8 9
;##9 :
SendCommand$$ 
=$$ 
new$$ 
RelayCommand$$ *
($$* +
ExecuteSend$$+ 6
)$$6 7
;$$7 8
}%% 	
public** 
string** 
Email** 
{++ 	
get,, 
=>,, 
_email,, 
;,, 
set-- 
=>-- 
SetProperty-- 
(-- 
ref-- "
_email--# )
,--) *
value--+ 0
)--0 1
;--1 2
}.. 	
public33 
ICommand33 
CloseCommand33 $
{33% &
get33' *
;33* +
}33, -
public88 
ICommand88 
SendCommand88 #
{88$ %
get88& )
;88) *
}88+ ,
private:: 
void:: 
ExecuteClose:: !
(::! "
)::" #
{;; 	
RequestClose<< 
?<< 
.<< 
Invoke<<  
(<<  !
)<<! "
;<<" #
}== 	
private?? 
void?? 
ExecuteSend??  
(??  !
)??! "
{@@ 	
stringAA 
trimmedEmailAA 
=AA  !
EmailAA" '
?AA' (
.AA( )
TrimAA) -
(AA- .
)AA. /
??AA0 2
stringAA3 9
.AA9 :
EmptyAA: ?
;AA? @
ifCC 
(CC 
stringCC 
.CC 
IsNullOrWhiteSpaceCC )
(CC) *
trimmedEmailCC* 6
)CC6 7
)CC7 8
{DD 
_dialogServiceEE 
.EE 
ShowWarningEE *
(EE* +
MessageCodeEE+ 6
.EE6 7

EmptyEmailEE7 A
)EEA B
;EEB C
}FF 
elseGG 
{HH 
EmailSubmittedII 
?II 
.II  
InvokeII  &
(II& '
trimmedEmailII' 3
)II3 4
;II4 5
}JJ 
}KK 	
}LL 
}MM ‹A
jC:\Users\oscar\source\repos\TrickTakingMissions\Client\ViewModel\ViewModels\Menu\EnterGameCodeViewModel.cs
	namespace 	
	ViewModel
 
. 

ViewModels 
{ 
public 

sealed 
class "
EnterGameCodeViewModel .
:/ 0
ViewModelBase1 >
{ 
private 
const 
int $
ServerErrorCodeLobbyFull 2
=3 4
$num5 8
;8 9
private 
const 
int 9
-ServerErrorCodeKickedParticipantReentryDenied G
=H I
$numJ M
;M N
private 
const 
string #
LogJoinLobbyUnavailable 4
=5 6
$str7 s
;s t
private 
const 
string  
LogJoinLobbyRejected 1
=2 3
$str4 x
;x y
private 
readonly 
IDialogService '
_dialogService( 6
;6 7
private 
readonly 
ILobbySession &
_lobbySession' 4
;4 5
private 
readonly 
ILoggerService '
_logger( /
;/ 0
private 
string 
	_gameCode  
;  !
public "
EnterGameCodeViewModel %
(% &
IDialogService& 4
dialogService5 B
,B C
ILobbySessionD Q
lobbySessionR ^
,^ _
ILoggerService` n
loggero u
)u v
{ 	
_dialogService 
= 
dialogService *
??+ -
throw. 3
new4 7!
ArgumentNullException8 M
(M N
nameofN T
(T U
dialogServiceU b
)b c
)c d
;d e
_lobbySession   
=   
lobbySession   (
??  ) +
throw  , 1
new  2 5!
ArgumentNullException  6 K
(  K L
nameof  L R
(  R S
lobbySession  S _
)  _ `
)  ` a
;  a b
_logger!! 
=!! 
logger!! 
??!! 
throw!!  %
new!!& )!
ArgumentNullException!!* ?
(!!? @
nameof!!@ F
(!!F G
logger!!G M
)!!M N
)!!N O
;!!O P
	_gameCode"" 
="" 
string"" 
."" 
Empty"" $
;""$ %
CloseCommand$$ 
=$$ 
new$$ 
RelayCommand$$ +
($$+ ,
ExecuteClose$$, 8
)$$8 9
;$$9 :
JoinCommand%% 
=%% 
new%% 
AsyncRelayCommand%% /
(%%/ 0
ExecuteJoinAsync%%0 @
)%%@ A
;%%A B
}&& 	
public(( 
event(( 
Action(( 
<(( 
bool((  
>((  !
RequestClose((" .
;((. /
public** 
string** 
GameCode** 
{++ 	
get,, 
=>,, 
	_gameCode,, 
;,, 
set-- 
=>-- 
SetProperty-- 
(-- 
ref-- "
	_gameCode--# ,
,--, -
value--. 3
)--3 4
;--4 5
}.. 	
public00 
ICommand00 
CloseCommand00 $
{00% &
get00' *
;00* +
}00, -
public22 
ICommand22 
JoinCommand22 #
{22$ %
get22& )
;22) *
}22+ ,
private44 
void44 
ExecuteClose44 !
(44! "
)44" #
{55 	
RequestClose66 
?66 
.66 
Invoke66  
(66  !
false66! &
)66& '
;66' (
}77 	
private99 
async99 
Task99 
ExecuteJoinAsync99 +
(99+ ,
)99, -
{:: 	
if;; 
(;; 
string;; 
.;; 
IsNullOrWhiteSpace;; )
(;;) *
	_gameCode;;* 3
);;3 4
);;4 5
{<< 
_dialogService== 
.== 
ShowWarning== *
(==* +
MessageCode==+ 6
.==6 7"
EnterGameCodeEmptyCode==7 M
)==M N
;==N O
}>> 
else?? 
{@@ 
awaitAA 
TryJoinLobbyAsyncAA '
(AA' (
)AA( )
;AA) *
}BB 
}CC 	
privateEE 
staticEE 
intEE &
ResolveLobbyEntryRejectionEE 5
(EE5 6
intEE6 9
serverErrorCodeEE: I
)EEI J
{FF 	
intGG  
rejectionMessageCodeGG $
;GG$ %
switchHH 
(HH 
serverErrorCodeHH #
)HH# $
{II 
caseJJ $
ServerErrorCodeLobbyFullJJ -
:JJ- . 
rejectionMessageCodeKK (
=KK) *
MessageCodeKK+ 6
.KK6 7)
EnterGameCodeLobbyAlreadyFullKK7 T
;KKT U
breakLL 
;LL 
caseMM 9
-ServerErrorCodeKickedParticipantReentryDeniedMM B
:MMB C 
rejectionMessageCodeNN (
=NN) *
MessageCodeNN+ 6
.NN6 7/
#LobbyKickedParticipantReentryDeniedNN7 Z
;NNZ [
breakOO 
;OO 
defaultPP 
:PP  
rejectionMessageCodeQQ (
=QQ) *
MessageCodeQQ+ 6
.QQ6 7$
EnterGameCodeInvalidCodeQQ7 O
;QQO P
breakRR 
;RR 
}SS 
returnUU  
rejectionMessageCodeUU '
;UU' (
}VV 	
privateXX 
asyncXX 
TaskXX 
TryJoinLobbyAsyncXX ,
(XX, -
)XX- .
{YY 	
intZZ 
userIdZZ 
=ZZ 
UserSessionZZ $
.ZZ$ %
CurrentZZ% ,
.ZZ, -
EnsureActiveUserIdZZ- ?
(ZZ? @
)ZZ@ A
;ZZA B
string[[ 
normalizedCode[[ !
=[[" #
	_gameCode[[$ -
.[[- .
Trim[[. 2
([[2 3
)[[3 4
.[[4 5
ToUpperInvariant[[5 E
([[E F
)[[F G
;[[G H
LobbyResult]] 
result]] 
=]]  
await]]! &
_lobbySession]]' 4
.]]4 5
Client]]5 ;
.]]; < 
JoinLobbyByCodeAsync]]< P
(]]P Q
normalizedCode]]Q _
,]]_ `
userId]]a g
)]]g h
;]]h i
if__ 
(__ 
result__ 
==__ 
null__ 
)__ 
{`` 
_loggeraa 
.aa 
Erroraa 
(aa #
LogJoinLobbyUnavailableaa 5
,aa5 6
normalizedCodeaa7 E
)aaE F
;aaF G
_dialogServicebb 
.bb 
	ShowErrorbb (
(bb( )
MessageCodebb) 4
.bb4 5
ConnectionFailedbb5 E
)bbE F
;bbF G
}cc 
elsedd 
ifdd 
(dd 
!dd 
resultdd 
.dd 
	IsSuccessdd &
||dd' )
resultdd* 0
.dd0 1
Lobbydd1 6
==dd7 9
nulldd: >
)dd> ?
{ee 
_loggerff 
.ff 
Warningff 
(ff   
LogJoinLobbyRejectedff  4
,ff4 5
normalizedCodeff6 D
,ffD E
resultffF L
.ffL M
	ErrorCodeffM V
)ffV W
;ffW X
intgg 
messageToDisplaygg $
=gg% &&
ResolveLobbyEntryRejectiongg' A
(ggA B
resultggB H
.ggH I
	ErrorCodeggI R
)ggR S
;ggS T
_dialogServiceii 
.ii 
ShowWarningii *
(ii* +
messageToDisplayii+ ;
)ii; <
;ii< =
}jj 
elsekk 
{ll 
_lobbySessionmm 
.mm 
SetLobbymm &
(mm& '
resultmm' -
.mm- .
Lobbymm. 3
)mm3 4
;mm4 5
RequestClosenn 
?nn 
.nn 
Invokenn $
(nn$ %
truenn% )
)nn) *
;nn* +
}oo 
}pp 	
}qq 
}rr ˜6
uC:\Users\oscar\source\repos\TrickTakingMissions\Client\ViewModel\ViewModels\Authentication\ChangePasswordViewModel.cs
	namespace 	
	ViewModel
 
. 

ViewModels 
{		 
public 

sealed 
class #
ChangePasswordViewModel /
:0 1
ViewModelBase2 ?
{ 
private 
const 
int !
MinimumPasswordLength /
=0 1
$num2 3
;3 4
private 
const 
string #
SpecialCharacterPattern 4
=5 6
$str7 F
;F G
private 
const 
string 
NumberPattern *
=+ ,
$str- 5
;5 6
private 
readonly 
IDialogService '
_dialogService( 6
;6 7
private 
string 
_newPassword #
;# $
private 
string 
_confirmPassword '
;' (
public 
event 
Action 
RequestClose (
;( )
public   #
ChangePasswordViewModel   &
(  & '
IDialogService  ' 5
dialogService  6 C
)  C D
{!! 	
_dialogService"" 
="" 
dialogService"" *
??""+ -
throw"". 3
new""4 7!
ArgumentNullException""8 M
(""M N
nameof""N T
(""T U
dialogService""U b
)""b c
)""c d
;""d e
CloseCommand$$ 
=$$ 
new$$ 
RelayCommand$$ +
($$+ ,
ExecuteClose$$, 8
)$$8 9
;$$9 :
ConfirmCommand%% 
=%% 
new%%  
RelayCommand%%! -
(%%- .
ExecuteConfirm%%. <
)%%< =
;%%= >
}&& 	
public++ 
string++ 
NewPassword++ !
{,, 	
get-- 
=>-- 
_newPassword-- 
;--  
set.. 
=>.. 
SetProperty.. 
(.. 
ref.. "
_newPassword..# /
,../ 0
value..1 6
)..6 7
;..7 8
}// 	
public44 
string44 
ConfirmPassword44 %
{55 	
get66 
=>66 
_confirmPassword66 #
;66# $
set77 
=>77 
SetProperty77 
(77 
ref77 "
_confirmPassword77# 3
,773 4
value775 :
)77: ;
;77; <
}88 	
public== 
ICommand== 
CloseCommand== $
{==% &
get==' *
;==* +
}==, -
publicBB 
ICommandBB 
ConfirmCommandBB &
{BB' (
getBB) ,
;BB, -
}BB. /
privateDD 
voidDD 
ExecuteCloseDD !
(DD! "
)DD" #
{EE 	
RequestCloseFF 
?FF 
.FF 
InvokeFF  
(FF  !
)FF! "
;FF" #
}GG 	
privateII 
voidII 
ExecuteConfirmII #
(II# $
)II$ %
{JJ 	
stringKK 
passwordKK 
=KK 
NewPasswordKK )
??KK* ,
stringKK- 3
.KK3 4
EmptyKK4 9
;KK9 :
stringLL 
confirmLL 
=LL 
ConfirmPasswordLL ,
??LL- /
stringLL0 6
.LL6 7
EmptyLL7 <
;LL< =
ifNN 
(NN 
IsPasswordValidNN 
(NN  
passwordNN  (
,NN( )
confirmNN* 1
)NN1 2
)NN2 3
{OO 
RequestCloseQQ 
?QQ 
.QQ 
InvokeQQ $
(QQ$ %
)QQ% &
;QQ& '
}RR 
}SS 	
privateUU 
boolUU 
IsPasswordValidUU $
(UU$ %
stringUU% +
passwordUU, 4
,UU4 5
stringUU6 <
confirmUU= D
)UUD E
{VV 	
boolWW 
isValidWW 
=WW 
falseWW  
;WW  !
ifYY 
(YY 
stringYY 
.YY 
IsNullOrEmptyYY $
(YY$ %
passwordYY% -
)YY- .
)YY. /
{ZZ 
_dialogService[[ 
.[[ 
ShowWarning[[ *
([[* +
MessageCode[[+ 6
.[[6 7!
RegisterEmptyPassword[[7 L
)[[L M
;[[M N
}\\ 
else]] 
if]] 
(]] 
string]] 
.]] 
IsNullOrEmpty]] )
(]]) *
confirm]]* 1
)]]1 2
)]]2 3
{^^ 
_dialogService__ 
.__ 
ShowWarning__ *
(__* +
MessageCode__+ 6
.__6 7-
!RegisterEmptyPasswordConfirmation__7 X
)__X Y
;__Y Z
}`` 
elseaa 
ifaa 
(aa 
passwordaa 
.aa 
Lengthaa $
<aa% &!
MinimumPasswordLengthaa' <
)aa< =
{bb 
_dialogServicecc 
.cc 
ShowWarningcc *
(cc* +
MessageCodecc+ 6
.cc6 7&
RegisterPasswordRuleLengthcc7 Q
)ccQ R
;ccR S
}dd 
elseee 
ifee 
(ee 
!ee 
Regexee 
.ee 
IsMatchee #
(ee# $
passwordee$ ,
,ee, -#
SpecialCharacterPatternee. E
)eeE F
)eeF G
{ff 
_dialogServicegg 
.gg 
ShowWarninggg *
(gg* +
MessageCodegg+ 6
.gg6 7+
RegisterPasswordRuleSpecialChargg7 V
)ggV W
;ggW X
}hh 
elseii 
ifii 
(ii 
!ii 
Regexii 
.ii 
IsMatchii #
(ii# $
passwordii$ ,
,ii, -
NumberPatternii. ;
)ii; <
)ii< =
{jj 
_dialogServicekk 
.kk 
ShowWarningkk *
(kk* +
MessageCodekk+ 6
.kk6 7&
RegisterPasswordRuleNumberkk7 Q
)kkQ R
;kkR S
}ll 
elsemm 
ifmm 
(mm 
!mm 
passwordmm 
.mm 
Equalsmm %
(mm% &
confirmmm& -
,mm- .
StringComparisonmm/ ?
.mm? @
Ordinalmm@ G
)mmG H
)mmH I
{nn 
_dialogServiceoo 
.oo 
ShowWarningoo *
(oo* +
MessageCodeoo+ 6
.oo6 7$
RegisterPasswordMismatchoo7 O
)ooO P
;ooP Q
}pp 
elseqq 
{rr 
isValidss 
=ss 
truess 
;ss 
}tt 
returnvv 
isValidvv 
;vv 
}ww 	
}xx 
}yy —
`C:\Users\oscar\source\repos\TrickTakingMissions\Client\ViewModel\Services\ViewModelUiServices.cs
	namespace 	
	ViewModel
 
. 
Services 
{ 
public		 

sealed		 
class		 
ViewModelUiServices		 +
{

 
public 
ViewModelUiServices "
(" #
INavigationService# 5
navigationService6 G
,G H
IDialogServiceI W
dialogServiceX e
,e f
ILoggerService 
logger !
)! "
{ 	
NavigationService 
= 
navigationService  1
??2 4
throw5 :
new; >!
ArgumentNullException? T
(T U
nameofU [
([ \
navigationService\ m
)m n
)n o
;o p
DialogService 
= 
dialogService )
??* ,
throw- 2
new3 6!
ArgumentNullException7 L
(L M
nameofM S
(S T
dialogServiceT a
)a b
)b c
;c d
Logger 
= 
logger 
?? 
throw $
new% (!
ArgumentNullException) >
(> ?
nameof? E
(E F
loggerF L
)L M
)M N
;N O
} 	
public 
INavigationService !
NavigationService" 3
{4 5
get6 9
;9 :
}; <
public 
IDialogService 
DialogService +
{, -
get. 1
;1 2
}3 4
public 
ILoggerService 
Logger $
{% &
get' *
;* +
}, -
} 
} Å
gC:\Users\oscar\source\repos\TrickTakingMissions\Client\ViewModel\Services\ViewModelNavigationLogging.cs
	namespace 	
	ViewModel
 
. 
Services 
{ 
public		 

sealed		 
class		 &
ViewModelNavigationLogging		 2
{

 
public &
ViewModelNavigationLogging )
() *
INavigationService* <
navigationService= N
,N O
ILoggerServiceP ^
logger_ e
)e f
{ 	
NavigationService 
= 
navigationService  1
??2 4
throw5 :
new; >!
ArgumentNullException? T
(T U
nameofU [
([ \
navigationService\ m
)m n
)n o
;o p
Logger 
= 
logger 
?? 
throw $
new% (!
ArgumentNullException) >
(> ?
nameof? E
(E F
loggerF L
)L M
)M N
;N O
} 	
public 
INavigationService !
NavigationService" 3
{4 5
get6 9
;9 :
}; <
public 
ILoggerService 
Logger $
{% &
get' *
;* +
}, -
} 
} ÿ
^C:\Users\oscar\source\repos\TrickTakingMissions\Client\ViewModel\Services\MatchBoardContext.cs
	namespace 	
	ViewModel
 
. 
Services 
{ 
public		 

sealed		 
class		 
MatchBoardContext		 )
{

 
private 
const 
string !
EmptyLobbyCodeMessage 2
=3 4
$str5 a
;a b
public 
MatchBoardContext  
(  !
string! '
	lobbyCode( 1
,1 2
int3 6
participantUserId7 H
,H I
IMatchClientJ V
matchClientW b
)b c
{ 	
if 
( 
string 
. 
IsNullOrWhiteSpace )
() *
	lobbyCode* 3
)3 4
)4 5
{ 
throw 
new 
ArgumentException +
(+ ,!
EmptyLobbyCodeMessage, A
,A B
nameofC I
(I J
	lobbyCodeJ S
)S T
)T U
;U V
} 
	LobbyCode 
= 
	lobbyCode !
;! "
ParticipantUserId 
= 
participantUserId  1
;1 2
MatchClient 
= 
matchClient %
??& (
throw) .
new/ 2!
ArgumentNullException3 H
(H I
nameofI O
(O P
matchClientP [
)[ \
)\ ]
;] ^
} 	
public 
string 
	LobbyCode 
{  !
get" %
;% &
}' (
public 
int 
ParticipantUserId $
{% &
get' *
;* +
}, -
public 
IMatchClient 
MatchClient '
{( )
get* -
;- .
}/ 0
} 
} Ç
_C:\Users\oscar\source\repos\TrickTakingMissions\Client\ViewModel\Services\INavigationService.cs
	namespace 	
	ViewModel
 
. 
Services 
{ 
public 

	interface 
INavigationService '
{ 
void 

NavigateTo 
( 
int 
viewId "
)" #
;# $
void 
GoBack 
( 
) 
; 
void 

ShowDialog 
( 
int 
dialogId $
)$ %
;% &
} 
} ´
]C:\Users\oscar\source\repos\TrickTakingMissions\Client\ViewModel\Services\ILanguageService.cs
	namespace 	
	ViewModel
 
. 
Services 
{ 
public 

	interface 
ILanguageService %
{ 
string 
CurrentCultureCode !
{" #
get$ '
;' (
}) *
void 
ChangeLanguage 
( 
string "
cultureCode# .
). /
;/ 0
} 
} µ
[C:\Users\oscar\source\repos\TrickTakingMissions\Client\ViewModel\Services\IDialogService.cs
	namespace 	
	ViewModel
 
. 
Services 
{ 
public 

	interface 
IDialogService #
{ 
void 
ShowInformation 
( 
int  
messageCode! ,
), -
;- .
void 
ShowWarning 
( 
int 
messageCode (
)( )
;) *
void 
	ShowError 
( 
int 
messageCode &
)& '
;' (
} 
} Ü
[C:\Users\oscar\source\repos\TrickTakingMissions\Client\ViewModel\Properties\AssemblyInfo.cs
[ 
assembly 	
:	 

AssemblyTitle 
( 
$str $
)$ %
]% &
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
$str &
)& '
]' (
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
]!!) *Ù
TC:\Users\oscar\source\repos\TrickTakingMissions\Client\ViewModel\Constants\ViewId.cs
	namespace 	
	ViewModel
 
. 
	Constants 
{ 
public 

static 
class 
ViewId 
{ 
public		 
const		 
int		 
None		 
=		 
$num		  !
;		! "
public 
const 
int 

HomeScreen #
=$ %
$num& '
;' (
public 
const 
int 
	LoginPage "
=# $
$num% &
;& '
public 
const 
int 
RegisterPage %
=& '
$num( )
;) *
public 
const 
int 
GameMenu !
=" #
$num$ %
;% &
public 
const 
int 
Lobby 
=  
$num! "
;" #
public 
const 
int 
Profile  
=! "
$num# $
;$ %
public 
const 
int 
RecoverPassword (
=) *
$num+ ,
;, -
public 
const 
int 
SendFriendRequest *
=+ ,
$num- .
;. /
public 
const 
int 
	GameMatch "
=# $
$num% &
;& '
public 
const 
int  
ForgotPasswordDialog -
=. /
$num0 3
;3 4
public 
const 
int  
ChangePasswordDialog -
=. /
$num0 3
;3 4
public 
const 
int 
EnterGameCodeDialog ,
=- .
$num/ 2
;2 3
public 
const 
int 
GameSettingsDialog +
=, -
$num. 1
;1 2
public 
const 
int 
HowToPlayDialog (
=) *
$num+ .
;. /
public 
const 
int %
ManageFriendRequestDialog 2
=3 4
$num5 8
;8 9
public 
const 
int 
ScoreBoardDialog )
=* +
$num, /
;/ 0
public 
const 
int  
SelectLanguageDialog -
=. /
$num0 3
;3 4
} 
}   ≠%
YC:\Users\oscar\source\repos\TrickTakingMissions\Client\ViewModel\Constants\MessageCode.cs
	namespace 	
	ViewModel
 
. 
	Constants 
{ 
public 

static 
class 
MessageCode #
{ 
public		 
const		 
int		 
None		 
=		 
$num		  !
;		! "
public 
const 
int 

EmptyEmail #
=$ %
$num& *
;* +
public 
const 
int 
EmptyPassword &
=' (
$num) -
;- .
public 
const 
int 
InvalidCredentials +
=, -
$num. 2
;2 3
public 
const 
int 
ChatAccountBanned *
=+ ,
$num- 1
;1 2
public 
const 
int "
ChatStorageUnavailable /
=0 1
$num2 6
;6 7
public 
const 
int  
RegisterInvalidEmail -
=. /
$num0 4
;4 5
public 
const 
int 
RegisterEmptyEmail +
=, -
$num. 2
;2 3
public 
const 
int !
RegisterEmptyUsername .
=/ 0
$num1 5
;5 6
public 
const 
int !
RegisterEmptyPassword .
=/ 0
$num1 5
;5 6
public 
const 
int -
!RegisterEmptyPasswordConfirmation :
=; <
$num= A
;A B
public 
const 
int $
RegisterPasswordMismatch 1
=2 3
$num4 8
;8 9
public 
const 
int &
RegisterPasswordRuleLength 3
=4 5
$num6 :
;: ;
public 
const 
int +
RegisterPasswordRuleSpecialChar 8
=9 :
$num; ?
;? @
public 
const 
int &
RegisterPasswordRuleNumber 3
=4 5
$num6 :
;: ;
public 
const 
int *
RegisterEmailAlreadyRegistered 7
=8 9
$num: >
;> ?
public 
const 
int -
!RegisterUsernameAlreadyRegistered :
=; <
$num= A
;A B
public 
const 
int 
RegisterSuccess (
=) *
$num+ /
;/ 0
public 
const 
int +
RegisterEmailPermanentlyBlocked 8
=9 :
$num; ?
;? @
public   
const   
int   %
AccountStorageUnavailable   2
=  3 4
$num  5 8
;  8 9
public## 
const## 
int## "
EnterGameCodeEmptyCode## /
=##0 1
$num##2 6
;##6 7
public$$ 
const$$ 
int$$ $
EnterGameCodeInvalidCode$$ 1
=$$2 3
$num$$4 8
;$$8 9
public%% 
const%% 
int%% )
EnterGameCodeLobbyAlreadyFull%% 6
=%%7 8
$num%%9 =
;%%= >
public&& 
const&& 
int&& 
LobbyHostRequired&& *
=&&+ ,
$num&&- 1
;&&1 2
public'' 
const'' 
int'' %
LobbyConfigurationInvalid'' 2
=''3 4
$num''5 9
;''9 :
public(( 
const(( 
int((  
LobbyMatchInProgress(( -
=((. /
$num((0 4
;((4 5
public)) 
const)) 
int)) /
#LobbyKickedParticipantReentryDenied)) <
=))= >
$num))? C
;))C D
public,, 
const,, 
int,, 
EmptyFriendUsername,, ,
=,,- .
$num,,/ 3
;,,3 4
public// 
const// 
int// 
ConnectionFailed// )
=//* +
$num//, 0
;//0 1
public00 
const00 
int00 
RequestTimeout00 '
=00( )
$num00* .
;00. /
public11 
const11 
int11 
CommunicationError11 +
=11, -
$num11. 2
;112 3
public22 
const22 
int22 
UnexpectedError22 (
=22) *
$num22+ /
;22/ 0
}33 
}44 ˙
VC:\Users\oscar\source\repos\TrickTakingMissions\Client\ViewModel\Base\ViewModelBase.cs
	namespace 	
	ViewModel
 
. 
Base 
{ 
public		 

abstract		 
class		 
ViewModelBase		 '
:		( )"
INotifyPropertyChanged		* @
{

 
public 
event '
PropertyChangedEventHandler 0
PropertyChanged1 @
;@ A
	protected 
virtual 
void 
OnPropertyChanged 0
(0 1
[1 2
CallerMemberName2 B
]B C
stringD J
propertyNameK W
=X Y
nullZ ^
)^ _
{ 	
PropertyChanged 
? 
. 
Invoke #
(# $
this$ (
,( )
new* -$
PropertyChangedEventArgs. F
(F G
propertyNameG S
)S T
)T U
;U V
} 	
	protected 
virtual 
bool 
SetProperty *
<* +
T+ ,
>, -
(- .
ref. 1
T2 3
storage4 ;
,; <
T= >
value? D
,D E
[F G
CallerMemberNameG W
]W X
stringY _
propertyName` l
=m n
nullo s
)s t
{ 	
bool   
isValueChanged   
;    
if"" 
("" 
Equals"" 
("" 
storage"" 
,"" 
value""  %
)""% &
)""& '
{## 
isValueChanged$$ 
=$$  
false$$! &
;$$& '
}%% 
else&& 
{'' 
isValueChanged(( 
=((  
true((! %
;((% &
storage)) 
=)) 
value)) 
;))  
OnPropertyChanged** !
(**! "
propertyName**" .
)**. /
;**/ 0
}++ 
return-- 
isValueChanged-- !
;--! "
}.. 	
}// 
}00 €
UC:\Users\oscar\source\repos\TrickTakingMissions\Client\ViewModel\Base\RelayCommand.cs
	namespace 	
	ViewModel
 
. 
Base 
{ 
public

 

class

 
RelayCommand

 
:

 
ICommand

  (
{ 
private 
readonly 
Action 
<  
object  &
>& '
_execute( 0
;0 1
private 
readonly 
	Predicate "
<" #
object# )
>) *
_canExecute+ 6
;6 7
public 
event 
EventHandler !
CanExecuteChanged" 3
{ 	
add 
=> 
CommandManager !
.! "
RequerySuggested" 2
+=3 5
value6 ;
;; <
remove 
=> 
CommandManager $
.$ %
RequerySuggested% 5
-=6 8
value9 >
;> ?
} 	
public 
RelayCommand 
( 
Action "
<" #
object# )
>) *
execute+ 2
,2 3
	Predicate4 =
<= >
object> D
>D E

canExecuteF P
=Q R
nullS W
)W X
{ 	
_execute   
=   
execute   
??   !
throw  " '
new  ( +!
ArgumentNullException  , A
(  A B
nameof  B H
(  H I
execute  I P
)  P Q
)  Q R
;  R S
_canExecute!! 
=!! 

canExecute!! $
;!!$ %
}"" 	
public)) 
RelayCommand)) 
()) 
Action)) "
execute))# *
,))* +
Func)), 0
<))0 1
bool))1 5
>))5 6

canExecute))7 A
=))B C
null))D H
)))H I
:** 
this** 
(** 
_** 
=>** 
execute** 
(**  
)**  !
,**! "

canExecute**# -
==**. 0
null**1 5
?**6 7
(**8 9
	Predicate**9 B
<**B C
object**C I
>**I J
)**J K
null**K O
:**P Q
_**R S
=>**T V

canExecute**W a
(**a b
)**b c
)**c d
{++ 	
if,, 
(,, 
execute,, 
==,, 
null,, 
),,  
{-- 
throw.. 
new.. !
ArgumentNullException.. /
(../ 0
nameof..0 6
(..6 7
execute..7 >
)..> ?
)..? @
;..@ A
}// 
}00 	
public55 
bool55 

CanExecute55 
(55 
object55 %
	parameter55& /
)55/ 0
{66 	
return77 
_canExecute77 
==77 !
null77" &
||77' )
_canExecute77* 5
(775 6
	parameter776 ?
)77? @
;77@ A
}88 	
public== 
void== 
Execute== 
(== 
object== "
	parameter==# ,
)==, -
{>> 	
_execute?? 
(?? 
	parameter?? 
)?? 
;??  
}@@ 	
publicEE 
voidEE "
RaiseCanExecuteChangedEE *
(EE* +
)EE+ ,
{FF 	
CommandManagerGG 
.GG &
InvalidateRequerySuggestedGG 5
(GG5 6
)GG6 7
;GG7 8
}HH 	
}II 
}JJ †*
ZC:\Users\oscar\source\repos\TrickTakingMissions\Client\ViewModel\Base\AsyncRelayCommand.cs
	namespace 	
	ViewModel
 
. 
Base 
{ 
public 

sealed 
class 
AsyncRelayCommand )
:* +
ICommand, 4
{ 
private 
readonly 
Func 
< 
object $
,$ %
Task& *
>* +&
_executeWithParameterAsync, F
;F G
private 
readonly 
Func 
< 
Task "
>" #
_executeAsync$ 1
;1 2
private 
readonly 
	Predicate "
<" #
object# )
>) *$
_canExecuteWithParameter+ C
;C D
private 
readonly 
Func 
< 
bool "
>" #
_canExecute$ /
;/ 0
private 
bool 

_isRunning 
;  
public 
AsyncRelayCommand  
(  !
Func! %
<% &
Task& *
>* +
executeAsync, 8
,8 9
Func: >
<> ?
bool? C
>C D

canExecuteE O
=P Q
nullR V
)V W
{ 	
_executeAsync 
= 
executeAsync (
??) +
throw, 1
new2 5!
ArgumentNullException6 K
(K L
nameofL R
(R S
executeAsyncS _
)_ `
)` a
;a b
_canExecute 
= 

canExecute $
;$ %
} 	
public## 
AsyncRelayCommand##  
(##  !
Func$$ 
<$$ 
object$$ 
,$$ 
Task$$ 
>$$ %
executeWithParameterAsync$$ 8
,$$8 9
	Predicate%% 
<%% 
object%% 
>%% #
canExecuteWithParameter%% 5
=%%6 7
null%%8 <
)%%< =
{&& 	&
_executeWithParameterAsync'' &
=''' (%
executeWithParameterAsync'') B
??(( 
throw(( 
new(( !
ArgumentNullException(( 2
(((2 3
nameof((3 9
(((9 :%
executeWithParameterAsync((: S
)((S T
)((T U
;((U V$
_canExecuteWithParameter)) $
=))% &#
canExecuteWithParameter))' >
;))> ?
}** 	
public,, 
event,, 
EventHandler,, !
CanExecuteChanged,," 3
{-- 	
add.. 
=>.. 
CommandManager.. !
...! "
RequerySuggested.." 2
+=..3 5
value..6 ;
;..; <
remove// 
=>// 
CommandManager// $
.//$ %
RequerySuggested//% 5
-=//6 8
value//9 >
;//> ?
}00 	
public22 
bool22 

CanExecute22 
(22 
object22 %
	parameter22& /
)22/ 0
{33 	
bool44  
isAllowedByPredicate44 %
=44& '
true44( ,
;44, -
if66 
(66 $
_canExecuteWithParameter66 (
!=66) +
null66, 0
)660 1
{77  
isAllowedByPredicate88 $
=88% &$
_canExecuteWithParameter88' ?
(88? @
	parameter88@ I
)88I J
;88J K
}99 
else:: 
if:: 
(:: 
_canExecute::  
!=::! #
null::$ (
)::( )
{;;  
isAllowedByPredicate<< $
=<<% &
_canExecute<<' 2
(<<2 3
)<<3 4
;<<4 5
}== 
return?? 
!?? 

_isRunning?? 
&&?? ! 
isAllowedByPredicate??" 6
;??6 7
}@@ 	
publicBB 
voidBB 
ExecuteBB 
(BB 
objectBB "
	parameterBB# ,
)BB, -
{CC 	
_DD 
=DD 
RunAsyncDD 
(DD 
	parameterDD "
)DD" #
;DD# $
}EE 	
privateGG 
asyncGG 
TaskGG 
RunAsyncGG #
(GG# $
objectGG$ *
	parameterGG+ 4
)GG4 5
{HH 	

_isRunningII 
=II 
trueII 
;II 
CommandManagerJJ 
.JJ &
InvalidateRequerySuggestedJJ 5
(JJ5 6
)JJ6 7
;JJ7 8
tryLL 
{MM 
ifNN 
(NN &
_executeWithParameterAsyncNN .
!=NN/ 1
nullNN2 6
)NN6 7
{OO 
awaitPP &
_executeWithParameterAsyncPP 4
(PP4 5
	parameterPP5 >
)PP> ?
;PP? @
}QQ 
elseRR 
{SS 
awaitTT 
_executeAsyncTT '
(TT' (
)TT( )
;TT) *
}UU 
}VV 
finallyWW 
{XX 

_isRunningYY 
=YY 
falseYY "
;YY" #
CommandManagerZZ 
.ZZ &
InvalidateRequerySuggestedZZ 9
(ZZ9 :
)ZZ: ;
;ZZ; <
}[[ 
}\\ 	
}]] 
}^^ À
eC:\Users\oscar\source\repos\TrickTakingMissions\Client\ViewModel\Services\IChatModerationPresenter.cs
	namespace 	
	ViewModel
 
. 
Services 
{ 
public 

	interface $
IChatModerationPresenter -
{ 
string		 (
FormatChatSubmissionFeedback		 +
(		+ ,-
!LobbyChatMessageSubmissionOutcome		, M(
chatMessageSubmissionOutcome		N j
)		j k
;		k l
string 
FormatAccountBan 
(   
ChatAccountBanNotice  4 
chatAccountBanNotice5 I
)I J
;J K
void 
ShowChatAccountBan 
(   
ChatAccountBanNotice  4 
chatAccountBanNotice5 I
)I J
;J K
} 
} Â
nC:\Users\oscar\source\repos\TrickTakingMissions\Client\ViewModel\ViewModels\Lobby\LobbyChatMessageViewModel.cs
	namespace 	
	ViewModel
 
. 

ViewModels 
{ 
public 

sealed 
class %
LobbyChatMessageViewModel 1
:2 3
ViewModelBase4 A
,A B
IDisposableC N
{ 
private 
readonly 
LobbyMessage %!
_publishedChatMessage& ;
;; <
public %
LobbyChatMessageViewModel (
(( )
LobbyMessage) 5 
publishedChatMessage6 J
)J K
{ 	!
_publishedChatMessage !
=" # 
publishedChatMessage$ 8
??9 ;
throw 
new !
ArgumentNullException /
(/ 0
nameof0 6
(6 7 
publishedChatMessage7 K
)K L
)L M
;M N
} 	
public 
string 
SenderUsername $
=>% '!
_publishedChatMessage( =
.= >
SenderUsername> L
;L M
public 
string 
Message 
=>  !
_publishedChatMessage! 6
.6 7
Message7 >
;> ?
public !
ProfileImageViewModel $
ProfileImage% 1
{2 3
get4 7
;7 8
private9 @
setA D
;D E
}F G
public 
void 
AttachProfileImage &
(& '
IProfileImageCache' 9
profileImageCache: K
)K L
{ 	
ProfileImage 
? 
. 
Dispose !
(! "
)" #
;# $
ProfileImage 
= 
new !
ProfileImageViewModel 4
(4 5!
_publishedChatMessage5 J
.J K
SenderUserIdK W
,W X
profileImageCacheY j
)j k
;k l
OnPropertyChanged 
( 
nameof $
($ %
ProfileImage% 1
)1 2
)2 3
;3 4
}   	
public"" 
void"" 
Dispose"" 
("" 
)"" 
{## 	
ProfileImage$$ 
?$$ 
.$$ 
Dispose$$ !
($$! "
)$$" #
;$$# $
}%% 	
}&& 
}'' —∂
gC:\Users\oscar\source\repos\TrickTakingMissions\Client\ViewModel\ViewModels\Lobby\LobbyChatViewModel.cs
	namespace 	
	ViewModel
 
. 

ViewModels 
{ 
public 

sealed 
class 
LobbyChatViewModel *
:+ ,
ViewModelBase- :
,: ;
IDisposable< G
{ 
private 
const 
int &
MaximumVisibleChatMessages 4
=5 6
$num7 :
;: ;
private 
const 
string "
LogChatDeliveryUnknown 3
=4 5
$str T
;T U
private 
const 
string (
LogChatModerationUnavailable 9
=: ;
$str J
;J K
private 
const 
string  
LogAccountBanApplied 1
=2 3
$str4 t
;t u
private 
readonly 
ILobbySession &
_lobbySession' 4
;4 5
private 
readonly 
ILobbyClient %
_chatLobbyClient& 6
;6 7
private 
readonly 
INavigationService +
_navigationService, >
;> ?
private 
readonly 
ILoggerService '
_logger( /
;/ 0
private   
readonly   $
IChatModerationPresenter   1$
_chatModerationPresenter  2 J
;  J K
private!! 
readonly!! "
SynchronizationContext!! /)
_chatUiSynchronizationContext!!0 M
;!!M N
private"" 
readonly"" 
string"" 
_chatLobbyCode""  .
;"". /
private## 
string## !
_draftChatMessageText## ,
;##, -
private$$ &
LobbyChatMessageSubmission$$ *)
_pendingChatMessageSubmission$$+ H
;$$H I
private%% -
!LobbyChatMessageSubmissionOutcome%% 1#
_chatSubmissionFeedback%%2 I
;%%I J
private&& 
bool&& #
_isChatSendingAvailable&& ,
;&&, -
private'' 
long'' )
_chatAvailabilityStateVersion'' 2
;''2 3
private(( 
bool(( !
_hasAppliedAccountBan(( *
;((* +
private)) 
bool)) 
_isChatDisposed)) $
;))$ %
private** 
IProfileImageCache** "
_profileImageCache**# 5
;**5 6
public,, 
LobbyChatViewModel,, !
(,,! "&
ViewModelNavigationLogging,," <
navigationLogging,,= N
,,,N O
ILobbySession,,P ]
lobbySession,,^ j
,,,j k$
IChatModerationPresenter-- $#
chatModerationPresenter--% <
)--< =
{.. 	
if// 
(// 
navigationLogging// !
==//" $
null//% )
)//) *
{00 
throw11 
new11 !
ArgumentNullException11 /
(11/ 0
nameof110 6
(116 7
navigationLogging117 H
)11H I
)11I J
;11J K
}22 
_lobbySession44 
=44 
lobbySession44 (
??44) +
throw44, 1
new442 5!
ArgumentNullException446 K
(44K L
nameof44L R
(44R S
lobbySession44S _
)44_ `
)44` a
;44a b
_chatLobbyClient55 
=55 
lobbySession55 +
.55+ ,
Client55, 2
;552 3
_navigationService66 
=66  
navigationLogging66! 2
.662 3
NavigationService663 D
;66D E
_logger77 
=77 
navigationLogging77 '
.77' (
Logger77( .
;77. /$
_chatModerationPresenter88 $
=88% &#
chatModerationPresenter88' >
;88> ?)
_chatUiSynchronizationContext99 )
=99* +"
SynchronizationContext99, B
.99B C
Current99C J
;99J K
_chatLobbyCode:: 
=:: 
lobbySession:: )
.::) *
CurrentLobby::* 6
?::6 7
.::7 8
	LobbyCode::8 A
??::B D
string::E K
.::K L
Empty::L Q
;::Q R#
_isChatSendingAvailable;; #
=;;$ %
lobbySession;;& 2
.;;2 3
CurrentLobby;;3 ?
?;;? @
.;;@ A"
IsChatSendingAvailable;;A W
==;;X Z
true;;[ _
;;;_ `)
_chatAvailabilityStateVersion<< )
=<<* +
lobbySession<<, 8
.<<8 9
CurrentLobby<<9 E
?<<E F
.<<F G
StateVersion<<G S
??<<T V
$num<<W X
;<<X Y!
_draftChatMessageText== !
===" #
string==$ *
.==* +
Empty==+ 0
;==0 1
if>> 
(>> 
!>> #
_isChatSendingAvailable>> (
)>>( )
{?? '
ShowChatUnavailableFeedback@@ +
(@@+ ,
)@@, -
;@@- .
}AA 
ChatMessagesBB 
=BB 
newBB  
ObservableCollectionBB 3
<BB3 4%
LobbyChatMessageViewModelBB4 M
>BBM N
(BBN O
)BBO P
;BBP Q"
SendChatMessageCommandCC "
=CC# $
newCC% (
AsyncRelayCommandCC) :
(CC: ; 
SendChatMessageAsyncCC; O
,CCO P
CanSendChatMessageCCQ c
)CCc d
;CCd e
_chatLobbyClientDD 
.DD 
LobbyStateChangedDD .
+=DD/ 1#
OnChatLobbyStateChangedDD2 I
;DDI J
_chatLobbyClientEE 
.EE 
ChatMessageReceivedEE 0
+=EE1 3&
OnLobbyChatMessageReceivedEE4 N
;EEN O
_chatLobbyClientFF 
.FF !
ChatAccountBanAppliedFF 2
+=FF3 5#
OnChatAccountBanAppliedFF6 M
;FFM N
}GG 	
publicII  
ObservableCollectionII #
<II# $%
LobbyChatMessageViewModelII$ =
>II= >
ChatMessagesII? K
{IIL M
getIIN Q
;IIQ R
}IIS T
publicKK 
stringKK  
DraftChatMessageTextKK *
{LL 	
getMM 
=>MM !
_draftChatMessageTextMM (
;MM( )
setNN 
{OO 
SetPropertyPP 
(PP 
refPP !
_draftChatMessageTextPP  5
,PP5 6
valuePP7 <
)PP< =
;PP= >
CommandManagerQQ 
.QQ &
InvalidateRequerySuggestedQQ 9
(QQ9 :
)QQ: ;
;QQ; <
}RR 
}SS 	
publicUU 
boolUU ,
 IsRegisteredAccountChatAvailableUU 4
=>UU5 7#
_isChatSendingAvailableVV #
&&VV$ &
!WW 
stringWW 
.WW 
IsNullOrEmptyWW !
(WW! "
UserSessionWW" -
.WW- .
CurrentWW. 5
.WW5 6
CurrentUserWW6 A
?WWA B
.WWB C
AccountSessionTokenWWC V
)WWV W
&&WWX Z
!WW[ \!
_hasAppliedAccountBanWW\ q
;WWq r
publicYY -
!LobbyChatMessageSubmissionOutcomeYY 0"
ChatSubmissionFeedbackYY1 G
{ZZ 	
get[[ 
=>[[ #
_chatSubmissionFeedback[[ *
;[[* +
private\\ 
set\\ 
{]] 
if^^ 
(^^ 
SetProperty^^ 
(^^  
ref^^  ##
_chatSubmissionFeedback^^$ ;
,^^; <
value^^= B
)^^B C
)^^C D
{__ 
OnPropertyChanged`` %
(``% &
nameof``& ,
(``, -&
ChatSubmissionFeedbackText``- G
)``G H
)``H I
;``I J
}aa 
}bb 
}cc 	
publicee 
stringee &
ChatSubmissionFeedbackTextee 0
=>ee1 3$
_chatModerationPresenterff $
.ff$ %(
FormatChatSubmissionFeedbackff% A
(ffA B"
ChatSubmissionFeedbackffB X
)ffX Y
;ffY Z
publichh 
ICommandhh "
SendChatMessageCommandhh .
{hh/ 0
gethh1 4
;hh4 5
}hh6 7
publicjj 
voidjj "
ConfigureProfileImagesjj *
(jj* +
IProfileImageCachejj+ =
profileImageCachejj> O
)jjO P
{kk 	
_profileImageCachell 
=ll  
profileImageCachell! 2
;ll2 3
foreachmm 
(mm %
LobbyChatMessageViewModelmm .
chatMessagemm/ :
inmm; =
ChatMessagesmm> J
)mmJ K
{nn 
chatMessageoo 
.oo 
AttachProfileImageoo .
(oo. /
profileImageCacheoo/ @
)oo@ A
;ooA B
}pp 
}qq 	
publicss 
voidss 
Disposess 
(ss 
)ss 
{tt 	
_isChatDisposeduu 
=uu 
trueuu "
;uu" #
foreachvv 
(vv %
LobbyChatMessageViewModelvv .
chatMessagevv/ :
invv; =
ChatMessagesvv> J
)vvJ K
{ww 
chatMessagexx 
.xx 
Disposexx #
(xx# $
)xx$ %
;xx% &
}yy 
_chatLobbyClientzz 
.zz 
LobbyStateChangedzz .
-=zz/ 1#
OnChatLobbyStateChangedzz2 I
;zzI J
_chatLobbyClient{{ 
.{{ 
ChatMessageReceived{{ 0
-={{1 3&
OnLobbyChatMessageReceived{{4 N
;{{N O
_chatLobbyClient|| 
.|| !
ChatAccountBanApplied|| 2
-=||3 5#
OnChatAccountBanApplied||6 M
;||M N
}}} 	
private 
bool 
CanSendChatMessage '
(' (
)( )
{
ÄÄ 	
return
ÅÅ 
!
ÅÅ 
_isChatDisposed
ÅÅ #
&&
ÅÅ$ &.
 IsRegisteredAccountChatAvailable
ÅÅ' G
&&
ÅÅH J
!
ÇÇ 
string
ÇÇ 
.
ÇÇ  
IsNullOrWhiteSpace
ÇÇ *
(
ÇÇ* +"
DraftChatMessageText
ÇÇ+ ?
)
ÇÇ? @
;
ÇÇ@ A
}
ÉÉ 	
private
ÖÖ 
async
ÖÖ 
Task
ÖÖ "
SendChatMessageAsync
ÖÖ /
(
ÖÖ/ 0
)
ÖÖ0 1
{
ÜÜ 	*
PreparePendingChatSubmission
áá (
(
áá( )
)
áá) *
;
áá* +(
LobbyChatMessageSubmission
àà &"
submittedChatMessage
àà' ;
=
àà< =+
_pendingChatMessageSubmission
àà> [
;
àà[ \/
!LobbyChatMessageSubmissionOutcome
ââ -*
chatMessageSubmissionOutcome
ââ. J
=
ââK L
await
ää 
_chatLobbyClient
ää &
.
ää& ''
SendLobbyChatMessageAsync
ää' @
(
ää@ A"
submittedChatMessage
ãã $
)
ãã$ %
;
ãã% &
if
åå 
(
åå 
!
åå 
_isChatDisposed
åå  
&&
åå! #
!
åå$ %#
_hasAppliedAccountBan
åå% :
)
åå: ;
{
çç '
ProcessSubmissionFeedback
éé )
(
éé) *"
submittedChatMessage
éé* >
,
éé> ?*
chatMessageSubmissionOutcome
éé@ \
)
éé\ ]
;
éé] ^
}
èè 
}
êê 	
private
íí 
void
íí *
PreparePendingChatSubmission
íí 1
(
íí1 2
)
íí2 3
{
ìì 	
if
îî 
(
îî +
_pendingChatMessageSubmission
îî -
==
îî. 0
null
îî1 5
||
îî6 8+
_pendingChatMessageSubmission
ïï -
.
ïï- .%
OriginalChatMessageText
ïï. E
!=
ïïF H"
DraftChatMessageText
ïïI ]
)
ïï] ^
{
ññ +
_pendingChatMessageSubmission
óó -
=
óó. /
new
óó0 3(
LobbyChatMessageSubmission
óó4 N
{
òò %
ChatMessageSubmissionId
ôô +
=
ôô, -
Guid
ôô. 2
.
ôô2 3
NewGuid
ôô3 :
(
ôô: ;
)
ôô; <
,
ôô< =
	LobbyCode
öö 
=
öö 
_chatLobbyCode
öö  .
,
öö. /%
OriginalChatMessageText
õõ +
=
õõ, -"
DraftChatMessageText
õõ. B
}
úú 
;
úú 
}
ùù 
}
ûû 	
private
†† 
void
†† '
ProcessSubmissionFeedback
†† .
(
††. /(
LobbyChatMessageSubmission
††/ I"
submittedChatMessage
††J ^
,
††^ _/
!LobbyChatMessageSubmissionOutcome
°° -*
chatMessageSubmissionOutcome
°°. J
)
°°J K
{
¢¢ 	
if
££ 
(
££ *
chatMessageSubmissionOutcome
££ ,
==
££- /
null
££0 4
)
££4 5
{
§§ 
_logger
•• 
.
•• 
Warning
•• 
(
••  $
LogChatDeliveryUnknown
••  6
,
••6 7
_chatLobbyCode
••8 F
)
••F G
;
••G H$
ChatSubmissionFeedback
¶¶ &
=
¶¶' (
new
¶¶) ,/
!LobbyChatMessageSubmissionOutcome
¶¶- N
{
ßß (
ChatMessageRejectionReason
®® .
=
®®/ 0(
ChatMessageRejectionReason
®®1 K
.
®®K L!
ChatDeliveryUnknown
®®L _
}
©© 
;
©© 
}
™™ 
else
´´ 
{
¨¨ $
ChatSubmissionFeedback
≠≠ &
=
≠≠' (*
chatMessageSubmissionOutcome
≠≠) E
;
≠≠E F
if
ÆÆ 
(
ÆÆ *
chatMessageSubmissionOutcome
ÆÆ 0
.
ÆÆ0 1"
ChatAccountBanNotice
ÆÆ1 E
!=
ÆÆF H
null
ÆÆI M
)
ÆÆM N
{
ØØ 
ApplyAccountBan
∞∞ #
(
∞∞# $*
chatMessageSubmissionOutcome
∞∞$ @
.
∞∞@ A"
ChatAccountBanNotice
∞∞A U
)
∞∞U V
;
∞∞V W
}
±± 
else
≤≤ 
if
≤≤ 
(
≤≤ *
chatMessageSubmissionOutcome
≤≤ 5
.
≤≤5 6#
IsChatMessageAccepted
≤≤6 K
)
≤≤K L
{
≥≥  
ClearAcceptedDraft
¥¥ &
(
¥¥& '"
submittedChatMessage
¥¥' ;
)
¥¥; <
;
¥¥< =
}
µµ 
}
∂∂ 
}
∑∑ 	
private
ππ 
void
ππ  
ClearAcceptedDraft
ππ '
(
ππ' ((
LobbyChatMessageSubmission
ππ( B"
submittedChatMessage
ππC W
)
ππW X
{
∫∫ 	+
_pendingChatMessageSubmission
ªª )
=
ªª* +
null
ªª, 0
;
ªª0 1
if
ºº 
(
ºº "
DraftChatMessageText
ºº $
==
ºº% '"
submittedChatMessage
ºº( <
.
ºº< =%
OriginalChatMessageText
ºº= T
)
ººT U
{
ΩΩ "
DraftChatMessageText
ææ $
=
ææ% &
string
ææ' -
.
ææ- .
Empty
ææ. 3
;
ææ3 4
}
øø 
}
¿¿ 	
private
¬¬ 
void
¬¬ %
OnChatLobbyStateChanged
¬¬ ,
(
¬¬, -
object
¬¬- 3
sender
¬¬4 :
,
¬¬: ;(
LobbyStateChangedEventArgs
¬¬< V
e
¬¬W X
)
¬¬X Y
{
√√ 	"
DispatchChatUiAction
ƒƒ  
(
ƒƒ  !
(
ƒƒ! "
)
ƒƒ" #
=>
ƒƒ$ &#
ApplyChatAvailability
ƒƒ' <
(
ƒƒ< =
e
ƒƒ= >
.
ƒƒ> ?
ConfirmedLobby
ƒƒ? M
)
ƒƒM N
)
ƒƒN O
;
ƒƒO P
}
≈≈ 	
private
«« 
void
«« #
ApplyChatAvailability
«« *
(
««* +
Lobby
««+ 0
confirmedLobby
««1 ?
)
««? @
{
»» 	
if
…… 
(
…… 
!
…… 
_isChatDisposed
……  
&&
……! #
confirmedLobby
……$ 2
?
……2 3
.
……3 4
	LobbyCode
……4 =
==
……> @
_chatLobbyCode
……A O
&&
……P R
confirmedLobby
   
.
   
StateVersion
   +
>=
  , .+
_chatAvailabilityStateVersion
  / L
)
  L M
{
ÀÀ +
_chatAvailabilityStateVersion
ÃÃ -
=
ÃÃ. /
confirmedLobby
ÃÃ0 >
.
ÃÃ> ?
StateVersion
ÃÃ? K
;
ÃÃK L%
_isChatSendingAvailable
ÕÕ '
=
ÕÕ( )
confirmedLobby
ÕÕ* 8
.
ÕÕ8 9$
IsChatSendingAvailable
ÕÕ9 O
;
ÕÕO P
OnPropertyChanged
ŒŒ !
(
ŒŒ! "
nameof
ŒŒ" (
(
ŒŒ( ).
 IsRegisteredAccountChatAvailable
ŒŒ) I
)
ŒŒI J
)
ŒŒJ K
;
ŒŒK L
CommandManager
œœ 
.
œœ (
InvalidateRequerySuggested
œœ 9
(
œœ9 :
)
œœ: ;
;
œœ; <
if
–– 
(
–– 
!
–– %
_isChatSendingAvailable
–– ,
)
––, -
{
—— )
ShowChatUnavailableFeedback
““ /
(
““/ 0
)
““0 1
;
““1 2
}
”” 
else
‘‘ 
if
‘‘ 
(
‘‘ $
ChatSubmissionFeedback
‘‘ /
?
‘‘/ 0
.
‘‘0 1(
ChatMessageRejectionReason
‘‘1 K
==
‘‘L N(
ChatMessageRejectionReason
’’ .
.
’’. /'
ChatModerationUnavailable
’’/ H
)
’’H I
{
÷÷ $
ChatSubmissionFeedback
◊◊ *
=
◊◊+ ,
null
◊◊- 1
;
◊◊1 2
}
ÿÿ 
}
ŸŸ 
}
⁄⁄ 	
private
‹‹ 
void
‹‹ )
ShowChatUnavailableFeedback
‹‹ 0
(
‹‹0 1
)
‹‹1 2
{
›› 	
_logger
ﬁﬁ 
.
ﬁﬁ 
Warning
ﬁﬁ 
(
ﬁﬁ *
LogChatModerationUnavailable
ﬁﬁ 8
,
ﬁﬁ8 9
_chatLobbyCode
ﬁﬁ: H
)
ﬁﬁH I
;
ﬁﬁI J$
ChatSubmissionFeedback
ﬂﬂ "
=
ﬂﬂ# $
new
ﬂﬂ% (/
!LobbyChatMessageSubmissionOutcome
ﬂﬂ) J
{
‡‡ (
ChatMessageRejectionReason
·· *
=
··+ ,(
ChatMessageRejectionReason
··- G
.
··G H'
ChatModerationUnavailable
··H a
}
‚‚ 
;
‚‚ 
}
„„ 	
private
ÂÂ 
void
ÂÂ (
OnLobbyChatMessageReceived
ÂÂ /
(
ÂÂ/ 0
LobbyMessage
ÂÂ0 <"
publishedChatMessage
ÂÂ= Q
)
ÂÂQ R
{
ÊÊ 	"
DispatchChatUiAction
ÁÁ  
(
ÁÁ  !
(
ÁÁ! "
)
ÁÁ" #
=>
ÁÁ$ &(
AppendPublishedChatMessage
ÁÁ' A
(
ÁÁA B"
publishedChatMessage
ÁÁB V
)
ÁÁV W
)
ÁÁW X
;
ÁÁX Y
}
ËË 	
private
ÍÍ 
void
ÍÍ (
AppendPublishedChatMessage
ÍÍ /
(
ÍÍ/ 0
LobbyMessage
ÍÍ0 <"
publishedChatMessage
ÍÍ= Q
)
ÍÍQ R
{
ÎÎ 	
if
ÏÏ 
(
ÏÏ 
!
ÏÏ 
_isChatDisposed
ÏÏ  
)
ÏÏ  !
{
ÌÌ 
var
ÓÓ 
chatMessage
ÓÓ 
=
ÓÓ  !
new
ÓÓ" %'
LobbyChatMessageViewModel
ÓÓ& ?
(
ÓÓ? @"
publishedChatMessage
ÓÓ@ T
)
ÓÓT U
;
ÓÓU V
if
ÔÔ 
(
ÔÔ  
_profileImageCache
ÔÔ &
!=
ÔÔ' )
null
ÔÔ* .
)
ÔÔ. /
{
 
chatMessage
ÒÒ 
.
ÒÒ   
AttachProfileImage
ÒÒ  2
(
ÒÒ2 3 
_profileImageCache
ÒÒ3 E
)
ÒÒE F
;
ÒÒF G
}
ÚÚ 
ChatMessages
ÛÛ 
.
ÛÛ 
Add
ÛÛ  
(
ÛÛ  !
chatMessage
ÛÛ! ,
)
ÛÛ, -
;
ÛÛ- .
if
ÙÙ 
(
ÙÙ 
ChatMessages
ÙÙ  
.
ÙÙ  !
Count
ÙÙ! &
>
ÙÙ' ((
MaximumVisibleChatMessages
ÙÙ) C
)
ÙÙC D
{
ıı 
ChatMessages
ˆˆ  
[
ˆˆ  !
$num
ˆˆ! "
]
ˆˆ" #
.
ˆˆ# $
Dispose
ˆˆ$ +
(
ˆˆ+ ,
)
ˆˆ, -
;
ˆˆ- .
ChatMessages
˜˜  
.
˜˜  !
RemoveAt
˜˜! )
(
˜˜) *
$num
˜˜* +
)
˜˜+ ,
;
˜˜, -
}
¯¯ 
}
˘˘ 
}
˙˙ 	
private
¸¸ 
void
¸¸ %
OnChatAccountBanApplied
¸¸ ,
(
¸¸, -
object
¸¸- 3
sender
¸¸4 :
,
¸¸: ;,
ChatAccountBanAppliedEventArgs
¸¸< Z
e
¸¸[ \
)
¸¸\ ]
{
˝˝ 	"
DispatchChatUiAction
˛˛  
(
˛˛  !
(
˛˛! "
)
˛˛" #
=>
˛˛$ &
ApplyAccountBan
˛˛' 6
(
˛˛6 7
e
˛˛7 8
.
˛˛8 9"
ChatAccountBanNotice
˛˛9 M
)
˛˛M N
)
˛˛N O
;
˛˛O P
}
ˇˇ 	
private
ÅÅ 
void
ÅÅ 
ApplyAccountBan
ÅÅ $
(
ÅÅ$ %"
ChatAccountBanNotice
ÅÅ% 9"
chatAccountBanNotice
ÅÅ: N
)
ÅÅN O
{
ÇÇ 	
if
ÉÉ 
(
ÉÉ 
!
ÉÉ #
_hasAppliedAccountBan
ÉÉ &
&&
ÉÉ' )
!
ÉÉ* +
_isChatDisposed
ÉÉ+ :
)
ÉÉ: ;
{
ÑÑ 
_logger
ÖÖ 
.
ÖÖ 
Warning
ÖÖ 
(
ÖÖ  "
LogAccountBanApplied
ÖÖ  4
,
ÖÖ4 5"
chatAccountBanNotice
ÖÖ6 J
?
ÖÖJ K
.
ÖÖK L 
ChatAccountBanType
ÖÖL ^
,
ÖÖ^ _
_chatLobbyCode
ÖÖ` n
)
ÖÖn o
;
ÖÖo p#
_hasAppliedAccountBan
ÜÜ %
=
ÜÜ& '
true
ÜÜ( ,
;
ÜÜ, -
_lobbySession
áá 
.
áá 

ClearLobby
áá (
(
áá( )
)
áá) *
;
áá* +
UserSession
àà 
.
àà 
Current
àà #
.
àà# $
ClearSession
àà$ 0
(
àà0 1
)
àà1 2
;
àà2 3 
_navigationService
ââ "
.
ââ" #

NavigateTo
ââ# -
(
ââ- .
ViewId
ââ. 4
.
ââ4 5

HomeScreen
ââ5 ?
)
ââ? @
;
ââ@ A&
_chatModerationPresenter
ää (
.
ää( ) 
ShowChatAccountBan
ää) ;
(
ää; <"
chatAccountBanNotice
ää< P
)
ääP Q
;
ääQ R
}
ãã 
}
åå 	
private
éé 
void
éé "
DispatchChatUiAction
éé )
(
éé) *
Action
éé* 0
chatUiAction
éé1 =
)
éé= >
{
èè 	
if
êê 
(
êê +
_chatUiSynchronizationContext
êê -
!=
êê. 0
null
êê1 5
&&
êê6 8$
SynchronizationContext
ëë &
.
ëë& '
Current
ëë' .
!=
ëë/ 1+
_chatUiSynchronizationContext
ëë2 O
)
ëëO P
{
íí +
_chatUiSynchronizationContext
ìì -
.
ìì- .
Post
ìì. 2
(
ìì2 3
_
ìì3 4
=>
ìì5 7
chatUiAction
ìì8 D
(
ììD E
)
ììE F
,
ììF G
null
ììH L
)
ììL M
;
ììM N
}
îî 
else
ïï 
{
ññ 
chatUiAction
óó 
(
óó 
)
óó 
;
óó 
}
òò 
}
ôô 	
}
öö 
}õõ 