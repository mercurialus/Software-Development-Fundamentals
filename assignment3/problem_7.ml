exception NotFound of int * int

let rec solution predicate lst =
  let rec length lst = match lst with | [] -> 0 | h::t -> 1 + length t in
  let len = length lst in
  match lst with
  | [] -> raise (NotFound(0,len))
  | h::t ->
   if predicate h then 0
  else try 1 + solution predicate t with
  | NotFound (idx,_) -> raise (NotFound(idx+1,len));;