let solution a b = try Some(a / b)
with
| Division_by_zero -> None ;;
(*Input -> safe_div 4 0;;*)
(*Output -> int option = None *)