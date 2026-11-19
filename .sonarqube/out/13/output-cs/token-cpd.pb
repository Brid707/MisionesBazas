ÙV
iC:\Users\oscar\source\repos\TrickTakingMissions\Server\Infrastructure.ProfileImages\ProfileImageHeader.cs
	namespace 	
Infrastructure
 
. 
ProfileImages &
{ 
internal		 
static		 
class		 
ProfileImageHeader		 ,
{

 
private 
static 
readonly 
byte  $
[$ %
]% &
_pngSignature' 4
=5 6
{7 8
$num9 <
,< =
$num> @
,@ A
$numB D
,D E
$numF H
,H I
$numJ L
,L M
$numN P
,P Q
$numR T
,T U
$numV X
}Y Z
;Z [
internal 
static 
void 
ValidateDimensions /
(/ 0
byte0 4
[4 5
]5 6

imageBytes7 A
)A B
{ 	
int 

imageWidth 
= 
$num 
; 
int 
imageHeight 
= 
$num 
;  
if 
( 
HasPngHeader 
( 

imageBytes '
)' (
)( )
{ 

imageWidth 
=  
ReadBigEndianInteger 1
(1 2

imageBytes2 <
,< =
$num> @
)@ A
;A B
imageHeight 
=  
ReadBigEndianInteger 2
(2 3

imageBytes3 =
,= >
$num? A
)A B
;B C
} 
else 
{ 
ReadJpegDimensions "
(" #

imageBytes# -
,- .
out/ 2

imageWidth3 =
,= >
out? B
imageHeightC N
)N O
;O P
} 
ValidatePixelBudget 
(  

imageWidth  *
,* +
imageHeight, 7
)7 8
;8 9
} 	
private 
static 
bool 
HasPngHeader (
(( )
byte) -
[- .
]. /

imageBytes0 :
): ;
{ 	
return 

imageBytes 
. 
Length $
>=% '
$num( *
&&+ -

imageBytes. 8
.8 9
Take9 =
(= >
$num> ?
)? @
.@ A
SequenceEqualA N
(N O
_pngSignatureO \
)\ ]
&&^ `
Encoding   
.   
ASCII   
.   
	GetString   (
(  ( )

imageBytes  ) 3
,  3 4
$num  5 7
,  7 8
$num  9 :
)  : ;
==  < >
$str  ? E
;  E F
}!! 	
private## 
static## 
void## 
ValidatePixelBudget## /
(##/ 0
int##0 3

imageWidth##4 >
,##> ?
int##@ C
imageHeight##D O
)##O P
{$$ 	
bool%% 
isWithinBudget%% 
=%%  !

imageWidth%%" ,
>%%- .
$num%%/ 0
&&%%1 3
imageHeight%%4 ?
>%%@ A
$num%%B C
&&%%D F

imageWidth&& 
<=&& 
ProfileImageLimits&& 0
.&&0 1"
MaximumSourceDimension&&1 G
&&&&H J
imageHeight'' 
<='' 
ProfileImageLimits'' 1
.''1 2"
MaximumSourceDimension''2 H
&&''I K
((( 
long(( 
)(( 

imageWidth((  
*((! "
imageHeight((# .
<=((/ 1
ProfileImageLimits((2 D
.((D E
MaximumPixelCount((E V
;((V W
if)) 
()) 
!)) 
isWithinBudget)) 
)))  
{** 
throw++ 
new++ !
ProfileImageException++ /
(++/ 0$
ProfileImageFailureCodes++0 H
.++H I#
ImageDimensionsExceeded++I `
)++` a
;++a b
},, 
}-- 	
private// 
static// 
void// 
ReadJpegDimensions// .
(//. /
byte/// 3
[//3 4
]//4 5

imageBytes//6 @
,//@ A
out//B E
int//F I

imageWidth//J T
,//T U
out//V Y
int//Z ]
imageHeight//^ i
)//i j
{00 	

imageWidth11 
=11 
$num11 
;11 
imageHeight22 
=22 
$num22 
;22 
if33 
(33 

imageBytes33 
.33 
Length33 !
<33" #
$num33$ %
||33& (

imageBytes33) 3
[333 4
$num334 5
]335 6
!=337 9
$num33: =
||33> @

imageBytes33A K
[33K L
$num33L M
]33M N
!=33O Q
$num33R U
)33U V
{44 
throw55 
new55 !
ProfileImageException55 /
(55/ 0$
ProfileImageFailureCodes550 H
.55H I
InvalidImageFormat55I [
)55[ \
;55\ ]
}66 
int77 
segmentPosition77 
=77  !
$num77" #
;77# $
while88 
(88 
segmentPosition88 "
+88# $
$num88% &
<88' (

imageBytes88) 3
.883 4
Length884 :
&&88; =

imageWidth88> H
==88I K
$num88L M
)88M N
{99 
int:: 
segmentMarker:: !
=::" #
ReadJpegMarker::$ 2
(::2 3

imageBytes::3 =
,::= >
ref::? B
segmentPosition::C R
)::R S
;::S T
int;; 
segmentLength;; !
=;;" #
ReadSegmentLength;;$ 5
(;;5 6

imageBytes;;6 @
,;;@ A
segmentPosition;;B Q
);;Q R
;;;R S
bool<< 
hasDimensions<< "
=<<# $
segmentMarker<<% 2
==<<3 5
$num<<6 9
||<<: <
segmentMarker<<= J
==<<K M
$num<<N Q
||<<R T
segmentMarker<<U b
==<<c e
$num<<f i
;<<i j
if== 
(== 
hasDimensions== !
&&==" $
segmentLength==% 2
>===3 5
$num==6 7
)==7 8
{>> 
imageHeight?? 
=??  !

imageBytes??" ,
[??, -
segmentPosition??- <
+??= >
$num??? @
]??@ A
*??B C
$num??D G
+??H I

imageBytes??J T
[??T U
segmentPosition??U d
+??e f
$num??g h
]??h i
;??i j

imageWidth@@ 
=@@  

imageBytes@@! +
[@@+ ,
segmentPosition@@, ;
+@@< =
$num@@> ?
]@@? @
*@@A B
$num@@C F
+@@G H

imageBytes@@I S
[@@S T
segmentPosition@@T c
+@@d e
$num@@f g
]@@g h
;@@h i
}AA 
segmentPositionBB 
+=BB  "
segmentLengthBB# 0
;BB0 1
}CC 
}DD 	
privateFF 
staticFF 
intFF 
ReadJpegMarkerFF )
(FF) *
byteFF* .
[FF. /
]FF/ 0

imageBytesFF1 ;
,FF; <
refFF= @
intFFA D
segmentPositionFFE T
)FFT U
{GG 	
ifHH 
(HH 

imageBytesHH 
[HH 
segmentPositionHH *
++HH* ,
]HH, -
!=HH. 0
$numHH1 4
)HH4 5
{II 
throwJJ 
newJJ !
ProfileImageExceptionJJ /
(JJ/ 0$
ProfileImageFailureCodesJJ0 H
.JJH I
InvalidImageFormatJJI [
)JJ[ \
;JJ\ ]
}KK 
whileLL 
(LL 
segmentPositionLL "
<LL# $

imageBytesLL% /
.LL/ 0
LengthLL0 6
&&LL7 9

imageBytesLL: D
[LLD E
segmentPositionLLE T
]LLT U
==LLV X
$numLLY \
)LL\ ]
{MM 
segmentPositionNN 
++NN !
;NN! "
}OO 
ifPP 
(PP 
segmentPositionPP 
+PP  !
$numPP" #
>=PP$ &

imageBytesPP' 1
.PP1 2
LengthPP2 8
)PP8 9
{QQ 
throwRR 
newRR !
ProfileImageExceptionRR /
(RR/ 0$
ProfileImageFailureCodesRR0 H
.RRH I
InvalidImageFormatRRI [
)RR[ \
;RR\ ]
}SS 
returnTT 

imageBytesTT 
[TT 
segmentPositionTT -
++TT- /
]TT/ 0
;TT0 1
}UU 	
privateWW 
staticWW 
intWW 
ReadSegmentLengthWW ,
(WW, -
byteWW- 1
[WW1 2
]WW2 3

imageBytesWW4 >
,WW> ?
intWW@ C
segmentPositionWWD S
)WWS T
{XX 	
intYY 
segmentLengthYY 
=YY 

imageBytesYY  *
[YY* +
segmentPositionYY+ :
]YY: ;
*YY< =
$numYY> A
+YYB C

imageBytesYYD N
[YYN O
segmentPositionYYO ^
+YY_ `
$numYYa b
]YYb c
;YYc d
ifZZ 
(ZZ 
segmentLengthZZ 
<ZZ 
$numZZ  !
||ZZ" $
segmentLengthZZ% 2
>ZZ3 4

imageBytesZZ5 ?
.ZZ? @
LengthZZ@ F
-ZZG H
segmentPositionZZI X
)ZZX Y
{[[ 
throw\\ 
new\\ !
ProfileImageException\\ /
(\\/ 0$
ProfileImageFailureCodes\\0 H
.\\H I
InvalidImageFormat\\I [
)\\[ \
;\\\ ]
}]] 
return^^ 
segmentLength^^  
;^^  !
}__ 	
privateaa 
staticaa 
intaa  
ReadBigEndianIntegeraa /
(aa/ 0
byteaa0 4
[aa4 5
]aa5 6
bytesaa7 <
,aa< =
intaa> A
positionaaB J
)aaJ K
{bb 	
returncc 
(cc 
bytescc 
[cc 
positioncc "
]cc" #
<<cc$ &
$numcc' )
)cc) *
|cc+ ,
(cc- .
bytescc. 3
[cc3 4
positioncc4 <
+cc= >
$numcc? @
]cc@ A
<<ccB D
$numccE G
)ccG H
|ccI J
(dd 
bytesdd 
[dd 
positiondd 
+dd  !
$numdd" #
]dd# $
<<dd% '
$numdd( )
)dd) *
|dd+ ,
bytesdd- 2
[dd2 3
positiondd3 ;
+dd< =
$numdd> ?
]dd? @
;dd@ A
}ee 	
}ff 
}gg ŽJ
lC:\Users\oscar\source\repos\TrickTakingMissions\Server\Infrastructure.ProfileImages\ProfileImageProcessor.cs
	namespace 	
