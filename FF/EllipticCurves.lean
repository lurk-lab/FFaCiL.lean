import FF.NewField

/-- Curves with Weierstrass form satisfying the equation `y² = x³ + a x + b` -/
class Curve (K : Type _) (F : outParam (Type _)) [PrimeField F] where
  /-- `a` coefficient -/
  a : F
  /-- `b` coefficient -/
  b : F
  /-- Curve order -/
  order : Nat
  /-- Curve cofactor -/
  cofactor : Nat
  /-- Curve characteristic -/
  characteristic : Nat
  /- More here -/

class EdwardsCurve (C : Type _) (F : Type _) [PrimeField F] extends Curve C F where
  edwardsForm : F × F × F

namespace Curve

/-- `y² = x³ + a x + b ↦ (a, b)`   -/
def weierstrassForm (C : Type _) [PrimeField F] [Curve C F] : F × F := 
  (Curve.a C, Curve.b C) 

def jacobianForm (C : Type _) [PrimeField F] [Curve C F] : F × F := sorry 

end Curve

structure AffinePoint (F : Type _) [PrimeField F] where
  x : F
  y : F
  isInfty : Bool

structure ProjectivePoint (F : Type _) [PrimeField F] where
  x : F
  y : F
  z : F

/--
`CurvePoint` provides algebraic operations on elliptic curve points and related constants
-/
class CurvePoint {F : Type _} (C : Type _) (K : Type _) [PrimeField F] [Curve C F] where
  /-- The neutral element of the Abelian group of points. -/
  zero : K
  /-- The base point. -/
  base : K
  /-- `inv` inverses a given point. -/
  inv : K → K
  /-- Point addition. -/
  add : K → K → K
  /-- `double : p ↦ 2 ⬝ p` -/
  double : K → K := fun x => add x x 
  /-- Number-point multiplication. -/
  smul : Nat → K → K
  /-- `toPoint` form a point from prime field elements whenever it is possible -/
  toPoint : F → F → Option K
  /-- Frobenius endomorphism -/
  frobenius : F → F
  

def infinity [PrimeField F] : ProjectivePoint F :=
  ProjectivePoint.mk 0 1 0

def ProjectivePoint.isInfinity {F : Type _} [PrimeField F] : ProjectivePoint F → Bool
  | c => c.z == 0

-- P₁ : AffinePoint, P₂ : ProjectivePoint ==> P₁ + P₂
-- (x, y) : AffinePoint => (x, y, 1) : ProjectivePoint
-- (x, y, z) : ProjectivePoint => (x/z, y/z) : AffinePoint
-- If z ≠ 0
-- If z = 0

instance {F} [PrimeField F] [Curve C F] : CurvePoint C (AffinePoint F) where
  base := sorry
  zero := sorry
  inv := sorry
  add := fun ⟨x, y, i⟩ ⟨u, v, j⟩ => 
    match i, j with
    | true, true => sorry
    | true, false => sorry
    | false, true => sorry
    | false, false => sorry
  double := fun ⟨x, y, i⟩ =>
    let lambda := ((3 : Nat) * x^2 + Curve.a C) / (2 : Nat) * y
    let x' := lambda^2 - (2 : Nat)*x
    let y' := lambda * (x - x') - y
    ⟨x', y', i⟩
  smul := sorry
  toPoint := sorry
  frobenius := sorry

instance {F} [PrimeField F] [Curve C F] : CurvePoint C (ProjectivePoint F) where
  zero := sorry
  base := sorry
  inv := sorry
  add := sorry
  smul := sorry
  toPoint := sorry
  frobenius := sorry
  double := sorry

-- class CurveGroup (C : Type _) {F : outParam (Type _)} [PrimeField F] [Curve C F] where
  -- zero {K : Type _} [CurvePoint C K] : K
  -- gen {K : Type _} [CurvePoint C K] : K
  -- inv {K : Type _} [CurvePoint C K] : K → K
  -- double {K : Type _} [CurvePoint C K] : K → K
  -- add {K L M : Type _} [CurvePoint C K] [CurvePoint C L] [CurvePoint C M] : K → L → M