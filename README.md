# RC-000002-RIS-MO

**Four-map affine IFS with a solid triangular attractor**  
**Hệ IFS affine bốn thành phần có attractor là tam giác đặc**

Author / đề xuất toán học: **S.S. Duymt / maitheduy**, F-Group.  
RC identifier: **RC-000002-RIS-MO** (the final character is the letter **O**, as requested).  
Prepared: **2026-11-14**. Version: **0.1.0**.

**Verification: PASSED_LEAN_GATE — local build and direct Lean check succeeded.**

## Core claim

Let

\[
T=\operatorname{conv}\{(0,0),(1,-1),(0,-1)\}
 =\{(x,y):0\le x\le -y\le1\},\qquad
L=\begin{pmatrix}-1/2&-1/2\\0&1/2\end{pmatrix}.
\]

Define

\[
\begin{aligned}
f_1(z)&=Lz,&f_2(z)&=Lz+(0,-1/2),\\
f_3(z)&=Lz+(1/2,-1/2),&f_4(z)&=-Lz+(1/2,-1).
\end{aligned}
\]

Then **T is the unique nonempty compact invariant set of this IFS**:

\[
T=f_1(T)\cup f_2(T)\cup f_3(T)\cup f_4(T).
\]

Each map is a strict Euclidean contraction. This RC records a concrete, reusable construction and proof; it does **not** claim a new class of plane tilings.

## Construction and mathematical proof

Take the midpoints

\[
M=(1/2,-1/2),\quad P=(1/2,-1),\quad Q=(0,-1/2).
\]

The ordered affine frame rule sends `(O,A,B)` to `(O,Q,M)`. It determines `L` by mapping the two source edge columns to their target columns. Translate the first image downward and diagonally to obtain the second and third maps; use central inversion and translation by `OP` for the fourth.

| Map | Images of `(O,A,B)` | Image triangle |
|---|---|---|
| f₁ | `(O,Q,M)` | OQM |
| f₂ | `(Q,B,P)` | QBP |
| f₃ | `(M,P,A)` | MPA |
| f₄ | `(P,M,Q)` | PMQ |

The midpoint construction covers T and the image interiors are disjoint. A detailed barycentric proof appears in `docs/name.tex`.

The exact Euclidean operator norm is `(1+sqrt(5))/4 < 1`. The Lean proof uses the simpler sufficient bound

\[
\|f_i(u)-f_i(v)\|_2^2\le\tfrac34\|u-v\|_2^2,
\]

so `sqrt(3)/2 < 1` is also a valid contraction factor. The bound is deliberately not asserted to be optimal.

For uniqueness, `L² = I/4`. Hence every two-step composition has linear part `+I/4` or `-I/4`, and is a contraction of factor `1/4` in the product sup metric. The formal proof shows that the Hausdorff distance `h` between any two nonempty compact invariant sets satisfies `h ≤ h/4`, whence `h=0` and the sets coincide. This proves uniqueness without adding Hutchinson's theorem as an unproved axiom.

## Formalization

Main source: `RC000002/Triangle.lean`. Entry point: `RC000002.lean`.

| Lean theorem | Meaning |
|---|---|
| `triangle_invariant` | Exact real-coordinate membership equivalence for the invariant set |
| `set_equation` | Four-image set union equals T |
| `euclidean_contraction_squared` | Certified squared Euclidean contraction bound |
| `two_step_difference` | Two-step differences are ± one quarter of the input difference |
| `two_step_contraction` | Two-step contraction in the sup metric |
| `triangle_compact`, `triangle_nonempty` | The candidate set is compact and nonempty |
| `compact_invariant_unique` | Reusable compact-set uniqueness lemma using Hausdorff distance |
| `unique_compact_attractor` | T is invariant and every nonempty compact invariant set equals T |

