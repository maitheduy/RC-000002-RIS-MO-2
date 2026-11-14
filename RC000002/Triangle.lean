import Mathlib.Topology.MetricSpace.HausdorffDistance
import Mathlib.Topology.Instances.Real.Lemmas
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Ring
import Mathlib.Tactic.FinCases

/-! RC-000002-RIS-MO. All coordinates are real, not floating point.
The product metric used for the uniqueness argument is the sup metric.
Euclidean contraction is independently certified by a squared-distance bound. -/
noncomputable section
namespace RC000002
open Set Metric
abbrev Point := ℝ × ℝ

def triangle : Set Point := {z | 0 ≤ z.1 ∧ z.1 ≤ -z.2 ∧ -z.2 ≤ 1}
def f1 (z : Point) : Point := (-(z.1 + z.2)/2, z.2/2)
def f2 (z : Point) : Point := (-(z.1 + z.2)/2, z.2/2-1/2)
def f3 (z : Point) : Point := (-(z.1 + z.2)/2+1/2, z.2/2-1/2)
def f4 (z : Point) : Point := ((z.1 + z.2)/2+1/2, -z.2/2-1)
def F (i : Fin 4) (z : Point) : Point :=
  if i.val = 0 then f1 z else if i.val = 1 then f2 z else if i.val = 2 then f3 z else f4 z

def invariant (K : Set Point) : Prop :=
  ∀ z, z ∈ K ↔ ∃ i : Fin 4, ∃ w ∈ K, F i w = z

theorem maps_into (i : Fin 4) {z : Point} (hz : z ∈ triangle) :
    F i z ∈ triangle := by
  rcases hz with ⟨h1,h2,h3⟩
  fin_cases i <;> norm_num [F, f1, f2, f3, f4, triangle] <;>
    refine ⟨?_, ?_, ?_⟩ <;> linarith

theorem triangle_invariant : invariant triangle := by
  intro z
  constructor
  · rintro ⟨h1,h2,h3⟩
    by_cases hy : -(1:ℝ)/2 ≤ z.2
    · refine ⟨0, (-2*z.1-2*z.2, 2*z.2), ?_, ?_⟩
      · change 0 ≤ -2*z.1-2*z.2 ∧ -2*z.1-2*z.2 ≤ -(2*z.2) ∧ -(2*z.2) ≤ 1
        refine ⟨?_, ?_, ?_⟩ <;> linarith
      · change f1 (-2*z.1-2*z.2, 2*z.2) = z
        ext <;> dsimp only [f1] <;> ring
    · by_cases hx : z.1 ≤ (1:ℝ)/2
      · by_cases hs : z.1+z.2 ≤ -(1:ℝ)/2
        · refine ⟨1, (-2*z.1-2*z.2-1, 2*z.2+1), ?_, ?_⟩
          · change 0 ≤ -2*z.1-2*z.2-1 ∧ -2*z.1-2*z.2-1 ≤ -(2*z.2+1) ∧ -(2*z.2+1) ≤ 1
            refine ⟨?_, ?_, ?_⟩ <;> linarith
          · change f2 (-2*z.1-2*z.2-1, 2*z.2+1) = z
            ext <;> dsimp only [f2] <;> ring
        · refine ⟨3, (2*z.1+2*z.2+1, -2*z.2-2), ?_, ?_⟩
          · change 0 ≤ 2*z.1+2*z.2+1 ∧ 2*z.1+2*z.2+1 ≤ -(-2*z.2-2) ∧ -(-2*z.2-2) ≤ 1
            refine ⟨?_, ?_, ?_⟩ <;> linarith
          · change f4 (2*z.1+2*z.2+1, -2*z.2-2) = z
            ext <;> dsimp only [f4] <;> ring
      · refine ⟨2, (-2*z.1-2*z.2, 2*z.2+1), ?_, ?_⟩
        · change 0 ≤ -2*z.1-2*z.2 ∧ -2*z.1-2*z.2 ≤ -(2*z.2+1) ∧ -(2*z.2+1) ≤ 1
          refine ⟨?_, ?_, ?_⟩ <;> linarith
        · change f3 (-2*z.1-2*z.2, 2*z.2+1) = z
          ext <;> dsimp only [f3] <;> ring
  · rintro ⟨i,w,hw,rfl⟩
    exact maps_into i hw

