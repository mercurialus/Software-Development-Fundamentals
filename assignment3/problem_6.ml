type shape =
| Circle of float
| Rectangle of float * float;;

let solution s = match s with
| Circle radius -> 3.14 *. radius *. radius
| Rectangle (width,height) -> width *. height;;
(*input ->  let c = Circle 10.0 in solution c;;*)
(*output -> - : float = 314. *)