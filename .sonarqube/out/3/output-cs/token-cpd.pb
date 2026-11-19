¨<
]C:\Users\oscar\source\repos\TrickTakingMissions\Shared\Gameplay\Tricks\PlayerMatchSnapshot.cs
	namespace 	
Gameplay
 
{ 
[ 
DataContract 
] 
public		 

sealed		 
class		 
PlayerMatchSnapshot		 +
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
public 
System 
. 
Guid 
MatchId "
{# $
get% (
;( )
set* -
;- .
}/ 0
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public 
long 
MatchStateVersion %
{& '
get( +
;+ ,
set- 0
;0 1
}2 3
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public 
int 
[ 
] 
OwnHandCardIds #
{$ %
get& )
;) *
set+ .
;. /
}0 1
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public 
int 
[ 
] 
ParticipantUserIds '
{( )
get* -
;- .
set/ 2
;2 3
}4 5
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public 
int 
[ 
] #
RemainingHandCardCounts ,
{- .
get/ 2
;2 3
set4 7
;7 8
}9 :
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public 
int #
CurrentTurnPlayerUserId *
{+ ,
get- 0
;0 1
set2 5
;5 6
}7 8
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public 
int  
MissionCaptainUserId '
{( )
get* -
;- .
set/ 2
;2 3
}4 5
[   	

DataMember  	 
(   
Order   
=   
$num   
)   
]   
public!! 
int!! 
CurrentTrickNumber!! %
{!!& '
get!!( +
;!!+ ,
set!!- 0
;!!0 1
}!!2 3
[## 	

DataMember##	 
(## 
Order## 
=## 
$num## 
)## 
]## 
public$$ 
int$$ $
MaximumMissionTrickCount$$ +
{$$, -
get$$. 1
;$$1 2
set$$3 6
;$$6 7
}$$8 9
[&& 	

DataMember&&	 
(&& 
Order&& 
=&& 
$num&& 
)&& 
]&&  
public'' 
bool'' 
IsDealCompleted'' #
{''$ %
get''& )
;'') *
set''+ .
;''. /
}''0 1
[)) 	

DataMember))	 
()) 
Order)) 
=)) 
$num)) 
))) 
]))  
public** 
MatchCardPlay** 
[** 
]** !
CurrentTrickCardPlays** 4
{**5 6
get**7 :
;**: ;
set**< ?
;**? @
}**A B
[,, 	

DataMember,,	 
(,, 
Order,, 
=,, 
$num,, 
),, 
],,  
public-- 
MatchCardPlay-- 
[-- 
]-- '
LastCompletedTrickCardPlays-- :
{--; <
get--= @
;--@ A
set--B E
;--E F
}--G H
[// 	

DataMember//	 
(// 
Order// 
=// 
$num// 
)// 
]//  
public00 
int00 !
LastTrickWinnerUserId00 (
{00) *
get00+ .
;00. /
set000 3
;003 4
}005 6
[22 	

DataMember22	 
(22 
Order22 
=22 
$num22 
)22 
]22  
public33 ,
 PlayerMissionPreparationSnapshot33 /
MissionPreparation330 B
{33C D
get33E H
;33H I
set33J M
;33M N
}33O P
[55 	

DataMember55	 
(55 
Order55 
=55 
$num55 
)55 
]55  
public66 '
PlayerCapturedCardsSnapshot66 *
[66* +
]66+ ,!
CapturedCardsByPlayer66- B
{66C D
get66E H
;66H I
set66J M
;66M N
}66O P
[77 	

DataMember77	 
(77 
Order77 
=77 
$num77 
)77 
]77  
public88 %
MissionEvaluationSnapshot88 (
MissionEvaluation88) :
{88; <
get88= @
;88@ A
set88B E
;88E F
}88G H
[99 	

DataMember99	 
(99 
Order99 
=99 
$num99 
)99 
]99  
public::  
MissionRetrySnapshot:: #
MissionRetry::$ 0
{::1 2
get::3 6
;::6 7
set::8 ;
;::; <
}::= >
[<< 	

DataMember<<	 
(<< 
Order<< 
=<< 
$num<< 
)<< 
]<<  
public== %
MissionTransitionSnapshot== (
MissionTransition==) :
{==; <
get=== @
;==@ A
set==B E
;==E F
}==G H
[?? 	

DataMember??	 
(?? 
Order?? 
=?? 
$num?? 
)?? 
]??  
public@@ ,
 PlayerRadioCommunicationSnapshot@@ /
[@@/ 0
]@@0 1
RadioCommunications@@2 E
{@@F G
get@@H K
;@@K L
set@@M P
;@@P Q
}@@R S
[BB 	

DataMemberBB	 
(BB 
OrderBB 
=BB 
$numBB 
)BB 
]BB  
publicCC "
RadioCommunicationModeCC %
	RadioModeCC& /
{CC0 1
getCC2 5
;CC5 6
setCC7 :
;CC: ;
}CC< =
[DD 	

DataMemberDD	 
(DD 
OrderDD 
=DD 
$numDD 
)DD 
]DD  
publicEE ,
 MissionConditionProgressSnapshotEE /$
MissionConditionProgressEE0 H
{EEI J
getEEK N
;EEN O
setEEP S
;EES T
}EEU V
[FF 	

DataMemberFF	 
(FF 
OrderFF 
=FF 
$numFF 
)FF 
]FF  
publicGG %
RadioAvailabilitySnapshotGG ( 
OwnRadioAvailabilityGG) =
{GG> ?
getGG@ C
;GGC D
setGGE H
;GGH I
}GGJ K
[HH 	

DataMemberHH	 
(HH 
OrderHH 
=HH 
$numHH 
)HH 
]HH  
publicII "
DistressSignalSnapshotII %
DistressSignalII& 4
{II5 6
getII7 :
;II: ;
setII< ?
;II? @
}IIA B
}JJ 
}KK Ç
^C:\Users\oscar\source\repos\TrickTakingMissions\Shared\Gameplay\Tricks\MatchRejectionReason.cs
	namespace 	
Gameplay
 
{ 
[ 
DataContract 
] 
public 

enum  
MatchRejectionReason $
{ 
[		 	

EnumMember			 
]		 
None		 
=		 
$num		 
,		 
[

 	

EnumMember

	 
]

 
MatchUnavailable

 %
=

& '
$num

( )
,

) *
[ 	

EnumMember	 
] !
ParticipantNotAllowed *
=+ ,
$num- .
,. /
[ 	

EnumMember	 
] 
InvalidSubmission &
=' (
$num) *
,* +
[ 	

EnumMember	 
] $
SubmissionIdentityReused -
=. /
$num0 1
,1 2
[ 	

EnumMember	 
] 
StaleMatchState $
=% &
$num' (
,( )
[ 	

EnumMember	 
] 
NotPlayerTurn "
=# $
$num% &
,& '
[ 	

EnumMember	 
] 
CardNotInHand "
=# $
$num% &
,& '
[ 	

EnumMember	 
] 
MustFollowLeadSuit '
=( )
$num* +
,+ ,
[ 	

EnumMember	 
] 
DealCompleted "
=# $
$num% &
,& '
[ 	

EnumMember	 
] %
SubmissionCapacityReached .
=/ 0
$num1 3
,3 4
[ 	

EnumMember	 
] &
MissionPreparationRequired /
=0 1
$num2 4
,4 5
[ 	

EnumMember	 
] "
MissionAttemptFinished +
=, -
$num. 0
,0 1
[ 	

EnumMember	 
] 
WrongMissionAttempt (
=) *
$num+ -
} 
} é
WC:\Users\oscar\source\repos\TrickTakingMissions\Shared\Gameplay\Tricks\MatchCardPlay.cs
	namespace 	
Gameplay
 
{ 
[ 
DataContract 
] 
public		 

sealed		 
class		 
MatchCardPlay		 %
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
public 
int 
PlayerUserId 
{  !
get" %
;% &
set' *
;* +
}, -
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public 
int 
CardId 
{ 
get 
;  
set! $
;$ %
}& '
} 
} â
\C:\Users\oscar\source\repos\TrickTakingMissions\Shared\Gameplay\Tricks\CardPlaySubmission.cs
	namespace 	
Gameplay
 
{ 
[ 
DataContract 
] 
public		 

sealed		 
class		 
CardPlaySubmission		 *
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
public 
int 
MissionAttemptId #
{$ %
get& )
;) *
set+ .
;. /
}0 1
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
System 
. 
Guid 
MatchId "
{# $
get% (
;( )
set* -
;- .
}/ 0
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public 
System 
. 
Guid  
CardPlaySubmissionId /
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
public 
long %
ExpectedMatchStateVersion -
{. /
get0 3
;3 4
set5 8
;8 9
}: ;
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public 
int 
CardId 
{ 
get 
;  
set! $
;$ %
}& '
} 
} ≤
ZC:\Users\oscar\source\repos\TrickTakingMissions\Shared\Gameplay\Tricks\CardPlayDecision.cs
	namespace 	
Gameplay
 