theorem set_equation : triangle =
    f1 '' triangle ∪ f2 '' triangle ∪ f3 '' triangle ∪ f4 '' triangle := by
  ext z
  rw [triangle_invariant z]
  simp only [mem_union, mem_image]
  constructor
  · rintro ⟨i,w,hw,he⟩
    fin_cases i <;> simp [F] at he
    · exact Or.inl (Or.inl (Or.inl ⟨w,hw,he⟩))
    · exact Or.inl (Or.inl (Or.inr ⟨w,hw,he⟩))
    · exact Or.inl (Or.inr ⟨w,hw,he⟩)
    · exact Or.inr ⟨w,hw,he⟩
  · rintro (((⟨w,hw,he⟩ | ⟨w,hw,he⟩) | ⟨w,hw,he⟩) | ⟨w,hw,he⟩)
    · exact ⟨0,w,hw,he⟩
    · exact ⟨1,w,hw,he⟩
    · exact ⟨2,w,hw,he⟩
    · exact ⟨3,w,hw,he⟩

def sqDist (u v : Point) : ℝ := (u.1-v.1)^2+(u.2-v.2)^2

theorem euclidean_contraction_squared (i : Fin 4) (u v : Point) :
    sqDist (F i u) (F i v) ≤ (3:ℝ)/4 * sqDist u v := by
  fin_cases i <;> simp [F,f1,f2,f3,f4,sqDist] <;>
    nlinarith [sq_nonneg ((u.1-v.1)-(u.2-v.2)), sq_nonneg (u.1-v.1)]

def sgn (i : Fin 4) : ℝ := if i.val = 3 then -1 else 1

theorem abs_sgn (i : Fin 4) : |sgn i| = 1 := by
  fin_cases i <;> norm_num [sgn]

theorem two_step_difference (i j : Fin 4) (u v : Point) :
    (F i (F j u)).1 - (F i (F j v)).1 = sgn i * sgn j * ((u.1-v.1)/4) ∧
    (F i (F j u)).2 - (F i (F j v)).2 = sgn i * sgn j * ((u.2-v.2)/4) := by
  fin_cases i <;> fin_cases j <;> norm_num [F,f1,f2,f3,f4,sgn] <;>
    constructor <;> ring

theorem two_step_contraction (i j : Fin 4) (u v : Point) :
    dist (F i (F j u)) (F i (F j v)) ≤ (1:ℝ)/4 * dist u v := by
  rcases two_step_difference i j u v with ⟨hx,hy⟩
  simp only [Prod.dist_eq, Real.dist_eq, hx, hy, abs_mul, abs_sgn]
  rw [abs_div, abs_div]
  norm_num
  constructor <;> nlinarith [le_max_left |u.1-v.1| |u.2-v.2|,
    le_max_right |u.1-v.1| |u.2-v.2|]

theorem triangle_nonempty : triangle.Nonempty := by
  exact ⟨(0,0), by norm_num [triangle]⟩

theorem triangle_compact : IsCompact triangle := by
  have hc : IsClosed triangle := by
    exact (isClosed_le continuous_const continuous_fst).inter
      ((isClosed_le continuous_fst continuous_snd.neg).inter
        (isClosed_le continuous_snd.neg continuous_const))
  apply (isCompact_Icc : IsCompact (Icc ((-1:ℝ),(-1:ℝ)) (1,1))).of_isClosed_subset hc
  rintro z ⟨h1,h2,h3⟩
  change ((-1:ℝ) ≤ z.1 ∧ (-1:ℝ) ≤ z.2) ∧ (z.1 ≤ 1 ∧ z.2 ≤ 1)
  constructor <;> constructor <;> linarith

