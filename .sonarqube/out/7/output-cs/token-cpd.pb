ù'
vC:\Users\oscar\source\repos\TrickTakingMissions\Client\ClientTrickTakingMissions\Converters\CardArtworkPathResolver.cs
	namespace 	
View
 
. 

Converters 
{		 
internal

 
static

 
class

 #
CardArtworkPathResolver

 1
{ 
private 
const 
string 
CardBackPath )
=* +
$str, g
;g h
private 
const 
string 
StandardCardPath -
=. /
$str0 f
;f g
private 
const 
string 
ObjectiveCardPath .
=/ 0
$str U
;U V
private 
static 
readonly 
IReadOnlyDictionary  3
<3 4
int4 7
,7 8
string9 ?
>? @
s_numberNamesA N
=O P
newQ T

DictionaryU _
<_ `
int` c
,c d
stringe k
>k l
{ 	
{ 
$num 
, 
$str 
} 
, 
{ 
$num 
, 
$str $
}% &
,& '
{( )
$num* +
,+ ,
$str- 4
}5 6
,6 7
{8 9
$num: ;
,; <
$str= C
}D E
,E F
{G H
$numI J
,J K
$strL R
}S T
,T U
{ 
$num 
, 
$str 
} 
, 
{ 
$num 
, 
$str &
}' (
,( )
{* +
$num, -
,- .
$str/ 6
}7 8
,8 9
{: ;
$num< =
,= >
$str? E
}F G
} 	
;	 

internal 
static 
string 
ResolveCardPath .
(. /
object/ 5
value6 ;
,; <
bool= A
isObjectiveCardB Q
)Q R
{ 	
string 
artworkPath 
=  
CardBackPath! -
;- .
if 
( 
value 
is 
int 
cardId #
)# $
{ 
try 
{ 
Card 
card 
= 
	DeckRules  )
.) *
GetCardById* 5
(5 6
cardId6 <
)< =
;= >
artworkPath 
=  !#
ResolveOfficialCardPath" 9
(9 :
card: >
,> ?
isObjectiveCard@ O
)O P
;P Q
} 
catch   
(   '
ArgumentOutOfRangeException   2
)  2 3
{!! 
artworkPath"" 
=""  !
CardBackPath""" .
;"". /
}## 
}$$ 
return%% 
artworkPath%% 
;%% 
}&& 	
private(( 
static(( 
string(( #
ResolveOfficialCardPath(( 5
(((5 6
Card((6 :
card((; ?
,((? @
bool((A E
isObjectiveCard((F U
)((U V
{)) 	
string** 
artworkPath** 
=**  
CardBackPath**! -
;**- .
bool++ 
isSpecialCard++ 
=++  
card++! %
.++% &
Suit++& *
==+++ -
CardSuit++. 6
.++6 7
Special++7 >
;++> ?
if,, 
(,, 
!,, 
isObjectiveCard,,  
||,,! #
!,,$ %
isSpecialCard,,% 2
),,2 3
{-- 
string.. 
suitName.. 
=..  !
isSpecialCard.." /
?..0 1
card..2 6
...6 7
SpecialSymbol..7 D
...D E
ToString..E M
(..M N
)..N O
:..P Q
card..R V
...V W
Suit..W [
...[ \
ToString..\ d
(..d e
)..e f
;..f g
string// 

numberName// !
=//" #
isSpecialCard//$ 1
?//2 3
$str//4 :
://; <
s_numberNames//= J
[//J K
card//K O
.//O P
Number//P V
]//V W
;//W X
artworkPath00 
=00 
string00 $
.00$ %
Format00% +
(00+ ,
CultureInfo00, 7
.007 8
InvariantCulture008 H
,00H I
isObjectiveCard11 #
?11$ %
ObjectiveCardPath11& 7
:118 9
StandardCardPath11: J
,11J K
suitName11L T
,11T U

numberName11V `
)11` a
;11a b
}22 
return33 
artworkPath33 
;33 
}44 	
}55 
}66 …
çC:\Users\oscar\source\repos\TrickTakingMissions\Client\ClientTrickTakingMissions\Converters\RadioTokenPositionToVerticalAlignmentConverter.cs
	namespace 	
View
 
. 

Converters 
{ 
public 

sealed 
class :
.RadioTokenPositionToVerticalAlignmentConverter F
:G H
IValueConverterI X
{ 
public 
object 
Convert 
( 
object $
value% *
,* +
Type, 0

targetType1 ;
,; <
object= C
	parameterD M
,M N
CultureInfoO Z
culture[ b
)b c
{ 	
VerticalAlignment 
resolvedAlignment /
=0 1
VerticalAlignment2 C
.C D
CenterD J
;J K
if 
( 
value 
is 
RadioTokenPosition +
tokenPosition, 9
)9 :
{ 
switch 
( 
tokenPosition %
)% &
{ 
case 
RadioTokenPosition +
.+ ,
Highest, 3
:3 4
resolvedAlignment )
=* +
VerticalAlignment, =
.= >
Top> A
;A B
break 
; 
case 
RadioTokenPosition +
.+ ,
Lowest, 2
:2 3
resolvedAlignment )
=* +
VerticalAlignment, =
.= >
Bottom> D
;D E
break 
; 
case 
RadioTokenPosition +
.+ ,
Only, 0
:0 1
case 
RadioTokenPosition +
.+ ,
Interference, 8
:8 9
default 
: 
resolvedAlignment )
=* +
VerticalAlignment, =
.= >
Center> D
;D E
break 
; 
}   
}!! 
return"" 
resolvedAlignment"" $
;""$ %
}## 	
public%% 
object%% 
ConvertBack%% !
(%%! "
object%%" (
value%%) .
,%%. /
Type%%0 4

targetType%%5 ?
,%%? @
object%%A G
	parameter%%H Q
,%%Q R
CultureInfo%%S ^
culture%%_ f
)%%f g
{&& 	
return'' 
Binding'' 
.'' 
	DoNothing'' $
;''$ %
}(( 	
})) 
}** »
àC:\Users\oscar\source\repos\TrickTakingMissions\Client\ClientTrickTakingMissions\Converters\MissionObjectiveTokenToImagePathConverter.cs
	namespace 	
View
 
. 

Converters 
{ 
public		 

sealed		 
class		 5
)MissionObjectiveTokenToImagePathConverter		 A
:		B C
IValueConverter		D S
{

 
private 
static 
readonly 
IReadOnlyDictionary  3
<3 4!
MissionObjectiveToken4 I
,I J
stringK Q
>Q R
s_tokenFilesS _
=` a
new 

Dictionary 
< !
MissionObjectiveToken 0
,0 1
string2 8
>8 9
{ 
{ !
MissionObjectiveToken '
.' (
OrderOne( 0
,0 1
$str2 =
}> ?
,? @
{ !
MissionObjectiveToken '
.' (
OrderTwo( 0
,0 1
$str2 =
}> ?
,? @
{ !
MissionObjectiveToken '
.' (

OrderThree( 2
,2 3
$str4 A
}B C
,C D
{ !
MissionObjectiveToken '
.' (
	OrderFour( 1
,1 2
$str3 ?
}@ A
,A B
{ !
MissionObjectiveToken '
.' (
	OrderFive( 1
,1 2
$str3 ?
}@ A
,A B
{ !
MissionObjectiveToken '
.' (
ArrowOne( 0
,0 1
$str2 =
}> ?
,? @
{ !
MissionObjectiveToken '
.' (
ArrowTwo( 0
,0 1
$str2 =
}> ?
,? @
{ !
MissionObjectiveToken '
.' (

ArrowThree( 2
,2 3
$str4 A
}B C
,C D
{ !
MissionObjectiveToken '
.' (
	ArrowFour( 1
,1 2
$str3 ?
}@ A
,A B
{ !
MissionObjectiveToken '
.' (
Omega( -
,- .
$str/ 6
}7 8
} 
; 
public 
object 
Convert 
( 
object $
value% *
,* +
Type, 0

targetType1 ;
,; <
object= C
	parameterD M
,M N
CultureInfoO Z
culture[ b
)b c
{ 	
string 
	tokenPath 
= 
null #
;# $
if 
( 
value 
is !
MissionObjectiveToken .
token/ 4
&&5 7
s_tokenFiles8 D
.D E
TryGetValueE P
(P Q
tokenQ V
,V W
outX [
string\ b
	tokenFilec l
)l m
)m n
{ 
	tokenPath 
= 
string "
." #
Format# )
() *
CultureInfo* 5
.5 6
InvariantCulture6 F
,F G
$str   Y
,  Y Z
	tokenFile  [ d
)  d e
;  e f
}!! 
return"" 
	tokenPath"" 
;"" 
}## 	
public%% 
object%% 
ConvertBack%% !
(%%! "
object%%" (
value%%) .
,%%. /
Type%%0 4

targetType%%5 ?
,%%? @
object%%A G
	parameter%%H Q
,%%Q R
CultureInfo%%S ^
culture%%_ f
)%%f g
{&& 	
return'' 
Binding'' 
.'' 
	DoNothing'' $
;''$ %
}(( 	
})) 
}** ˘

âC:\Users\oscar\source\repos\TrickTakingMissions\Client\ClientTrickTakingMissions\Converters\MissionObjectiveCardIdToImagePathConverter.cs
	namespace 	
View
 
. 

Converters 
{ 
public 

sealed 
class 6
*MissionObjectiveCardIdToImagePathConverter B
:C D
IValueConverterE T
{		 
public

 
object

 
Convert

 
(

 
object

 $
value

% *
,

* +
Type

, 0

targetType

1 ;
,

; <
object

= C
	parameter

D M
,

M N
CultureInfo

O Z
culture

[ b
)

b c
{ 	
return #
CardArtworkPathResolver *
.* +
ResolveCardPath+ :
(: ;
value; @
,@ A
trueB F
)F G
;G H
} 	
public 
object 
ConvertBack !
(! "
object" (
value) .
,. /
Type0 4

targetType5 ?
,? @
objectA G
	parameterH Q
,Q R
CultureInfoS ^
culture_ f
)f g
{ 	
return 
Binding 
. 
	DoNothing $
;$ %
} 	
} 
} ™
ÄC:\Users\oscar\source\repos\TrickTakingMissions\Client\ClientTrickTakingMissions\Converters\MatchFeedbackKeyToStringConverter.cs
	namespace 	
View
 
. 

Converters 
{ 
public 

sealed 
class -
!MatchFeedbackKeyToStringConverter 9
:: ;
IValueConverter< K
{		 
public

 
object

 
Convert

 
(

 
object

 $
value

% *
,

* +
Type

, 0

targetType

1 ;
,

; <
object

= C
	parameter

D M
,

M N
CultureInfo

O Z
culture

[ b
)

b c
{ 	
string 
resourceKey 
=  
value! &
as' )
string* 0
??1 3
$str4 F
;F G
return 

Properties 
. 
Langs #
.# $
	Resources$ -
.- .
ResourceManager. =
.= >
	GetString> G
(G H
resourceKeyH S
,S T

Properties 
. 
Langs  
.  !
	Resources! *
.* +
Culture+ 2
)2 3
??4 6
string7 =
.= >
Empty> C
;C D
} 	
public 
object 
ConvertBack !
(! "
object" (
value) .
,. /
Type0 4

targetType5 ?
,? @
objectA G
	parameterH Q
,Q R
CultureInfoS ^
culture_ f
)f g
{ 	
return 
Binding 
. 
	DoNothing $
;$ %
} 	
} 
} Ÿ

yC:\Users\oscar\source\repos\TrickTakingMissions\Client\ClientTrickTakingMissions\Converters\CardIdToImagePathConverter.cs
	namespace 	
View
 
. 

Converters 
{ 
public 

sealed 
class &
CardIdToImagePathConverter 2
:3 4
IValueConverter5 D
{		 
public

 
object

 
Convert

 
(

 
object

 $
value

% *
,

* +
Type

, 0

targetType

1 ;
,

; <
object

= C
	parameter

D M
,

M N
CultureInfo

O Z
culture

[ b
)

b c
{ 	
return #
CardArtworkPathResolver *
.* +
ResolveCardPath+ :
(: ;
value; @
,@ A
falseB G
)G H
;H I
} 	
public 
object 
ConvertBack !
(! "
object" (
value) .
,. /
Type0 4

targetType5 ?
,? @
objectA G
	parameterH Q
,Q R
CultureInfoS ^
culture_ f
)f g
{ 	
return 
Binding 
. 
	DoNothing $
;$ %
} 	
} 
} ¶6
rC:\Users\oscar\source\repos\TrickTakingMissions\Client\ClientTrickTakingMissions\Services\WpfProfileImagePicker.cs
	namespace 	
View
 
. 
Services 
{ 
public 

sealed 
class !
WpfProfileImagePicker -
:. /
IProfileImagePicker0 C
{ 
public 
async 
Task 
< !
ProfileImageSelection /
>/ 0!
PickProfileImageAsync1 F
(F G
)G H
{ 	
var 
picker 
= 
new 
OpenFileDialog +
{ 
Title 
= 

Properties "
." #
Langs# (
.( )
	Resources) 2
.2 3
Profile_SelectImage3 F
,F G
Filter 
= 

Properties #
.# $
Langs$ )
.) *
	Resources* 3
.3 4#
Profile_ImageFileFilter4 K
,K L
InitialDirectory  
=! "
Environment# .
.. /
GetFolderPath/ <
(< =
Environment= H
.H I
SpecialFolderI V
.V W

MyPicturesW a
)a b
,b c
RestoreDirectory  
=! "
true# '
,' (
CheckFileExists 
=  !
true" &
,& '
Multiselect 
= 
false #
} 
; 
var !
profileImageSelection %
=& '
new( +!
ProfileImageSelection, A
(A B
)B C
;C D
if 
( 
picker 
. 

ShowDialog !
(! "
System" (
.( )
Windows) 0
.0 1
Application1 <
.< =
Current= D
.D E

MainWindowE O
)O P
==Q S
trueT X
)X Y
{   !
profileImageSelection!! %
=!!& '
await!!( -
Task!!. 2
.!!2 3
Run!!3 6
(!!6 7
(!!7 8
)!!8 9
=>!!: <
ReadSelectedImage!!= N
(!!N O
picker!!O U
.!!U V
FileName!!V ^
)!!^ _
)!!_ `
;!!` a
}"" 
return## !
profileImageSelection## (
;##( )
}$$ 	
private&& 
static&& !
ProfileImageSelection&& ,
ReadSelectedImage&&- >
(&&> ?
string&&? E
selectedImagePath&&F W
)&&W X
{'' 	
var(( !
profileImageSelection(( %
=((& '
new((( +!
ProfileImageSelection((, A
(((A B
)((B C
;((C D
try)) 
{** 
using++ 
(++ 
var++ 
imageStream++ &
=++' (
new++) ,

FileStream++- 7
(++7 8
selectedImagePath++8 I
,++I J
FileMode++K S
.++S T
Open++T X
,++X Y

FileAccess,, 
.,, 
Read,, #
,,,# $
	FileShare,,% .
.,,. /
Read,,/ 3
),,3 4
),,4 5
using-- 
(-- 
var-- 
reader-- !
=--" #
new--$ '
BinaryReader--( 4
(--4 5
imageStream--5 @
)--@ A
)--A B
{..  
ProfileImageFeedback// (
selectionFeedback//) :
=//; < 
GetSelectionFeedback//= Q
(//Q R
imageStream//R ]
.//] ^
Length//^ d
)//d e
;//e f
if00 
(00 
selectionFeedback00 )
==00* , 
ProfileImageFeedback00- A
.00A B
None00B F
)00F G
{11 
byte22 
[22 
]22 %
selectedProfileImageBytes22 8
=229 :
reader22; A
.22A B
	ReadBytes22B K
(22K L
ProfileImageLimits22L ^
.22^ _
MaximumUploadBytes22_ q
+22r s
$num22t u
)22u v
;22v w
selectionFeedback33 )
=33* + 
GetSelectionFeedback33, @
(33@ A%
selectedProfileImageBytes33A Z
.33Z [
Length33[ a
)33a b
;33b c
if44 
(44 
selectionFeedback44 -
==44. 0 
ProfileImageFeedback441 E
.44E F
None44F J
)44J K
{55 !
profileImageSelection66 1
.661 2%
SelectedProfileImageBytes662 K
=66L M%
selectedProfileImageBytes66N g
;66g h
}77 
}88 !
profileImageSelection99 )
.99) *
SelectionFeedback99* ;
=99< =
selectionFeedback99> O
;99O P
}:: 
};; 
catch<< 
(<< 
IOException<< 
ex<< !
)<<! "
{== 
throw>> 
new>> *
ProfileImageOperationException>> 8
(>>8 9$
ProfileImageFailureCodes>>9 Q
.>>Q R 
ImageFileUnavailable>>R f
,>>f g
ex>>h j
)>>j k
;>>k l
}?? 
catch@@ 
(@@ '
UnauthorizedAccessException@@ .
ex@@/ 1
)@@1 2
{AA 
throwBB 
newBB *
ProfileImageOperationExceptionBB 8
(BB8 9$
ProfileImageFailureCodesBB9 Q
.BBQ R 
ImageFileUnavailableBBR f
,BBf g
exBBh j
)BBj k
;BBk l
}CC 
returnDD !
profileImageSelectionDD (
;DD( )
}EE 	
privateGG 
staticGG  
ProfileImageFeedbackGG + 
GetSelectionFeedbackGG, @
(GG@ A
longGGA E
selectedImageLengthGGF Y
)GGY Z
{HH 	 
ProfileImageFeedbackII  
selectionFeedbackII! 2
=II3 4 
ProfileImageFeedbackII5 I
.III J
NoneIIJ N
;IIN O
ifJJ 
(JJ 
selectedImageLengthJJ #
==JJ$ &
$numJJ' (
)JJ( )
{KK 
selectionFeedbackLL !
=LL" # 
ProfileImageFeedbackLL$ 8
.LL8 9
InvalidImageFormatLL9 K
;LLK L
}MM 
elseNN 
ifNN 
(NN 
selectedImageLengthNN (
>NN) *
ProfileImageLimitsNN+ =
.NN= >
MaximumUploadBytesNN> P
)NNP Q
{OO 
selectionFeedbackPP !
=PP" # 
ProfileImageFeedbackPP$ 8
.PP8 9
ImageSizeExceededPP9 J
;PPJ K
}QQ 
returnRR 
selectionFeedbackRR $
;RR$ %
}SS 	
}TT 
}UU Ä
ÑC:\Users\oscar\source\repos\TrickTakingMissions\Client\ClientTrickTakingMissions\Converters\ProfileImageFeedbackToStringConverter.cs
	namespace 	
View
 
. 

Converters 
{ 
public 

sealed 
class 1
%ProfileImageFeedbackToStringConverter =
:> ?
IValueConverter@ O
{ 
public 
object 
Convert 
( 
object $
value% *
,* +
Type, 0

targetType1 ;
,; <
object= C
	parameterD M
,M N
CultureInfoO Z
culture[ b
)b c
{ 	
string 
feedback 
= 
string $
.$ %
Empty% *
;* +
if 
( 
value 
is  
ProfileImageFeedback - 
profileImageFeedback. B
&&C E 
profileImageFeedbackF Z
!=[ ] 
ProfileImageFeedback^ r
.r s
Nones w
)w x
{ 
string 
resourceKey "
=# $
$str% 5
+6 7 
profileImageFeedback8 L
;L M
feedback 
= 

Properties %
.% &
Langs& +
.+ ,
	Resources, 5
.5 6
ResourceManager6 E
.E F
	GetStringF O
(O P
resourceKeyP [
,[ \

Properties 
. 
Langs $
.$ %
	Resources% .
.. /
Culture/ 6
)6 7
??8 :

Properties; E
.E F
LangsF K
.K L
	ResourcesL U
.U V)
Profile_Image_OperationFailedV s
;s t
} 
return 
feedback 
; 
} 	
public 
object 
ConvertBack !
(! "
object" (
value) .
,. /
Type0 4

targetType5 ?
,? @
objectA G
	parameterH Q
,Q R
CultureInfoS ^
culture_ f
)f g
{ 	
return 
Binding 
. 
	DoNothing $
;$ %
} 	
} 
} Ö#
~C:\Users\oscar\source\repos\TrickTakingMissions\Client\ClientTrickTakingMissions\Converters\ByteArrayToImageSourceConverter.cs
	namespace		 	
View		
 
.		 

Converters		 
{

 
public 

sealed 
class +
ByteArrayToImageSourceConverter 7
:8 9
IValueConverter: I
{ 
private 
static 
readonly  
ConditionalWeakTable  4
<4 5
byte5 9
[9 :
]: ;
,; <
BitmapImage= H
>H I!
_decodedProfileImagesJ _
=` a
new  
ConditionalWeakTable $
<$ %
byte% )
[) *
]* +
,+ ,
BitmapImage- 8
>8 9
(9 :
): ;
;; <
public 
object 
Convert 
( 
object $
value% *
,* +
Type, 0

targetType1 ;
,; <
object= C
	parameterD M
,M N
CultureInfoO Z
culture[ b
)b c
{ 	
BitmapImage 
image 
= 
null  $
;$ %
if 
( 
value 
is 
byte 
[ 
] 

imageBytes  *
&&+ -

imageBytes. 8
.8 9
Length9 ?
>@ A
$numB C
&&D F

imageBytes 
. 
Length !
<=" $
ProfileImageLimits% 7
.7 8#
MaximumStoredImageBytes8 O
)O P
{ 
try 
{ 
image 
= !
_decodedProfileImages 1
.1 2
GetValue2 :
(: ;

imageBytes; E
,E F
DecodeImageG R
)R S
;S T
} 
catch 
( !
NotSupportedException ,
), -
{ 
image 
= 
null  
;  !
}   
catch!! 
(!! 
IOException!! "
)!!" #
{"" 
image## 
=## 
null##  
;##  !
}$$ 
catch%% 
(%% 
ArgumentException%% (
)%%( )
{&& 
image'' 
='' 
null''  
;''  !
}(( 
})) 
return** 
image** 
;** 
}++ 	
private-- 
static-- 
BitmapImage-- "
DecodeImage--# .
(--. /
byte--/ 3
[--3 4
]--4 5

imageBytes--6 @
)--@ A
{.. 	
var// 
image// 
=// 
new// 
BitmapImage// '
(//' (
)//( )
;//) *
using00 
(00 
var00 
imageStream00 "
=00# $
new00% (
MemoryStream00) 5
(005 6

imageBytes006 @
,00@ A
false00B G
)00G H
)00H I
{11 
image22 
.22 
	BeginInit22 
(22  
)22  !
;22! "
image33 
.33 
CacheOption33 !
=33" #
BitmapCacheOption33$ 5
.335 6
OnLoad336 <
;33< =
image44 
.44 
DecodePixelWidth44 &
=44' (
ProfileImageLimits44) ;
.44; <
OutputPixelSize44< K
;44K L
image55 
.55 
StreamSource55 "
=55# $
imageStream55% 0
;550 1
image66 
.66 
EndInit66 
(66 
)66 
;66  
image77 
.77 
Freeze77 
(77 
)77 
;77 
}88 
return99 
image99 
;99 
}:: 	
public<< 
object<< 
ConvertBack<< !
(<<! "
object<<" (
value<<) .
,<<. /
Type<<0 4

targetType<<5 ?
,<<? @
object<<A G
	parameter<<H Q
,<<Q R
CultureInfo<<S ^
culture<<_ f
)<<f g
{== 	
return>> 
Binding>> 
.>> 
	DoNothing>> $
;>>$ %
}?? 	
}@@ 
}AA ≤
kC:\Users\oscar\source\repos\TrickTakingMissions\Client\ClientTrickTakingMissions\Properties\AssemblyInfo.cs
[

 
assembly

 	
:

	 

AssemblyTitle

 
(

 
$str

 
)

  
]

  !
[ 
assembly 	
:	 

AssemblyDescription 
( 
$str !
)! "
]" #
[ 
assembly 	
:	 
!
AssemblyConfiguration  
(  !
$str! #
)# $
]$ %
[ 
assembly 	
:	 

AssemblyCompany 
( 
$str 
) 
] 
[ 
assembly 	
:	 

AssemblyProduct 
( 
$str !
)! "
]" #
[ 
assembly 	
:	 

AssemblyCopyright 
( 
$str 0
)0 1
]1 2
[ 
assembly 	
:	 

AssemblyTrademark 
( 
$str 
)  
]  !
[ 
assembly 	
:	 

AssemblyCulture 
( 
$str 
) 
] 
[ 
assembly 	
:	 


ComVisible 
( 
false 
) 
] 
["" 
assembly"" 	
:""	 

	ThemeInfo"" 
("" &
ResourceDictionaryLocation## 
.## 
None## #
,### $&
ResourceDictionaryLocation&& 
.&& 
SourceAssembly&& -
))) 
])) 
[33 
assembly33 	
:33	 

AssemblyVersion33 
(33 
$str33 $
)33$ %
]33% &
[44 
assembly44 	
:44	 

AssemblyFileVersion44 
(44 
$str44 (
)44( )
]44) *≈&
iC:\Users\oscar\source\repos\TrickTakingMissions\Client\ClientTrickTakingMissions\Views\MainWindow.xaml.cs
	namespace

 	
View


 
.

 
Views

 
{ 
public 

partial 
class 

MainWindow #
:$ %
Window& ,
{ 
private 
const 
int '
GracefulDisconnectTimeoutMs 5
=6 7
$num8 ;
;; <
private 
const 
string $
LogHomeNavigationFailure 5
=6 7
$str8 h
;h i
private 
const 
string -
!LogLeaveLobbyCommunicationFailure >
=? @
$str f
;f g
private 
const 
string  
LogLeaveLobbyTimeout 1
=2 3
$str \
;\ ]
private 
readonly 
ILoggerService '
_logger( /
;/ 0
public 

MainWindow 
( 
) 
{ 	
InitializeComponent 
(  
)  !
;! "
_logger   
=    
ClientLoggingRuntime   *
.  * +
CreateLogger  + 7
<  7 8

MainWindow  8 B
>  B C
(  C D
)  D E
;  E F
Closing!! 
+=!! 
OnMainWindowClosing!! *
;!!* +
try## 
{$$ 

HomeScreen%% 
homePage%% #
=%%$ %
new%%& )

HomeScreen%%* 4
(%%4 5
)%%5 6
;%%6 7
	MainFrame&& 
.&& 
Navigate&& "
(&&" #
homePage&&# +
)&&+ ,
;&&, -
}'' 
catch(( 
((( %
InvalidOperationException(( ,
ex((- /
)((/ 0
{)) 
_logger** 
.** 
Error** 
(** 
ex**  
,**  !$
LogHomeNavigationFailure**" :
)**: ;
;**; <
}++ 
},, 	
private.. 
void.. 
OnMainWindowClosing.. (
(..( )
object..) /
sender..0 6
,..6 7
CancelEventArgs..8 G
e..H I
)..I J
{// 	
if00 
(00 
LobbySession00 
.00 
Current00 $
.00$ %
HasActiveLobby00% 3
)003 4
{11 
string22 
	lobbyCode22  
=22! "
LobbySession22# /
.22/ 0
Current220 7
.227 8
CurrentLobby228 D
?22D E
.22E F
	LobbyCode22F O
;22O P
int33 
userId33 
=33 
UserSession33 (
.33( )
Current33) 0
.330 1
EnsureActiveUserId331 C
(33C D
)33D E
;33E F
if55 
(55 
!55 
string55 
.55 
IsNullOrWhiteSpace55 .
(55. /
	lobbyCode55/ 8
)558 9
)559 :
{66 
Task77 
.77 
Run77 
(77 
async77 "
(77# $
)77$ %
=>77& (
{88 
try99 
{:: 
await;; !
LobbySession;;" .
.;;. /
Current;;/ 6
.;;6 7
Client;;7 =
.;;= >
LeaveLobbyAsync;;> M
(;;M N
	lobbyCode;;N W
,;;W X
userId;;Y _
);;_ `
;;;` a
}<< 
catch== 
(== "
CommunicationException== 5
ex==6 8
)==8 9
{>> 
_logger?? #
.??# $
Warning??$ +
(??+ ,-
!LogLeaveLobbyCommunicationFailure??, M
,??M N
	lobbyCode??O X
,??X Y
ex??Z \
.??\ ]
GetType??] d
(??d e
)??e f
.??f g
Name??g k
)??k l
;??l m
}@@ 
catchAA 
(AA 
TimeoutExceptionAA /
exAA0 2
)AA2 3
{BB 
_loggerCC #
.CC# $
WarningCC$ +
(CC+ , 
LogLeaveLobbyTimeoutCC, @
,CC@ A
	lobbyCodeCCB K
,CCK L
exCCM O
.CCO P
GetTypeCCP W
(CCW X
)CCX Y
.CCY Z
NameCCZ ^
)CC^ _
;CC_ `
}DD 
}EE 
)EE 
.EE 
WaitEE 
(EE 
TimeSpanEE $
.EE$ %
FromMillisecondsEE% 5
(EE5 6'
GracefulDisconnectTimeoutMsEE6 Q
)EEQ R
)EER S
;EES T
}FF 
LobbySessionHH 
.HH 
CurrentHH $
.HH$ %

ClearLobbyHH% /
(HH/ 0
)HH0 1
;HH1 2
}II 
}JJ 	
}KK 
}LL ‚

nC:\Users\oscar\source\repos\TrickTakingMissions\Client\ClientTrickTakingMissions\Views\Menu\HomeScreen.xaml.cs
	namespace 	
View
 
. 
Views 
{ 
public

 

partial

 
class

 

HomeScreen

 #
:

$ %
Page

& *
{ 
private 
readonly 
HomeScreenViewModel ,

_viewModel- 7
;7 8
public 

HomeScreen 
( 
) 
: 
this 
( 
new 
HomeScreenViewModel *
(* +
new  
WpfNavigationService (
(( )
)) *
,* + 
ClientLoggingRuntime $
.$ %
CreateLogger% 1
<1 2
HomeScreenViewModel2 E
>E F
(F G
)G H
)H I
)I J
{ 	
} 	
public 

HomeScreen 
( 
HomeScreenViewModel -
	viewModel. 7
)7 8
{ 	
InitializeComponent 
(  
)  !
;! "

_viewModel   
=   
	viewModel   "
;  " #
DataContext!! 
=!! 

_viewModel!! $
;!!$ %
}"" 	
}## 
}$$ £Q
\C:\Users\oscar\source\repos\TrickTakingMissions\Client\ClientTrickTakingMissions\App.xaml.cs
	namespace 	
View
 
{ 
public 

partial 
class 
App 
: 
Application *
{ 
private 
const 
string !
ApplicationFolderName 2
=3 4
$str5 J
;J K
private 
const 
string 
LogsFolderName +
=, -
$str. 4
;4 5
private 
const 
string 
ClientLogFileName .
=/ 0
$str1 P
;P Q
private 
const 
string *
ProfileImageEndpointSettingKey ;
=< =
$str> [
;[ \
private 
const 
string .
"DefaultProfileImageEndpointAddress ?
=@ A
$strB p
;p q
private 
const 
string !
ClientStartedTemplate 2
=3 4
$str5 b
;b c
private 
const 
string !
ClientExitingTemplate 2
=3 4
$str N
;N O
private 
const 
string '
DispatcherUnhandledTemplate 8
=9 :
$str; h
;h i
private 
const 
string &
AppDomainUnhandledTemplate 7
=8 9
$str   U
;  U V
private!! 
const!! 
string!! "
UnobservedTaskTemplate!! 3
=!!4 5
$str!!6 f
;!!f g
private## 
ILoggerService## 
_applicationLogger## 1
;##1 2
public%% 
IProfileImageCache%% !
ProfileImages%%" /
{%%0 1
get%%2 5
;%%5 6
private%%7 >
set%%? B
;%%B C
}%%D E
	protected'' 
override'' 
void'' 
OnExit''  &
(''& '
ExitEventArgs''' 4
e''5 6
)''6 7
{(( 	
ProfileImages)) 
?)) 
.)) 
Dispose)) "
())" #
)))# $
;))$ %
if++ 
(++ 
_applicationLogger++ "
!=++# %
null++& *
)++* +
{,, 
_applicationLogger-- "
.--" #
Information--# .
(--. /!
ClientExitingTemplate--/ D
,--D E
e--F G
.--G H
ApplicationExitCode--H [
)--[ \
;--\ ]
}.. 
base00 
.00 
OnExit00 
(00 
e00 
)00 
;00 
}11 	
public77 
static77 
void77 
ApplyCulture77 '
(77' (
string77( .
languageCode77/ ;
)77; <
{88 	
if99 
(99 
!99 
string99 
.99 
IsNullOrEmpty99 %
(99% &
languageCode99& 2
)992 3
)993 4
{:: 
var;; 
culture;; 
=;; 
new;; !
CultureInfo;;" -
(;;- .
languageCode;;. :
);;: ;
;;;; <
Thread<< 
.<< 
CurrentThread<< $
.<<$ %
CurrentCulture<<% 3
=<<4 5
culture<<6 =
;<<= >
Thread== 
.== 
CurrentThread== $
.==$ %
CurrentUICulture==% 5
===6 7
culture==8 ?
;==? @
CultureInfo>> 
.>> '
DefaultThreadCurrentCulture>> 7
=>>8 9
culture>>: A
;>>A B
CultureInfo?? 
.?? )
DefaultThreadCurrentUICulture?? 9
=??: ;
culture??< C
;??C D
View@@ 
.@@ 

Properties@@ 
.@@  
Langs@@  %
.@@% &
	Resources@@& /
.@@/ 0
Culture@@0 7
=@@8 9
culture@@: A
;@@A B
}AA 
}BB 	
	protectedHH 
overrideHH 
voidHH 
	OnStartupHH  )
(HH) *
StartupEventArgsHH* :
eHH; <
)HH< =
{II 	
ILoggerFactoryJJ 
loggerFactoryJJ (
=JJ) *"
ConfigureClientLoggingJJ+ A
(JJA B
)JJB C
;JJC D'
InitializeProfileImageCacheKK '
(KK' (
loggerFactoryKK( 5
)KK5 6
;KK6 7
varMM 
languageCodeMM 
=MM 
ViewMM #
.MM# $

PropertiesMM$ .
.MM. /
SettingsMM/ 7
.MM7 8
DefaultMM8 ?
.MM? @
LanguageCodeMM@ L
;MML M
ApplyCultureNN 
(NN 
languageCodeNN %
)NN% &
;NN& '
_applicationLoggerPP 
.PP 
InformationPP *
(PP* +!
ClientStartedTemplatePP+ @
)PP@ A
;PPA B
baseQQ 
.QQ 
	OnStartupQQ 
(QQ 
eQQ 
)QQ 
;QQ 
}RR 	
privateTT 
ILoggerFactoryTT "
ConfigureClientLoggingTT 5
(TT5 6
)TT6 7
{UU 	
stringVV 
localAppDataPathVV #
=VV$ %
EnvironmentVV& 1
.VV1 2
GetFolderPathVV2 ?
(VV? @
EnvironmentVV@ K
.VVK L
SpecialFolderVVL Y
.VVY Z 
LocalApplicationDataVVZ n
)VVn o
;VVo p
stringWW 
logsDirectoryWW  
=WW! "
PathWW# '
.WW' (
CombineWW( /
(WW/ 0
localAppDataPathWW0 @
,WW@ A!
ApplicationFolderNameWWB W
,WWW X
LogsFolderNameWWY g
)WWg h
;WWh i
Log4NetConfiguratorYY 
.YY  
	ConfigureYY  )
(YY) *
logsDirectoryYY* 7
,YY7 8
ClientLogFileNameYY9 J
)YYJ K
;YYK L
ILoggerFactory[[ 
loggerFactory[[ (
=[[) *
new[[+ .
LoggerFactory[[/ <
([[< =
)[[= >
;[[> ? 
ClientLoggingRuntime\\  
.\\  !

Initialize\\! +
(\\+ ,
loggerFactory\\, 9
)\\9 :
;\\: ;
LobbySession]] 
.]] 
Current]]  
.]]  !
ConfigureLogging]]! 1
(]]1 2
loggerFactory]]2 ?
)]]? @
;]]@ A
FriendshipSession^^ 
.^^ 
Current^^ %
.^^% &
ConfigureLogging^^& 6
(^^6 7
loggerFactory^^7 D
)^^D E
;^^E F
_applicationLogger`` 
=``  
loggerFactory``! .
.``. /
CreateLogger``/ ;
<``; <
App``< ?
>``? @
(``@ A
)``A B
;``B C(
DispatcherUnhandledExceptionbb (
+=bb) +*
OnDispatcherUnhandledExceptionbb, J
;bbJ K
	AppDomaincc 
.cc 
CurrentDomaincc #
.cc# $
UnhandledExceptioncc$ 6
+=cc7 9-
!OnCurrentDomainUnhandledExceptioncc: [
;cc[ \
TaskSchedulerdd 
.dd #
UnobservedTaskExceptiondd 1
+=dd2 4%
OnUnobservedTaskExceptiondd5 N
;ddN O
returnff 
loggerFactoryff  
;ff  !
}gg 	
privateii 
voidii '
InitializeProfileImageCacheii 0
(ii0 1
ILoggerFactoryii1 ?
loggerFactoryii@ M
)iiM N
{jj 	
stringkk 
endpointAddresskk "
=kk# $ 
ConfigurationManagerkk% 9
.kk9 :
AppSettingskk: E
[kkE F*
ProfileImageEndpointSettingKeykkF d
]kkd e
??kkf h.
"DefaultProfileImageEndpointAddressll 2
;ll2 3
ProfileImageClientmm 
profileImageClientmm 1
=mm2 3
newmm4 7
ProfileImageClientmm8 J
(mmJ K
endpointAddressnn 
,nn  
loggerFactoryoo 
.oo 
CreateLoggeroo *
<oo* +
ProfileImageClientoo+ =
>oo= >
(oo> ?
)oo? @
)oo@ A
;ooA B
ProfileImagespp 
=pp 
newpp 
ProfileImageCachepp  1
(pp1 2
profileImageClientpp2 D
)ppD E
;ppE F
}qq 	
privatess 
voidss *
OnDispatcherUnhandledExceptionss 3
(ss3 4
objectss4 :
senderss; A
,ssA B1
%DispatcherUnhandledExceptionEventArgsssC h
essi j
)ssj k
{tt 	
_applicationLoggeruu 
.uu 
Fataluu $
(uu$ %
euu% &
.uu& '
	Exceptionuu' 0
,uu0 1'
DispatcherUnhandledTemplateuu2 M
)uuM N
;uuN O
}vv 	
privatexx 
voidxx -
!OnCurrentDomainUnhandledExceptionxx 6
(xx6 7
objectxx7 =
senderxx> D
,xxD E'
UnhandledExceptionEventArgsxxF a
exxb c
)xxc d
{yy 	
	Exceptionzz 
unhandledExceptionzz (
=zz) *
ezz+ ,
.zz, -
ExceptionObjectzz- <
aszz= ?
	Exceptionzz@ I
;zzI J
_applicationLogger{{ 
.{{ 
Fatal{{ $
({{$ %
unhandledException{{% 7
,{{7 8&
AppDomainUnhandledTemplate{{9 S
,{{S T
e{{U V
.{{V W
IsTerminating{{W d
){{d e
;{{e f
}|| 	
private~~ 
void~~ %
OnUnobservedTaskException~~ .
(~~. /
object~~/ 5
sender~~6 <
,~~< =,
 UnobservedTaskExceptionEventArgs~~> ^
e~~_ `
)~~` a
{ 	 
_applicationLogger
ÄÄ 
.
ÄÄ 
Error
ÄÄ $
(
ÄÄ$ %
e
ÄÄ% &
.
ÄÄ& '
	Exception
ÄÄ' 0
,
ÄÄ0 1$
UnobservedTaskTemplate
ÄÄ2 H
)
ÄÄH I
;
ÄÄI J
e
ÅÅ 
.
ÅÅ 
SetObserved
ÅÅ 
(
ÅÅ 
)
ÅÅ 
;
ÅÅ 
}
ÇÇ 	
}
ÉÉ 
}ÑÑ Ù
nC:\Users\oscar\source\repos\TrickTakingMissions\Client\ClientTrickTakingMissions\Views\Match\GameMatch.xaml.cs
	namespace 	
View
 
. 
Views 
{ 
public 

partial 
class 
	GameMatch "
:# $
Page% )
{ 
public 
	GameMatch 
( 
) 
{ 	
InitializeComponent 
(  
)  !
;! "
INavigationService 
navigationService 0
=1 2
new3 6 
WpfNavigationService7 K
(K L
)L M
;M N
var 
	viewModel 
= 
new 
GameMatchViewModel  2
(2 3
navigationService !
,! "
LobbySession 
. 
Current $
,$ % 
ClientLoggingRuntime $
.$ %
CreateLogger% 1
<1 2
GameMatchViewModel2 D
>D E
(E F
)F G
)G H
;H I
DataContext 
= 
	viewModel #
;# $
Loaded 
+= 
OnGameMatchLoaded '
;' (
Unloaded 
+= 
OnGameMatchUnloaded +
;+ ,
} 	
private 
void 
OnGameMatchLoaded &
(& '
object' -
sender. 4
,4 5
System6 <
.< =
Windows= D
.D E
RoutedEventArgsE T
eU V
)V W
{ 	
var 
	viewModel 
= 
( 
GameMatchViewModel /
)/ 0
DataContext0 ;
;; <
	viewModel 
. "
ConfigureProfileImages ,
(, -
(- .
(. /
App/ 2
)2 3
System3 9
.9 :
Windows: A
.A B
ApplicationB M
.M N
CurrentN U
)U V
.V W
ProfileImagesW d
)d e
;e f
	viewModel 
. 
ConfigureMatch $
($ %
LobbySession% 1
.1 2
Current2 9
.9 :
Client: @
)@ A
;A B
}   	
private"" 
void"" 
OnGameMatchUnloaded"" (
(""( )
object"") /
sender""0 6
,""6 7
System""8 >
.""> ?
Windows""? F
.""F G
RoutedEventArgs""G V
e""W X
)""X Y
{## 	
($$ 
($$ 
GameMatchViewModel$$  
)$$  !
DataContext$$! ,
)$$, -
.$$- .
Dispose$$. 5
($$5 6
)$$6 7
;$$7 8
}%% 	
}&& 
}'' ¥Ñ
mC:\Users\oscar\source\repos\TrickTakingMissions\Client\ClientTrickTakingMissions\Services\WpfDialogService.cs
	namespace 	
View
 
. 
Services 
{		 
public 

sealed 
class 
WpfDialogService (
:) *
IDialogService+ 9
{ 
private 
const 
string (
LogMissingResourceKeyMapping 9
=: ;
$str K
;K L
private 
const 
string "
LogMissingResourceText 3
=4 5
$str h
;h i
private 
static 
readonly 

Dictionary  *
<* +
int+ .
,. /
string0 6
>6 7
s_resourceKeys8 F
=G H
newI L

DictionaryM W
<W X
intX [
,[ \
string] c
>c d
{ 	
{ 
MessageCode 
. /
#LobbyKickedParticipantReentryDenied =
,= >
$str? e
}f g
,g h
{ 
MessageCode 
. 
LobbyHostRequired +
,+ ,
$str- A
}B C
,C D
{ 
MessageCode 
. %
LobbyConfigurationInvalid 3
,3 4
$str5 Q
}R S
,S T
{ 
MessageCode 
.  
LobbyMatchInProgress .
,. /
$str0 G
}H I
,I J
{ 
MessageCode 
. +
RegisterEmailPermanentlyBlocked 9
,9 :
$str; ]
}^ _
,_ `
{ 
MessageCode 
. 

EmptyEmail $
,$ %
nameof& ,
(, -
View- 1
.1 2

Properties2 <
.< =
Langs= B
.B C
	ResourcesC L
.L M
Login_EmptyEmailM ]
)] ^
}_ `
,` a
{ 
MessageCode 
. 
EmptyPassword '
,' (
nameof) /
(/ 0
View0 4
.4 5

Properties5 ?
.? @
Langs@ E
.E F
	ResourcesF O
.O P
Login_EmptyPasswordP c
)c d
}e f
,f g
{ 
MessageCode 
. "
ChatStorageUnavailable 0
,0 1
$str2 N
}O P
,P Q
{ 
MessageCode 
. 
ChatAccountBanned +
,+ ,
$str- A
}B C
,C D
{ 
MessageCode 
. 
InvalidCredentials ,
,, -
nameof. 4
(4 5
View5 9
.9 :

Properties: D
.D E
LangsE J
.J K
	ResourcesK T
.T U$
Login_InvalidCredentialsU m
)m n
}o p
,p q
{   
MessageCode   
.    
RegisterInvalidEmail   .
,  . /
nameof  0 6
(  6 7
View  7 ;
.  ; <

Properties  < F
.  F G
Langs  G L
.  L M
	Resources  M V
.  V W!
Register_InvalidEmail  W l
)  l m
}  n o
,  o p
{!! 
MessageCode!! 
.!! 
RegisterEmptyEmail!! ,
,!!, -
nameof!!. 4
(!!4 5
View!!5 9
.!!9 :

Properties!!: D
.!!D E
Langs!!E J
.!!J K
	Resources!!K T
.!!T U
Register_EmptyEmail!!U h
)!!h i
}!!j k
,!!k l
{"" 
MessageCode"" 
."" !
RegisterEmptyUsername"" /
,""/ 0
nameof""1 7
(""7 8
View""8 <
.""< =

Properties""= G
.""G H
Langs""H M
.""M N
	Resources""N W
.""W X"
Register_EmptyUsername""X n
)""n o
}""p q
,""q r
{## 
MessageCode## 
.## !
RegisterEmptyPassword## /
,##/ 0
nameof##1 7
(##7 8
View##8 <
.##< =

Properties##= G
.##G H
Langs##H M
.##M N
	Resources##N W
.##W X"
Register_EmptyPassword##X n
)##n o
}##p q
,##q r
{$$ 
MessageCode%% 
.%% -
!RegisterEmptyPasswordConfirmation%% =
,%%= >
nameof&& 
(&& 
View&& 
.&& 

Properties&& &
.&&& '
Langs&&' ,
.&&, -
	Resources&&- 6
.&&6 7.
"Register_EmptyPasswordConfirmation&&7 Y
)&&Y Z
}'' 
,'' 
{(( 
MessageCode)) 
.)) $
RegisterPasswordMismatch)) 4
,))4 5
nameof** 
(** 
View** 
.** 

Properties** &
.**& '
Langs**' ,
.**, -
	Resources**- 6
.**6 7%
Register_PasswordMismatch**7 P
)**P Q
}++ 
,++ 
{,, 
MessageCode-- 
.-- &
RegisterPasswordRuleLength-- 6
,--6 7
nameof.. 
(.. 
View.. 
... 

Properties.. &
...& '
Langs..' ,
..., -
	Resources..- 6
...6 7'
Register_PasswordRuleLength..7 R
)..R S
}// 
,// 
{00 
MessageCode11 
.11 +
RegisterPasswordRuleSpecialChar11 ;
,11; <
nameof22 
(22 
View22 
.22 

Properties22 &
.22& '
Langs22' ,
.22, -
	Resources22- 6
.226 7,
 Register_PasswordRuleSpecialChar227 W
)22W X
}33 
,33 
{44 
MessageCode55 
.55 &
RegisterPasswordRuleNumber55 6
,556 7
nameof66 
(66 
View66 
.66 

Properties66 &
.66& '
Langs66' ,
.66, -
	Resources66- 6
.666 7'
Register_PasswordRuleNumber667 R
)66R S
}77 
,77 
{88 
MessageCode99 
.99 *
RegisterEmailAlreadyRegistered99 :
,99: ;
nameof:: 
(:: 
View:: 
.:: 

Properties:: &
.::& '
Langs::' ,
.::, -
	Resources::- 6
.::6 7+
Register_EmailAlreadyRegistered::7 V
)::V W
};; 
,;; 
{<< 
MessageCode== 
.== -
!RegisterUsernameAlreadyRegistered== =
,=== >
nameof>> 
(>> 
View>> 
.>> 

Properties>> &
.>>& '
Langs>>' ,
.>>, -
	Resources>>- 6
.>>6 7.
"Register_UsernameAlreadyRegistered>>7 Y
)>>Y Z
}?? 
,?? 
{@@ 
MessageCode@@ 
.@@ 
RegisterSuccess@@ )
,@@) *
nameof@@+ 1
(@@1 2
View@@2 6
.@@6 7

Properties@@7 A
.@@A B
Langs@@B G
.@@G H
	Resources@@H Q
.@@Q R
Register_Success@@R b
)@@b c
}@@d e
,@@e f
{AA 
MessageCodeAA 
.AA "
EnterGameCodeEmptyCodeAA 0
,AA0 1
nameofAA2 8
(AA8 9
ViewAA9 =
.AA= >

PropertiesAA> H
.AAH I
LangsAAI N
.AAN O
	ResourcesAAO X
.AAX Y#
EnterGameCode_EmptyCodeAAY p
)AAp q
}AAr s
,AAs t
{BB 
MessageCodeBB 
.BB $
EnterGameCodeInvalidCodeBB 2
,BB2 3
nameofBB4 :
(BB: ;
ViewBB; ?
.BB? @

PropertiesBB@ J
.BBJ K
LangsBBK P
.BBP Q
	ResourcesBBQ Z
.BBZ [%
EnterGameCode_InvalidCodeBB[ t
)BBt u
}BBv w
,BBw x
{CC 
MessageCodeDD 
.DD )
EnterGameCodeLobbyAlreadyFullDD 9
,DD9 :
nameofEE 
(EE 
ViewEE 
.EE 

PropertiesEE &
.EE& '
LangsEE' ,
.EE, -
	ResourcesEE- 6
.EE6 7*
EnterGameCode_LobbyAlreadyFullEE7 U
)EEU V
}FF 
,FF 
{GG 
MessageCodeGG 
.GG 
EmptyFriendUsernameGG -
,GG- .
nameofGG/ 5
(GG5 6
ViewGG6 :
.GG: ;

PropertiesGG; E
.GGE F
LangsGGF K
.GGK L
	ResourcesGGL U
.GGU V"
Register_EmptyUsernameGGV l
)GGl m
}GGn o
,GGo p
{HH 
MessageCodeHH 
.HH 
ConnectionFailedHH *
,HH* +
nameofHH, 2
(HH2 3
ViewHH3 7
.HH7 8

PropertiesHH8 B
.HHB C
LangsHHC H
.HHH I
	ResourcesHHI R
.HHR S)
Common_Error_ConnectionFailedHHS p
)HHp q
}HHr s
,HHs t
{II 
MessageCodeII 
.II 
RequestTimeoutII (
,II( )
nameofII* 0
(II0 1
ViewII1 5
.II5 6

PropertiesII6 @
.II@ A
LangsIIA F
.IIF G
	ResourcesIIG P
.IIP Q 
Common_Error_TimeoutIIQ e
)IIe f
}IIg h
,IIh i
{JJ 
MessageCodeJJ 
.JJ 
CommunicationErrorJJ ,
,JJ, -
nameofJJ. 4
(JJ4 5
ViewJJ5 9
.JJ9 :

PropertiesJJ: D
.JJD E
LangsJJE J
.JJJ K
	ResourcesJJK T
.JJT U&
Common_Error_CommunicationJJU o
)JJo p
}JJq r
,JJr s
{KK 
MessageCodeKK 
.KK 
UnexpectedErrorKK )
,KK) *
nameofKK+ 1
(KK1 2
ViewKK2 6
.KK6 7

PropertiesKK7 A
.KKA B
LangsKKB G
.KKG H
	ResourcesKKH Q
.KKQ R#
Common_Error_UnexpectedKKR i
)KKi j
}KKk l
}LL 	
;LL	 

privateNN 
readonlyNN 
ILoggerServiceNN '
_loggerNN( /
;NN/ 0
publicPP 
WpfDialogServicePP 
(PP  
)PP  !
:QQ 
thisQQ 
(QQ  
ClientLoggingRuntimeQQ '
.QQ' (
CreateLoggerQQ( 4
<QQ4 5
WpfDialogServiceQQ5 E
>QQE F
(QQF G
)QQG H
)QQH I
{RR 	
}SS 	
publicUU 
WpfDialogServiceUU 
(UU  
ILoggerServiceUU  .
loggerUU/ 5
)UU5 6
{VV 	
_loggerWW 
=WW 
loggerWW 
??WW 
throwWW  %
newWW& )!
ArgumentNullExceptionWW* ?
(WW? @
nameofWW@ F
(WWF G
loggerWWG M
)WWM N
)WWN O
;WWO P
}XX 	
public^^ 
void^^ 
ShowInformation^^ #
(^^# $
int^^$ '
messageCode^^( 3
)^^3 4
{__ 	
string`` 
message`` 
=`` 
ResolveMessage`` +
(``+ ,
messageCode``, 7
)``7 8
;``8 9
Applicationaa 
.aa 
Currentaa 
?aa  
.aa  !

Dispatcheraa! +
?aa+ ,
.aa, -
Invokeaa- 3
(aa3 4
(aa4 5
)aa5 6
=>aa7 9
{bb 

MessageBoxcc 
.cc 
Showcc 
(cc  
messagecc  '
,cc' (
Viewdd 
.dd 

Propertiesdd #
.dd# $
Langsdd$ )
.dd) *
	Resourcesdd* 3
.dd3 4
MainWindow_Titledd4 D
,ddD E
MessageBoxButtonee $
.ee$ %
OKee% '
,ee' (
MessageBoxImageee) 8
.ee8 9
Informationee9 D
)eeD E
;eeE F
}ff 
)ff 
;ff 
}gg 	
publicmm 
voidmm 
ShowWarningmm 
(mm  
intmm  #
messageCodemm$ /
)mm/ 0
{nn 	
stringoo 
messageoo 
=oo 
ResolveMessageoo +
(oo+ ,
messageCodeoo, 7
)oo7 8
;oo8 9
Applicationpp 
.pp 
Currentpp 
?pp  
.pp  !

Dispatcherpp! +
?pp+ ,
.pp, -
Invokepp- 3
(pp3 4
(pp4 5
)pp5 6
=>pp7 9
{qq 

MessageBoxrr 
.rr 
Showrr 
(rr  
messagerr  '
,rr' (
Viewss 
.ss 

Propertiesss #
.ss# $
Langsss$ )
.ss) *
	Resourcesss* 3
.ss3 4
MainWindow_Titless4 D
,ssD E
MessageBoxButtontt $
.tt$ %
OKtt% '
,tt' (
MessageBoxImagett) 8
.tt8 9
Warningtt9 @
)tt@ A
;ttA B
}uu 
)uu 
;uu 
}vv 	
public|| 
void|| 
	ShowError|| 
(|| 
int|| !
messageCode||" -
)||- .
{}} 	
string~~ 
message~~ 
=~~ 
ResolveMessage~~ +
(~~+ ,
messageCode~~, 7
)~~7 8
;~~8 9
Application 
. 
Current 
?  
.  !

Dispatcher! +
?+ ,
., -
Invoke- 3
(3 4
(4 5
)5 6
=>7 9
{
ÄÄ 

MessageBox
ÅÅ 
.
ÅÅ 
Show
ÅÅ 
(
ÅÅ  
message
ÅÅ  '
,
ÅÅ' (
View
ÇÇ 
.
ÇÇ 

Properties
ÇÇ #
.
ÇÇ# $
Langs
ÇÇ$ )
.
ÇÇ) *
	Resources
ÇÇ* 3
.
ÇÇ3 4
MainWindow_Title
ÇÇ4 D
,
ÇÇD E
MessageBoxButton
ÉÉ $
.
ÉÉ$ %
OK
ÉÉ% '
,
ÉÉ' (
MessageBoxImage
ÉÉ) 8
.
ÉÉ8 9
Error
ÉÉ9 >
)
ÉÉ> ?
;
ÉÉ? @
}
ÑÑ 
)
ÑÑ 
;
ÑÑ 
}
ÖÖ 	
private
áá 
string
áá 
ResolveMessage
áá %
(
áá% &
int
áá& )
messageCode
áá* 5
)
áá5 6
{
àà 	
string
ââ 
resolvedText
ââ 
;
ââ  
if
ãã 
(
ãã 
s_resourceKeys
ãã 
.
ãã 
TryGetValue
ãã *
(
ãã* +
messageCode
ãã+ 6
,
ãã6 7
out
ãã8 ;
var
ãã< ?
resourceKey
ãã@ K
)
ããK L
)
ããL M
{
åå 
string
çç 
text
çç 
=
çç 
View
çç "
.
çç" #

Properties
çç# -
.
çç- .
Langs
çç. 3
.
çç3 4
	Resources
çç4 =
.
çç= >
ResourceManager
çç> M
.
ççM N
	GetString
ççN W
(
ççW X
resourceKey
ççX c
)
ççc d
;
ççd e
if
éé 
(
éé 
!
éé 
string
éé 
.
éé 
IsNullOrEmpty
éé )
(
éé) *
text
éé* .
)
éé. /
)
éé/ 0
{
èè 
resolvedText
êê  
=
êê! "
text
êê# '
;
êê' (
}
ëë 
else
íí 
{
ìì 
_logger
îî 
.
îî 
Warning
îî #
(
îî# $$
LogMissingResourceText
îî$ :
,
îî: ;
resourceKey
îî< G
,
îîG H
messageCode
îîI T
)
îîT U
;
îîU V
resolvedText
ïï  
=
ïï! "
resourceKey
ïï# .
;
ïï. /
}
ññ 
}
óó 
else
òò 
{
ôô 
_logger
öö 
.
öö 
Warning
öö 
(
öö  *
LogMissingResourceKeyMapping
öö  <
,
öö< =
messageCode
öö> I
)
ööI J
;
ööJ K
resolvedText
õõ 
=
õõ 
View
õõ #
.
õõ# $

Properties
õõ$ .
.
õõ. /
Langs
õõ/ 4
.
õõ4 5
	Resources
õõ5 >
.
õõ> ?(
Common_Error_Communication
õõ? Y
;
õõY Z
}
úú 
return
ûû 
resolvedText
ûû 
;
ûû  
}
üü 	
}
†† 
}°° ã
oC:\Users\oscar\source\repos\TrickTakingMissions\Client\ClientTrickTakingMissions\Services\WpfLanguageService.cs
	namespace 	
View
 
. 
Services 
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
WpfLanguageService

 *
:

+ ,
ILanguageService

- =
{ 
private 
const 
string 
LogCultureChanged .
=/ 0
$str1 `
;` a
private 
readonly 
ILoggerService '
_logger( /
;/ 0
public 
WpfLanguageService !
(! "
)" #
: 
this 
(  
ClientLoggingRuntime '
.' (
CreateLogger( 4
<4 5
WpfLanguageService5 G
>G H
(H I
)I J
)J K
{ 	
} 	
public 
WpfLanguageService !
(! "
ILoggerService" 0
logger1 7
)7 8
{ 	
_logger 
= 
logger 
?? 
throw  %
new& )!
ArgumentNullException* ?
(? @
nameof@ F
(F G
loggerG M
)M N
)N O
;O P
} 	
public 
string 
CurrentCultureCode (
=>) +
View, 0
.0 1

Properties1 ;
.; <
Settings< D
.D E
DefaultE L
.L M
LanguageCodeM Y
;Y Z
public## 
void## 
ChangeLanguage## "
(##" #
string### )
cultureCode##* 5
)##5 6
{$$ 	
View%% 
.%% 

Properties%% 
.%% 
Settings%% $
.%%$ %
Default%%% ,
.%%, -
LanguageCode%%- 9
=%%: ;
cultureCode%%< G
;%%G H
View&& 
.&& 

Properties&& 
.&& 
Settings&& $
.&&$ %
Default&&% ,
.&&, -
Save&&- 1
(&&1 2
)&&2 3
;&&3 4
App(( 
.(( 
ApplyCulture(( 
((( 
cultureCode(( (
)((( )
;(() *
_logger)) 
.)) 
Information)) 
())  
LogCultureChanged))  1
,))1 2
cultureCode))3 >
)))> ?
;))? @
}** 	
}++ 
},, Ÿ
iC:\Users\oscar\source\repos\TrickTakingMissions\Client\ClientTrickTakingMissions\Styles\FontTypography.cs
	namespace 	
View
 
. 
Styles 
{ 
public		 

static		 
class		 
FontTypography		 &
{

 
public 
static 

FontFamily  
TitleFontFamily! 0
{1 2
get3 6
;6 7
}8 9
=: ;
new 

FontFamily 
( 
$str :
): ;
;; <
public 
static 

FontFamily  
BodyFontFamily! /
{0 1
get2 5
;5 6
}7 8
=9 :
new 

FontFamily 
( 
$str %
)% &
;& '
public 
static 

FontFamily  $
GameBrandTitleFontFamily! 9
{: ;
get< ?
;? @
}A B
=C D
new 

FontFamily 
( 
$str ?
)? @
;@ A
public 
static 

FontFamily  +
AuthenticationHeadingFontFamily! @
{A B
getC F
;F G
}H I
=J K
new 

FontFamily 
( 
$str 2
)2 3
;3 4
public 
const 
double 
HeroTitleFontSize -
=. /
$num0 4
;4 5
public 
const 
double  
DisplayTitleFontSize 0
=1 2
$num3 7
;7 8
public 
const 
double  
ProfileTitleFontSize 0
=1 2
$num3 7
;7 8
public 
const 
double )
AuthenticationHeadingFontSize 9
=: ;
$num< @
;@ A
public 
const 
double 
LargeTitleFontSize .
=/ 0
$num1 5
;5 6
public   
const   
double    
SectionTitleFontSize   0
=  1 2
$num  3 7
;  7 8
public!! 
const!! 
double!! 
MediumTitleFontSize!! /
=!!0 1
$num!!2 6
;!!6 7
public"" 
const"" 
double"" 
SubtitleFontSize"" ,
=""- .
$num""/ 3
;""3 4
public%% 
const%% 
double%% !
PrimaryActionFontSize%% 1
=%%2 3
$num%%4 8
;%%8 9
public&& 
const&& 
double&&  
ActionButtonFontSize&& 0
=&&1 2
$num&&3 7
;&&7 8
public'' 
const'' 
double'' #
SecondaryButtonFontSize'' 3
=''4 5
$num''6 :
;'': ;
public** 
const** 
double** 
FormLabelFontSize** -
=**. /
$num**0 4
;**4 5
public++ 
const++ 
double++ 
BodyFontSize++ (
=++) *
$num+++ /
;++/ 0
public,, 
const,, 
double,, 
CaptionFontSize,, +
=,,, -
$num,,. 2
;,,2 3
public-- 
const-- 
double-- 
SmallFontSize-- )
=--* +
$num--, 0
;--0 1
public.. 
const.. 
double.. 
MicroFontSize.. )
=..* +
$num.., 0
;..0 1
}// 
}00 ’c
qC:\Users\oscar\source\repos\TrickTakingMissions\Client\ClientTrickTakingMissions\Services\WpfNavigationService.cs
	namespace

 	
View


 
.

 
Services

 
{ 
public 

sealed 
class  
WpfNavigationService ,
:- .
INavigationService/ A
{ 
private 
const 
string !
LogUnrecognizedViewId 2
=3 4
$str5 m
;m n
private 
const 
string #
LogUnrecognizedDialogId 4
=5 6
$str P
;P Q
private 
static 
readonly 

Dictionary  *
<* +
int+ .
,. /
Func0 4
<4 5
Page5 9
>9 :
>: ;
s_pageFactories< K
=L M
newN Q

DictionaryR \
<\ ]
int] `
,` a
Funcb f
<f g
Pageg k
>k l
>l m
{ 	
{ 
ViewId 
. 

HomeScreen 
,  
(! "
)" #
=>$ &
new' *

HomeScreen+ 5
(5 6
)6 7
}8 9
,9 :
{ 
ViewId 
. 
	LoginPage 
, 
(  !
)! "
=># %
new& )
	LoginPage* 3
(3 4
)4 5
}6 7
,7 8
{ 
ViewId 
. 
RegisterPage !
,! "
(# $
)$ %
=>& (
new) ,
RegisterPage- 9
(9 :
): ;
}< =
,= >
{ 
ViewId 
. 
GameMenu 
, 
(  
)  !
=>" $
new% (
GameMenu) 1
(1 2
)2 3
}4 5
,5 6
{ 
ViewId 
. 
Lobby 
, 
( 
) 
=> !
new" %
Lobby& +
(+ ,
), -
}. /
,/ 0
{ 
ViewId 
. 
Profile 
, 
( 
)  
=>! #
new$ '
Profile( /
(/ 0
)0 1
}2 3
,3 4
{ 
ViewId 
. 
RecoverPassword $
,$ %
(& '
)' (
=>) +
new, /
RecoverPassword0 ?
(? @
)@ A
}B C
,C D
{ 
ViewId 
. 
SendFriendRequest &
,& '
(( )
)) *
=>+ -
new. 1!
SendFriendRequestPage2 G
(G H
)H I
}J K
,K L
{   
ViewId   
.   
	GameMatch   
,   
(    !
)  ! "
=>  # %
new  & )
	GameMatch  * 3
(  3 4
)  4 5
}  6 7
}!! 	
;!!	 

private## 
static## 
readonly## 

Dictionary##  *
<##* +
int##+ .
,##. /
Func##0 4
<##4 5
Window##5 ;
>##; <
>##< =
s_dialogFactories##> O
=##P Q
new##R U

Dictionary##V `
<##` a
int##a d
,##d e
Func##f j
<##j k
Window##k q
>##q r
>##r s
{$$ 	
{%% 
ViewId%% 
.%%  
ForgotPasswordDialog%% )
,%%) *
(%%+ ,
)%%, -
=>%%. 0
new%%1 4
ForgotPassword%%5 C
(%%C D
)%%D E
}%%F G
,%%G H
{&& 
ViewId&& 
.&&  
ChangePasswordDialog&& )
,&&) *
(&&+ ,
)&&, -
=>&&. 0
new&&1 4
ChangePassword&&5 C
(&&C D
)&&D E
}&&F G
,&&G H
{'' 
ViewId'' 
.'' 
EnterGameCodeDialog'' (
,''( )
(''* +
)''+ ,
=>''- /
new''0 3
EnterGameCode''4 A
(''A B
)''B C
}''D E
,''E F
{(( 
ViewId(( 
.(( 
GameSettingsDialog(( '
,((' (
((() *
)((* +
=>((, .
new((/ 2
GameSettings((3 ?
(((? @
)((@ A
}((B C
,((C D
{)) 
ViewId)) 
.)) 
HowToPlayDialog)) $
,))$ %
())& '
)))' (
=>))) +
new)), /
	HowToPlay))0 9
())9 :
))): ;
}))< =
,))= >
{** 
ViewId** 
.** %
ManageFriendRequestDialog** .
,**. /
(**0 1
)**1 2
=>**3 5
new**6 9%
ManageFriendRequestWindow**: S
(**S T
)**T U
}**V W
,**W X
{++ 
ViewId++ 
.++ 
ScoreBoardDialog++ %
,++% &
(++' (
)++( )
=>++* ,
new++- 0

ScoreBoard++1 ;
(++; <
)++< =
}++> ?
,++? @
{,, 
ViewId,, 
.,,  
SelectLanguageDialog,, )
,,,) *
(,,+ ,
),,, -
=>,,. 0
new,,1 4 
SelectLanguageWindow,,5 I
(,,I J
),,J K
},,L M
}-- 	
;--	 

private// 
readonly// 
ILoggerService// '
_logger//( /
;/// 0
public11  
WpfNavigationService11 #
(11# $
)11$ %
:22 
this22 
(22  
ClientLoggingRuntime22 '
.22' (
CreateLogger22( 4
<224 5 
WpfNavigationService225 I
>22I J
(22J K
)22K L
)22L M
{33 	
}44 	
public66  
WpfNavigationService66 #
(66# $
ILoggerService66$ 2
logger663 9
)669 :
{77 	
_logger88 
=88 
logger88 
??88 
throw88  %
new88& )!
ArgumentNullException88* ?
(88? @
nameof88@ F
(88F G
logger88G M
)88M N
)88N O
;88O P
}99 	
public?? 
void?? 

NavigateTo?? 
(?? 
int?? "
viewId??# )
)??) *
{@@ 	
ApplicationAA 
.AA 
CurrentAA 
?AA  
.AA  !

DispatcherAA! +
?AA+ ,
.AA, -
InvokeAA- 3
(AA3 4
(AA4 5
)AA5 6
=>AA7 9
{BB 
ifCC 
(CC 
s_pageFactoriesCC #
.CC# $
TryGetValueCC$ /
(CC/ 0
viewIdCC0 6
,CC6 7
outCC8 ;
varCC< ?
factoryCC@ G
)CCG H
)CCH I
{DD 

MainWindowEE 

mainWindowEE )
=EE* +
FindMainWindowEE, :
(EE: ;
)EE; <
;EE< =
ifFF 
(FF 

mainWindowFF "
!=FF# %
nullFF& *
)FF* +
{GG 

mainWindowHH "
.HH" #
	MainFrameHH# ,
.HH, -
NavigateHH- 5
(HH5 6
factoryHH6 =
(HH= >
)HH> ?
)HH? @
;HH@ A
}II 
}JJ 
elseKK 
{LL 
_loggerMM 
.MM 
WarningMM #
(MM# $!
LogUnrecognizedViewIdMM$ 9
,MM9 :
viewIdMM; A
)MMA B
;MMB C
}NN 
}OO 
)OO 
;OO 
}PP 	
publicVV 
voidVV 
GoBackVV 
(VV 
)VV 
{WW 	
ApplicationXX 
.XX 
CurrentXX 
?XX  
.XX  !

DispatcherXX! +
?XX+ ,
.XX, -
InvokeXX- 3
(XX3 4
(XX4 5
)XX5 6
=>XX7 9
{YY 

MainWindowZZ 

mainWindowZZ %
=ZZ& '
FindMainWindowZZ( 6
(ZZ6 7
)ZZ7 8
;ZZ8 9
if[[ 
([[ 

mainWindow[[ 
!=[[ !
null[[" &
)[[& '
{\\ 
if]] 
(]] 

mainWindow]] "
.]]" #
	MainFrame]]# ,
.]], -
	CanGoBack]]- 6
)]]6 7
{^^ 

mainWindow__ "
.__" #
	MainFrame__# ,
.__, -
GoBack__- 3
(__3 4
)__4 5
;__5 6
}`` 
elseaa 
{bb 

NavigateTocc "
(cc" #
ViewIdcc# )
.cc) *

HomeScreencc* 4
)cc4 5
;cc5 6
}dd 
}ee 
}ff 
)ff 
;ff 
}gg 	
publicmm 
voidmm 

ShowDialogmm 
(mm 
intmm "
dialogIdmm# +
)mm+ ,
{nn 	
Applicationoo 
.oo 
Currentoo 
?oo  
.oo  !

Dispatcheroo! +
?oo+ ,
.oo, -
Invokeoo- 3
(oo3 4
(oo4 5
)oo5 6
=>oo7 9
{pp 
ifqq 
(qq 
s_dialogFactoriesqq %
.qq% &
TryGetValueqq& 1
(qq1 2
dialogIdqq2 :
,qq: ;
outqq< ?
varqq@ C
factoryqqD K
)qqK L
)qqL M
{rr 
Windowss 
dialogss !
=ss" #
factoryss$ +
(ss+ ,
)ss, -
;ss- .
Windowtt 
ownertt  
=tt! "
ResolveDialogOwnertt# 5
(tt5 6
dialogtt6 <
)tt< =
;tt= >
ifuu 
(uu 
owneruu 
!=uu  
nulluu! %
)uu% &
{vv 
dialogww 
.ww 
Ownerww $
=ww% &
ownerww' ,
;ww, -
}xx 
dialogzz 
.zz 

ShowDialogzz %
(zz% &
)zz& '
;zz' (
}{{ 
else|| 
{}} 
_logger~~ 
.~~ 
Warning~~ #
(~~# $#
LogUnrecognizedDialogId~~$ ;
,~~; <
dialogId~~= E
)~~E F
;~~F G
} 
}
ÄÄ 
)
ÄÄ 
;
ÄÄ 
}
ÅÅ 	
private
ÉÉ 
static
ÉÉ 

MainWindow
ÉÉ !
FindMainWindow
ÉÉ" 0
(
ÉÉ0 1
)
ÉÉ1 2
{
ÑÑ 	

MainWindow
ÖÖ 
found
ÖÖ 
=
ÖÖ 
null
ÖÖ #
;
ÖÖ# $
foreach
áá 
(
áá 
Window
áá 
	candidate
áá %
in
áá& (
Application
áá) 4
.
áá4 5
Current
áá5 <
.
áá< =
Windows
áá= D
)
ááD E
{
àà 
if
ââ 
(
ââ 
	candidate
ââ 
is
ââ  

MainWindow
ââ! +
)
ââ+ ,
{
ää 
found
ãã 
=
ãã 
(
ãã 

MainWindow
ãã '
)
ãã' (
	candidate
ãã( 1
;
ãã1 2
}
åå 
}
çç 
return
èè 
found
èè 
;
èè 
}
êê 	
private
íí 
static
íí 
Window
íí  
ResolveDialogOwner
íí 0
(
íí0 1
Window
íí1 7
dialog
íí8 >
)
íí> ?
{
ìì 	
Window
îî 
owner
îî 
=
îî 
null
îî 
;
îî  
foreach
ññ 
(
ññ 
Window
ññ 
	candidate
ññ %
in
ññ& (
Application
ññ) 4
.
ññ4 5
Current
ññ5 <
.
ññ< =
Windows
ññ= D
)
ññD E
{
óó 
bool
òò 
isValidOwner
òò !
=
òò" #
	candidate
òò$ -
!=
òò. 0
dialog
òò1 7
&&
òò8 :
	candidate
òò; D
.
òòD E
	IsVisible
òòE N
&&
òòO Q
	candidate
òòR [
is
òò\ ^

MainWindow
òò_ i
;
òòi j
if
ôô 
(
ôô 
isValidOwner
ôô  
)
ôô  !
{
öö 
owner
õõ 
=
õõ 
	candidate
õõ %
;
õõ% &
}
úú 
}
ùù 
return
üü 
owner
üü 
;
üü 
}
†† 	
}
°° 
}¢¢ Ã
qC:\Users\oscar\source\repos\TrickTakingMissions\Client\ClientTrickTakingMissions\Services\ClientLoggingRuntime.cs
	namespace 	
View
 
. 
Services 
{		 
internal 
static 
class  
ClientLoggingRuntime .
{ 
private 
const 
string (
RuntimeNotInitializedMessage 9
=: ;
$str b
;b c
private 
static 
readonly 
object  &

s_syncRoot' 1
=2 3
new4 7
object8 >
(> ?
)? @
;@ A
private 
static 
readonly 
DependencyObject  0
s_designModeProbe1 B
=C D
newE H
DependencyObjectI Y
(Y Z
)Z [
;[ \
private 
static 
ILoggerFactory %
s_loggerFactory& 5
;5 6
public 
static 
void 

Initialize %
(% &
ILoggerFactory& 4
loggerFactory5 B
)B C
{ 	
if 
( 
loggerFactory 
==  
null! %
)% &
{ 
throw 
new !
ArgumentNullException /
(/ 0
nameof0 6
(6 7
loggerFactory7 D
)D E
)E F
;F G
} 
lock 
( 

s_syncRoot 
) 
{ 
s_loggerFactory 
=  !
loggerFactory" /
;/ 0
}   
}!! 	
public## 
static## 
ILoggerService## $
CreateLogger##% 1
<##1 2
TCaller##2 9
>##9 :
(##: ;
)##; <
{$$ 	
lock%% 
(%% 

s_syncRoot%% 
)%% 
{&& 
if'' 
('' 
s_loggerFactory'' #
!=''$ &
null''' +
)''+ ,
{(( 
return)) 
s_loggerFactory)) *
.))* +
CreateLogger))+ 7
<))7 8
TCaller))8 ?
>))? @
())@ A
)))A B
;))B C
}** 
}++ 
if-- 
(-- 
DesignerProperties-- "
.--" #
GetIsInDesignMode--# 4
(--4 5
s_designModeProbe--5 F
)--F G
)--G H
{.. 
return// 
NullLoggerService// (
.//( )
Instance//) 1
;//1 2
}00 
throw22 
new22 %
InvalidOperationException22 /
(22/ 0(
RuntimeNotInitializedMessage220 L
)22L M
;22M N
}33 	
public55 
static55 
ViewModelUiServices55 )
CreateUiServices55* :
<55: ;
TCaller55; B
>55B C
(55C D
)55D E
{66 	
return77 
new77 
ViewModelUiServices77 *
(77* +
new88  
WpfNavigationService88 (
(88( )
)88) *
,88* +
new99 
WpfDialogService99 $
(99$ %
)99% &
,99& '
CreateLogger:: 
<:: 
TCaller:: $
>::$ %
(::% &
)::& '
)::' (
;::( )
};; 	
public== 
static== &
ViewModelNavigationLogging== 0#
CreateNavigationLogging==1 H
<==H I
TCaller==I P
>==P Q
(==Q R
)==R S
{>> 	
return?? 
new?? &
ViewModelNavigationLogging?? 1
(??1 2
new@@  
WpfNavigationService@@ (
(@@( )
)@@) *
,@@* +
CreateLoggerAA 
<AA 
TCallerAA $
>AA$ %
(AA% &
)AA& '
)AA' (
;AA( )
}BB 	
}CC 
}DD »$
rC:\Users\oscar\source\repos\TrickTakingMissions\Client\ClientTrickTakingMissions\Views\Friends\FriendsView.xaml.cs
	namespace 	
View
 
. 
Views 
{ 
public 

partial 
class 
FriendsView $
:% &
UserControl' 2
{ 
public 
static 
readonly 
DependencyProperty 1
IsInLobbyProperty2 C
=D E
DependencyProperty 
. 
Register '
(' (
nameof 
( 
	IsInLobby  
)  !
,! "
typeof 
( 
bool 
) 
, 
typeof 
( 
FriendsView "
)" #
,# $
new 
PropertyMetadata $
($ %
false% *
,* +
OnIsInLobbyChanged, >
)> ?
)? @
;@ A
public 
static 
readonly 
DependencyProperty 1*
InviteButtonVisibilityProperty2 P
=Q R
DependencyProperty 
. 
Register '
(' (
nameof 
( "
InviteButtonVisibility -
)- .
,. /
typeof 
( 

Visibility !
)! "
," #
typeof   
(   
FriendsView   "
)  " #
,  # $
new!! 
PropertyMetadata!! $
(!!$ %

Visibility!!% /
.!!/ 0
	Collapsed!!0 9
)!!9 :
)!!: ;
;!!; <
private## 
readonly## 
FriendsViewModel## )

_viewModel##* 4
;##4 5
public(( 
FriendsView(( 
((( 
)(( 
{)) 	
InitializeComponent** 
(**  
)**  !
;**! "

_viewModel,, 
=,, 
new,, 
FriendsViewModel,, -
(,,- . 
ClientLoggingRuntime-- $
.--$ %
CreateUiServices--% 5
<--5 6
FriendsViewModel--6 F
>--F G
(--G H
)--H I
,--I J
FriendshipSession.. !
...! "
Current.." )
,..) *
LobbySession// 
.// 
Current// $
)//$ %
;//% &
DataContext00 
=00 

_viewModel00 $
;00$ %
}11 	
public66 
bool66 
	IsInLobby66 
{77 	
get88 
=>88 
(88 
bool88 
)88 
GetValue88 !
(88! "
IsInLobbyProperty88" 3
)883 4
;884 5
set99 
=>99 
SetValue99 
(99 
IsInLobbyProperty99 -
,99- .
value99/ 4
)994 5
;995 6
}:: 	
public?? 

Visibility?? "
InviteButtonVisibility?? 0
{@@ 	
getAA 
=>AA 
(AA 

VisibilityAA 
)AA 
GetValueAA '
(AA' (*
InviteButtonVisibilityPropertyAA( F
)AAF G
;AAG H
setBB 
=>BB 
SetValueBB 
(BB *
InviteButtonVisibilityPropertyBB :
,BB: ;
valueBB< A
)BBA B
;BBB C
}CC 	
privateEE 
staticEE 
voidEE 
OnIsInLobbyChangedEE .
(EE. /
DependencyObjectEE/ ?
dEE@ A
,EEA B.
"DependencyPropertyChangedEventArgsEEC e
eEEf g
)EEg h
{FF 	
ifGG 
(GG 
dGG 
isGG 
FriendsViewGG  
friendsViewGG! ,
)GG, -
{HH 
boolII 
	isInLobbyII 
=II  
(II! "
boolII" &
)II& '
eII' (
.II( )
NewValueII) 1
;II1 2
friendsViewJJ 
.JJ "
InviteButtonVisibilityJJ 2
=JJ3 4
	isInLobbyJJ5 >
?JJ? @

VisibilityJJA K
.JJK L
VisibleJJL S
:JJT U

VisibilityJJV `
.JJ` a
	CollapsedJJa j
;JJj k
ifKK 
(KK 
friendsViewKK 
.KK  

_viewModelKK  *
!=KK+ -
nullKK. 2
)KK2 3
{LL 
friendsViewMM 
.MM  

_viewModelMM  *
.MM* +
	IsInLobbyMM+ 4
=MM5 6
	isInLobbyMM7 @
;MM@ A
}NN 
}OO 
}PP 	
}QQ 
}RR ﬁ
ÄC:\Users\oscar\source\repos\TrickTakingMissions\Client\ClientTrickTakingMissions\Views\Friends\ManageFriendRequestWindow.xaml.cs
	namespace 	
View
 
. 
Views 
{ 
public 

partial 
class %
ManageFriendRequestWindow 2
:3 4
Window5 ;
{ 
public %
ManageFriendRequestWindow (
(( )
)) *
{ 	
InitializeComponent 
(  
)  !
;! "
IDialogService 
dialogService (
=) *
new+ .
WpfDialogService/ ?
(? @
)@ A
;A B(
ManageFriendRequestViewModel (
	viewModel) 2
=3 4
new5 8(
ManageFriendRequestViewModel9 U
(U V
FriendshipSession !
.! "
Current" )
,) *
dialogService 
,  
ClientLoggingRuntime $
.$ %
CreateLogger% 1
<1 2(
ManageFriendRequestViewModel2 N
>N O
(O P
)P Q
)Q R
;R S
	viewModel 
. 
RequestClose "
+=# %
OnRequestClose& 4
;4 5
DataContext 
= 
	viewModel #
;# $
} 	
private 
void 
OnRequestClose #
(# $
)$ %
{ 	
Close   
(   
)   
;   
}!! 	
}"" 
}## «
|C:\Users\oscar\source\repos\TrickTakingMissions\Client\ClientTrickTakingMissions\Views\Friends\SendFriendRequestPage.xaml.cs
	namespace 	
View
 
. 
Views 
{ 
public 

partial 
class !
SendFriendRequestPage .
:/ 0
Page1 5
{ 
public !
SendFriendRequestPage $
($ %
)% &
{ 	
InitializeComponent 
(  
)  !
;! "&
SendFriendRequestViewModel &
	viewModel' 0
=1 2
new3 6&
SendFriendRequestViewModel7 Q
(Q R 
ClientLoggingRuntime $
.$ %
CreateUiServices% 5
<5 6&
SendFriendRequestViewModel6 P
>P Q
(Q R
)R S
,S T
FriendshipSession !
.! "
Current" )
)) *
;* +
DataContext 
= 
	viewModel #
;# $
} 	
} 
} ≈
xC:\Users\oscar\source\repos\TrickTakingMissions\Client\ClientTrickTakingMissions\Views\Menu\SelectLanguageWindow.xaml.cs
	namespace 	
View
 
. 
Views 
{ 
public

 

partial

 
class

  
SelectLanguageWindow

 -
:

. /
Window

0 6
{ 
private 
readonly #
SelectLanguageViewModel 0

_viewModel1 ;
;; <
public  
SelectLanguageWindow #
(# $
)$ %
: 
this 
( 
new #
SelectLanguageViewModel .
(. /
new/ 2
WpfLanguageService3 E
(E F
)F G
)G H
)H I
{ 	
} 	
public  
SelectLanguageWindow #
(# $#
SelectLanguageViewModel$ ;
	viewModel< E
)E F
{ 	
InitializeComponent 
(  
)  !
;! "

_viewModel 
= 
	viewModel "
;" #
DataContext 
= 

_viewModel $
;$ %
if!! 
(!! 

_viewModel!! 
!=!! 
null!! "
)!!" #
{"" 

_viewModel## 
.## 
RequestClose## '
+=##( *
(##+ ,
)##, -
=>##. 0
this##1 5
.##5 6
Close##6 ;
(##; <
)##< =
;##= >
}$$ 
}%% 	
}&& 
}'' ¬
nC:\Users\oscar\source\repos\TrickTakingMissions\Client\ClientTrickTakingMissions\Views\Menu\ScoreBoard.xaml.cs
	namespace 	
View
 
. 
Views 
{ 
public		 

partial		 
class		 

ScoreBoard		 #
:		$ %
Window		& ,
{

 
private 
readonly 
ScoreBoardViewModel ,

_viewModel- 7
;7 8
public 

ScoreBoard 
( 
) 
: 
this 
( 
new 
ScoreBoardViewModel *
(* +
)+ ,
), -
{ 	
} 	
public 

ScoreBoard 
( 
ScoreBoardViewModel -
	viewModel. 7
)7 8
{ 	
InitializeComponent 
(  
)  !
;! "

_viewModel 
= 
	viewModel "
;" #
DataContext 
= 

_viewModel $
;$ %
if   
(   

_viewModel   
!=   
null   "
)  " #
{!! 

_viewModel"" 
."" 
RequestClose"" '
+=""( *
(""+ ,
)"", -
=>"". 0
this""1 5
.""5 6
Close""6 ;
(""; <
)""< =
;""= >
}## 
}$$ 	
}%% 
}&& ”
nC:\Users\oscar\source\repos\TrickTakingMissions\Client\ClientTrickTakingMissions\Views\Profile\Profile.xaml.cs
	namespace 	
View
 
. 
Views 
{ 
public

 

partial

 
class

 
Profile

  
:

! "
Page

# '
{ 
private 
readonly 
ProfileViewModel )

_viewModel* 4
;4 5
public 
Profile 
( 
) 
: 
this 
( 
new 
ProfileViewModel '
(' ( 
ClientLoggingRuntime $
.$ %#
CreateNavigationLogging% <
<< =
ProfileViewModel= M
>M N
(N O
)O P
,P Q
new !
WpfProfileImagePicker )
() *
)* +
,+ ,
( 
( 
App 
) 
System 
. 
Windows $
.$ %
Application% 0
.0 1
Current1 8
)8 9
.9 :
ProfileImages: G
)G H
)H I
{ 	
} 	
public 
Profile 
( 
ProfileViewModel '
	viewModel( 1
)1 2
{ 	
InitializeComponent 
(  
)  !
;! "

_viewModel!! 
=!! 
	viewModel!! "
;!!" #
DataContext"" 
="" 

_viewModel"" $
;""$ %
Loaded## 
+=## 
(## 
_## 
,## 
__## 
)## 
=>##  

_viewModel##! +
.##+ , 
ActivateProfileImage##, @
(##@ A
)##A B
;##B C
Unloaded$$ 
+=$$ 
($$ 
_$$ 
,$$ 
__$$ 
)$$ 
=>$$  "

_viewModel$$# -
.$$- ."
DeactivateProfileImage$$. D
($$D E
)$$E F
;$$F G
}%% 	
}&& 
}'' –
zC:\Users\oscar\source\repos\TrickTakingMissions\Client\ClientTrickTakingMissions\Views\Authentication\RegisterPage.xaml.cs
	namespace 	
View
 
. 
Views 
{ 
public 

partial 
class 
RegisterPage %
:& '
Page( ,
{ 
private 
readonly 
RegisterViewModel *

_viewModel+ 5
;5 6
public 
RegisterPage 
( 
) 
: 
this 
( 
new 
RegisterViewModel (
(( ) 
ClientLoggingRuntime $
.$ %
CreateUiServices% 5
<5 6
RegisterViewModel6 G
>G H
(H I
)I J
,J K
new #
AccountManagementClient +
(+ , 
ClientLoggingRuntime, @
.@ A
CreateLoggerA M
<M N#
AccountManagementClientN e
>e f
(f g
)g h
)h i
)i j
)j k
{ 	
} 	
public 
RegisterPage 
( 
RegisterViewModel -
	viewModel. 7
)7 8
{ 	
InitializeComponent   
(    
)    !
;  ! "

_viewModel"" 
="" 
	viewModel"" "
;""" #
DataContext## 
=## 

_viewModel## $
;##$ %
}$$ 	
private&& 
void&& '
PasswordBox_PasswordChanged&& 0
(&&0 1
object&&1 7
sender&&8 >
,&&> ?
RoutedEventArgs&&@ O
e&&P Q
)&&Q R
{'' 	
if(( 
((( 

_viewModel(( 
!=(( 
null(( "
)((" #
{)) 

_viewModel** 
.** 
Password** #
=**$ %
PasswordBox**& 1
.**1 2
Password**2 :
;**: ;
}++ 
},, 	
private.. 
void.. .
"ConfirmPasswordBox_PasswordChanged.. 7
(..7 8
object..8 >
sender..? E
,..E F
RoutedEventArgs..G V
e..W X
)..X Y
{// 	
if00 
(00 

_viewModel00 
!=00 
null00 "
)00" #
{11 

_viewModel22 
.22 
PasswordConfirm22 *
=22+ ,
ConfirmPasswordBox22- ?
.22? @
Password22@ H
;22H I
}33 
}44 	
}55 
}66 Ω
}C:\Users\oscar\source\repos\TrickTakingMissions\Client\ClientTrickTakingMissions\Views\Authentication\RecoverPassword.xaml.cs
	namespace 	
View
 
. 
Views 
{ 
public 

partial 
class 
RecoverPassword (
:) *
Page+ /
{ 
private 
readonly $
RecoverPasswordViewModel 1

_viewModel2 <
;< =
public 
RecoverPassword 
( 
)  
: 
this 
( 
string 
. 
Empty 
)  
{ 	
} 	
public 
RecoverPassword 
( 
string %
email& +
)+ ,
: 
this 
( 
new $
RecoverPasswordViewModel /
(/ 0 
ClientLoggingRuntime0 D
.D E
CreateUiServicesE U
<U V$
RecoverPasswordViewModelV n
>n o
(o p
)p q
,q r
emails x
)x y
)y z
{ 	
} 	
public$$ 
RecoverPassword$$ 
($$ $
RecoverPasswordViewModel$$ 7
	viewModel$$8 A
)$$A B
{%% 	
InitializeComponent&& 
(&&  
)&&  !
;&&! "

_viewModel(( 
=(( 
	viewModel(( "
;((" #
DataContext)) 
=)) 

_viewModel)) $
;))$ %
if++ 
(++ 

_viewModel++ 
!=++ 
null++ "
)++" #
{,, 

_viewModel-- 
.-- 
RequestBack-- &
+=--' )
OnRequestBack--* 7
;--7 8

_viewModel.. 
... 
RequestClose.. '
+=..( *
OnRequestClose..+ 9
;..9 :
}// 
}00 	
private22 
void22 
OnRequestBack22 "
(22" #
)22# $
{33 	
ForgotPassword44 
parent44 !
=44" #
Window44$ *
.44* +
	GetWindow44+ 4
(444 5
this445 9
)449 :
as44; =
ForgotPassword44> L
;44L M
if55 
(55 
parent55 
!=55 
null55 
)55 
{66 
parent77 
.77 
ShowInitialView77 &
(77& '
)77' (
;77( )
}88 
else99 
if99 
(99 
this99 
.99 
NavigationService99 +
!=99, .
null99/ 3
&&994 6
this997 ;
.99; <
NavigationService99< M
.99M N
	CanGoBack99N W
)99W X
{:: 
this;; 
.;; 
NavigationService;; &
.;;& '
GoBack;;' -
(;;- .
);;. /
;;;/ 0
}<< 
}== 	
private?? 
void?? 
OnRequestClose?? #
(??# $
)??$ %
{@@ 	
WindowAA 
.AA 
	GetWindowAA 
(AA 
thisAA !
)AA! "
?AA" #
.AA# $
CloseAA$ )
(AA) *
)AA* +
;AA+ ,
}BB 	
}CC 
}DD è
wC:\Users\oscar\source\repos\TrickTakingMissions\Client\ClientTrickTakingMissions\Views\Authentication\LoginPage.xaml.cs
	namespace 	
View
 
. 
Views 
{ 
public 

partial 
class 
	LoginPage "
:# $
Page% )
{ 
private 
readonly 
LoginViewModel '

_viewModel( 2
;2 3
public 
	LoginPage 
( 
) 
: 
this 
( 
new 
LoginViewModel %
(% & 
ClientLoggingRuntime& :
.: ;
CreateUiServices; K
<K L
LoginViewModelL Z
>Z [
([ \
)\ ]
,] ^
new #
ChatModerationPresenter +
(+ ,
), -
)- .
). /
{ 	
} 	
public 
	LoginPage 
( 
LoginViewModel '
	viewModel( 1
)1 2
{ 	
InitializeComponent 
(  
)  !
;! "

_viewModel!! 
=!! 
	viewModel!! "
;!!" #
DataContext"" 
="" 

_viewModel"" $
;""$ %
Unloaded## 
+=## 
OnLoginPageUnloaded## +
;##+ ,
}$$ 	
private&& 
void&& 
OnLoginPageUnloaded&& (
(&&( )
object&&) /
sender&&0 6
,&&6 7
RoutedEventArgs&&8 G
e&&H I
)&&I J
{'' 	

_viewModel(( 
.(( 
Dispose(( 
((( 
)((  
;((  !
})) 	
private++ 
void++ '
PasswordBox_PasswordChanged++ 0
(++0 1
object++1 7
sender++8 >
,++> ?
RoutedEventArgs++@ O
e++P Q
)++Q R
{,, 	
if-- 
(-- 

_viewModel-- 
!=-- 
null-- "
)--" #
{.. 

_viewModel// 
.// 
Password// #
=//$ %
PasswordBox//& 1
.//1 2
Password//2 :
;//: ;
}00 
}11 	
}22 
}33 é"
jC:\Users\oscar\source\repos\TrickTakingMissions\Client\ClientTrickTakingMissions\Views\Lobby\Lobby.xaml.cs
	namespace 	
View
 
. 
Views 
{ 
public 

partial 
class 
Lobby 
:  
Page! %
{ 
public 
Lobby 
( 
) 
{ 	
InitializeComponent 
(  
)  !
;! "
LobbyViewModel 
	viewModel $
=% &
new' *
LobbyViewModel+ 9
(9 : 
ClientLoggingRuntime $
.$ %#
CreateNavigationLogging% <
<< =
LobbyViewModel= K
>K L
(L M
)M N
,N O
LobbySession 
. 
Current $
,$ %
new #
ChatModerationPresenter +
(+ ,
), -
)- .
;. /
Loaded 
+= 
( 
_ 
, 
__ 
) 
=>  
	viewModel 
. "
ConfigureProfileImages 0
(0 1
(1 2
(2 3
App3 6
)6 7
System7 =
.= >
Windows> E
.E F
ApplicationF Q
.Q R
CurrentR Y
)Y Z
.Z [
ProfileImages[ h
)h i
;i j
DataContext 
= 
	viewModel #
;# $
	viewModel 
. 
CurrentPlayerKicked )
+=* ,!
OnCurrentPlayerKicked- B
;B C
Unloaded 
+= 
OnLobbyUnloaded '
;' (
} 	
private 
void &
OnPlayerActionsButtonClick /
(/ 0
object0 6
sender7 =
,= >
System? E
.E F
WindowsF M
.M N
RoutedEventArgsN ]
e^ _
)_ `
{ 	
if   
(   
sender   
is   
Button    
playerActionsButton  ! 4
&&  5 7
playerActionsButton  8 K
.  K L
ContextMenu  L W
!=  X Z
null  [ _
)  _ `
{!! 
playerActionsButton"" #
.""# $
ContextMenu""$ /
.""/ 0
PlacementTarget""0 ?
=""@ A
playerActionsButton""B U
;""U V
playerActionsButton## #
.### $
ContextMenu##$ /
.##/ 0
IsOpen##0 6
=##7 8
true##9 =
;##= >
}$$ 
}%% 	
private'' 
void'' !
OnCurrentPlayerKicked'' *
(''* +
object''+ 1
sender''2 8
,''8 9
System'': @
.''@ A
	EventArgs''A J
e''K L
)''L M
{(( 	
System)) 
.)) 
Windows)) 
.)) 

MessageBox)) %
.))% &
Show))& *
())* +

Properties))+ 5
.))5 6
Langs))6 ;
.)); <
	Resources))< E
