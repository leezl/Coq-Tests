type unit0 =
| Tt

val negb : bool -> bool

type 'a option =
| Some of 'a
| None

type ('a, 'b) prod =
| Pair of 'a * 'b

type 'a list =
| Nil
| Cons of 'a * 'a list

val app : 'a1 list -> 'a1 list -> 'a1 list

val plus : int -> int -> int

val mult : int -> int -> int

val minus : int -> int -> int

type positive =
| XI of positive
| XO of positive
| XH

val psucc : positive -> positive

val pplus : positive -> positive -> positive

val pplus_carry : positive -> positive -> positive

val pmult_nat : positive -> int -> int

val nat_of_P : positive -> int

val pmult : positive -> positive -> positive

type n =
| N0
| Npos of positive

val nplus : n -> n -> n

val nmult : n -> n -> n

val beq_nat : int -> int -> bool

val nat_of_N : n -> int

val rev : 'a1 list -> 'a1 list

val map : ('a1 -> 'a2) -> 'a1 list -> 'a2 list

val fold_left : ('a1 -> 'a2 -> 'a1) -> 'a2 list -> 'a1 -> 'a1

val fold_right : ('a2 -> 'a1 -> 'a1) -> 'a1 -> 'a2 list -> 'a1

val forallb : ('a1 -> bool) -> 'a1 list -> bool

val n_of_digits : bool list -> n

val n_of_ascii : char -> n

val nat_of_ascii : char -> int

type string =
| EmptyString
| String of char * string

val string_dec : string -> string -> bool

val append : string -> string -> string

val ble_nat : int -> int -> bool

type id =
  int
  (* singleton inductive, whose constructor was Id *)

val beq_id : id -> id -> bool

type state = id -> int

val empty_state : state

val update : state -> id -> int -> state

type aexp =
| ANum of int
| AId of id
| APlus of aexp * aexp
| AMinus of aexp * aexp
| AMult of aexp * aexp

type bexp =
| BTrue
| BFalse
| BEq of aexp * aexp
| BLe of aexp * aexp
| BNot of bexp
| BAnd of bexp * bexp

val aeval : state -> aexp -> int

val beval : state -> bexp -> bool

type com =
| CSkip
| CAss of id * aexp
| CSeq of com * com
| CIf of bexp * com * com
| CWhile of bexp * com

val ceval_step : state -> com -> int -> state option

val isWhite : char -> bool

val isLowerAlpha : char -> bool

val isAlpha : char -> bool

val isDigit : char -> bool

type chartype =
| White
| Alpha
| Digit
| Other

val classifyChar : char -> chartype

val list_of_string : string -> char list

val string_of_list : char list -> string

type token = string

val tokenize_helper : chartype -> char list -> char list -> char list list

val tokenize : string -> string list

type 'x optionE =
| SomeE of 'x
| NoneE of string

val build_symtable : token list -> int -> token -> int

type 't parser0 = token list -> ('t, token list) prod optionE

val many_helper :
  'a1 parser0 -> 'a1 list -> int -> token list -> ('a1 list, token list) prod
  optionE

val many : 'a1 parser0 -> int -> 'a1 list parser0

val firstExpect : token -> 'a1 parser0 -> 'a1 parser0

val expect : token -> unit0 parser0

val parseIdentifier :
  (string -> int) -> token list -> (id, token list) prod optionE

val parseNumber : token list -> (int, token list) prod optionE

val parsePrimaryExp :
  int -> (string -> int) -> token list -> (aexp, token list) prod optionE

val parseProductExp :
  int -> (string -> int) -> token list -> (aexp, token list) prod optionE

val parseSumExp :
  int -> (string -> int) -> token list -> (aexp, token list) prod optionE

val parseAExp :
  int -> (string -> int) -> token list -> (aexp, token list) prod optionE

val parseAtomicExp :
  int -> (string -> int) -> token list -> (bexp, token list) prod optionE

val parseConjunctionExp :
  int -> (string -> int) -> token list -> (bexp, token list) prod optionE

val parseBExp :
  int -> (string -> int) -> token list -> (bexp, token list) prod optionE

val parseSimpleCommand :
  int -> (string -> int) -> token list -> (com, token list) prod optionE

val parseSequencedCommand :
  int -> (string -> int) -> token list -> (com, token list) prod optionE

val bignumber : int

val parse : string -> (com, token list) prod optionE