`Point = ℝ × ℝ` has Lean's product **sup metric**. The function `sqDist` is explicitly the squared **Euclidean** distance. They are kept distinct. Compactness is unaffected because these metrics induce the same topology on the plane. The Euclidean Lipschitz bound follows from the displayed squared inequality in ordinary mathematics; the exact optimal singular-value calculation belongs to the accompanying written proof.

The main formal theorem identifies the unique compact fixed set. It does not separately formalize Hausdorff convergence of arbitrary initial compact sets. That convergence also follows from the classical contractive-IFS theorem cited below.

## Reproduce

Install elan / Lean, unzip or clone this directory, and run:

```bash
lake exe cache get Mathlib.Topology.MetricSpace.HausdorffDistance Mathlib.Topology.Instances.Real.Lemmas Mathlib.Tactic.Linarith Mathlib.Tactic.NormNum Mathlib.Tactic.Ring Mathlib.Tactic.FinCases
lake build
lake env lean RC000002/Triangle.lean
python3 scripts/audit.py
```

Lean: **4.19.0**. Mathlib is pinned to commit **c44e0c8ee63ca166450922a373c7409c5d26b00b** (`v4.19.0`). `lake-manifest.json` records transitive dependencies. The source ends with `#print axioms` commands. Verification outputs and their meaning are documented in `verification/REPORT.md`.

A GitHub Actions workflow is provided. It has not been run on GitHub merely by being included in this archive; local verification and hosted CI are different records.

## Scope, provenance, and lineage

- The coordinates, vertex ordering, and four-map construction were proposed by Dr.rer.nat Duymt in the research session of 14 November 2026.
- Proof development and packaging were assisted by ChatGPT. This is not an independent human peer review.
- The layout follows the author-supplied example [RC-000001-RIS-M0](https://github.com/maitheduy/RC-000001-RIS-M0), inspected at commit `fd65d2cbbb059dcb852e3e7632e4cbf5b87ad53e`.
- RC-000001 is a **format / conceptual predecessor**, not a mathematical dependency of this proof. This RC does not resolve its tetrahedron challenge.
- Novelty is **not established**. Medial subdivision is classical; relevant affine triangular IFS constructions already appear in Barnsley–Vince.
- Disjointness of interiors is proved in the written note; consult the formal theorem inventory for exactly what has been machine-checked.
- No DOI, public repository URL for this RC, license grant, or independent review is claimed. Publication and licensing remain with the author.

## Open challenge

Starting from this verified triangular seed, determine which deformations of the maps and/or vertex assignments preserve exact covering and produce genuinely different hierarchical or plane tilings. For each proposal, distinguish invariant-set geometry from address dynamics, prove the required covering and non-overlap properties, and compare with the literature before claiming novelty.

## References

1. J. E. Hutchinson, *Fractals and Self Similarity*, Indiana University Mathematics Journal **30**(5), 713–747 (1981). DOI: [10.1512/iumj.1981.30.30055](https://doi.org/10.1512/iumj.1981.30.30055).
2. M. Barnsley and A. Vince, *Fractal Tilings from Iterated Function Systems*, Discrete & Computational Geometry **51**(3), 729–752 (2014), especially Example 3.14. DOI: [10.1007/s00454-014-9589-2](https://doi.org/10.1007/s00454-014-9589-2).
3. F. Brunck, *Iterated Medial Triangle Subdivision in Surfaces of Constant Curvature*, Discrete & Computational Geometry **70**, 1059–1089 (2023). DOI: [10.1007/s00454-023-00500-5](https://doi.org/10.1007/s00454-023-00500-5).
4. M. S. Floater, *Generalized Barycentric Coordinates and Applications*, Acta Numerica **24**, 161–214 (2015). DOI: [10.1017/S0962492914000129](https://doi.org/10.1017/S0962492914000129).
5. S.S. Duymt, *Research Capital: Từ một viên gạch đến một hệ sinh thái tiến hóa của tri thức* (2026), [author-supplied Zenodo record](https://zenodo.org/records/24117869).

Full BibTeX entries and the supplied LaTeX style are included under `docs/`.