.))E F
Lobby_KickedNotice))F X
,))X Y

Properties** 
.** 
Langs**  
.**  !
	Resources**! *
.*** +
Lobby_PlayerActions**+ >
,**> ?
System++ 
.++ 
Windows++ 
.++ 
MessageBoxButton++ /
.++/ 0
OK++0 2
)++2 3
;++3 4
},, 	
private.. 
void.. 
OnLobbyUnloaded.. $
(..$ %
object..% +
sender.., 2
,..2 3
System..4 :
...: ;
Windows..; B
...B C
RoutedEventArgs..C R
e..S T
)..T U
{// 	
if00 
(00 
DataContext00 
is00 
LobbyViewModel00 -
lobbyViewModel00. <
)00< =
{11 
lobbyViewModel22 
.22 
CurrentPlayerKicked22 2
-=223 5!
OnCurrentPlayerKicked226 K
;22K L
lobbyViewModel33 
.33 
Dispose33 &
(33& '
)33' (
;33( )
}44 
}55 	
}66 
}77 ª
mC:\Users\oscar\source\repos\TrickTakingMissions\Client\ClientTrickTakingMissions\Views\Menu\HowToPlay.xaml.cs
	namespace 	
View
 
. 
Views 
{ 
public		 

partial		 
class		 
	HowToPlay		 "
:		# $
Window		% +
{

 
private 
readonly 
HowToPlayViewModel +

_viewModel, 6
;6 7
public 
	HowToPlay 
( 
) 
: 
this 
( 
new 
HowToPlayViewModel )
() *
)* +
)+ ,
{ 	
} 	
public 
	HowToPlay 
