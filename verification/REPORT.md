# Báo cáo kiểm chứng RC-000002-RIS-MO

Ngày kiểm chứng: 14/11/2026. Phạm vi: kiểm chứng cục bộ bằng Lean, chưa phải phản biện độc lập.

## Kết quả

**PASSED_LEAN_GATE** cho các định lý liệt kê dưới đây.

- `lake build`: exit code **0**, `Build completed successfully.`
- `lake env lean RC000002/Triangle.lean`: exit code **0**.
- `python3 scripts/audit.py`: exit code **0**.
- Lean **4.19.0**, release commit **6caaee842e94**.
- Mathlib **c44e0c8ee63ca166450922a373c7409c5d26b00b**.

## Nội dung được chứng nhận

1. Tam giác được định nghĩa chính xác bằng `0 ≤ x ∧ x ≤ -y ∧ -y ≤ 1`.
2. Bốn ánh xạ đúng theo công thức tọa độ của tác giả; số hữu tỉ trong các công thức được hiểu là số thực chính xác.
3. `set_equation`: hợp bốn ảnh bằng tam giác.
4. `euclidean_contraction_squared`: với mỗi ánh xạ, khoảng cách Euclid bình phương sau ánh xạ không vượt quá `3/4` khoảng cách Euclid bình phương ban đầu.
5. `two_step_difference`: mọi hợp hai ánh xạ có sai khác tọa độ bằng ± một phần tư sai khác đầu vào.
6. `two_step_contraction`: hệ hai bước co với hệ số `1/4` theo metric sup của `ℝ × ℝ`.
7. Tam giác là compact và khác rỗng.
8. `unique_compact_attractor`: bất kỳ tập compact khác rỗng nào thỏa phương trình bất biến của cùng hệ đều bằng tam giác.

Chứng minh tính duy nhất được xây dựng trong chính mã nguồn từ các bổ đề khoảng cách Hausdorff của mathlib; không giả định kết luận attractor hoặc thêm định lý Hutchinson như một tiên đề riêng.

## Kiểm toán tiên đề

Kết quả `#print axioms` cho hai định lý trọng tâm chỉ liệt kê:

```text
[propext, Classical.choice, Quot.sound]
```

Đây là các tiên đề nền tảng thông thường dùng trong Lean/mathlib. Không có `sorryAx`, tiên đề tự khai báo để giả định claim, `native_decide` hoặc cơ chế `implemented_by` trong mã RC. Không nên diễn giải kết quả này thành “không dùng bất kỳ tiên đề nào”.

## Phân biệt metric

`Point = ℝ × ℝ` có metric tích mặc định là metric sup. `sqDist` được định nghĩa riêng bằng tổng hai bình phương sai khác tọa độ, chính là khoảng cách Euclid bình phương. Phần tính duy nhất dùng metric sup; phần tính co một bước dùng `sqDist`. Hai metric có cùng topology trên mặt phẳng, nên phát biểu compact và phương trình tập hợp mô tả đúng cùng đối tượng hình học.

## Phần chưa được Lean chứng nhận

- Tính không chồng nội thất: đã có chứng minh barycentric trong `docs/name.tex`, chưa nằm trong định lý Lean.
- Giá trị tối ưu `(1+sqrt(5))/4` của chuẩn ma trận: nằm trong bản chứng minh viết; Lean chứng nhận một chặn đủ mạnh hơn là `sqrt(3)/2` thông qua bất đẳng thức bình phương.
- Hội tụ Hausdorff từ mọi tập compact ban đầu: không được hình thức hóa riêng. Định lý Lean chính chứng minh tính bất biến và duy nhất của tập compact khác rỗng.
- Tính mới của kết quả, khả năng chấp nhận công bố, một lớp tiling toàn mặt phẳng mới hoặc tính phi tuần hoàn.
- Khi kiểm chứng cục bộ ban đầu, GitHub Actions chưa được chạy. Kết quả CI công khai bổ sung được ghi ở cuối báo cáo.

## Tái kiểm tra và bằng chứng

Xem các lệnh trong README. Các tệp log kèm theo là `build.log`, `lean-check.log`, `source-audit.log`, `toolchain.log`. `SHA256SUMS` ở thư mục gốc gắn hồ sơ với mã nguồn và tài liệu cụ thể; mã kiểm tra chỉ xác nhận toàn vẹn nội dung, không thay cho chạy Lean.

Không có bước công bố GitHub hoặc Zenodo nào được thực hiện trong phiên này.

## Cập nhật phiên bản 0.2.0

Bổ sung Open Challenge tiếng Anh về IFS hai ánh xạ cho phép chia simplex được chỉ định. Mã Lean giữ nguyên từng byte so với phiên bản 0.1.0 đã kiểm chứng. Trạng thái PASSED_LEAN_GATE chỉ áp dụng cho các định lý đã nêu, không áp dụng cho các câu hỏi trong OPEN_CHALLENGE.md.

## Công bố GitHub

Kho công khai: https://github.com/maitheduy/RC-000002-RIS-MO-2. Đã khôi phục cấu trúc thư mục để các đường dẫn Lean, LaTeX và kiểm toán khớp cấu hình. Kết quả kiểm chứng cục bộ ở trên giữ nguyên; trạng thái chạy CI trên GitHub được theo dõi riêng.

## GitHub Actions: kiểm chứng thành công

Run #1 (43606518846) trên commit `1a5879b484a44835765a99c4e7c2ff7da358d34e` kết thúc với `success`. Bước Build and audit đã chạy thành công `lake build`, kiểm tra Lean trực tiếp và `scripts/audit.py`.

Kết quả: https://github.com/maitheduy/RC-000002-RIS-MO-2/actions/runs/43606518846