/-- A compact-set uniqueness argument for arbitrary indexed strict contractions. -/
theorem compact_invariant_unique {X I : Type*} [MetricSpace X]
    (g : I → X → X) (q : ℝ) (hq0 : 0 ≤ q) (hq1 : q < 1)
    (hg : ∀ i x y, dist (g i x) (g i y) ≤ q * dist x y)
    {K S : Set X} (hK : IsCompact K) (hS : IsCompact S)
    (nK : K.Nonempty) (nS : S.Nonempty)
    (invK : ∀ z, z ∈ K ↔ ∃ i, ∃ w ∈ K, g i w = z)
    (invS : ∀ z, z ∈ S ↔ ∃ i, ∃ w ∈ S, g i w = z) : K = S := by
  have fin := hausdorffEdist_ne_top_of_nonempty_of_bounded nK nS hK.isBounded hS.isBounded
  have fins := hausdorffEdist_ne_top_of_nonempty_of_bounded nS nK hS.isBounded hK.isBounded
  have directed : ∀ (A B : Set X), IsCompact B → B.Nonempty →
      (∀ z, z ∈ A ↔ ∃ i, ∃ w ∈ A, g i w = z) →
      (∀ z, z ∈ B ↔ ∃ i, ∃ w ∈ B, g i w = z) →
      EMetric.hausdorffEdist A B ≠ ⊤ →
      ∀ x ∈ A, ∃ y ∈ B, dist x y ≤ q * hausdorffDist A B := by
    intro A B hc hn ia ib hf x hx
    rcases (ia x).mp hx with ⟨i,w,hw,rfl⟩
    rcases hc.exists_infDist_eq_dist hn w with ⟨v,hv,hd⟩
    refine ⟨g i v, (ib _).mpr ⟨i,v,hv,rfl⟩, ?_⟩
    calc
      dist (g i w) (g i v) ≤ q * dist w v := hg i w v
      _ = q * infDist w B := by rw [hd]
      _ ≤ q * hausdorffDist A B := mul_le_mul_of_nonneg_left
        (infDist_le_hausdorffDist_of_mem hw hf) hq0
  have hb : hausdorffDist K S ≤ q * hausdorffDist K S := by
    apply hausdorffDist_le_of_mem_dist (mul_nonneg hq0 hausdorffDist_nonneg)
    · exact directed K S hS nS invK invS fin
    · simpa only [hausdorffDist_comm] using directed S K hK nK invS invK fins
  apply (hK.isClosed.hausdorffDist_zero_iff_eq hS.isClosed fin).mp
  have hn : 0 ≤ hausdorffDist K S := hausdorffDist_nonneg
  nlinarith

theorem invariant_twice {K : Set Point} (h : invariant K) :
    ∀ z, z ∈ K ↔ ∃ ij : Fin 4 × Fin 4, ∃ w ∈ K, F ij.1 (F ij.2 w) = z := by
  intro z
  constructor
  · intro hz
    rcases (h z).mp hz with ⟨i,v,hv,rfl⟩
    rcases (h v).mp hv with ⟨j,w,hw,rfl⟩
    exact ⟨(i,j),w,hw,rfl⟩
  · rintro ⟨⟨i,j⟩,w,hw,rfl⟩
    exact (h _).mpr ⟨i,F j w,(h _).mpr ⟨j,w,hw,rfl⟩,rfl⟩

/-- Main RC claim: exactly one nonempty compact invariant set, namely triangle. -/
theorem unique_compact_attractor :
    IsCompact triangle ∧ triangle.Nonempty ∧ invariant triangle ∧
    ∀ K : Set Point, IsCompact K → K.Nonempty → invariant K → K = triangle := by
  refine ⟨triangle_compact, triangle_nonempty, triangle_invariant, ?_⟩
  intro K hK nK invK
  exact compact_invariant_unique (fun ij : Fin 4 × Fin 4 => fun z => F ij.1 (F ij.2 z))
    (1/4) (by norm_num) (by norm_num)
    (fun ij => two_step_contraction ij.1 ij.2) hK triangle_compact nK triangle_nonempty
    (invariant_twice invK) (invariant_twice triangle_invariant)

#print axioms RC000002.unique_compact_attractor
#print axioms RC000002.euclidean_contraction_squared
end RC000002