( 
HowToPlayViewModel +
	viewModel, 5
)5 6
{ 	
InitializeComponent 
(  
)  !
;! "

_viewModel 
= 
	viewModel "
;" #
DataContext 
= 

_viewModel $
;$ %
if   
(   

_viewModel   
!=   
null   "
)  " #
{!! 

_viewModel"" 
."" 
RequestClose"" '
+=""( *
(""+ ,
)"", -
=>"". 0
this""1 5
.""5 6
Close""6 ;
(""; <
)""< =
;""= >
}## 
}$$ 	
}%% 
}&& ë
pC:\Users\oscar\source\repos\TrickTakingMissions\Client\ClientTrickTakingMissions\Views\Menu\GameSettings.xaml.cs
	namespace 	
View
 
. 
Views 
{ 
public 

partial 
class 
GameSettings %
:& '
Window( .
{ 
public 
GameSettings 
( 
) 
{ 	
InitializeComponent 
(  
)  !
;! "
IDialogService 
dialogService (
=) *
new+ .
WpfDialogService/ ?
(? @
)@ A
;A B!
GameSettingsViewModel !
	viewModel" +
=, -
new. 1!
GameSettingsViewModel2 G
(G H
dialogService 
, 
LobbySession 
. 
Current $
,$ % 
ClientLoggingRuntime $
.$ %
CreateLogger% 1
<1 2!
GameSettingsViewModel2 G
>G H
(H I
)I J
)J K
;K L
	viewModel 
. 
RequestClose "
+=# %
OnRequestClose& 4
;4 5
DataContext 
= 
	viewModel #
;# $
} 	
private 
void 
OnRequestClose #
(# $
bool$ (
	confirmed) 2
)2 3
{   	
DialogResult!! 
=!! 
	confirmed!! $
;!!$ %
Close"" 
("" 
)"" 
;"" 
}## 	
}$$ 
}%% ©
qC:\Users\oscar\source\repos\TrickTakingMissions\Client\ClientTrickTakingMissions\Views\Menu\EnterGameCode.xaml.cs
	namespace 	
View
 
. 
Views 
{ 
public 

partial 
class 
EnterGameCode &
:' (
Window) /
{ 
private 
readonly "
EnterGameCodeViewModel /

_viewModel0 :
;: ;
public 
EnterGameCode 
( 
) 
{ 	
InitializeComponent 
(  
)  !
;! "
IDialogService 
dialogService (
=) *
new+ .
WpfDialogService/ ?
(? @
)@ A
;A B

_viewModel 
= 
new "
EnterGameCodeViewModel 3
(3 4
dialogService 
, 
LobbySession 
. 
Current $
,$ % 
ClientLoggingRuntime $
.$ %
CreateLogger% 1
<1 2"
EnterGameCodeViewModel2 H
>H I
(I J
)J K
)K L
;L M

_viewModel 
. 
RequestClose #
+=$ &
OnRequestClose' 5
;5 6
DataContext 
= 

_viewModel $
;$ %
} 	
public## 
string## 
GameCode## 
=>## !

_viewModel##" ,
?##, -
.##- .
GameCode##. 6
?##6 7
.##7 8
Trim##8 <
(##< =
)##= >
??##? A
string##B H
.##H I
Empty##I N
;##N O
private%% 
void%% 
OnRequestClose%% #
(%%# $
bool%%$ (
	confirmed%%) 2
)%%2 3
{&& 	
DialogResult'' 
='' 
	confirmed'' $
;''$ %
Close(( 
((( 
)(( 
;(( 
})) 	
}** 
}++ Ô
|C:\Users\oscar\source\repos\TrickTakingMissions\Client\ClientTrickTakingMissions\Views\Authentication\ChangePassword.xaml.cs
	namespace 	
View
 
. 
Views 
{ 
public

 

partial

 
class

 
ChangePassword

 '
:

( )
Window

* 0
{ 
private 
readonly #
ChangePasswordViewModel 0

_viewModel1 ;
;; <
public 
ChangePassword 
( 
) 
: 
this 
( 
new #
ChangePasswordViewModel .
(. /
new/ 2
WpfDialogService3 C
(C D
)D E
)E F
)F G
{ 	
} 	
public 
ChangePassword 
( #
ChangePasswordViewModel 5
	viewModel6 ?
)? @
{ 	
InitializeComponent 
(  
)  !
;! "

_viewModel 
= 
	viewModel "
;" #
DataContext 
= 

_viewModel $
;$ %
if!! 
(!! 

_viewModel!! 
!=!! 
null!! "
)!!" #
{"" 

_viewModel## 
.## 
RequestClose## '
+=##( *
(##+ ,
)##, -
=>##. 0
this##1 5
.##5 6
Close##6 ;
(##; <
)##< =
;##= >
}$$ 
}%% 	
private'' 
void'' *
NewPasswordBox_PasswordChanged'' 3
(''3 4
object''4 :
sender''; A
,''A B
RoutedEventArgs''C R
e''S T
)''T U
{(( 	
if)) 
()) 

_viewModel)) 
!=)) 
null)) "
)))" #
{** 

_viewModel++ 
.++ 
NewPassword++ &
=++' (
NewPasswordBox++) 7
.++7 8
Password++8 @
;++@ A
},, 
}-- 	
private// 
void// .
"ConfirmPasswordBox_PasswordChanged// 7
(//7 8
object//8 >
sender//? E
,//E F
RoutedEventArgs//G V
e//W X
)//X Y
{00 	
if11 
(11 

_viewModel11 
!=11 
null11 "
)11" #
{22 

_viewModel33 
.33 
ConfirmPassword33 *
=33+ ,
ConfirmPasswordBox33- ?
.33? @
Password33@ H
;33H I
}44 
}55 	
}66 
}77 ˘
lC:\Users\oscar\source\repos\TrickTakingMissions\Client\ClientTrickTakingMissions\Views\Menu\GameMenu.xaml.cs
	namespace 	