{ 
[ 
DataContract 
] 
public		 

sealed		 
class		 
CardPlayDecision		 (
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
public 
System 
. 
Guid  
CardPlaySubmissionId /
{0 1
get2 5
;5 6
set7 :
;: ;
}< =
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public 
bool 

IsAccepted 
{  
get! $
;$ %
set& )
;) *
}+ ,
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public  
MatchRejectionReason #
RejectionReason$ 3
{4 5
get6 9
;9 :
set; >
;> ?
}@ A
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public 
long &
CommittedMatchStateVersion .
{/ 0
get1 4
;4 5
set6 9
;9 :
}; <
} 
} ’
oC:\Users\oscar\source\repos\TrickTakingMissions\Shared\Gameplay\SpecialPreparation\RadioAvailabilitySnapshot.cs
	namespace 	
Gameplay
 
{ 
[ 
DataContract 
] 
public 

sealed 
class %
RadioAvailabilitySnapshot 1
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
bool 
IsAvailable 
{  !
get" %
;% &
set' *
;* +
}, -
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public +
RadioCommunicationFailureReason .
FailureReason/ <
{= >
get? B
;B C
setD G
;G H
}I J
} 
} Ö
xC:\Users\oscar\source\repos\TrickTakingMissions\Shared\Gameplay\SpecialPreparation\MissionTrickDistributionSubmission.cs
	namespace 	
Gameplay
 
{ 
[ 
DataContract 
] 
public 

sealed 
class .
"MissionTrickDistributionSubmission :
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
public 
string 
	LobbyCode 
{  !
get" %
;% &
set' *
;* +
}, -
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public 
Guid 
MatchId 
{ 
get !
;! "
set# &
;& '
}( )
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public 
int 
MissionAttemptId #
{$ %
get& )
;) *
set+ .
;. /
}0 1
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public 
Guid %
MissionPreparationStageId -
{. /
get0 3
;3 4
set5 8
;8 9
}: ;
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public 
Guid *
MissionPreparationSubmissionId 2
{3 4
get5 8
;8 9
set: =
;= >
}? @
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public 
long %
ExpectedMatchStateVersion -
{. /
get0 3
;3 4
set5 8
;8 9
}: ;
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public 
int 2
&FirstFourTricksWinnerParticipantUserId 9
{: ;
get< ?
;? @
setA D
;D E
}F G
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public   
int   ,
 LastTrickWinnerParticipantUserId   3
{  4 5
get  6 9
;  9 :
set  ; >
;  > ?
}  @ A
}!! 
}"" π
uC:\Users\oscar\source\repos\TrickTakingMissions\Shared\Gameplay\SpecialPreparation\MissionRoleAssignmentSubmission.cs
	namespace 	
Gameplay
 
{ 
[ 
DataContract 
] 
public 

sealed 
class +
MissionRoleAssignmentSubmission 7
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
public 
string 
	LobbyCode 
{  !
get" %
;% &
set' *
;* +
}, -
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public 
Guid 
MatchId 
{ 
get !
;! "
set# &
;& '
}( )
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public 
int 
MissionAttemptId #
{$ %
get& )
;) *
set+ .
;. /
}0 1
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public 
Guid %
MissionPreparationStageId -
{. /
get0 3
;3 4
set5 8
;8 9
}: ;
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public 
Guid *
MissionPreparationSubmissionId 2
{3 4
get5 8
;8 9
set: =
;= >
}? @
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public 
long %
ExpectedMatchStateVersion -
{. /
get0 3
;3 4
set5 8
;8 9
}: ;
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public 
int %
SelectedParticipantUserId ,
{- .
get/ 2
;2 3
set4 7
;7 8
}9 :
} 
} ·
mC:\Users\oscar\source\repos\TrickTakingMissions\Shared\Gameplay\SpecialPreparation\MissionPreparationStage.cs
	namespace 	
Gameplay
 
{ 
[ 
DataContract 
] 
public 

enum #
MissionPreparationStage '
{ 
[		 	

EnumMember			 
]		 
None		 
=		 
$num		 
,		 
[

 	

EnumMember

	 
]

 
RoleSelection

 "
=

# $
$num

% &
,

& '
[ 	

EnumMember	 
] 
BlindResponses #
=$ %
$num& '
,' (
[ 	

EnumMember	 
] 
AssigneeSelection &
=' (
$num) *
,* +
[ 	

EnumMember	 
] 
ObjectiveDrafting &
=' (
$num) *
,* +
[ 	

EnumMember	 
] 
PlayingTricks "
=# $
$num% &
,& '
[ 	

EnumMember	 
] 
Finished 
= 
$num  !
,! "
[ 	

EnumMember	 
] #
HeartNineIdentification ,
=- .
$num/ 0
,0 1
[ 	

EnumMember	 
] &
TrickDistributionSelection /
=0 1
$num2 3
} 
} ¨
mC:\Users\oscar\source\repos\TrickTakingMissions\Shared\Gameplay\SpecialPreparation\MissionPreparationFault.cs
	namespace 	
Gameplay
 
{ 
[ 
DataContract 
] 
public 

sealed 
class #
MissionPreparationFault /
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
public +
MissionPreparationFailureReason .
FailureReason/ <
{= >
get? B
;B C
setD G
;G H
}I J
} 
} ë
uC:\Users\oscar\source\repos\TrickTakingMissions\Shared\Gameplay\SpecialPreparation\MissionPreparationFailureReason.cs
	namespace 	
Gameplay
 
{ 
[ 
DataContract 
] 
public 

enum +
MissionPreparationFailureReason /
{ 
[		 	

EnumMember			 
]		 
None		 
=		 
$num		 
,		 
[

 	

EnumMember

	 
]

 
InvalidSubmission

 &
=

' (
$num

) *
,

* +
[ 	

EnumMember	 
] 
MatchUnavailable %
=& '
$num( )
,) *
[ 	

EnumMember	 
] !
ParticipantNotAllowed *
=+ ,
$num- .
,. /
[ 	

EnumMember	 
] 
WrongMissionAttempt (
=) *
$num+ ,
,, -
[ 	

EnumMember	 
] $
SubmissionIdentityReused -
=. /
$num0 1
,1 2
[ 	

EnumMember	 
] 
StageMismatch "
=# $
$num% &
,& '
[ 	

EnumMember	 
] 
StaleMatchState $
=% &
$num' (
,( )
[ 	

EnumMember	 
] 
CaptainRequired $
=% &
$num' (
,( )
[ 	

EnumMember	 
] 
InvalidTarget "
=# $
$num% &
,& '
[ 	

EnumMember	 
] 
ResponsesPending %
=& '
$num( *
,* +
[ 	

EnumMember	 
] 
AlreadyAnswered $
=% &
$num' )
,) *
[ 	

EnumMember	 
] 
RequestLimitReached (
=) *
$num+ -
,- .
[ 	

EnumMember	 
]  
OperationUnavailable )
=* +
$num, .
} 
} ‰
tC:\Users\oscar\source\repos\TrickTakingMissions\Shared\Gameplay\SpecialPreparation\MissionPreparationConfirmation.cs
	namespace 	
Gameplay
 
{ 
[ 
DataContract 
] 
public 

sealed 
class *
MissionPreparationConfirmation 6
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
Guid *
MissionPreparationSubmissionId 2
{3 4
get5 8
;8 9
set: =
;= >
}? @
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public 
long &
CommittedMatchStateVersion .
{/ 0
get1 4
;4 5
set6 9
;9 :
}; <
} 
} ´

vC:\Users\oscar\source\repos\TrickTakingMissions\Shared\Gameplay\SpecialPreparation\MissionConditionProgressSnapshot.cs
	namespace 	
Gameplay
 
{ 
[ 
DataContract 
] 
public 

sealed 
class ,
 MissionConditionProgressSnapshot 8
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
public 
int '
TricksWonWithNormalOneCount .
{/ 0
get1 4
;4 5
set6 9
;9 :
}; <
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public 
int 
[ 
] !
SpecialWinningCardIds *
{+ ,
get- 0
;0 1
set2 5
;5 6
}7 8
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public 
int "
CapturedHeartCardCount )
{* +
get, /
;/ 0
set1 4
;4 5
}6 7
} 
} ã
wC:\Users\oscar\source\repos\TrickTakingMissions\Shared\Gameplay\SpecialPreparation\HeartNineIdentificationSubmission.cs
	namespace 	
Gameplay
 
{ 
[ 
DataContract 
] 
public 

sealed 
class -
!HeartNineIdentificationSubmission 9
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
public 
string 
	LobbyCode 
{  !
get" %
;% &
set' *
;* +
}, -
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public 
Guid 
MatchId 
{ 
get !
;! "
set# &
;& '
}( )
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public 
int 
MissionAttemptId #
{$ %
get& )
;) *
set+ .
;. /
}0 1
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public 
Guid %
MissionPreparationStageId -
{. /
get0 3
;3 4
set5 8
;8 9
}: ;
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public 
Guid *
MissionPreparationSubmissionId 2
{3 4
get5 8
;8 9
set: =
;= >
}? @
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public 
long %
ExpectedMatchStateVersion -
{. /
get0 3
;3 4
set5 8
;8 9
}: ;
} 
} Ω
vC:\Users\oscar\source\repos\TrickTakingMissions\Shared\Gameplay\SpecialPreparation\BlindObjectiveResponseSubmission.cs
	namespace 	
