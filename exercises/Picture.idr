module Picture

public export
data Shape = ||| A triangle, with its base length and height
             Triangle Double Double
           | ||| A rectangle, with its length and height
              Rectangle Double Double
           | ||| A circle, with its radius
             Circle Double

public export
area : Shape -> Double
area (Triangle base height) = 0.5 * base * height
area (Rectangle length height) = length * height
area (Circle radius) = pi * radius * radius

public export
data Picture = Primitive Shape
             | Combine Picture Picture
             | Rotate Double Picture
             | Translate Double Double Picture

public export
rectangle : Picture
rectangle = Primitive (Rectangle 20 10)

public export
circle : Picture
circle = Primitive (Circle 5)

public export
triangle : Picture
triangle = Primitive (Triangle 10 10)

public export
testPicture : Picture
testPicture = Combine (Translate 5 5 rectangle)
              (Combine (Translate 35 5 circle)
              (Translate 15 25 triangle))

public export
pictureArea : Picture -> Double
pictureArea (Primitive shape) = area shape
pictureArea (Combine pic pic1) = pictureArea pic + pictureArea pic1
pictureArea (Rotate x pic) = pictureArea pic
pictureArea (Translate x y pic) = pictureArea pic