View
 
. 
Views 
{ 
public 

partial 
class 
GameMenu !
:" #
Page$ (
{ 
private 
readonly 
GameMenuViewModel *

_viewModel+ 5
;5 6
public 
GameMenu 
( 
) 
: 
this 
( 
new 
GameMenuViewModel (
(( )
new  
WpfNavigationService (
(( )
)) *
,* +
LobbySession 
. 
Current $
,$ % 
ClientLoggingRuntime $
.$ %
CreateLogger% 1
<1 2
GameMenuViewModel2 C
>C D
(D E
)E F
)F G
)G H
{ 	
} 	
public 
GameMenu 
( 
GameMenuViewModel )
	viewModel* 3
)3 4
{ 	
InitializeComponent   
(    
)    !
;  ! "

_viewModel"" 
="" 
	viewModel"" "
;""" #
DataContext## 
=## 

_viewModel## $
;##$ %
Loaded$$ 
+=$$ 
OnGameMenuLoaded$$ &
;$$& '
Unloaded%% 
+=%% 
OnGameMenuUnloaded%% *
;%%* +
}&& 	
private'' 
void'' 
OnGameMenuLoaded'' %
(''% &
object''& ,
sender''- 3
,''3 4
System''5 ;
.''; <
Windows''< C
.''C D
RoutedEventArgs''D S
e''T U
)''U V
{(( 	

_viewModel)) 
.)) "
ConfigureProfileImages)) -
())- .
()). /
())/ 0
App))0 3
)))3 4
System))4 :
.)): ;
Windows)); B
.))B C
Application))C N
.))N O
Current))O V
)))V W
.))W X
ProfileImages))X e
)))e f
;))f g
}** 	
private,, 
void,, 
OnGameMenuUnloaded,, '
(,,' (
object,,( .
sender,,/ 5
,,,5 6
System,,7 =
.,,= >
Windows,,> E
.,,E F
RoutedEventArgs,,F U
e,,V W
),,W X
{-- 	

_viewModel.. 
... 
Dispose.. 
(.. 
)..  
;..  !
}// 	
}00 
}11 Å
|C:\Users\oscar\source\repos\TrickTakingMissions\Client\ClientTrickTakingMissions\Views\Authentication\ForgotPassword.xaml.cs
	namespace 	
View
 
. 
Views 
{ 
public

 

partial

 
class

 
ForgotPassword

 '
:

( )
Window

* 0
{ 
private 
readonly #
ForgotPasswordViewModel 0

_viewModel1 ;
;; <
public 
ForgotPassword 
( 
) 
: 
this 
( 
new #
ForgotPasswordViewModel .
(. /
new/ 2
WpfDialogService3 C
(C D
)D E
)E F
)F G
{ 	
} 	
public 
ForgotPassword 
( #
ForgotPasswordViewModel 5
	viewModel6 ?
)? @
{ 	
InitializeComponent 
(  
)  !
;! "

_viewModel 
= 
	viewModel "
;" #
DataContext 
= 

_viewModel $
;$ %
if!! 
(!! 

_viewModel!! 
!=!! 
null!! "
)!!" #
{"" 

_viewModel## 
.## 
RequestClose## '
+=##( *
(##+ ,
)##, -
=>##. 0
this##1 5
.##5 6
Close##6 ;
(##; <
)##< =
;##= >

_viewModel$$ 
.$$ 
EmailSubmitted$$ )
+=$$* ,
OnEmailSubmitted$$- =
;$$= >
}%% 
}&& 	
public++ 
void++ 
ShowInitialView++ #
(++# $
)++$ %
{,, 	
ContentFrame-- 
.-- 
Content--  
=--! "
null--# '
;--' (
ContentFrame.. 
... 

Visibility.. #
=..$ %

Visibility..& 0
...0 1
	Collapsed..1 :
;..: ;

MainBorder// 
.// 

Visibility// !
=//" #

Visibility//$ .
.//. /
Visible/// 6
;//6 7
}00 	
private22 
void22 
OnEmailSubmitted22 %
(22% &
string22& ,
email22- 2
)222 3
{33 	

MainBorder44 
.44 

Visibility44 !
=44" #

Visibility44$ .
.44. /
	Collapsed44/ 8
;448 9
ContentFrame55 
.55 

Visibility55 #
=55$ %

Visibility55& 0
.550 1
Visible551 8
;558 9
ContentFrame66 
.66 
Navigate66 !
(66! "
new66" %
RecoverPassword66& 5
(665 6
email666 ;
)66; <
)66< =
;66= >
}77 	
}88 
}99 ¨6
xC:\Users\oscar\source\repos\TrickTakingMissions\Client\ClientTrickTakingMissions\Services\ChatModerationTextFormatter.cs
	namespace 	
View
 
. 
Services 
{ 
public

 

static

 
class

 '
ChatModerationTextFormatter

 3
{ 
public 
static 
string $
FormatSubmissionFeedback 5
(5 6-
!LobbyChatMessageSubmissionOutcome6 W(
chatMessageSubmissionOutcomeX t
)t u
{ 	
string !
localizedChatFeedback (
=) *
string+ 1
.1 2
Empty2 7
;7 8
if 
( (
chatMessageSubmissionOutcome ,
!=- /
null0 4
)4 5
{ 
if 
( (
chatMessageSubmissionOutcome 0
.0 1&
ChatMessageRejectionReason1 K
!=L N&
ChatMessageRejectionReasonO i
.i j
Nonej n
)n o
{ !
localizedChatFeedback )
=* +
GetChatResource, ;
(; <
$str 
+  !(
chatMessageSubmissionOutcome" >
.> ?&
ChatMessageRejectionReason? Y
)Y Z
;Z [
} 
else 
if 
( (
chatMessageSubmissionOutcome 5
.5 6 
ChatInfractionNotice6 J
?J K
.K L*
CurrentMessageInfractionPointsL j
>k l
$numm n
)n o
{ !
localizedChatFeedback )
=* +"
FormatInfractionNotice, B
(B C(
chatMessageSubmissionOutcomeC _
._ ` 
ChatInfractionNotice` t
)t u
;u v
} 
} 
return !
localizedChatFeedback (
;( )
} 	
public 
static 
string 
FormatAccountBan -
(- . 
ChatAccountBanNotice. B 
chatAccountBanNoticeC W
)W X
{   	
string!! %
localizedAccountBanNotice!! ,
=!!- .
GetChatResource!!/ >
(!!> ?
$str!!? Y
)!!Y Z
;!!Z [
if"" 
(""  
chatAccountBanNotice"" $
.""$ %
ChatAccountBanType""% 7
==""8 :
ChatAccountBanType""; M
.""M N
	Temporary""N W
)""W X
{## 
string$$ 
localBanEndText$$ &
=$$' ( 
chatAccountBanNotice$$) =
.$$= >#
ChatAccountBanEndsAtUtc$$> U
?$$U V
.$$V W
ToLocalTime$$W b
($$b c
)$$c d
.%% 
ToString%% 
(%% 
$str%% !
,%%! "
CultureInfo%%# .
.%%. /
CurrentCulture%%/ =
)%%= >
??%%? A
string%%B H
.%%H I
Empty%%I N
;%%N O
TimeSpan&&  
remainingBanDuration&& -
=&&. / 
chatAccountBanNotice&&0 D
.&&D E#
ChatAccountBanEndsAtUtc&&E \
.&&\ ]
GetValueOrDefault&&] n
(&&n o
)&&o p
-&&q r 
chatAccountBanNotice'' (
.''( )
EvaluatedAtUtc'') 7
;''7 8%
localizedAccountBanNotice(( )
=((* +
string((, 2
.((2 3
Format((3 9
(((9 :
CultureInfo((: E
.((E F
CurrentCulture((F T
,((T U
	Resources)) 
.)) $
Chat_TemporaryAccountBan)) 6
,))6 7
new** 
object** 
[** 
]**  
{**! "
localBanEndText**# 2
,**2 3&
FormatRemainingBanDuration**4 N
(**N O 
remainingBanDuration**O c
)**c d
}**e f
)**f g
;**g h
}++ 
return-- %
localizedAccountBanNotice-- ,
;--, -
}.. 	
private00 
static00 
string00 &
FormatRemainingBanDuration00 8
(008 9
TimeSpan009 A 
remainingBanDuration00B V
)00V W
{11 	
string22 
remainingBanText22 #
=22$ %
GetChatResource22& 5
(225 6
$str226 P
)22P Q
;22Q R
if33 
(33  
remainingBanDuration33 $
>33% &
TimeSpan33' /
.33/ 0
Zero330 4
)334 5
{44 
remainingBanText55  
=55! "
string55# )
.55) *
Format55* 0
(550 1
CultureInfo551 <
.55< =
CurrentCulture55= K
,55K L
	Resources55M V
.55V W%
Chat_RemainingBanDuration55W p
,55p q
new66 
object66 
[66 
]66  
{77  
remainingBanDuration88 ,
.88, -
Days88- 1
,881 2 
remainingBanDuration99 ,
.99, -
Hours99- 2
,992 3 
remainingBanDuration:: ,
.::, -
Minutes::- 4
,::4 5 
remainingBanDuration;; ,
.;;, -
Seconds;;- 4
}<< 
)<< 
;<< 
}== 
return?? 
remainingBanText?? #
;??# $
}@@ 	
privateBB 
staticBB 
stringBB "
FormatInfractionNoticeBB 4
(BB4 5 
ChatInfractionNoticeBB5 I 
chatInfractionNoticeBBJ ^
)BB^ _
{CC 	
returnDD 
stringDD 
.DD 
FormatDD  
(DD  !
CultureInfoDD! ,
.DD, -
CurrentCultureDD- ;
,DD; <
	ResourcesDD= F
.DDF G"
Chat_InfractionWarningDDG ]
,DD] ^
newEE 
objectEE 
[EE 
]EE 
{FF  
chatInfractionNoticeGG (
.GG( )+
AccumulatedChatInfractionPointsGG) H
,GGH I 
chatInfractionNoticeHH (
.HH( )(
ChatInfractionPointThresholdHH) E
,HHE F 
chatInfractionNoticeII (
.II( )2
&RemainingChatInfractionPointsBeforeBanII) O
}JJ 
)JJ 
;JJ 
}KK 	
privateMM 
staticMM 
stringMM 
GetChatResourceMM -
(MM- .
stringMM. 4
chatResourceNameMM5 E
)MME F
{NN 	
returnOO 
	ResourcesOO 
.OO 
ResourceManagerOO ,
.OO, -
	GetStringOO- 6
(OO6 7
chatResourceNameOO7 G
,OOG H
CultureInfoOOI T
.OOT U
CurrentUICultureOOU e
)OOe f
??OOg i
	ResourcesPP 
.PP #
Common_Error_UnexpectedPP 1
;PP1 2
}QQ 	
}RR 
}SS ≠
oC:\Users\oscar\source\repos\TrickTakingMissions\Client\ClientTrickTakingMissions\Controls\GameTitleView.xaml.cs
	namespace 	
View
 
. 
Controls 
{ 
public 

partial 
class 
GameTitleView &
:' (
UserControl) 4
{ 
public 
GameTitleView 
( 
) 
{		 	
InitializeComponent

 
(

  
)

  !
;

! "
} 	
} 
} é.
uC:\Users\oscar\source\repos\TrickTakingMissions\Client\ClientTrickTakingMissions\Controls\OverlappingCardHandPanel.cs
	namespace 	
View
 
. 
Controls 
{ 
public 

sealed 
class $
OverlappingCardHandPanel 0
:1 2
Panel3 8
{		 
private

 
const

 
double

 #
MaximumCardSpacingRatio

 4
=

5 6
$num

7 ;
;

; <
private 
Size 
_cardSlotSize "
;" #
	protected 
override 
Size 
MeasureOverride  /
(/ 0
Size0 4
availableSize5 B
)B C
{ 	
double 
maximumCardWidth #
=$ %
$num& '
;' (
double 
maximumCardHeight $
=% &
$num' (
;( )
foreach 
( 
	UIElement 
cardElement *
in+ -
InternalChildren. >
)> ?
{ 
cardElement 
. 
Measure #
(# $
new$ '
Size( ,
(, -
double- 3
.3 4
PositiveInfinity4 D
,D E
doubleF L
.L M
PositiveInfinityM ]
)] ^
)^ _
;_ `
maximumCardWidth  
=! "
Math# '
.' (
Max( +
(+ ,
maximumCardWidth, <
,< =
cardElement> I
.I J
DesiredSizeJ U
.U V
WidthV [
)[ \
;\ ]
maximumCardHeight !
=" #
Math$ (
.( )
Max) ,
(, -
maximumCardHeight- >
,> ?
cardElement@ K
.K L
DesiredSizeL W
.W X
HeightX ^
)^ _
;_ `
} 
_cardSlotSize 
= 
new 
Size  $
($ %
maximumCardWidth% 5
,5 6
maximumCardHeight7 H
)H I
;I J
double 
	handWidth 
= 
double %
.% &

IsInfinity& 0
(0 1
availableSize1 >
.> ?
Width? D
)D E
? 
maximumCardWidth "
*# $
InternalChildren% 5
.5 6
Count6 ;
: 
availableSize 
.  
Width  %
;% &
return 
new 
Size 
( 
	handWidth %
,% &
maximumCardHeight' 8
)8 9
;9 :
} 	
	protected 
override 
Size 
ArrangeOverride  /
(/ 0
Size0 4
	finalSize5 >
)> ?
{   	
int!! 
	cardCount!! 
=!! 
InternalChildren!! ,
.!!, -
Count!!- 2
;!!2 3
double"" 
cardSpacing"" 
=""  
$num""! "
;""" #
if## 
(## 
	cardCount## 
>## 
$num## 
)## 
{$$ 
cardSpacing%% 
=%% 
Math%% "
.%%" #
Min%%# &
(%%& '
_cardSlotSize%%' 4
.%%4 5
Width%%5 :
*%%; <#
MaximumCardSpacingRatio%%= T
,%%T U
Math&& 
.&& 
Max&& 
(&& 
$num&& 
,&& 
	finalSize&&  )
.&&) *
Width&&* /
-&&0 1
_cardSlotSize&&2 ?
.&&? @
Width&&@ E
)&&E F
/&&G H
(&&I J
	cardCount&&J S
-&&T U
$num&&V W
)&&W X
)&&X Y
;&&Y Z
}'' 
double)) 
occupiedWidth))  
=))! "
	cardCount))# ,