Gameplay
 
{ 
[ 
DataContract 
] 
public 

sealed 
class ,
 BlindObjectiveResponseSubmission 8
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
public 
string 
	LobbyCode 
{  !
get" %
;% &
set' *
;* +
}, -
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public 
Guid 
MatchId 
{ 
get !
;! "
set# &
;& '
}( )
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public 
int 
MissionAttemptId #
{$ %
get& )
;) *
set+ .
;. /
}0 1
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public 
Guid %
MissionPreparationStageId -
{. /
get0 3
;3 4
set5 8
;8 9
}: ;
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public 
Guid *
MissionPreparationSubmissionId 2
{3 4
get5 8
;8 9
set: =
;= >
}? @
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public 
long %
ExpectedMatchStateVersion -
{. /
get0 3
;3 4
set5 8
;8 9
}: ;
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public "
BlindObjectiveResponse %
Response& .
{/ 0
get1 4
;4 5
set6 9
;9 :
}; <
} 
} ¨
lC:\Users\oscar\source\repos\TrickTakingMissions\Shared\Gameplay\SpecialPreparation\BlindObjectiveResponse.cs
	namespace 	
Gameplay
 
{ 
[ 
DataContract 
] 
public 

enum "
BlindObjectiveResponse &
{ 
[		 	

EnumMember			 
]		 
Pending		 
=		 
$num		  
,		  !
[

 	

EnumMember

	 
]

 
Yes

 
=

 
$num

 
,

 
[ 	

EnumMember	 
] 
No 
= 
$num 
} 
} ‹
wC:\Users\oscar\source\repos\TrickTakingMissions\Shared\Gameplay\SpecialPreparation\BlindObjectiveParticipantSnapshot.cs
	namespace 	
Gameplay
 
{ 
[ 
DataContract 
] 
public 

sealed 
class -
!BlindObjectiveParticipantSnapshot 9
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
public 
int 
ParticipantUserId $
{% &
get' *
;* +
set, /
;/ 0
}1 2
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public "
BlindObjectiveResponse %
Response& .
{/ 0
get1 4
;4 5
set6 9
;9 :
}; <
} 
} æ
[C:\Users\oscar\source\repos\TrickTakingMissions\Shared\Gameplay\Retry\MissionRetryStatus.cs
	namespace 	
Gameplay
 
{ 
[ 
DataContract 
] 
public 

enum 
MissionRetryStatus "
{ 
[		 	

EnumMember			 
]		 
Inactive		 
=		 
$num		  !
,		! "
[

 	

EnumMember

	 
]

 "
WaitingForParticipants

 +
=

, -
$num

. /
,

/ 0
[ 	

EnumMember	 
] 
CountingDown !
=" #
$num$ %
,% &
[ 	

EnumMember	 
] 
	Preparing 
=  
$num! "
," #
[ 	

EnumMember	 
] 
PreparationFailed &
=' (
$num) *
,* +
[ 	

EnumMember	 
] 
AttemptLimitReached (
=) *
$num+ ,
} 
} Ø
_C:\Users\oscar\source\repos\TrickTakingMissions\Shared\Gameplay\Retry\MissionRetrySubmission.cs
	namespace 	
Gameplay
 
{ 
[ 
DataContract 
] 
public 

sealed 
class "
MissionRetrySubmission .
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
public 
string 
	LobbyCode 
{  !
get" %
;% &
set' *
;* +
}, -
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public 
Guid 
MatchId 
{ 
get !
;! "
set# &
;& '
}( )
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public 
int 
MissionAttemptId #
{$ %
get& )
;) *
set+ .
;. /
}0 1
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public 
Guid $
MissionRetrySubmissionId ,
{- .
get/ 2
;2 3
set4 7
;7 8
}9 :
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public 
long %
ExpectedMatchStateVersion -
{. /
get0 3
;3 4
set5 8
;8 9
}: ;
} 
} …
]C:\Users\oscar\source\repos\TrickTakingMissions\Shared\Gameplay\Retry\MissionRetrySnapshot.cs
	namespace 	
Gameplay
 
{ 
[ 
DataContract 
] 
public 

sealed 
class  
MissionRetrySnapshot ,
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
public 
int 
MissionAttemptId #
{$ %
get& )
;) *
set+ .
;. /
}0 1
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public 
int 
AttemptNumber  
{! "
get# &
;& '
set( +
;+ ,
}- .
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public 
bool 
IsRetryAvailable $
{% &
get' *
;* +
set, /
;/ 0
}1 2
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public 
int 
[ 
] #
ReadyParticipantUserIds ,
{- .
get/ 2
;2 3
set4 7
;7 8
}9 :
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public 
Guid 
? -
!AvailableMissionRetrySubmissionId 6
{7 8
get9 <
;< =
set> A
;A B
}C D
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public 
MissionRetryStatus !
Status" (
{) *
get+ .
;. /
set0 3
;3 4
}5 6
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public 
Guid "
MissionRetryScheduleId *
{+ ,
get- 0
;0 1
set2 5
;5 6
}7 8
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public   
int   &
RemainingDelayMilliseconds   -
{  . /
get  0 3
;  3 4
set  5 8
;  8 9
}  : ;
["" 	

DataMember""	 
("" 
Order"" 
="" 
$num"" 
)"" 
]"" 
public## 
int## 
[## 
]## %
MissingParticipantUserIds## .
{##/ 0
get##1 4
;##4 5
set##6 9
;##9 :
}##; <
}$$ 
}%% ¯
dC:\Users\oscar\source\repos\TrickTakingMissions\Shared\Gameplay\Retry\MissionRetryRejectionReason.cs
	namespace 	
Gameplay
 
{ 
[ 
DataContract 
] 
public 

enum '
MissionRetryRejectionReason +
{ 
[		 	

EnumMember			 
]		 
None		 
=		 
$num		 
,		 
[

 	

EnumMember

	 
]

 
MatchUnavailable

 %
=

& '
$num

( )
,

) *
[ 	

EnumMember	 
] !
ParticipantNotAllowed *
=+ ,
$num- .
,. /
[ 	

EnumMember	 
] 
InvalidSubmission &
=' (
$num) *
,* +
[ 	

EnumMember	 
] $
SubmissionIdentityReused -
=. /
$num0 1
,1 2
[ 	

EnumMember	 
] 
WrongMissionAttempt (
=) *
$num+ ,
,, -
[ 	

EnumMember	 
] 
RetryUnavailable %
=& '
$num( )
,) *
[ 	

EnumMember	 
] 
StaleMatchState $
=% &
$num' (
,( )
[ 	

EnumMember	 
] 
SubmissionExpired &
=' (
$num) *
,* +
[ 	

EnumMember	 
] 
RequestLimitReached (
=) *
$num+ ,
,, -
[ 	

EnumMember	 
] 
AttemptLimitReached (
=) *
$num+ -
} 
} ˛
]C:\Users\oscar\source\repos\TrickTakingMissions\Shared\Gameplay\Retry\MissionRetryDecision.cs
	namespace 	
Gameplay
 
{ 
[ 
DataContract 
] 
public 

sealed 
class  
MissionRetryDecision ,
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
Guid $
MissionRetrySubmissionId ,
{- .
get/ 2
;2 3
set4 7
;7 8
}9 :
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public 
bool 

IsAccepted 
{  
get! $
;$ %
set& )
;) *
}+ ,
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public 
bool 
HasRestartedMission '
{( )
get* -
;- .
set/ 2
;2 3
}4 5
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public 
long &
CommittedMatchStateVersion .
{/ 0
get1 4
;4 5
set6 9
;9 :
}; <
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public 
int #
CurrentMissionAttemptId *
{+ ,
get- 0
;0 1
set2 5
;5 6
}7 8
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public '
MissionRetryRejectionReason *
RejectionReason+ :
{; <
get= @
;@ A
setB E
;E F
}G H
} 
} ú
eC:\Users\oscar\source\repos\TrickTakingMissions\Shared\Gameplay\Radio\RadioCommunicationSubmission.cs
	namespace 	
Gameplay
 
{ 
[ 
DataContract 
] 
public 

sealed 
class (
RadioCommunicationSubmission 4
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
public 
string 
	LobbyCode 
{  !
get" %
;% &
set' *
;* +
}, -
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public 
Guid 
MatchId 
{ 
get !
;! "
set# &
;& '
}( )
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public 
int 
MissionAttemptId #
{$ %
get& )
;) *
set+ .
;. /
}0 1
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public 
Guid *
RadioCommunicationSubmissionId 2
{3 4
get5 8
;8 9
set: =
;= >
}? @
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public 
long %
ExpectedMatchStateVersion -
{. /
get0 3
;3 4
set5 8
;8 9
}: ;
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public 
int 
CardId 
{ 
get 
;  
set! $
;$ %
}& '
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public $
RadioCommunicationMarker '
SelectedMarker( 6
{7 8
get9 <
;< =
set> A
;A B
}C D
} 
} ≈
_C:\Users\oscar\source\repos\TrickTakingMissions\Shared\Gameplay\Radio\RadioCommunicationMode.cs
	namespace 	
