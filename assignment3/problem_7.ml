exception NotFound of int

let rec solution predicate lst =
  let rec length lst = match lst with | [] -> 0 | h::t -> 1 + length t in
  let len = length lst in
  match lst with
  | [] -> raise (NotFound(len))
  | h::t ->
   if predicate h then 0
  else try 1 + solution predicate t with
  | NotFound (idx) -> raise (NotFound(idx+1));;

(*input -> let pred  x = x mod 3 = 0
            solution pred ([1;2;4;5;7;8;9])*)
(*output -> 6*) 