>))- .
$num))/ 0
?** 
_cardSlotSize** 
.**  
Width**  %
+**& '
cardSpacing**( 3
***4 5
(**6 7
	cardCount**7 @
-**A B
$num**C D
)**D E
:++ 
$num++ 
;++ 
double,, 
firstCardOffset,, "
=,,# $
Math,,% )
.,,) *
Max,,* -
(,,- .
$num,,. /
,,,/ 0
(,,1 2
	finalSize,,2 ;
.,,; <
Width,,< A
-,,B C
occupiedWidth,,D Q
),,Q R
/,,S T
$num,,U V
),,V W
;,,W X
double-- 
cardTopOffset--  
=--! "
Math--# '
.--' (
Max--( +
(--+ ,
$num--, -
,--- .
	finalSize--/ 8
.--8 9
Height--9 ?
---@ A
_cardSlotSize--B O
.--O P
Height--P V
)--V W
;--W X
for.. 
(.. 
int.. 
	cardIndex.. 
=..  
$num..! "
;.." #
	cardIndex..$ -
<... /
	cardCount..0 9
;..9 :
	cardIndex..; D
++..D F
)..F G
{// 
InternalChildren00  
[00  !
	cardIndex00! *
]00* +
.00+ ,
Arrange00, 3
(003 4
new004 7
Rect008 <
(00< =
new11 
Point11 
(11 
firstCardOffset11 -
+11. /
	cardIndex110 9
*11: ;
cardSpacing11< G
,11G H
cardTopOffset11I V
)11V W
,11W X
_cardSlotSize11Y f
)11f g
)11g h
;11h i
}22 
return44 
	finalSize44 
;44 
}55 	
}66 
}77 Ë
tC:\Users\oscar\source\repos\TrickTakingMissions\Client\ClientTrickTakingMissions\Services\ChatModerationPresenter.cs
	namespace		 	