Gameplay
 
{ 
[ 
DataContract 
] 
public 

enum "
RadioCommunicationMode &
{ 
[		 	

EnumMember			 
]		 
Standard		 
=		 
$num		  !
,		! "
[

 	

EnumMember

	 
]

 
Interference

 !
=

" #
$num

$ %
,

% &
[ 	

EnumMember	 
] !
DisruptionUntilTrick2 *
=+ ,
$num- .
,. /
[ 	

EnumMember	 
] !
DisruptionUntilTrick3 *
=+ ,
$num- .
} 
} ö
aC:\Users\oscar\source\repos\TrickTakingMissions\Shared\Gameplay\Radio\RadioCommunicationMarker.cs
	namespace 	
Gameplay
 
{ 
[ 
DataContract 
] 
public 

enum $
RadioCommunicationMarker (
{ 
[		 	

EnumMember			 
]		 
None		 
=		 
$num		 
,		 
[

 	

EnumMember

	 
]

 
Highest

 
=

 
$num

  
,

  !
[ 	

EnumMember	 
] 
Only 
= 
$num 
, 
[ 	

EnumMember	 
] 
Lowest 
= 
$num 
,  
[ 	

EnumMember	 
] 
Hidden 
= 
$num 
} 
} ü
`C:\Users\oscar\source\repos\TrickTakingMissions\Shared\Gameplay\Radio\RadioCommunicationFault.cs
	namespace 	
Gameplay
 
{ 
[ 
DataContract 
] 
public 

sealed 
class #
RadioCommunicationFault /
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
public +
RadioCommunicationFailureReason .
FailureReason/ <
{= >
get? B
;B C
setD G
;G H
}I J
} 
} ›
hC:\Users\oscar\source\repos\TrickTakingMissions\Shared\Gameplay\Radio\RadioCommunicationFailureReason.cs
	namespace 	
Gameplay
 
{ 
[ 
DataContract 
] 
public 

enum +
RadioCommunicationFailureReason /
{ 
[		 	

EnumMember			 
]		 
None		 
=		 
$num		 
,		 
[

 	

EnumMember

	 
]

 
InvalidSubmission

 &
=

' (
$num

) *
,

* +
[ 	

EnumMember	 
] 
MatchUnavailable %
=& '
$num( )
,) *
[ 	

EnumMember	 
] !
ParticipantNotAllowed *
=+ ,
$num- .
,. /
[ 	

EnumMember	 
] 
WrongMissionAttempt (
=) *
$num+ ,
,, -
[ 	

EnumMember	 
] $
SubmissionIdentityReused -
=. /
$num0 1
,1 2
[ 	

EnumMember	 
] 
StaleMatchState $
=% &
$num' (
,( )
[ 	

EnumMember	 
] &
MissionPreparationRequired /
=0 1
$num2 3
,3 4
[ 	

EnumMember	 
] "
MissionAttemptFinished +
=, -
$num. /
,/ 0
[ 	

EnumMember	 
] 
CardNotInHand "
=# $
$num% &
,& '
[ 	

EnumMember	 
] !
SpecialCardNotAllowed *
=+ ,
$num- /
,/ 0
[ 	

EnumMember	 
] *
AlreadyCommunicatedThisAttempt 3
=4 5
$num6 8
,8 9
[ 	

EnumMember	 
] .
"CannotCommunicateDuringActiveTrick 7
=8 9
$num: <
,< =
[ 	

EnumMember	 
] '
InvalidTokenPositionForCard 0
=1 2
$num3 5
,5 6
[ 	

EnumMember	 
] 
RequestLimitReached (
=) *
$num+ -
,- .
[ 	

EnumMember	 
]  
OperationUnavailable )
=* +
$num, .
,. /
[ 	

EnumMember	 
] 
DisruptedUntilTrick (
=) *
$num+ -
,- .
[ 	

EnumMember	 
] 
SilencedByCaptain &
=' (
$num) +
} 
} ◊
gC:\Users\oscar\source\repos\TrickTakingMissions\Shared\Gameplay\Radio\RadioCommunicationConfirmation.cs
	namespace 	
Gameplay
 
{ 
[ 
DataContract 
] 
public 

sealed 
class *
RadioCommunicationConfirmation 6
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
Guid *
RadioCommunicationSubmissionId 2
{3 4
get5 8
;8 9
set: =
;= >
}? @
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public 
long &
CommittedMatchStateVersion .
{/ 0
get1 4
;4 5
set6 9
;9 :
}; <
} 
} Ø
iC:\Users\oscar\source\repos\TrickTakingMissions\Shared\Gameplay\Radio\PlayerRadioCommunicationSnapshot.cs
	namespace 	
Gameplay
 
{ 
[ 
DataContract 
] 
public 

sealed 
class ,
 PlayerRadioCommunicationSnapshot 8
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
public 
int 
ParticipantUserId $
{% &
get' *
;* +
set, /
;/ 0
}1 2
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public 
int 
CommunicatedCardId %
{& '
get( +
;+ ,
set- 0
;0 1
}2 3
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public $
RadioCommunicationMarker '
Marker( .
{/ 0
get1 4
;4 5
set6 9
;9 :
}; <
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public 
bool )
HasCommunicatedCardBeenPlayed 1
{2 3
get4 7
;7 8
set9 <
;< =
}> ?
} 
} Ö
ZC:\Users\oscar\source\repos\TrickTakingMissions\Shared\Gameplay\Properties\AssemblyInfo.cs
[ 
assembly 	
:	 

AssemblyTitle 
( 
$str #
)# $
]$ %
[ 
assembly 	
:	 

AssemblyDescription 
( 
$str !
)! "
]" #
[ 
assembly 	
:	 
!
AssemblyConfiguration  
(  !
$str! #
)# $
]$ %
[ 
assembly 	
:	 

AssemblyCompany 
( 
$str 
) 
] 
[		 
assembly		 	
:			 

AssemblyProduct		 
(		 
$str		 %
)		% &
]		& '
[

 
assembly

 	
:

	 

AssemblyCopyright

 
(

 
$str

 0
)

0 1
]

1 2
[ 
assembly 	
:	 

AssemblyTrademark 
( 
$str 
)  
]  !
[ 
assembly 	
:	 

AssemblyCulture 
( 
$str 
) 
] 
[ 
assembly 	
:	 


ComVisible 
( 
false 
) 
] 
[ 
assembly 	
:	 

Guid 
( 
$str 6
)6 7
]7 8
[ 
assembly 	
:	 

AssemblyVersion 
( 
$str $
)$ %
]% &
[ 
assembly 	
:	 

AssemblyFileVersion 
( 
$str (
)( )
]) *Ÿ

fC:\Users\oscar\source\repos\TrickTakingMissions\Shared\Gameplay\Progression\MissionTransitionStatus.cs
	namespace 	
Gameplay
 
{ 
[ 
DataContract 
] 
public 

enum #
MissionTransitionStatus '
{ 
[		 	

EnumMember			 
]		 
Inactive		 
=		 
$num		  !
,		! "
[

 	

EnumMember

	 
]

 "
WaitingForParticipants

 +
=

, -
$num

. /
,

/ 0
[ 	

EnumMember	 
] 
CountingDown !
=" #
$num$ %
,% &
[ 	

EnumMember	 
] 
	Preparing 
=  
$num! "
," #
[ 	

EnumMember	 
] 
PreparationFailed &
=' (
$num) *
,* +
[ 	

EnumMember	 
] 
AttemptLimitReached (
=) *
$num+ ,
,, -
[ 	

EnumMember	 
] 
CampaignCompleted &
=' (
$num) *
,* +
[ 	

EnumMember	 
] 
MissionUnavailable '
=( )
$num* +
} 
} ¨
hC:\Users\oscar\source\repos\TrickTakingMissions\Shared\Gameplay\Progression\MissionTransitionSnapshot.cs
	namespace 	
Gameplay
 
{ 
[ 
DataContract 
] 
public 

sealed 
class %
MissionTransitionSnapshot 1
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
public 
int 
MissionAttemptId #
{$ %
get& )
;) *
set+ .
;. /
}0 1
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public 
int 
AttemptNumber  
{! "
get# &
;& '
set( +
;+ ,
}- .
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public #
MissionTransitionStatus &
Status' -
{. /
get0 3
;3 4
set5 8
;8 9
}: ;
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public !
MissionTransitionKind $
Kind% )
{* +
get, /
;/ 0
set1 4
;4 5
}6 7
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public 
Guid '
MissionTransitionScheduleId /
{0 1
get2 5
;5 6
set7 :
;: ;
}< =
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public 
int &
RemainingDelayMilliseconds -
{. /
get0 3
;3 4
set5 8
;8 9
}: ;
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public 
int 
[ 
] %
MissingParticipantUserIds .
{/ 0
get1 4
;4 5
set6 9
;9 :
}; <
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public   
int   $
DestinationMissionNumber   +
{  , -
get  . 1
;  1 2
set  3 6
;  6 7
}  8 9
["" 	

DataMember""	 
("" 
Order"" 
="" 
$num"" 
)"" 
]"" 
public## 
int## 
TargetMissionCount## %
{##& '
get##( +
;##+ ,
set##- 0
;##0 1
}##2 3
}$$ 
}%% ¬
dC:\Users\oscar\source\repos\TrickTakingMissions\Shared\Gameplay\Progression\MissionTransitionKind.cs
	namespace 	
Gameplay
 
{ 
[ 
DataContract 
] 
public 

enum !
MissionTransitionKind %
{ 
[		 	

EnumMember			 
]		 
None		 
=		 
$num		 
,		 
[

 	

EnumMember

	 
]

 
RetryCurrentMission

 (
=

) *
$num

+ ,
,

, -
[ 	

EnumMember	 
]  
AdvanceToNextMission )
=* +
$num, -
} 
} ©5
oC:\Users\oscar\source\repos\TrickTakingMissions\Shared\Gameplay\Preparation\PlayerMissionPreparationSnapshot.cs
	namespace 	
Gameplay
 
{ 
[ 
DataContract 
] 
public 

sealed 
class ,
 PlayerMissionPreparationSnapshot 8
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
Guid 
? /
#AvailableObjectiveDraftSubmissionId 8
{9 :
get; >
;> ?
set@ C
;C D
}E F
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public 
int 
MissionAttemptId #
{$ %
get& )
;) *
set+ .
;. /
}0 1
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public 
int 
MissionNumber  
{! "
get# &
;& '
set( +
;+ ,
}- .
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public 
bool !
IsPreparationComplete )
{* +
get, /
;/ 0
set1 4
;4 5
}6 7
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public 
int -
!CurrentObjectiveDraftPlayerUserId 4
{5 6
get7 :
;: ;
set< ?
;? @
}A B
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public $
MissionObjectiveSnapshot '
[' (
]( )

Objectives* 4
{5 6
get7 :
;: ;
set< ?
;? @
}A B
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public #
MissionPreparationStage &
Stage' ,
{- .
get/ 2
;2 3
set4 7
;7 8
}9 :
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public 
Guid %
MissionPreparationStageId -
{. /
get0 3
;3 4
set5 8
;8 9
}: ;
[   	

DataMember  	 
(   
Order   
=   
$num   
)   
]   
public!! 
int!! 
[!! 
]!! *
EligibleRoleParticipantUserIds!! 3
{!!4 5
get!!6 9
;!!9 :
set!!; >
;!!> ?
}!!@ A
["" 	

DataMember""	 
("" 
Order"" 
="" 
$num"" 
)"" 
]""  
public## 
bool## '
CanRespondToBlindObjectives## /
{##0 1
get##2 5
;##5 6
set##7 :
;##: ;
}##< =
[$$ 	

DataMember$$	 
($$ 
Order$$ 
=$$ 
$num$$ 
)$$ 
]$$  
public%% -
!BlindObjectiveParticipantSnapshot%% 0
[%%0 1
]%%1 2#
BlindObjectiveResponses%%3 J
{%%K L
get%%M P
;%%P Q
set%%R U
;%%U V
}%%W X
[&& 	

DataMember&&	 
(&& 
Order&& 
=&& 
$num&& 
)&& 
]&&  
public'' 
int'' 
?'' %
SilencedParticipantUserId'' -
{''. /
get''0 3
;''3 4
set''5 8
;''8 9
}'': ;
[(( 	

DataMember((	 
((( 
Order(( 
=(( 
$num(( 
)(( 
]((  
public)) 
int)) 
?)) '
SoleObjectiveAssigneeUserId)) /
{))0 1
get))2 5
;))5 6
set))7 :
;)): ;
}))< =
[** 	

DataMember**	 
(** 
Order** 
=** 
$num** 
)** 
]**  
public++ 
int++ 
?++ .
"SingleTrickWinnerParticipantUserId++ 6
{++7 8
get++9 <
;++< =
set++> A
;++A B
}++C D
[,, 	

DataMember,,	 
(,, 
Order,, 
=,, 
$num,, 
),, 
],,  
public-- 
int-- 
?-- 4
(FirstAndLastTrickWinnerParticipantUserId-- <
{--= >
get--? B
;--B C
set--D G
;--G H
}--I J
[.. 	

DataMember..	 
(.. 
Order.. 
=.. 
$num.. 
).. 
]..  
public// 
int// 
?// 2
&FirstFourTricksWinnerParticipantUserId// :
{//; <
get//= @
;//@ A
set//B E
;//E F
}//G H
[00 	

DataMember00	 
(00 
Order00 
=00 
$num00 
)00 
]00  
public11 
int11 
?11 ,
 LastTrickWinnerParticipantUserId11 4
{115 6
get117 :
;11: ;
set11< ?
;11? @
}11A B
[22 	

DataMember22	 
(22 
Order22 
=22 
$num22 
)22 
]22  
public33 
int33 
?33 +
HeartNineOwnerParticipantUserId33 3
{334 5
get336 9
;339 :
set33; >
;33> ?
}33@ A
[44 	

DataMember44	 
(44 
Order44 
=44 
$num44 
)44 
]44  
public55 
int55 
?55 1
%RequiredHeartCaptureParticipantUserId55 9
{55: ;
get55< ?
;55? @
set55A D
;55D E
}55F G
[66 	

DataMember66	 
(66 
Order66 
=66 
$num66 
)66 
]66  
public77 
bool77 )
CanIdentifyHeartNineOwnership77 1
{772 3
get774 7
;777 8
set779 <
;77< =
}77> ?
}88 
}99 è
dC:\Users\oscar\source\repos\TrickTakingMissions\Shared\Gameplay\Preparation\MissionObjectiveToken.cs
	namespace 	
Gameplay
 
{ 
[ 
DataContract 
] 
public 

enum !
MissionObjectiveToken %
{ 
[		 	

EnumMember			 
]		 
None

 
=

 
$num

 
,

 
[ 	

EnumMember	 
] 
OrderOne 
= 
$num 
, 
[ 	

EnumMember	 
] 
OrderTwo 
= 
$num 
, 
[ 	

EnumMember	 
] 

OrderThree 
= 
$num 
, 
[ 	

EnumMember	 
] 
	OrderFour 
= 
$num 
, 
[ 	

EnumMember	 
] 
	OrderFive 
= 
$num 
, 
[ 	

EnumMember	 
] 
ArrowOne 
= 
$num 
, 
[ 	

EnumMember	 
] 
ArrowTwo 
= 
$num 
, 
[!! 	

EnumMember!!	 
]!! 

ArrowThree"" 
="" 
$num"" 
,"" 
[$$ 	

EnumMember$$	 
]$$ 
	ArrowFour%% 
=%% 
$num%% 
,%% 
['' 	

EnumMember''	 
]'' 
Omega(( 
=(( 
$num(( 
})) 
}** ø
gC:\Users\oscar\source\repos\TrickTakingMissions\Shared\Gameplay\Preparation\MissionObjectiveSnapshot.cs
	namespace 	
Gameplay
 
{ 
[ 
DataContract 
] 
public 

sealed 
class $
MissionObjectiveSnapshot 0
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
Guid 
MissionObjectiveId &
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
public 
int 
? 
CardId 
{ 
get  
;  !
set" %
;% &
}' (
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public !
MissionObjectiveToken $
Token% *
{+ ,
get- 0
;0 1
set2 5
;5 6
}7 8
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public 
int 
?  
AssignedPlayerUserId (
{) *
get+ .
;. /
set0 3
;3 4
}5 6
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public 
bool 

IsRevealed 
{  
get! $
;$ %
set& )
;) *
}+ ,
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public "
MissionObjectiveStatus %
Status& ,
{- .
get/ 2
;2 3
set4 7
;7 8
}9 :
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public 
int 
? "
CompletedAtTrickNumber *
{+ ,
get- 0
;0 1
set2 5
;5 6
}7 8
} 
} —
nC:\Users\oscar\source\repos\TrickTakingMissions\Shared\Gameplay\Preparation\MissionObjectiveDraftSubmission.cs
	namespace 	
Gameplay
 
{ 
[ 
DataContract 
] 
public 

sealed 
class +
MissionObjectiveDraftSubmission 7
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
public 
string 
	LobbyCode 
{  !
get" %
;% &
set' *
;* +
}, -
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public 
Guid 
MatchId 
{ 
get !
;! "
set# &
;& '
}( )
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public 
int 
MissionAttemptId #
{$ %
get& )
;) *
set+ .
;. /
}0 1
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public 
Guid &
ObjectiveDraftSubmissionId .
{/ 0
get1 4
;4 5
set6 9
;9 :
}; <
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public 
long %
ExpectedMatchStateVersion -
{. /
get0 3
;3 4
set5 8
;8 9
}: ;
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public '
MissionObjectiveDraftAction * 
ObjectiveDraftAction+ ?
{@ A
getB E
;E F
setG J
;J K
}L M
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public 
Guid 
? &
SelectedMissionObjectiveId /
{0 1
get2 5
;5 6
set7 :
;: ;
}< =
} 
} ñ
sC:\Users\oscar\source\repos\TrickTakingMissions\Shared\Gameplay\Preparation\MissionObjectiveDraftRejectionReason.cs
	namespace 	
Gameplay
 
{ 
[ 
DataContract 
] 
public 

enum 0
$MissionObjectiveDraftRejectionReason 4
{ 
[		 	

EnumMember			 
]		 
None

 
=

 
$num

 
,

 
[ 	

EnumMember	 
] 
MatchUnavailable 
= 
$num 
, 
[ 	

EnumMember	 
] !
ParticipantNotAllowed 
= 
$num  !
,! "
[ 	

EnumMember	 
] 
InvalidSubmission 
= 
$num 
, 
[ 	

EnumMember	 
] $
SubmissionIdentityReused  
=! "
$num# $
,$ %
[ 	

EnumMember	 
] 
StaleMatchState 
= 
$num 
, 
[ 	

EnumMember	 
] 
NotDraftTurn 
= 
$num 
, 
[ 	

EnumMember	 
]  
ObjectiveUnavailable 
= 
$num  
,  !
[!! 	

EnumMember!!	 
]!!  
PreparationCompleted"" 
="" 
$num""  
,""  !
[$$ 	

EnumMember$$	 
]$$ 
RequestLimitReached%% 
=%% 
$num%% 
,%%  
['' 	

EnumMember''	 
]''  
UnsupportedDraftMode(( 
=(( 
$num(( !
,((! "
[** 	

EnumMember**	 
]** 
SubmissionExpired++ 
=++ 
$num++ 
},, 
}-- ¸
lC:\Users\oscar\source\repos\TrickTakingMissions\Shared\Gameplay\Preparation\MissionObjectiveDraftDecision.cs
	namespace 	
Gameplay
 
{ 
[ 
DataContract 
] 
public 

sealed 
class )
MissionObjectiveDraftDecision 5
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
Guid &
ObjectiveDraftSubmissionId .
{/ 0
get1 4
;4 5
set6 9
;9 :
}; <
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public 
bool 

IsAccepted 
{  
get! $
;$ %
set& )
;) *
}+ ,
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public 0
$MissionObjectiveDraftRejectionReason 3
RejectionReason4 C
{D E
getF I
;I J
setK N
;N O
}P Q
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public 
long &
CommittedMatchStateVersion .
{/ 0
get1 4
;4 5
set6 9
;9 :
}; <
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public 
bool *
HasCompletedSelectionFreeCycle 2
{3 4
get5 8
;8 9
set: =
;= >
}? @
} 
} ¡
jC:\Users\oscar\source\repos\TrickTakingMissions\Shared\Gameplay\Preparation\MissionObjectiveDraftAction.cs
	namespace 	
Gameplay
 
{ 
[ 
DataContract 
] 
public 

enum '
MissionObjectiveDraftAction +
{ 
[		 	

EnumMember			 
]		 
Unspecified

 
=

 
$num

 
,

 
[ 	

EnumMember	 
] 
SelectObjective 
= 
$num 
, 
[ 	

EnumMember	 
] 
Pass 
= 
$num 
} 
} Î	
^C:\Users\oscar\source\repos\TrickTakingMissions\Shared\Gameplay\PlayerCapturedCardsSnapshot.cs
	namespace 	
Gameplay
 
{ 
[ 
DataContract 
] 
public		 

sealed		 
class		 '
PlayerCapturedCardsSnapshot		 3
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
public 
int 
PlayerUserId 
{  !
get" %
;% &
set' *
;* +
}, -
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public 
int 
WonTrickCount  
{! "
get# &
;& '
set( +
;+ ,
}- .
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public 
int 
[ 
] 

WonCardIds 
{  !
get" %
;% &
set' *
;* +
}, -
} 
} 
SC:\Users\oscar\source\repos\TrickTakingMissions\Shared\Gameplay\MatchAccessFault.cs
	namespace 	
Gameplay
 
{ 
[ 
DataContract 
] 
public 

sealed 
class 
MatchAccessFault (
{ 
[		 	

DataMember			 
(		 
Order		 
=		 
$num		 
)		 
]		 
public

 
string

 
FailureCode

 !
{

" #
get

$ '
;

' (
set

) ,
;

, -
}

. /
} 
} Ì;
PC:\Users\oscar\source\repos\TrickTakingMissions\Shared\Gameplay\IMatchService.cs
	namespace 	
Gameplay
 
{ 
[ 
ServiceContract 
] 
public 

	interface 
IMatchService "
{ 
[		 	
OperationContract			 
(		 
Action		 !
=		" #
$str		$ U
,		U V
ReplyAction		W b
=		c d
$str		e h
)		h i
]		i j
[

 	
FaultContract

	 
(

 
typeof

 
(

 
MatchAccessFault

 .
)

. /
)

/ 0
]

0 1
[ 	
FaultContract	 
( 
typeof 
( #
MissionPreparationFault 5
)5 6
)6 7
]7 8*
MissionPreparationConfirmation &"
IdentifyHeartNineOwner' =
(= >-
!HeartNineIdentificationSubmission -

submission. 8
,8 9
int: =
participantUserId> O
)O P
;P Q
[ 	
OperationContract	 
( 
Action !
=" #
$str$ ]
,] ^
ReplyAction_ j
=k l
$strm p
)p q
]q r
[ 	
FaultContract	 
( 
typeof 
( 
MatchAccessFault .
). /
)/ 0
]0 1
[ 	
FaultContract	 
( 
typeof 
( #
MissionPreparationFault 5
)5 6
)6 7
]7 8*
MissionPreparationConfirmation &*
AssignMissionTrickDistribution' E
(E F.
"MissionTrickDistributionSubmission .

submission/ 9
,9 :
int; >
participantUserId? P
)P Q
;Q R
[ 	
OperationContract	 
( 
Action !
=" #
$str$ P
,P Q
ReplyActionR ]
=^ _
$str` c
)c d
]d e
[ 	
FaultContract	 
( 
typeof 
( 
MatchAccessFault .
). /
)/ 0
]0 1
[ 	
FaultContract	 
( 
typeof 
( #
MissionPreparationFault 5
)5 6
)6 7
]7 8*
MissionPreparationConfirmation &
AssignMissionRole' 8
(8 9+
MissionRoleAssignmentSubmission9 X

submissionY c
,c d
inte h
participantUserId 
) 
; 
[ 	
OperationContract	 
( 
Action !
=" #
$str$ W
,W X
ReplyActionY d
=e f
$strg j
)j k
]k l
[ 	
FaultContract	 
( 
typeof 
( 
MatchAccessFault .
). /
)/ 0
]0 1
[ 	
FaultContract	 
( 
typeof 
( #
MissionPreparationFault 5
)5 6
)6 7
]7 8*
MissionPreparationConfirmation &$
RespondToBlindObjectives' ?
(? @,
 BlindObjectiveResponseSubmission@ `

submissiona k
,k l
intm p
participantUserId 
) 
; 
[!! 	
OperationContract!!	 
(!! 
Action!! !
=!!" #
$str!!$ Z
,!!Z [
ReplyAction!!\ g
=!!h i
$str!!j m
)!!m n
]!!n o
["" 	
FaultContract""	 
("" 
typeof"" 
("" 
MatchAccessFault"" .
)"". /
)""/ 0
]""0 1)
MissionObjectiveDraftDecision## %'
ProcessObjectiveDraftAction##& A
(##A B+
MissionObjectiveDraftSubmission$$ +

submission$$, 6
,$$6 7
int$$8 ;
participantUserId$$< M
)$$M N
;$$N O
[&& 	
OperationContract&&	 
(&& 
Action&& !
=&&" #
$str&&$ M
,&&M N
ReplyAction&&O Z
=&&[ \
$str&&] `
)&&` a
]&&a b
['' 	
FaultContract''	 
('' 
typeof'' 
('' 
MatchAccessFault'' .
)''. /
)''/ 0
]''0 1
PlayerMatchSnapshot(( 
GetPlayerMatch(( *
(((* +
string((+ 1
	lobbyCode((2 ;
,((; <
int((= @
participantUserId((A R
)((R S
;((S T
[** 	
OperationContract**	 
(** 
Action** !
=**" #
$str**$ R
,**R S
ReplyAction**T _
=**` a
$str**b e
)**e f
]**f g
[++ 	
FaultContract++	 
(++ 
typeof++ 
(++ 
MatchAccessFault++ .
)++. /
)++/ 0
]++0 1 
MissionRetryDecision,, 
ConfirmMissionRetry,, 0
(,,0 1"
MissionRetrySubmission,,1 G

submission,,H R
,,,R S
int,,T W
participantUserId,,X i
),,i j
;,,j k
[.. 	
OperationContract..	 
(.. 
Action.. !
=.." #
$str..$ W
,..W X
ReplyAction..Y d
=..e f
$str..g j
)..j k
]..k l
[// 	
FaultContract//	 
(// 
typeof// 
(// 
MatchAccessFault// .
)//. /
)/// 0
]//0 1
[00 	
FaultContract00	 
(00 
typeof00 
(00 #
RadioCommunicationFault00 5
)005 6
)006 7
]007 8*
RadioCommunicationConfirmation11 &$
SubmitRadioCommunication11' ?
(11? @(
RadioCommunicationSubmission11@ \

submission11] g
,11g h
int22 
participantUserId22 !
)22! "
;22" #
[44 	
OperationContract44	 
(44 
Action44 !
=44" #
$str44$ G
,44G H
ReplyAction44I T
=44U V
$str44W Z
)44Z [
]44[ \
[55 	
FaultContract55	 
(55 
typeof55 
(55 
MatchAccessFault55 .
)55. /
)55/ 0
]550 1
CardPlayDecision66 
PlayCard66 !
(66! "
CardPlaySubmission66" 4
cardPlaySubmission665 G
,66G H
int66I L
participantUserId66M ^
)66^ _
;66_ `
[88 	
OperationContract88	 
(88 
Action88 !
=88" #
$str88$ S
,88S T
ReplyAction88U `
=88a b
$str88c f
)88f g
]88g h
[99 	
FaultContract99	 
(99 
typeof99 
(99 
MatchAccessFault99 .
)99. /
)99/ 0
]990 1
[:: 	
FaultContract::	 
(:: 
typeof:: 
(:: 
DistressSignalFault:: 1
)::1 2
)::2 3
]::3 4&
DistressSignalConfirmation;; " 
SubmitDistressSignal;;# 7
(;;7 8$
DistressSignalSubmission;;8 P

submission;;Q [
,;;[ \
int;;] `
participantUserId;;a r
);;r s
;;;s t
}<< 
}== ¬
dC:\Users\oscar\source\repos\TrickTakingMissions\Shared\Gameplay\Distress\DistressSignalSubmission.cs
	namespace 	
Gameplay
 
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
 $
DistressSignalSubmission

 0
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
Guid 
MatchId 
{ 
get !
;! "
set# &
;& '
}( )
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public 
string 
	LobbyCode 
{  !
get" %
;% &
set' *
;* +
}, -
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public 
int 
MissionAttemptId #
{$ %
get& )
;) *
set+ .
;. /
}0 1
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public 
int 
CardIdToPass 
{  !
get" %
;% &
set' *
;* +
}, -
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public !
DistressPassDirection $
SelectedDirection% 6
{7 8
get9 <
;< =
set> A
;A B
}C D
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public 
bool 
IsVoteAccepted "
{# $
get% (
;( )
set* -
;- .
}/ 0
=1 2
true3 7
;7 8
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public $
DistressSignalActionType '

ActionType( 2
{3 4
get5 8
;8 9
set: =
;= >
}? @
}   
}!! á1
lC:\Users\oscar\source\repos\TrickTakingMissions\Shared\Gameplay\Evaluation\MissionEvaluationFailureReason.cs
	namespace 	
Gameplay
 
{ 
[ 
DataContract 
] 
public 

enum *
MissionEvaluationFailureReason .
{ 
[		 	

EnumMember			 
]		 
None		 
=		 
$num		 
,		 
[

 	

EnumMember

	 
]

 (
ObjectiveCapturedByWrongSeat

 1
=

2 3
$num

4 5
,

5 6
[ 	

EnumMember	 
] ,
 MultipleOrderedTokensInSameTrick 5
=6 7
$num8 9
,9 :
[ 	

EnumMember	 
] *
MultipleArrowTokensInSameTrick 3
=4 5
$num6 7
,7 8
[ 	

EnumMember	 
] '
OmegaSimultaneousCompletion 0
=1 2
$num3 4
,4 5
[ 	

EnumMember	 
] +
PrecedingOrderTokenNotCompleted 4
=5 6
$num7 8
,8 9
[ 	

EnumMember	 
] +
PrecedingArrowTokenNotCompleted 4
=5 6
$num7 8
,8 9
[ 	

EnumMember	 
] *
OmegaObjectiveNotCompletedLast 3
=4 5
$num6 7
,7 8
[ 	

EnumMember	 
] ,
 ObjectivesIncompleteAtMissionEnd 5
=6 7
$num8 9
,9 :
[ 	

EnumMember	 
] (
Mission48OmegaNotInLastTrick 1
=2 3
$num4 5
,5 6
[ 	

EnumMember	 
] 3
'Mission48PendingNonOmegaBeforeLastTrick <
== >
$num? A
,A B
[ 	

EnumMember	 
] $
SpecialMissionConstraint -
=. /
$num0 2
,2 3
[ 	

EnumMember	 
] -
!AllParticipantsWonAtLeastOneTrick 6
=7 8
$num9 ;
,; <
[ 	

EnumMember	 
] #
NormalOneDidNotWinTrick ,
=- .
$num/ 1
,1 2
[ 	

EnumMember	 
]  
SpecialCardLostTrick )
=* +
$num, .
,. /
[ 	

EnumMember	 
] 2
&SpecialCardsDidNotWinAllRequiredTricks ;
=< =
$num> @
,@ A
[ 	

EnumMember	 
] 
NormalNineWonTrick '
=( )
$num* ,
,, -
[ 	

EnumMember	 
] .
"InsufficientNormalOneWinningTricks 7
=8 9
$num: <
,< =
[ 	

EnumMember	 
] &
WonTrickDifferenceExceeded /
=0 1
$num2 4
,4 5
[ 	

EnumMember	 
] '
SingleTrickWinnerUnassigned 0
=1 2
$num3 5
,5 6
[ 	

EnumMember	 
] 1
%SelectedParticipantWonWithSpecialCard :
=; <
$num= ?
,? @
[ 	

EnumMember	 
] 0
$SelectedParticipantWonMultipleTricks 9
=: ;
$num< >
,> ?
[ 	

EnumMember	 
] 7
+SelectedParticipantDidNotWinExactlyOneTrick @
=A B
$numC E
,E F
[   	

EnumMember  	 
]   &
CaptainDidNotWinFirstTrick   /
=  0 1
$num  2 4
,  4 5
[!! 	

EnumMember!!	 
]!! %
CaptainDidNotWinLastTrick!! .
=!!/ 0
$num!!1 3
,!!3 4
["" 	

EnumMember""	 
]"" (
FirstAndLastWinnerUnassigned"" 1
=""2 3
$num""4 6
,""6 7
[## 	

EnumMember##	 
]## +
FirstTrickWonByWrongParticipant## 4
=##5 6
$num##7 9
,##9 :
[$$ 	

EnumMember$$	 
]$$ (
FirstTrickWonWithSpecialCard$$ 1
=$$2 3
$num$$4 6
,$$6 7
[%% 	

EnumMember%%	 
]%% 5
)IntermediateTrickWonBySelectedParticipant%% >
=%%? @
$num%%A C
,%%C D
[&& 	

EnumMember&&	 
]&& *
LastTrickWonByWrongParticipant&& 3
=&&4 5
$num&&6 8
,&&8 9
['' 	

EnumMember''	 
]'' '
LastTrickWonWithSpecialCard'' 0
=''1 2
$num''3 5
,''5 6
[(( 	

EnumMember((	 
](( +
SpecialCardWinningOrderViolated(( 4
=((5 6
$num((7 9
,((9 :
[)) 	

EnumMember))	 
])) &
HeartNineOwnerUnidentified)) /
=))0 1
$num))2 4
,))4 5
[** 	

EnumMember**	 
]** +
HeartCapturedByWrongParticipant** 4
=**5 6
$num**7 9
,**9 :
[++ 	

EnumMember++	 
]++ $
HeartCardsNotAllCaptured++ -
=++. /
$num++0 2
,++2 3
[,, 	

EnumMember,,	 
],, '
TrickDistributionUnassigned,, 0
=,,1 2
$num,,3 5
,,,5 6
[-- 	

EnumMember--	 
]-- .
"InitialTricksWonByWrongParticipant-- 7
=--8 9
$num--: <
,--< =
[.. 	

EnumMember..	 
].. &
InitialTrickWinnerWonExtra.. /
=..0 1
$num..2 4
,..4 5
[// 	

EnumMember//	 
]// $
FinalTrickWinnerWonEarly// -
=//. /
$num//0 2
,//2 3
[00 	

EnumMember00	 
]00 +
FinalTrickWonByWrongParticipant00 4
=005 6
$num007 9
,009 :
[11 	

EnumMember11	 
]11 *
RemainingParticipantWonNoTrick11 3
=114 5
$num116 8
}22 
}33 Æ
dC:\Users\oscar\source\repos\TrickTakingMissions\Shared\Gameplay\Evaluation\MissionObjectiveStatus.cs
	namespace 	
Gameplay
 
{ 
[ 
DataContract 
] 
public 

enum "
MissionObjectiveStatus &
{ 
[		 	

EnumMember			 
]		 
Pending		 
=		 
$num		  
,		  !
[

 	

EnumMember

	 
]

 
	Completed

 
=

  
$num

! "
,

" #
[ 	

EnumMember	 
] 
Failed 
= 
$num 
} 
} ñ
_C:\Users\oscar\source\repos\TrickTakingMissions\Shared\Gameplay\Distress\DistressSignalFault.cs
	namespace 	
Gameplay
 
{ 
[ 
DataContract 
] 
public		 

sealed		 
class		 
DistressSignalFault		 +
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
public '
DistressSignalFailureReason *
FailureReason+ 8
{9 :
get; >
;> ?
set@ C
;C D
}E F
} 
} –
gC:\Users\oscar\source\repos\TrickTakingMissions\Shared\Gameplay\Evaluation\MissionEvaluationSnapshot.cs
	namespace 	
Gameplay
 
{ 
[ 
DataContract 
] 
public 

sealed 
class %
MissionEvaluationSnapshot 1
{ 
[		 	

DataMember			 
(		 
Order		 
=		 
$num		 
)		 
]		 
public

 
int

 
MissionAttemptId
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
) *
set

+ .
;

. /
}

0 1
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public 
int $
LastEvaluatedTrickNumber +
{, -
get. 1
;1 2
set3 6
;6 7
}8 9
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public *
MissionAttemptEvaluationStatus - 
MissionAttemptStatus. B
{C D
getE H
;H I
setJ M
;M N
}O P
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public *
MissionEvaluationFailureReason - 
MissionFailureReason. B
{C D
getE H
;H I
setJ M
;M N
}O P
} 
} ¡
lC:\Users\oscar\source\repos\TrickTakingMissions\Shared\Gameplay\Evaluation\MissionAttemptEvaluationStatus.cs
	namespace 	
Gameplay
 
{ 
[ 
DataContract 
] 
public 

enum *
MissionAttemptEvaluationStatus .
{ 
[		 	

EnumMember			 
]		 
NotEvaluated		 !
=		" #
$num		$ %
,		% &
[

 	

EnumMember

	 
]

 

InProgress

 
=

  !
$num

" #
,

# $
[ 	

EnumMember	 
] 
	Succeeded 
=  
$num! "
," #
[ 	

EnumMember	 
] 
Failed 
= 
$num 
} 
} ¨
_C:\Users\oscar\source\repos\TrickTakingMissions\Shared\Gameplay\Distress\DistressSignalPhase.cs
	namespace 	
Gameplay
 
{ 
[ 
DataContract 
] 
public		 

enum		 
DistressSignalPhase		 #
{

 
[ 	

EnumMember	 
] 
None 
= 
$num 
, 
[ 	

EnumMember	 
] 
VotingToUse  
=! "
$num# $
,$ %
[ 	

EnumMember	 
] 
VotingDirection $
=% &
$num' (
,( )
[ 	

EnumMember	 
] 
SelectingCard "
=# $
$num% &
,& '
[ 	

EnumMember	 
] 
	Completed 
=  
$num! "
} 
} Ê
bC:\Users\oscar\source\repos\TrickTakingMissions\Shared\Gameplay\Distress\DistressSignalSnapshot.cs
	namespace 	
Gameplay
 
{ 
[ 
DataContract 
] 
public		 

sealed		 
class		 "
DistressSignalSnapshot		 .
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
bool !
HasUsedDistressSignal )
{* +
get, /
;/ 0
set1 4
;4 5
}6 7
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public 
bool 
IsInProgress  
{! "
get# &
;& '
set( +
;+ ,
}- .
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public !
DistressPassDirection $
AgreedDirection% 4
{5 6
get7 :
;: ;
set< ?
;? @
}A B
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public 
int 
[ 
] '
SubmittedParticipantUserIds 0
{1 2
get3 6
;6 7
set8 ;
;; <
}= >
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public 
int 
InitiatorUserId "
{# $
get% (
;( )
set* -
;- .
}/ 0
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public 
string 
InitiatorPlayerName )
{* +
get, /
;/ 0
set1 4
;4 5
}6 7
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public 
bool 
HasBeenRejected #
{$ %
get& )
;) *
set+ .
;. /
}0 1
[   	

DataMember  	 
(   
Order   
=   
$num   
)   
]   
public!! 
DistressSignalPhase!! "
CurrentStep!!# .
{!!/ 0
get!!1 4
;!!4 5
set!!6 9
;!!9 :
}!!; <
[## 	

DataMember##	 
(## 
Order## 
=## 
$num## 
)## 
]## 
public$$ 
int$$ 
[$$ 
]$$ 
VotedYesUserIds$$ $
{$$% &
get$$' *
;$$* +
set$$, /
;$$/ 0
}$$1 2
[&& 	

DataMember&&	 
(&& 
Order&& 
=&& 
$num&& 
)&& 
]&&  
public'' 
int'' #
LeftDirectionVotesCount'' *
{''+ ,
get''- 0
;''0 1
set''2 5
;''5 6
}''7 8
[)) 	

DataMember))	 
()) 
Order)) 
=)) 
$num)) 
))) 
]))  
public** 
int** $
RightDirectionVotesCount** +
{**, -
get**. 1
;**1 2
set**3 6
;**6 7
}**8 9
[,, 	

DataMember,,	 
(,, 
Order,, 
=,, 
$num,, 
),, 
],,  
public-- 
int-- 
[-- 
]-- !
DirectionVotedUserIds-- *
{--+ ,
get--- 0
;--0 1
set--2 5
;--5 6
}--7 8
}.. 
}// æ
fC:\Users\oscar\source\repos\TrickTakingMissions\Shared\Gameplay\Distress\DistressSignalConfirmation.cs
	namespace 	
Gameplay
 
{ 
[ 
DataContract 
] 
public		 

sealed		 
class		 &
DistressSignalConfirmation		 2
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
bool 

IsExecuted 
{  
get! $
;$ %
set& )
;) *
}+ ,
[ 	

DataMember	 
( 
Order 
= 
$num 
) 
] 
public 
long &
CommittedMatchStateVersion .
{/ 0
get1 4
;4 5
set6 9
;9 :
}; <
} 
} ö
gC:\Users\oscar\source\repos\TrickTakingMissions\Shared\Gameplay\Distress\DistressSignalFailureReason.cs
	namespace 	
Gameplay
 
{ 
[ 
DataContract 
] 
public		 

enum		 '
DistressSignalFailureReason		 +
{

 
[ 	

EnumMember	 
] 
None 
= 
$num 
, 
[ 	

EnumMember	 
] 
InvalidSubmission &
=' (
$num) *
,* +
[ 	

EnumMember	 
] 
MatchUnavailable %
=& '
$num( )
,) *
[ 	

EnumMember	 
] !
ParticipantNotAllowed *
=+ ,
$num- .
,. /
[ 	

EnumMember	 
] 
WrongMissionAttempt (
=) *
$num+ ,
,, -
[ 	

EnumMember	 
] &
MissionPreparationRequired /
=0 1
$num2 3
,3 4
[ 	

EnumMember	 
] "
MissionAttemptFinished +
=, -
$num. /
,/ 0
[ 	

EnumMember	 
] 
DistressAlreadyUsed (
=) *
$num+ ,
,, -
[ 	

EnumMember	 
] 
TrickAlreadyStarted (
=) *
$num+ ,
,, -
[ 	

EnumMember	 
] 
RadioAlreadyUsed %
=& '
$num( )
,) *
[ 	

EnumMember	 
] 
CardNotInHand "
=# $
$num% '
,' (
[ 	

EnumMember	 
] !
SpecialCardNotAllowed *
=+ ,
$num- /
,/ 0
[ 	

EnumMember	 
] !
InvalidStepTransition *
=+ ,
$num- /
,/ 0
[ 	

EnumMember	 
]  
OperationUnavailable )
=* +
$num, .
} 
} ∏
dC:\Users\oscar\source\repos\TrickTakingMissions\Shared\Gameplay\Distress\DistressSignalActionType.cs
	namespace 	
Gameplay
 
{ 
[ 
DataContract 
] 
public		 

enum		 $
DistressSignalActionType		 (
{

 
[ 	

EnumMember	 
] 
None 
= 
$num 
, 
[ 	

EnumMember	 
] 
ProposeUsage !
=" #
$num$ %
,% &
[ 	

EnumMember	 
] 
	VoteUsage 
=  
$num! "
," #
[ 	

EnumMember	 
] 
VoteDirection "
=# $
$num% &
,& '
[ 	

EnumMember	 
] 
SubmitPassCard #
=$ %
$num& '
,' (
[ 	

EnumMember	 
] 
CancelProposal #
=$ %
$num& '
} 
} °
aC:\Users\oscar\source\repos\TrickTakingMissions\Shared\Gameplay\Distress\DistressPassDirection.cs
	namespace 	
Gameplay
 
{ 
[ 
DataContract 
] 
public		 

enum		 !
DistressPassDirection		 %
{

 
[ 	

EnumMember	 
] 
None 
= 
$num 
, 
[ 	

EnumMember	 
] 
Left 
= 
$num 
, 
[ 	

EnumMember	 
] 
Right 
= 
$num 
} 
} 