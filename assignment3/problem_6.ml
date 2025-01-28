type shape =
| Circle of float
| Rectangle of float * float;;

let area s = match s with
| Circle radius -> 3.14 *. radius *. radius
| Rectangle (width,height) -> width *. height;;
(*input ->  let c = Circle 10.0 in area c;;*)
(*output -> - : float = 314. *)