Infrastructure
 
. 
ProfileImages &
{ 
public 

sealed 
class !
ProfileImageProcessor -
:. /"
IProfileImageProcessor0 F
{ 
public 
byte 
[ 
] !
NormalizeProfileImage +
(+ ,
byte, 0
[0 1
]1 2%
selectedProfileImageBytes3 L
)L M
{ 	
if 
( %
selectedProfileImageBytes )
==* ,
null- 1
||2 4%
selectedProfileImageBytes5 N
.N O
LengthO U
==V X
$numY Z
||[ ]%
selectedProfileImageBytes )
.) *
Length* 0
>1 2
ProfileImageLimits3 E
.E F
MaximumUploadBytesF X
)X Y
{ 
throw 
new !
ProfileImageException /
(/ 0$
ProfileImageFailureCodes0 H
.H I
ImageSizeExceededI Z
)Z [
;[ \
} 
ProfileImageHeader 
. 
ValidateDimensions 1
(1 2%
selectedProfileImageBytes2 K
)K L
;L M
byte 
[ 
] 
normalizedImage "
;" #
try 
{ 
using 
( 
var 
sourceStream '
=( )
new* -
MemoryStream. :
(: ;%
selectedProfileImageBytes; T
,T U
falseV [
)[ \
)\ ]
using 
( 
Image 
sourceImage (
=) *
Image+ 0
.0 1

FromStream1 ;
(; <
sourceStream< H
,H I
trueJ N
,N O
trueP T
)T U
)U V
{  
ApplyExifOrientation   (
(  ( )
sourceImage  ) 4
)  4 5
;  5 6
normalizedImage!! #
=!!$ %!
EncodeNormalizedImage!!& ;
(!!; <
sourceImage!!< G
)!!G H
;!!H I
}"" 
}## 
catch$$ 
($$ 
ArgumentException$$ $
ex$$% '
)$$' (
{%% 
throw&& 
new&& !
ProfileImageException&& /
(&&/ 0$
ProfileImageFailureCodes&&0 H
.&&H I
InvalidImageFormat&&I [
,&&[ \
ex&&] _
)&&_ `
;&&` a
}'' 
catch(( 
((( 
ExternalException(( $
ex((% '
)((' (
{)) 
throw** 
new** !
ProfileImageException** /
(**/ 0$
ProfileImageFailureCodes**0 H
.**H I
InvalidImageFormat**I [
,**[ \
ex**] _
)**_ `
;**` a
}++ 
return,, 
normalizedImage,, "
;,," #
}-- 	
private// 
static// 
byte// 
[// 
]// !
EncodeNormalizedImage// 3
(//3 4
Image//4 9
sourceImage//: E
)//E F
{00 	
int11 

outputSize11 
=11 
ProfileImageLimits11 /
.11/ 0
OutputPixelSize110 ?
;11? @
byte22 
[22 
]22 
normalizedImage22 "
;22" #
using33 
(33 
var33 
targetImage33 "
=33# $
new33% (
Bitmap33) /
(33/ 0

outputSize330 :
,33: ;

outputSize33< F
,33F G
PixelFormat33H S
.33S T
Format32bppArgb33T c
)33c d
)33d e
using44 
(44 
Graphics44 
graphics44 $
=44% &
Graphics44' /
.44/ 0
	FromImage440 9
(449 :
targetImage44: E
)44E F
)44F G
using55 
(55 
var55 
targetStream55 #
=55$ %
new55& )
MemoryStream55* 6
(556 7
)557 8
)558 9
{66 
graphics77 
.77 
Clear77 
(77 
Color77 $
.77$ %
Transparent77% 0
)770 1
;771 2
graphics88 
.88 
InterpolationMode88 *
=88+ ,
InterpolationMode88- >
.88> ?
HighQualityBicubic88? Q
;88Q R
float99 

imageScale99  
=99! "
Math99# '
.99' (
Min99( +
(99+ ,
(99, -
float99- 2
)992 3

outputSize993 =
/99> ?
sourceImage99@ K
.99K L
Width99L Q
,99Q R
(:: 
float:: 
):: 

outputSize:: %
/::& '
sourceImage::( 3
.::3 4
Height::4 :
)::: ;
;::; <
float;; 

imageWidth;;  
=;;! "
sourceImage;;# .
.;;. /
Width;;/ 4
*;;5 6

imageScale;;7 A
;;;A B
float<< 
imageHeight<< !
=<<" #
sourceImage<<$ /
.<</ 0
Height<<0 6
*<<7 8

imageScale<<9 C
;<<C D
graphics== 
.== 
	DrawImage== "
(==" #
sourceImage==# .
,==. /
(==0 1

outputSize==1 ;
-==< =

imageWidth==> H
)==H I
/==J K
$num==L M
,==M N
(==O P

outputSize==P Z
-==[ \
imageHeight==] h
)==h i
/==j k
$num==l m
,==m n

imageWidth>> 
,>> 
imageHeight>>  +
)>>+ ,
;>>, -
targetImage?? 
.?? 
Save??  
(??  !
targetStream??! -
,??- .
ImageFormat??/ :
.??: ;
Png??; >
)??> ?
;??? @
normalizedImage@@ 
=@@  !
targetStream@@" .
.@@. /
ToArray@@/ 6
(@@6 7
)@@7 8
;@@8 9
}AA 
ifBB 
(BB 
normalizedImageBB 
.BB  
LengthBB  &
>BB' (
ProfileImageLimitsBB) ;
.BB; <#
MaximumStoredImageBytesBB< S
)BBS T
{CC 
throwDD 
newDD !
ProfileImageExceptionDD /
(DD/ 0$
ProfileImageFailureCodesDD0 H
.DDH I
ImageSizeExceededDDI Z
)DDZ [
;DD[ \
}EE 
returnFF 
normalizedImageFF "
;FF" #
}GG 	
privateII 
staticII 
voidII  
ApplyExifOrientationII 0
(II0 1
ImageII1 6
sourceImageII7 B
)IIB C
{JJ 	
constKK 
intKK !
orientationPropertyIdKK +
=KK, -
$numKK. 1
;KK1 2
ifLL 
(LL 
ArrayLL 
.LL 
IndexOfLL 
(LL 
sourceImageLL )
.LL) *
PropertyIdListLL* 8
,LL8 9!
orientationPropertyIdLL: O
)LLO P
>=LLQ S
$numLLT U
)LLU V
{MM 
byteNN 
[NN 
]NN 
orientationBytesNN '
=NN( )
sourceImageNN* 5
.NN5 6
GetPropertyItemNN6 E
(NNE F!
orientationPropertyIdNNF [
)NN[ \
.NN\ ]
ValueNN] b
;NNb c
intOO 
orientationOO 
=OO  !
orientationBytesOO" 2
.OO2 3
LengthOO3 9
>OO: ;
$numOO< =
?OO> ?
orientationBytesOO@ P
[OOP Q
$numOOQ R
]OOR S
:OOT U
$numOOV W
;OOW X
RotateFlipTypePP 
[PP 
]PP  
orientationsPP! -
=PP. /
{QQ 
RotateFlipTypeRR "
.RR" #
RotateNoneFlipNoneRR# 5
,RR5 6
RotateFlipTypeRR7 E
.RRE F
RotateNoneFlipNoneRRF X
,RRX Y
RotateFlipTypeSS "
.SS" #
RotateNoneFlipXSS# 2
,SS2 3
RotateFlipTypeSS4 B
.SSB C
Rotate180FlipNoneSSC T
,SST U
RotateFlipTypeTT "
.TT" #
Rotate180FlipXTT# 1
,TT1 2
RotateFlipTypeTT3 A
.TTA B
Rotate90FlipXTTB O
,TTO P
RotateFlipTypeUU "
.UU" #
Rotate90FlipNoneUU# 3
,UU3 4
RotateFlipTypeUU5 C
.UUC D
Rotate270FlipXUUD R
,UUR S
RotateFlipTypeVV "
.VV" #
Rotate270FlipNoneVV# 4
}WW 
;WW 
ifXX 
(XX 
orientationXX 
>XX  !
$numXX" #
&&XX$ &
orientationXX' 2
<XX3 4
orientationsXX5 A
.XXA B
LengthXXB H
)XXH I
{YY 
sourceImageZZ 
.ZZ  

RotateFlipZZ  *
(ZZ* +
orientationsZZ+ 7
[ZZ7 8
orientationZZ8 C
]ZZC D
)ZZD E
;ZZE F
}[[ 
}\\ 
}]] 	
}^^ 
}__ ý>
nC:\Users\oscar\source\repos\TrickTakingMissions\Server\Infrastructure.ProfileImages\FileProfileImageStorage.cs
	namespace 	
Infrastructure
 
. 
ProfileImages &
{		 
public 

sealed 
class #
FileProfileImageStorage /
:0 1 
IProfileImageStorage2 F
{ 
private 
readonly 
string '
_profileImagesDirectoryPath  ;
;; <
private 
readonly 
ILoggerService '
_logger( /
;/ 0
public #
FileProfileImageStorage &
(& '
string' -&
profileImagesDirectoryPath. H
,H I
ILoggerServiceJ X
loggerY _
)_ `
{ 	'
_profileImagesDirectoryPath '
=( )
Path* .
.. /
GetFullPath/ :
(: ;&
profileImagesDirectoryPath; U
)U V
;V W
_logger 
= 
logger 
; 
} 	
public 
void 
SaveProfileImage $
($ %
Guid% )
profileImageId* 8
,8 9
byte: >
[> ?
]? @'
normalizedProfileImageBytesA \
)\ ]
{ 	
	Directory 
. 
CreateDirectory %
(% &'
_profileImagesDirectoryPath& A
)A B
;B C
string 
	imagePath 
= 
GetImagePath +
(+ ,
profileImageId, :
): ;
;; <
string 
pendingImagePath #
=$ %
	imagePath& /
+0 1
$str2 <
;< =
try 
{ 
using 
( 
var 
imageStream &
=' (
new) ,

FileStream- 7
(7 8
pendingImagePath8 H
,H I
FileModeJ R
.R S
	CreateNewS \
,\ ]

FileAccess   
.   
Write   $
,  $ %
	FileShare  & /
.  / 0
None  0 4
)  4 5
)  5 6
{!! 
imageStream"" 
.""  
Write""  %
(""% &'
normalizedProfileImageBytes""& A
,""A B
$num""C D
,""D E'
normalizedProfileImageBytes""F a
.""a b
Length""b h
)""h i
;""i j
imageStream## 
.##  
Flush##  %
(##% &
true##& *
)##* +
;##+ ,
}$$ 
File%% 
.%% 
Move%% 
(%% 
pendingImagePath%% *
,%%* +
	imagePath%%, 5
)%%5 6
;%%6 7
}&& 
finally'' 
{(( 
DeleteFileIfPresent)) #
())# $
pendingImagePath))$ 4
)))4 5
;))5 6
}** 
}++ 	
public-- 
byte-- 
[-- 
]-- 
ReadProfileImage-- &
(--& '
Guid--' +
profileImageId--, :
)--: ;
{.. 	
string// 
	imagePath// 
=// 
GetImagePath// +
(//+ ,
profileImageId//, :
)//: ;
;//; <
var00 
	imageFile00 
=00 
new00 
FileInfo00  (
(00( )
	imagePath00) 2
)002 3
;003 4
if11 
(11 
!11 
	imageFile11 
.11 
Exists11 !
)11! "
{22 
throw33 
new33 !
ProfileImageException33 /
(33/ 0$
ProfileImageFailureCodes330 H
.33H I
ImageNotFound33I V
)33V W
;33W X
}44 
if55 
(55 
	imageFile55 
.55 
Length55  
>55! "
ProfileImageLimits55# 5
.555 6#
MaximumStoredImageBytes556 M
)55M N
{66 
throw77 
new77 !
ProfileImageException77 /
(77/ 0$
ProfileImageFailureCodes770 H
.77H I
InvalidStoredImage77I [
)77[ \
;77\ ]
}88 
byte99 
[99 
]99 

imageBytes99 
;99 
using:: 
(:: 
var:: 
imageStream:: "
=::# $
new::% (

FileStream::) 3
(::3 4
	imagePath::4 =
,::= >
FileMode::? G
.::G H
Open::H L
,::L M

FileAccess::N X
.::X Y
Read::Y ]
,::] ^
	FileShare::_ h
.::h i
Read::i m
)::m n
)::n o
using;; 
(;; 
var;; 
imageReader;; "
=;;# $
new;;% (
BinaryReader;;) 5
(;;5 6
imageStream;;6 A
);;A B
);;B C
{<< 

imageBytes== 
=== 
imageReader== (
.==( )
	ReadBytes==) 2
(==2 3
ProfileImageLimits==3 E
.==E F#
MaximumStoredImageBytes==F ]
+==^ _
$num==` a
)==a b
;==b c
if>> 
(>> 

imageBytes>> 
.>> 
Length>> %
>>>& '
ProfileImageLimits>>( :
.>>: ;#
MaximumStoredImageBytes>>; R
)>>R S
{?? 
throw@@ 
new@@ !
ProfileImageException@@ 3
(@@3 4$
ProfileImageFailureCodes@@4 L
.@@L M
InvalidStoredImage@@M _
)@@_ `
;@@` a
}AA 
}BB 
returnCC 

imageBytesCC 
;CC 
}DD 	
publicFF 
voidFF 
DeleteProfileImageFF &
(FF& '
GuidFF' +
profileImageIdFF, :
)FF: ;
{GG 	
ifHH 
(HH 
profileImageIdHH 
!=HH !
GuidHH" &
.HH& '
EmptyHH' ,
)HH, -
{II 
DeleteFileIfPresentJJ #
(JJ# $
GetImagePathJJ$ 0
(JJ0 1
profileImageIdJJ1 ?
)JJ? @
)JJ@ A
;JJA B
}KK 
}LL 	
privateNN 
voidNN 
DeleteFileIfPresentNN (
(NN( )
stringNN) /
	imagePathNN0 9
)NN9 :
{OO 	
tryPP 
{QQ 
FileRR 
.RR 
DeleteRR 
(RR 
	imagePathRR %
)RR% &
;RR& '
}SS 
catchTT 
(TT 
IOExceptionTT 
exTT !
)TT! "
{UU 
_loggerVV 
.VV 
ErrorVV 
(VV 
exVV  
,VV  !
$strVV" Q
,VVQ R
PathVVS W
.VVW X
GetFileNameVVX c
(VVc d
	imagePathVVd m
)VVm n
)VVn o
;VVo p
}WW 
catchXX 
(XX '
UnauthorizedAccessExceptionXX .
exXX/ 1
)XX1 2
{YY 
_loggerZZ 
.ZZ 
ErrorZZ 
(ZZ 
exZZ  
,ZZ  !
$strZZ" U
,ZZU V
Path[[ 
.[[ 
GetFileName[[ $
([[$ %
	imagePath[[% .
)[[. /
)[[/ 0
;[[0 1
}\\ 
}]] 	
private__ 
string__ 
GetImagePath__ #
(__# $
Guid__$ (
profileImageId__) 7
)__7 8
{`` 	
returnaa 
Pathaa 
.aa 
Combineaa 
(aa  '
_profileImagesDirectoryPathaa  ;
,aa; <
$straa= N
+aaO P
profileImageIdaaQ _
.aa_ `
ToStringaa` h
(aah i
$straai l
)aal m
+aan o
$straap v
)aav w
;aaw x
}bb 	
}cc 
}dd 