let solution_option a b = 
  match b with
  | 0 -> None
  | _ -> Some(a/b);;

let solution_try_with a b = try Some(a / b)
with
| Division_by_zero -> None ;;
(*Input -> solution_try_with 4 0;;*)
(*Output -> int option = None *)