View		
 
.		 
Services		 
{

 
public 

sealed 
class #
ChatModerationPresenter /
:0 1$
IChatModerationPresenter2 J
{ 
private 
const 
string $
LogAccountBanNoticeShown 5
=6 7
$str8 h
;h i
private 
readonly 
ILoggerService '
_logger( /
;/ 0
public #
ChatModerationPresenter &
(& '
)' (
: 
this 
(  
ClientLoggingRuntime '
.' (
CreateLogger( 4
<4 5#
ChatModerationPresenter5 L
>L M
(M N
)N O
)O P
{ 	
} 	
public #
ChatModerationPresenter &
(& '
ILoggerService' 5
logger6 <
)< =
{ 	
_logger 
= 
logger 
?? 
throw  %
new& )!
ArgumentNullException* ?
(? @
nameof@ F
(F G
loggerG M
)M N
)N O
;O P
} 	
public 
string (
FormatChatSubmissionFeedback 2
(2 3-
!LobbyChatMessageSubmissionOutcome3 T(
chatMessageSubmissionOutcomeU q
)q r
{ 	
return '
ChatModerationTextFormatter .
.. /$
FormatSubmissionFeedback/ G
(G H(
chatMessageSubmissionOutcomeH d
)d e
;e f
} 	
public!! 
string!! 
FormatAccountBan!! &
(!!& ' 
ChatAccountBanNotice!!' ; 
chatAccountBanNotice!!< P
)!!P Q
{"" 	
return## '
ChatModerationTextFormatter## .
.##. /
FormatAccountBan##/ ?
(##? @ 
chatAccountBanNotice##@ T
)##T U
;##U V
}$$ 	
public&& 
void&& 
ShowChatAccountBan&& &
(&&& ' 
ChatAccountBanNotice&&' ; 
chatAccountBanNotice&&< P
)&&P Q
{'' 	
_logger(( 
.(( 
Warning(( 
((( $
LogAccountBanNoticeShown(( 4
,((4 5 
chatAccountBanNotice((6 J
?((J K
.((K L
ChatAccountBanType((L ^
)((^ _
;((_ `

MessageBox)) 
.)) 
Show)) 
()) '
ChatModerationTextFormatter)) 7
.))7 8
FormatAccountBan))8 H
())H I 
chatAccountBanNotice))I ]
)))] ^
,))^ _
	Resources** 
.** 

Chat_Title** $
,**$ %
MessageBoxButton**& 6
.**6 7
OK**7 9
,**9 :
MessageBoxImage**; J
.**J K
Warning**K R
)**R S
;**S T
}++ 	
},, 
}-- 