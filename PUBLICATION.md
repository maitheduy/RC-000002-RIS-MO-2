# Thông tin gợi ý khi công bố

**Tên kho:** RC-000002-RIS-MO  
**Tiêu đề:** RC-000002-RIS-MO: Four-map affine IFS with a solid triangular attractor  
**Tác giả:** S.S. Duymt / maitheduy — F-Group  
**Phiên bản:** 0.2.0

## Mô tả

Đơn vị Research Capital này trình bày một xây dựng IFS affine gồm bốn ánh xạ có attractor là tam giác đặc OAB, với O=(0,0), A=(1,-1), B=(0,-1). Bản ghi bao gồm chứng minh viết, mã Lean 4 và hồ sơ kiểm chứng có thể chạy lại. Lean chứng nhận phương trình hợp bốn ảnh, tính compact và không rỗng, ước lượng co Euclid bình phương và tính duy nhất của tập compact khác rỗng bất biến. Tính duy nhất được chứng minh bằng phép hợp hai bước và khoảng cách Hausdorff. Không tuyên bố một phép chia trung điểm mới hoặc một lớp tiling toàn mặt phẳng mới.

## Khi tải lên

- GitHub: tải các tệp bên trong thư mục RC lên gốc kho. Giữ `README.md`, `info.yaml`, mã Lean, lockfile và thư mục `verification` cùng nhau. Thư mục `.github` chứa workflow; cần giữ cả thư mục này nếu muốn chạy CI.
- Zenodo: có thể dùng loại tài nguyên Software cho gói mã kiểm chứng, hoặc chọn loại khác phù hợp với bản ghi nghiên cứu mà tác giả muốn công bố. Không giả định DOI đã được cấp.
- Quyền sử dụng: tác giả cần tự xác định giấy phép phù hợp trước khi cấp quyền tái sử dụng. Gói hiện tại không tự áp đặt một giấy phép lên công trình của tác giả.
- Tham chiếu RC-000001 như tiền thân về cách đóng gói. Không đánh dấu là giải quyết thách thức tứ diện của RC-000001.
- Sau khi nhận URL/DOI thực tế, cập nhật README, info.yaml và CITATION.cff; không dùng URL/DOI giả định.

Trạng thái: mã nguồn và hồ sơ kiểm chứng cục bộ được công bố tại https://github.com/maitheduy/RC-000002-RIS-MO-2. Chưa công bố trên Zenodo; chưa có DOI.

## Open Challenge added in version 0.2.0

The full English challenge is in OPEN_CHALLENGE.md and README.md. Metadata is provided as info.yaml and the identical requested alias infor.yaml. The challenge is not part of the Lean-verified seed claim.
