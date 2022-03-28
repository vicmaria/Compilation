(** This is the same abstract syntax tree as in [LMJ.mli] but without position informations.
    After typechecking, we don't need to give feedbacks to the user. *)

type identifier = string

type expression =
  | EConst of constant
  | EGetVar of identifier
  | EUnOp of unop * expression
  | EBinOp of binop * expression * expression
  | EMethodCall of expression * identifier * expression list
  | EArrayGet of expression * expression
  | EArrayAlloc of expression
  | EArrayLength of expression
  | EArrayCharGet of expression * expression
  | EArrayCharAlloc of expression
  | EArrayCharLength of expression
  | EThis
  | EObjectAlloc of identifier

and constant = LMJ.constant =
  | ConstBool of bool
  | ConstInt of int32
  | ConstFloat of float
  | ConstChar of char

and binop = LMJ.binop =
  | OpAdd
  | OpSub
  | OpMul
  | OpDiv
  | OpMod
  | OpLt
  | OpGt
  | OpAnd
  | OpEq

and unop = LMJ.unop = UOpNot

and instruction =
  | IBlock of instruction list
  | IIf of expression * instruction * instruction
  | IIf2 of expression * instruction
  | IWhile of expression * instruction
  | ISyso of expression
  | ISetVar of identifier * expression
  | IArraySet of identifier * expression * expression

and typ =
  | TypInt
  | TypFloat
  | TypChar
  | TypBool
  | TypIntArray
  | TypCharArray
  | Typ of identifier

and metho = {
    formals: (identifier * typ) list;
    result: typ;
    locals: (identifier * typ) list;
    body: instruction list;
    return: expression
  }

and clas = {
    extends: identifier option;
    attributes: (identifier * typ) list;
    methods: (identifier * metho) list
  }

and program = {
    name: identifier;
    defs: (identifier * clas) list;
    main_args: identifier;
    main: instruction
  }
