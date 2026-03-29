# VNCultureBridge AI

**Web giới thiệu và giải thích phong tục, văn hoá Việt Nam cho người nước ngoài**


## 1. Tổng quan đề tài

**VNCultureBridge AI** là hệ thống web được xây dựng nhằm giới thiệu, giải thích và hỗ trợ tra cứu tri thức văn hoá Việt Nam cho người nước ngoài theo hình thức trực quan, song ngữ và có tích hợp AI.

Khác với các website văn hoá thông thường chỉ hiển thị nội dung tĩnh, hệ thống này hướng đến việc:

- Tổ chức tri thức văn hoá Việt Nam theo cấu trúc rõ ràng
- Hỗ trợ người dùng khám phá nội dung theo vùng miền, dân tộc và chủ đề
- Cho phép AI giải thích nội dung văn hoá theo ngữ cảnh câu hỏi
- điều hướng người dùng tới bài viết hoặc chủ đề phù hợp
- bảo đảm phản hồi AI bám sát dữ liệu đã được kiểm duyệt

Hệ thống **không sử dụng RAG** hoặc **vector database**. Thay vào đó, AI hoạt động dựa trên:

- prompt template được thiết kế theo từng loại câu hỏi
- dữ liệu bài viết đã được kiểm duyệt
- metadata nội dung
- ngữ cảnh người dùng đang xem
- từ khoá, danh mục, vùng miền, dân tộc
- luật nghiệp vụ dùng để giới hạn phản hồi AI

Cách tiếp cận này giúp hệ thống:

- dễ triển khai hơn
- dễ kiểm soát phản hồi AI hơn
- giảm độ phức tạp kỹ thuật
- phù hợp với phạm vi đề tài ứng dụng web văn hoá



## 2. Bối cảnh và tính cấp thiết

Trong bối cảnh toàn cầu hoá và hội nhập quốc tế ngày càng sâu rộng, nhu cầu tìm hiểu về văn hoá Việt Nam của người nước ngoài đang tăng lên rõ rệt. Đối tượng quan tâm không chỉ bao gồm khách du lịch mà còn có:

- sinh viên quốc tế
- giảng viên, nhà nghiên cứu
- người lao động nước ngoài
- cộng đồng Việt kiều
- người yêu thích văn hoá châu Á

Những người này không chỉ cần biết **Việt Nam có gì**, mà còn muốn hiểu **vì sao người Việt lại có những phong tục, tập quán, tín ngưỡng và cách ứng xử như vậy**.

Tuy nhiên, phần lớn các website hiện nay mới chỉ dừng lại ở việc:

- giới thiệu điểm đến hoặc thông tin du lịch
- mô tả văn hoá ở mức khái quát
- trình bày nội dung phân tán, thiếu hệ thống
- chưa có cơ chế giải thích chiều sâu về ý nghĩa văn hoá
- chưa hỗ trợ tốt người dùng quốc tế về ngôn ngữ và ngữ cảnh tiếp nhận

Đặc biệt, nhiều phong tục, lễ hội, tín ngưỡng và biểu tượng văn hoá Việt Nam mang chiều sâu ngữ nghĩa, gắn với lịch sử, niềm tin cộng đồng và khác biệt vùng miền. Những yếu tố này rất khó truyền tải đầy đủ nếu chỉ bằng bài viết tĩnh hoặc bản dịch đơn thuần.

Bên cạnh đó, khi ứng dụng AI vào hệ thống văn hoá, nếu để mô hình trả lời tự do thì dễ xảy ra các vấn đề như:

- diễn giải sai lệch
- trả lời quá mức dữ liệu thực tế
- tạo ra thông tin thiếu căn cứ
- làm giảm độ tin cậy học thuật của hệ thống

Vì vậy, cần có một nền tảng vừa hỗ trợ tra cứu và học hỏi, vừa có cơ chế AI đủ linh hoạt để giải thích, nhưng vẫn đủ kiểm soát để bảo đảm tính chính xác và phù hợp văn hoá.



## 3. Bài toán nghiệp vụ

Bài toán nghiệp vụ cốt lõi của hệ thống là:

> Xây dựng một nền tảng web thông minh có khả năng số hoá, tổ chức, quản trị, tra cứu và giải thích tri thức văn hoá Việt Nam cho người dùng quốc tế theo hình thức trực quan, song ngữ và có hỗ trợ AI; trong đó AI đóng vai trò diễn giải, hướng dẫn và điều hướng người dùng tới nội dung phù hợp dựa trên prompt template, dữ liệu đã được kiểm duyệt và ngữ cảnh hiện có trong hệ thống.

Nói cách khác, hệ thống cần giải quyết đồng thời các nhu cầu sau:

- xây dựng kho tri thức văn hoá Việt Nam có cấu trúc, trực quan và song ngữ
- hỗ trợ người dùng khám phá, tra cứu và học hỏi theo vùng miền, dân tộc, chủ đề
- cho phép AI giải thích ngữ nghĩa văn hoá thay vì chỉ hiển thị thông tin tĩnh
- kiểm soát chất lượng phản hồi AI bằng prompt mẫu, luật nghiệp vụ và dữ liệu nội bộ
- điều hướng người dùng đến bài viết hoặc nội dung liên quan thay vì để AI trả lời tự do
- hỗ trợ quản trị viên cập nhật, kiểm duyệt và làm giàu nội dung tri thức liên tục



## 4. Tính mới của đề tài

So với các website giới thiệu văn hoá thông thường, đề tài có các điểm mới nổi bật:

- không chỉ cung cấp thông tin văn hoá dạng tĩnh mà còn hỗ trợ giải thích chiều sâu văn hoá theo ngữ cảnh câu hỏi
- kết hợp quản trị tri thức văn hoá với AI hỏi đáp song ngữ
- ứng dụng **Prompt Engineering** để định hướng phản hồi AI theo mục tiêu nghiệp vụ
- tổ chức nội dung theo nhiều lớp tri thức như vùng miền, dân tộc, chủ đề, từ khoá và bài viết liên quan
- hướng tới đối tượng người dùng quốc tế, do đó nhấn mạnh yếu tố quốc tế hoá nội dung và khả năng truyền đạt văn hoá xuyên ngôn ngữ
- giảm độ phức tạp kỹ thuật so với mô hình RAG, phù hợp hơn với đề tài web văn hoá quy mô vừa và dễ bảo trì

---

## 5. Mục tiêu hệ thống

### 5.1. Mục tiêu tổng quát

Xây dựng một nền tảng web thông minh có khả năng giới thiệu, giải thích và đề xuất nội dung văn hoá Việt Nam cho người nước ngoài theo hình thức trực quan, song ngữ và có hỗ trợ AI, qua đó giúp người dùng hiểu đúng, hiểu sâu và tiếp cận dễ dàng hơn với bản sắc văn hoá Việt Nam.

### 5.2. Mục tiêu cụ thể về nghiệp vụ

Hệ thống cần đạt được các mục tiêu cụ thể sau:

- số hoá và tổ chức dữ liệu văn hoá Việt Nam theo cấu trúc tri thức rõ ràng
- cung cấp giao diện khám phá văn hoá trực quan dựa trên bản đồ tương tác
- hỗ trợ người dùng tra cứu nội dung theo vùng miền, dân tộc, danh mục và từ khoá
- cung cấp nội dung song ngữ Việt - Anh một cách nhất quán
- tích hợp AI Chatbot có khả năng hỏi đáp tự nhiên và giải thích văn hoá theo ngữ cảnh
- bảo đảm phản hồi AI bám sát dữ liệu đã được kiểm duyệt và được kiểm soát bởi prompt
- cho phép gợi ý bài viết và chủ đề liên quan để mở rộng trải nghiệm khám phá
- hỗ trợ quản trị viên quản lý bài viết, media, danh mục, vùng miền, dân tộc và quy trình kiểm duyệt
- đồng bộ nội dung đã duyệt vào tầng hiển thị, dữ liệu AI và các mẫu prompt dùng trong hỏi đáp
- theo dõi thống kê truy cập, hành vi tra cứu và câu hỏi phổ biến để cải thiện hệ thống

### 5.3. Mục tiêu nghiên cứu

Bên cạnh mục tiêu ứng dụng, đề tài còn hướng đến các mục tiêu nghiên cứu sau:

- đề xuất mô hình hệ thống kết hợp quản trị tri thức văn hoá và hỏi đáp AI có kiểm soát
- xây dựng quy trình dùng prompt và ngữ cảnh dữ liệu để phục vụ giải thích văn hoá cho người dùng quốc tế
- đánh giá hiệu quả của mô hình về độ chính xác, tính dễ hiểu, tính hữu ích và trải nghiệm người dùng
- góp phần mở rộng hướng nghiên cứu ứng dụng AI trong lĩnh vực nhân văn số và bảo tồn văn hoá



## 6. Phạm vi và ranh giới hệ thống

### 6.1. Phạm vi chức năng

Hệ thống tập trung vào các chức năng sau:

- giới thiệu và giải thích văn hoá Việt Nam trên nền tảng web
- quản lý nội dung văn hoá thông qua hệ quản trị nội dung (CMS)
- hỗ trợ tra cứu, tìm kiếm và khám phá dữ liệu văn hoá
- hỗ trợ hỏi đáp AI có kiểm soát bằng dữ liệu nội bộ, prompt template và logic điều hướng nội dung
- cung cấp nội dung song ngữ Việt - Anh
- lưu trữ phản hồi người dùng và dữ liệu phục vụ cải tiến hệ thống

### 6.2. Đối tượng nội dung

Phạm vi nội dung văn hoá có thể bao gồm:

- lễ hội truyền thống
- tín ngưỡng và phong tục tập quán
- ẩm thực vùng miền
- trang phục truyền thống
- nghệ thuật dân gian
- kiến trúc truyền thống
- biểu tượng văn hoá
- các nhóm dân tộc và nét đặc trưng văn hoá

### 6.3. Những nội dung ngoài phạm vi

Để bảo đảm tính tập trung của đề tài, hệ thống không đặt mục tiêu giải quyết các bài toán sau:

- đặt tour du lịch
- thương mại điện tử hoặc thanh toán trực tuyến
- xây dựng mạng xã hội hoặc diễn đàn cộng đồng
- cung cấp tư vấn pháp lý, chính trị hoặc tôn giáo chuyên sâu
- cho phép người dùng khách chỉnh sửa trực tiếp nội dung tri thức
- cho phép AI trả lời hoàn toàn tự do ngoài phạm vi tri thức đã kiểm duyệt

### 6.4. Ranh giới trách nhiệm của AI

AI trong hệ thống chỉ đóng vai trò hỗ trợ:

- giải thích
- tổng hợp
- diễn đạt lại
- tóm tắt
- gợi ý nội dung liên quan
- điều hướng người dùng tới bài viết hoặc chủ đề phù hợp

AI không thay thế chuyên gia văn hoá, không được tự ý sáng tạo tri thức mới khi không có căn cứ dữ liệu, và không được trả lời vượt ra ngoài phạm vi nội dung đã được kiểm duyệt.



## 7. Đối tượng sử dụng và vai trò nghiệp vụ

Hệ thống gồm ba nhóm tác nhân chính.

### 7.1. Người dùng khách (Guest / End-user)

Đây là nhóm người dùng cuối của hệ thống, có thể là:

- người nước ngoài
- khách du lịch quốc tế
- sinh viên quốc tế
- giảng viên, nhà nghiên cứu
- người yêu thích văn hoá Việt Nam

#### Nhu cầu nghiệp vụ

- tra cứu và khám phá nội dung văn hoá theo vùng miền, dân tộc, chủ đề
- xem nội dung song ngữ Việt - Anh
- tìm kiếm nhanh các khái niệm văn hoá
- hỏi AI để được giải thích rõ hơn về ý nghĩa, nguồn gốc và bối cảnh văn hoá
- nhận gợi ý các bài viết liên quan để tiếp tục tìm hiểu
- gửi phản hồi đánh giá về nội dung và chất lượng trả lời của AI

### 7.2. Quản trị viên nội dung (Admin / Content Manager)

Đây là nhóm người chịu trách nhiệm vận hành kho tri thức của hệ thống.

#### Nhu cầu nghiệp vụ

- đăng nhập vào hệ quản trị
- thêm mới, sửa, xoá hoặc cập nhật bài viết văn hoá
- quản lý danh mục, vùng miền, dân tộc, thẻ và từ khoá
- quản lý ảnh, video và dữ liệu đa phương tiện
- kiểm duyệt nội dung trước khi công khai
- theo dõi dữ liệu thống kê truy cập và hành vi người dùng
- theo dõi lịch sử câu hỏi AI để phát hiện lỗ hổng tri thức
- cập nhật dữ liệu nguồn và mẫu prompt phục vụ AI

### 7.3. Dịch vụ AI (AI Service)

Đây là tác nhân xử lý nghiệp vụ nội bộ, không phải người dùng trực tiếp nhưng có vai trò đặc biệt quan trọng trong hệ thống.

#### Nhiệm vụ nghiệp vụ

- nhận câu hỏi từ người dùng
- phát hiện ngôn ngữ và phân tích ý định câu hỏi
- xác định ngữ cảnh nội dung liên quan từ kho tri thức hiện có
- lựa chọn prompt phù hợp với từng loại câu hỏi
- sinh phản hồi ngôn ngữ tự nhiên phù hợp với ngữ cảnh
- gợi ý các bài viết hoặc chủ đề liên quan
- ghi log lịch sử hỏi đáp, câu hỏi phổ biến và câu hỏi thiếu dữ liệu



## 8. Mô hình tri thức và các thực thể nghiệp vụ chính

Để hệ thống hoạt động hiệu quả, nội dung văn hoá cần được tổ chức theo mô hình tri thức có cấu trúc. Các thực thể nghiệp vụ chính bao gồm:

### 8.1. Bài viết văn hoá

Là đơn vị tri thức trung tâm của hệ thống, chứa các nội dung như:

- tiêu đề
- mô tả ngắn
- phần giới thiệu
- nguồn gốc
- ý nghĩa văn hoá
- bối cảnh sử dụng hoặc xuất hiện
- vùng miền hoặc dân tộc liên quan
- từ khoá
- ngôn ngữ
- trạng thái duyệt
- media đính kèm

### 8.2. Danh mục chủ đề

Dùng để phân loại bài viết theo các nhóm như:

- lễ hội
- tín ngưỡng
- phong tục
- ẩm thực
- trang phục
- nghệ thuật dân gian
- kiến trúc truyền thống

### 8.3. Vùng miền văn hoá

Dùng để định vị không gian văn hoá, ví dụ:

- miền Bắc
- miền Trung
- miền Nam
- Tây Nguyên
- đồng bằng sông Cửu Long

hoặc các không gian văn hoá đặc thù khác.

### 8.4. Dân tộc

Dùng để gắn bài viết với cộng đồng văn hoá cụ thể, đặc biệt hữu ích khi giới thiệu phong tục, lễ hội, trang phục và tín ngưỡng của các dân tộc Việt Nam.

### 8.5. Thẻ và từ khoá

Cho phép tăng khả năng liên kết giữa các bài viết, hỗ trợ tìm kiếm và đề xuất nội dung.

### 8.6. Media

Bao gồm:

- hình ảnh
- video
- âm thanh
- tư liệu minh hoạ

Media giúp tăng tính trực quan và hỗ trợ người dùng quốc tế hiểu sâu hơn về bối cảnh văn hoá.

### 8.7. Câu hỏi người dùng

Lưu vết các truy vấn hoặc câu hỏi gửi tới AI, phục vụ:

- thống kê chủ đề được quan tâm
- phát hiện nội dung còn thiếu
- cải thiện chất lượng phản hồi
- điều chỉnh prompt mẫu

### 8.8. Phản hồi đánh giá

Ghi nhận nhận xét của người dùng về:

- mức độ hữu ích của bài viết
- mức độ hữu ích của câu trả lời AI
- nội dung còn khó hiểu
- gợi ý cần bổ sung



## 9. Cách tiếp cận AI thay cho RAG

Hệ thống không sử dụng mô hình RAG. Thay vào đó, AI được thiết kế theo hướng đơn giản hơn nhưng vẫn có kiểm soát.

### 9.1. Nguyên tắc hoạt động

Quy trình cơ bản của AI gồm:

1. nhận câu hỏi từ người dùng  
2. xác định ngôn ngữ của câu hỏi  
3. phân tích ý định và chủ đề đang được hỏi  
4. xác định bài viết, danh mục, vùng miền, dân tộc hoặc nội dung liên quan từ hệ thống  
5. ghép dữ liệu đó vào prompt template phù hợp  
6. yêu cầu AI trả lời trong phạm vi dữ liệu đã có  
7. gợi ý nội dung liên quan hoặc hướng đọc tiếp nếu cần  

### 9.2. Nguồn ngữ cảnh cho AI

Ngữ cảnh cấp cho AI có thể đến từ:

- bài viết người dùng đang xem
- metadata của bài viết
- danh mục nội dung
- vùng miền hoặc dân tộc liên quan
- từ khoá nội dung
- bài viết liên quan đã được gắn sẵn
- dữ liệu tóm tắt do quản trị viên chuẩn bị

### 9.3. Vai trò của Prompt Engineering

Prompt được dùng để:

- định nghĩa vai trò của AI
- xác định phong cách trả lời
- giới hạn phạm vi trả lời
- yêu cầu AI giải thích dễ hiểu với người nước ngoài
- yêu cầu AI tôn trọng sắc thái văn hoá
- yêu cầu AI từ chối mềm nếu dữ liệu không đủ
- yêu cầu AI điều hướng người dùng tới nội dung liên quan

### 9.4. Lợi ích của cách tiếp cận này

- dễ triển khai hơn so với RAG
- giảm độ phức tạp kỹ thuật
- không cần vector database
- dễ kiểm soát hành vi AI hơn
- phù hợp với đề tài sinh viên hoặc hệ thống quy mô vừa
- dễ bảo trì, dễ cập nhật khi nội dung thay đổi



## 10. Danh sách nghiệp vụ chính của hệ thống

### 10.1. Nhóm nghiệp vụ dành cho người dùng khách

#### NV01. Truy cập và khám phá bản đồ văn hoá

Người dùng có thể truy cập giao diện bản đồ tương tác của hệ thống để khám phá văn hoá theo không gian địa lý. Tại đây, người dùng có thể chọn các khu vực văn hoá như Bắc - Trung - Nam hoặc những vùng văn hoá đặc thù để xem các chủ đề, bài viết, lễ hội, phong tục và nét đặc trưng liên quan.

**Mục đích nghiệp vụ:**

- tạo trải nghiệm khám phá trực quan và hấp dẫn
- giúp người dùng quốc tế tiếp cận văn hoá Việt Nam qua không gian địa lý cụ thể
- tăng khả năng nhận diện sự khác biệt văn hoá vùng miền

**Kết quả mong muốn:**

- hiển thị được nội dung văn hoá theo khu vực
- liên kết từ bản đồ tới bài viết chi tiết, media và chủ đề liên quan

#### NV02. Tra cứu nội dung văn hoá theo danh mục

Người dùng có thể duyệt các bài viết theo từng nhóm chủ đề như:

- lễ hội
- tín ngưỡng
- ẩm thực
- trang phục
- nghệ thuật dân gian
- phong tục tập quán
- kiến trúc truyền thống

**Mục đích nghiệp vụ:**

- hỗ trợ người dùng nhanh chóng tiếp cận đúng nhóm nội dung mong muốn
- giảm khó khăn khi người dùng chưa biết chính xác từ khoá cần tìm

**Kết quả mong muốn:**

- hệ thống hiển thị danh sách nội dung theo danh mục
- cho phép lọc tiếp theo vùng miền, dân tộc hoặc từ khoá liên quan

#### NV03. Tìm kiếm nội dung văn hoá

Người dùng nhập từ khoá để tìm kiếm các khái niệm, phong tục, món ăn, lễ hội hoặc biểu tượng văn hoá.

**Yêu cầu nghiệp vụ:**

- hỗ trợ tìm kiếm theo từ khoá thông thường
- hỗ trợ gợi ý từ khoá gần đúng theo ngữ nghĩa hoặc chủ đề
- hỗ trợ người dùng không thành thạo tiếng Việt
- ưu tiên hiển thị các kết quả đã được kiểm duyệt và có độ liên quan cao

**Kết quả mong muốn:**

- người dùng nhanh chóng tìm thấy nội dung phù hợp
- hạn chế tình trạng không tìm thấy do khác biệt ngôn ngữ hoặc cách diễn đạt

#### NV04. Chuyển đổi ngôn ngữ song ngữ Việt - Anh

Người dùng có thể chuyển đổi toàn bộ giao diện và nội dung giữa tiếng Việt và tiếng Anh một cách thuận tiện, nhất quán.

**Mục tiêu nghiệp vụ:**

- giúp người nước ngoài dễ dàng tiếp cận và hiểu nội dung
- bảo đảm trải nghiệm quốc tế hoá trên toàn hệ thống
- hạn chế việc người dùng phải dùng công cụ dịch bên ngoài dẫn tới sai lệch ngữ nghĩa

#### NV05. Xem chi tiết bài viết văn hoá

Người dùng có thể xem nội dung đầy đủ của một bài viết văn hoá, bao gồm:

- tên chủ đề
- giới thiệu
- nguồn gốc
- ý nghĩa văn hoá
- bối cảnh và phạm vi áp dụng
- vùng miền hoặc dân tộc liên quan
- hình ảnh hoặc video minh hoạ
- từ khoá liên quan
- bài viết gợi ý

**Mục tiêu nghiệp vụ:**

- cung cấp thông tin chính xác, có chiều sâu, dễ tiếp cận
- tăng giá trị học tập và nghiên cứu cho người dùng

#### NV06. Hỏi đáp với AI Chatbot

Người dùng có thể đặt câu hỏi bằng tiếng Việt hoặc tiếng Anh để hệ thống AI giải thích nội dung văn hoá, ví dụ:

- `Why do Vietnamese people celebrate Tet?`
- `What is the meaning of áo dài in Vietnamese culture?`
- `Lễ hội đâm trâu có ý nghĩa gì?`

**Mục tiêu nghiệp vụ:**

- trả lời rõ ràng, tự nhiên, dễ hiểu với người nước ngoài
- giải thích được ý nghĩa văn hoá thay vì chỉ dịch lại thuật ngữ
- tăng tính tương tác, cá nhân hoá và hỗ trợ học hỏi linh hoạt

#### NV07. Nhận gợi ý nội dung liên quan

Sau khi người dùng xem bài viết hoặc đặt câu hỏi cho AI, hệ thống đề xuất thêm:

- bài viết tương tự
- chủ đề liên quan
- không gian văn hoá gần gũi
- phong tục hoặc lễ hội có liên hệ

**Mục đích nghiệp vụ:**

- khuyến khích người dùng tiếp tục khám phá
- tăng chiều sâu trải nghiệm học tập
- mở rộng hiểu biết từ một chủ đề sang nhiều chủ đề liên quan

#### NV08. Gửi phản hồi hoặc đánh giá nội dung

Người dùng có thể phản hồi về:

- mức độ hữu ích của bài viết
- mức độ hữu ích của câu trả lời AI
- nội dung chưa rõ
- chủ đề còn thiếu

**Mục đích nghiệp vụ:**

- thu thập dữ liệu cải tiến hệ thống
- phát hiện các lỗ hổng trong kho tri thức
- nâng cao chất lượng nội dung và trải nghiệm người dùng

---

### 10.2. Nhóm nghiệp vụ dành cho AI Chatbot

#### NV09. Nhận diện ngôn ngữ câu hỏi

Hệ thống tự động xác định câu hỏi được nhập bằng tiếng Việt hay tiếng Anh để lựa chọn ngôn ngữ phản hồi phù hợp.

**Mục tiêu nghiệp vụ:**

- bảo đảm tính tự nhiên và thuận tiện cho người dùng
- hạn chế lỗi hiểu sai do xử lý sai ngôn ngữ

#### NV10. Phân tích ý định và ngữ cảnh câu hỏi

AI cần xác định loại nhu cầu mà người dùng đang yêu cầu, chẳng hạn:

- hỏi định nghĩa
- hỏi nguồn gốc
- hỏi ý nghĩa văn hoá
- hỏi so sánh vùng miền
- hỏi gợi ý chủ đề
- hỏi hướng dẫn tìm hiểu sâu hơn

**Mục tiêu nghiệp vụ:**

- tăng độ chính xác khi chọn ngữ cảnh trả lời
- tạo phản hồi phù hợp với mục đích của người dùng

#### NV11. Xác định ngữ cảnh dữ liệu từ kho nội dung

Trước khi sinh câu trả lời, AI cần xác định nội dung liên quan từ các nguồn nội bộ như:

- cơ sở dữ liệu bài viết
- metadata nội dung
- tóm tắt nội dung đã chuẩn hoá
- danh mục, thẻ, vùng miền, dân tộc
- bài viết liên quan đã gắn sẵn

**Mục tiêu nghiệp vụ:**

- bảo đảm AI trả lời dựa trên nguồn tri thức đã được kiểm duyệt
- tăng độ tin cậy và khả năng kiểm soát nội dung
- tránh để AI suy diễn ngoài nội dung thực tế

#### NV12. Áp dụng prompt template phù hợp

Sau khi xác định nội dung liên quan, hệ thống chọn prompt template phù hợp với loại câu hỏi. Ví dụ:

- prompt giải thích khái niệm
- prompt giải thích ý nghĩa văn hoá
- prompt so sánh vùng miền
- prompt gợi ý nội dung liên quan
- prompt từ chối mềm khi thiếu dữ liệu

**Yêu cầu nghiệp vụ:**

- prompt phải quy định rõ vai trò AI
- prompt phải giới hạn phạm vi phản hồi
- prompt phải yêu cầu AI diễn đạt dễ hiểu với người nước ngoài
- prompt phải ưu tiên điều hướng tới nội dung phù hợp khi dữ liệu chưa đủ

#### NV13. Sinh phản hồi ngôn ngữ tự nhiên

Sau khi xác định ngữ cảnh và chọn prompt, AI tiến hành sinh câu trả lời bằng ngôn ngữ tự nhiên.

**Yêu cầu nghiệp vụ:**

- trả lời ngắn gọn khi câu hỏi đơn giản
- trả lời chi tiết khi câu hỏi mang tính học thuật hoặc nghiên cứu
- ưu tiên diễn đạt dễ hiểu đối với người nước ngoài
- không khẳng định thông tin vượt quá dữ liệu hiện có

#### NV14. Giải thích ngữ nghĩa văn hoá chuyên sâu

AI phải có khả năng giải thích các khái niệm văn hoá có chiều sâu, ví dụ:

- ý nghĩa tục thờ cúng tổ tiên
- ý nghĩa mâm ngũ quả ngày Tết
- biểu tượng của áo dài
- khác biệt phong tục giữa các miền

Đây là nghiệp vụ cốt lõi làm nổi bật giá trị nghiên cứu và ứng dụng của hệ thống, vì mục tiêu của hệ thống không chỉ là **cung cấp dữ liệu** mà còn là **truyền đạt tri thức văn hoá một cách có ngữ cảnh**.

#### NV15. Đề xuất nội dung phù hợp

Dựa trên câu hỏi hiện tại và ngữ cảnh trao đổi, AI đề xuất:

- bài viết liên quan
- chủ đề mở rộng
- phong tục tương đồng ở vùng khác
- nội dung nên tìm hiểu tiếp theo

**Mục tiêu nghiệp vụ:**

- hỗ trợ người dùng học theo lộ trình khám phá
- tăng khả năng kết nối giữa các thành phần tri thức trong hệ thống

#### NV16. Ghi nhận câu hỏi phổ biến và câu hỏi chưa trả lời tốt

Hệ thống AI lưu lại:

- câu hỏi được hỏi nhiều
- chủ đề được quan tâm cao
- câu hỏi không có dữ liệu phù hợp
- trường hợp phản hồi còn yếu hoặc thiếu căn cứ

**Mục đích nghiệp vụ:**

- phục vụ dashboard quản trị
- hỗ trợ phát hiện thiếu hụt nội dung
- tạo cơ sở cho việc cải tiến kho tri thức và prompt của hệ thống



### 10.3. Nhóm nghiệp vụ dành cho quản trị viên

#### NV17. Đăng nhập và xác thực quản trị

Quản trị viên đăng nhập vào hệ thống CMS để thực hiện các nghiệp vụ quản lý.

**Yêu cầu:**

- có cơ chế xác thực an toàn
- có phân quyền phù hợp giữa các vai trò quản trị
- chỉ người có quyền mới được truy cập dashboard và dữ liệu nội bộ

#### NV18. Quản lý bài viết văn hoá

Admin có thể:

- thêm mới bài viết
- chỉnh sửa bài viết
- xoá bài viết
- lưu nháp
- gửi duyệt
- xuất bản
- ẩn bài viết
- gắn vùng miền, dân tộc, danh mục và thẻ liên quan

**Mục tiêu nghiệp vụ:**

- duy trì và mở rộng kho tri thức văn hoá
- bảo đảm thông tin được quản lý tập trung và có cấu trúc

#### NV19. Quản lý danh mục và cấu trúc tri thức

Admin quản lý các thực thể nền tảng như:

- danh mục chủ đề
- vùng miền
- dân tộc
- thẻ nội dung
- từ khoá
- liên kết bài viết

**Mục tiêu nghiệp vụ:**

- tạo cấu trúc tri thức nhất quán
- hỗ trợ tìm kiếm, lọc và đề xuất nội dung hiệu quả

#### NV20. Quản lý dữ liệu đa phương tiện

Admin có thể:

- tải ảnh lên
- tải video lên
- sửa thông tin mô tả media
- gắn media vào bài viết
- tối ưu kích thước và định dạng

**Mục đích nghiệp vụ:**

- tăng tính trực quan cho bài viết
- giúp người dùng quốc tế hiểu ngữ cảnh văn hoá tốt hơn
- nâng cao chất lượng trình bày nội dung

#### NV21. Kiểm duyệt nội dung trước khi công khai

Mọi nội dung mới hoặc nội dung được chỉnh sửa phải trải qua quy trình kiểm duyệt trước khi hiển thị cho người dùng cuối.

**Mục tiêu nghiệp vụ:**

- bảo đảm tính chính xác học thuật
- tránh sai lệch thông tin, đặc biệt với nội dung nhạy cảm về tín ngưỡng, dân tộc hoặc phong tục
- tạo nguồn tri thức đủ tin cậy cho AI sử dụng

#### NV22. Quản lý dữ liệu phục vụ AI

Sau khi bài viết được duyệt, hệ thống phải đồng bộ dữ liệu sang tầng AI thông qua các bước như:

- chuẩn hoá nội dung
- tóm tắt nội dung trọng tâm
- gắn metadata
- cập nhật liên kết bài viết liên quan
- cập nhật prompt template hoặc biến ngữ cảnh liên quan
- đánh dấu nội dung sẵn sàng cho AI sử dụng

Đây là nghiệp vụ quan trọng vì nó bảo đảm AI luôn sử dụng dữ liệu mới nhất đã được kiểm duyệt.

#### NV23. Theo dõi thống kê và hành vi người dùng

Dashboard quản trị cần hiển thị:

- số lượt truy cập
- bài viết được xem nhiều
- chủ đề được tìm kiếm nhiều
- câu hỏi AI phổ biến
- tỷ lệ phản hồi hữu ích
- nội dung chưa đủ dữ liệu

**Mục đích nghiệp vụ:**

- hỗ trợ quản trị viên ra quyết định cải tiến nội dung
- nhận diện xu hướng quan tâm của người dùng
- đánh giá hiệu quả hoạt động của hệ thống

#### NV24. Quản lý phản hồi người dùng

Admin xem và xử lý các phản hồi đánh giá từ người dùng để:

- sửa nội dung chưa rõ
- bổ sung kiến thức còn thiếu
- cải thiện trải nghiệm người dùng
- điều chỉnh cơ chế trả lời của AI khi cần thiết

---

## 11. Quy trình nghiệp vụ cốt lõi

### 11.1. Quy trình tra cứu nội dung văn hoá

1. Người dùng truy cập website  
2. Người dùng chọn vùng miền, dân tộc hoặc danh mục nội dung  
3. Hệ thống truy vấn dữ liệu phù hợp từ kho tri thức  
4. Hệ thống trả về danh sách bài viết tương ứng  
5. Người dùng chọn một bài viết để xem chi tiết  
6. Hệ thống hiển thị nội dung song ngữ và media minh hoạ  
7. Hệ thống đề xuất bài viết và chủ đề liên quan  
8. Người dùng có thể tiếp tục tra cứu hoặc gửi phản hồi  

### 11.2. Quy trình hỏi đáp với AI Chatbot

1. Người dùng nhập câu hỏi bằng tiếng Việt hoặc tiếng Anh  
2. Hệ thống nhận diện ngôn ngữ đầu vào  
3. Hệ thống phân tích ý định, từ khoá và ngữ cảnh câu hỏi  
4. Hệ thống xác định nội dung liên quan từ bài viết, metadata, danh mục, vùng miền, dân tộc hoặc từ khoá  
5. Hệ thống chọn prompt template phù hợp  
6. Mô hình ngôn ngữ sinh phản hồi dựa trên ngữ cảnh đã được cung cấp  
7. Hệ thống trả câu trả lời cho người dùng theo ngôn ngữ phù hợp  
8. Hệ thống đồng thời đề xuất bài viết hoặc chủ đề liên quan  
9. Lịch sử hỏi đáp và phản hồi đánh giá được lưu để phục vụ cải tiến hệ thống  

### 11.3. Quy trình cập nhật nội dung và đồng bộ AI

1. Admin tạo mới hoặc chỉnh sửa bài viết  
2. Nội dung được lưu ở trạng thái nháp  
3. Admin gửi nội dung sang bước kiểm duyệt  
4. Người có thẩm quyền kiểm tra và xác nhận nội dung hợp lệ  
5. Bài viết được xuất bản  
6. Hệ thống đánh dấu nội dung cần cập nhật cho AI  
7. Quá trình chuẩn hoá nội dung, tóm tắt trọng tâm và cập nhật metadata được kích hoạt  
8. Bộ dữ liệu dùng cho AI và các prompt liên quan được cập nhật  
9. AI sử dụng ngay nội dung mới trong các phiên hỏi đáp tiếp theo  

### 11.4. Quy trình xử lý phản hồi người dùng

1. Người dùng đánh giá bài viết hoặc câu trả lời AI  
2. Hệ thống lưu phản hồi vào cơ sở dữ liệu  
3. Dashboard thống kê hiển thị các phản hồi theo mức độ ưu tiên  
4. Admin xem xét phản hồi, xác định nguyên nhân  
5. Nếu cần, admin chỉnh sửa nội dung, bổ sung bài viết hoặc cập nhật prompt AI  
6. Hệ thống ghi nhận trạng thái đã xử lý phản hồi  

---

## 12. Quy tắc nghiệp vụ (Business Rules)

### BR01
Mọi nội dung công khai cho người dùng phải ở trạng thái đã duyệt.

### BR02
Mọi phản hồi từ AI phải ưu tiên dựa trên dữ liệu đã được kiểm duyệt trong hệ thống, không được trả lời tự do ngoài phạm vi tri thức khi không có căn cứ rõ ràng.

### BR03
Nếu không tìm thấy dữ liệu phù hợp, AI phải phản hồi theo hướng trung thực, chẳng hạn:

- chưa có dữ liệu đầy đủ
- đề nghị người dùng xem bài viết liên quan
- hoặc đưa câu hỏi vào nhóm cần bổ sung nội dung

### BR04
Mỗi bài viết phải thuộc ít nhất một danh mục.

### BR05
Mỗi bài viết phải gắn với ít nhất một vùng miền hoặc một nhóm dân tộc liên quan.

### BR06
Mỗi bài viết công khai phải hỗ trợ tối thiểu hai ngôn ngữ: tiếng Việt và tiếng Anh.

### BR07
Media tải lên phải gắn với ít nhất một bài viết hoặc một thực thể văn hoá cụ thể.

### BR08
Khi bài viết đã xuất bản được cập nhật nội dung, hệ thống phải đánh dấu trạng thái cần cập nhật lại dữ liệu phục vụ AI.

### BR09
Câu hỏi của người dùng có thể được lưu để cải thiện hệ thống nhưng phải tuân thủ nguyên tắc bảo mật dữ liệu và bảo vệ thông tin cá nhân.

### BR10
Dashboard thống kê chỉ hiển thị cho người có quyền quản trị.

### BR11
Người dùng khách không được phép chỉnh sửa, xuất bản hoặc kiểm duyệt nội dung tri thức.

### BR12
Nội dung công khai cần có nguồn tham khảo hoặc căn cứ kiểm chứng phù hợp để bảo đảm độ tin cậy học thuật.

### BR13
Bản dịch song ngữ phải bảo đảm tương đương về nghĩa, không được chỉ phụ thuộc vào dịch máy mà không qua kiểm tra.

### BR14
Đối với nội dung nhạy cảm liên quan đến tín ngưỡng, dân tộc, tập quán đặc thù hoặc diễn giải lịch sử, hệ thống phải áp dụng mức kiểm duyệt chặt hơn trước khi công khai.

### BR15
AI không được tạo nguồn tham khảo giả hoặc khẳng định chắc chắn khi độ tin cậy dữ liệu thấp.

### BR16
Khi hệ thống không đủ cơ sở dữ liệu để trả lời, mức độ khẳng định trong phản hồi AI phải được giảm xuống tương ứng.

### BR17
Mỗi thay đổi đối với bài viết đã xuất bản cần được lưu vết để phục vụ kiểm tra và truy hồi nội dung khi cần.

### BR18
Chỉ nội dung đã được chuẩn hoá và đánh dấu sẵn sàng cho AI mới được xem là có thể phục vụ hỏi đáp.

---

## 13. Luồng ngoại lệ và tình huống đặc biệt

### 13.1. Đối với người dùng khách

- Nếu người dùng tìm kiếm nhưng không có kết quả, hệ thống cần gợi ý từ khoá gần đúng hoặc danh mục liên quan.
- Nếu người dùng đặt câu hỏi ngoài phạm vi tri thức, AI cần từ chối mềm và hướng người dùng sang nội dung gần nhất.
- Nếu người dùng nhập câu hỏi mơ hồ, hệ thống có thể trả lời theo hướng khái quát trước, sau đó gợi ý đào sâu thêm.

### 13.2. Đối với quản trị viên

- Nếu bài viết thiếu bản dịch tiếng Anh hoặc tiếng Việt, hệ thống không cho phép xuất bản công khai.
- Nếu bài viết chưa gắn danh mục hoặc vùng miền hoặc dân tộc, hệ thống cảnh báo thiếu dữ liệu bắt buộc.
- Nếu media không đúng định dạng hoặc dung lượng vượt ngưỡng, hệ thống từ chối tải lên.
- Nếu quá trình cập nhật dữ liệu phục vụ AI thất bại, hệ thống phải ghi log lỗi và hiển thị trạng thái chưa sẵn sàng cho AI.

### 13.3. Đối với AI

- Nếu không xác định được ngữ cảnh phù hợp, AI phải trả lời trung thực thay vì đoán.
- Nếu câu hỏi chứa yếu tố nhạy cảm hoặc dễ gây hiểu sai văn hoá, AI cần phản hồi thận trọng, trung tính và có định hướng nội dung chính thống.
- Nếu có sự mâu thuẫn giữa các nguồn dữ liệu nội bộ, hệ thống cần ưu tiên nội dung đã được đánh dấu kiểm duyệt chính thức.

---

## 14. Yêu cầu chức năng chi tiết

### 14.1. Yêu cầu chức năng cho người dùng khách

- xem trang chủ và phần giới thiệu hệ thống
- khám phá bản đồ văn hoá tương tác
- xem nội dung theo vùng miền, dân tộc, danh mục
- tìm kiếm nội dung theo từ khoá và chủ đề gần đúng
- chuyển đổi ngôn ngữ Việt - Anh
- xem bài viết chi tiết
- hỏi đáp với AI Chatbot
- nhận đề xuất nội dung liên quan
- gửi phản hồi đánh giá bài viết hoặc phản hồi AI

### 14.2. Yêu cầu chức năng cho quản trị viên

- đăng nhập và đăng xuất quản trị
- quản lý bài viết văn hoá
- quản lý danh mục
- quản lý vùng miền và dân tộc
- quản lý thẻ và từ khoá
- quản lý media
- kiểm duyệt nội dung
- xuất bản hoặc ẩn bài viết
- theo dõi dashboard thống kê
- theo dõi lịch sử câu hỏi AI
- quản lý nội dung cần bổ sung cho AI
- cập nhật hoặc giám sát prompt và dữ liệu đầu vào phục vụ AI

### 14.3. Yêu cầu chức năng cho AI

- nhận diện ngôn ngữ đầu vào
- phân tích ý định câu hỏi
- xác định dữ liệu liên quan từ kho tri thức
- chọn prompt phù hợp với ngữ cảnh
- sinh phản hồi ngôn ngữ tự nhiên có kiểm soát
- giải thích ngữ nghĩa văn hoá theo ngữ cảnh
- gợi ý nội dung liên quan
- ghi nhận lịch sử hỏi đáp
- ghi nhận câu hỏi thiếu dữ liệu hoặc độ tin cậy thấp

---

## 15. Yêu cầu phi chức năng

### 15.1. Tính chính xác

Nội dung văn hoá và phản hồi AI phải bám sát dữ liệu đã được kiểm duyệt, hạn chế tối đa sai lệch hoặc suy diễn không có căn cứ.

### 15.2. Tính dễ sử dụng

Giao diện cần trực quan, rõ ràng, thân thiện với cả người Việt và người nước ngoài, đặc biệt với người chưa quen văn hoá Việt Nam.

### 15.3. Hiệu năng

Hệ thống phải phản hồi nhanh khi:

- tìm kiếm nội dung
- tải bài viết
- truy cập bản đồ
- hỏi đáp AI

### 15.4. Khả năng mở rộng

Hệ thống phải dễ dàng mở rộng:

- thêm chủ đề văn hoá mới
- thêm dữ liệu cho các dân tộc
- thêm ngôn ngữ khác ngoài Việt - Anh
- mở rộng quy mô kho tri thức

### 15.5. Bảo mật

Hệ thống phải:

- bảo vệ tài khoản admin
- bảo vệ dữ liệu người dùng
- bảo vệ API backend và AI
- kiểm soát truy cập tới dashboard và CMS

### 15.6. Khả năng bảo trì

Kiến trúc phần mềm cần phân tầng rõ ràng, dễ cập nhật module frontend, backend, CMS, AI service và cơ sở dữ liệu.

### 15.7. Tính quốc tế hoá

Hệ thống phải hỗ trợ định dạng nội dung, cách trình bày và diễn đạt phù hợp với người dùng quốc tế.

### 15.8. Độ tin cậy của AI

AI phải có cơ chế kiểm soát phản hồi bằng prompt, dữ liệu đã kiểm duyệt và luật nghiệp vụ, giảm nguy cơ ảo giác và có khả năng phản hồi trung thực khi thiếu dữ liệu.

### 15.9. Khả năng quan sát và giám sát

Hệ thống cần ghi log các hoạt động chính như:

- truy vấn người dùng
- lịch sử hỏi đáp AI
- trạng thái cập nhật dữ liệu cho AI
- thao tác quản trị

để phục vụ giám sát, kiểm tra lỗi và cải tiến hệ thống.

---

## 16. Chỉ số đánh giá hiệu quả nghiệp vụ và hệ thống

### 16.1. Chỉ số về nội dung

- tỷ lệ bài viết công khai có đủ 2 ngôn ngữ
- tỷ lệ bài viết có đầy đủ metadata: danh mục, vùng miền hoặc dân tộc, thẻ, media
- tỷ lệ bài viết đã duyệt trên tổng số bài viết

### 16.2. Chỉ số về tìm kiếm và khám phá

- tỷ lệ truy vấn tìm kiếm trả về kết quả phù hợp
- số lượt xem trung bình trên mỗi phiên truy cập
- tỷ lệ người dùng tiếp tục xem bài viết liên quan sau khi đọc bài đầu tiên

### 16.3. Chỉ số về AI

- thời gian phản hồi trung bình của AI
- tỷ lệ phản hồi AI được người dùng đánh giá hữu ích
- tỷ lệ câu hỏi không có đủ dữ liệu để trả lời
- tỷ lệ phản hồi AI bám sát đúng phạm vi dữ liệu nội bộ

### 16.4. Chỉ số về trải nghiệm người dùng

- mức độ hài lòng của người dùng qua phản hồi đánh giá
- tỷ lệ người dùng quay lại hệ thống
- thời gian trung bình người dùng ở lại hệ thống

### 16.5. Chỉ số về vận hành và cải tiến

- số lượng câu hỏi phổ biến được phát hiện qua hệ thống AI
- số lượng nội dung được bổ sung dựa trên phản hồi người dùng
- thời gian từ khi bài viết được duyệt đến khi dữ liệu sẵn sàng cho AI sử dụng

---

## 17. Mô hình nghiệp vụ theo Use Case

### 17.1. Use Case cho Guest

- xem bản đồ văn hoá
- xem danh mục văn hoá
- tìm kiếm nội dung
- chuyển ngôn ngữ
- xem bài viết chi tiết
- hỏi AI
- xem gợi ý liên quan
- gửi phản hồi

### 17.2. Use Case cho Admin

- đăng nhập
- quản lý bài viết
- quản lý danh mục
- quản lý vùng miền hoặc dân tộc
- quản lý media
- kiểm duyệt nội dung
- theo dõi dashboard
- quản lý dữ liệu AI
- xem phản hồi người dùng
- theo dõi lịch sử câu hỏi AI

### 17.3. Use Case cho AI Service

- nhận câu hỏi
- xác định ngôn ngữ
- phân tích ý định
- xác định ngữ cảnh nội dung
- chọn prompt phù hợp
- sinh câu trả lời
- đề xuất nội dung
- ghi log câu hỏi
- gắn cờ câu hỏi thiếu dữ liệu

---

## 18. Giá trị khoa học và thực tiễn của hệ thống

### 18.1. Giá trị khoa học

Về mặt khoa học, hệ thống **VNCultureBridge AI** không chỉ là một website giới thiệu văn hoá mà còn là một mô hình ứng dụng AI trong lĩnh vực nhân văn số. Điểm đóng góp chính của đề tài là:

- số hoá tri thức văn hoá theo cấu trúc có tổ chức
- kết hợp dữ liệu có kiểm duyệt với AI sinh ngôn ngữ tự nhiên
- kiểm soát chất lượng phản hồi AI bằng prompt và luật nghiệp vụ
- hỗ trợ truyền đạt tri thức văn hoá xuyên ngôn ngữ và xuyên bối cảnh

Đề tài góp phần minh hoạ cách ứng dụng AI có kiểm soát trong các lĩnh vực giàu sắc thái ngữ nghĩa như văn hoá, lịch sử, tập quán và tín ngưỡng.

### 18.2. Giá trị thực tiễn

Về mặt thực tiễn, hệ thống có thể mang lại các lợi ích sau:

- giúp người nước ngoài hiểu đúng và sâu hơn về văn hoá Việt Nam
- tăng khả năng quảng bá văn hoá dân tộc bằng nền tảng số hiện đại
- hỗ trợ giảng dạy, học tập, nghiên cứu và truyền thông văn hoá
- góp phần bảo tồn và lan toả tri thức văn hoá theo cách có hệ thống
- tạo nền tảng dữ liệu mở rộng cho các ứng dụng AI văn hoá trong tương lai

### 18.3. Ý nghĩa xã hội

Hệ thống có ý nghĩa trong việc:

- tăng cường giao lưu văn hoá quốc tế
- hỗ trợ phổ biến tri thức văn hoá chuẩn xác
- góp phần xây dựng hình ảnh Việt Nam thân thiện, sâu sắc và giàu bản sắc trong mắt bạn bè quốc tế

---

## 19. Đề xuất bổ sung để tăng tính thông minh và tính tế nhị của hệ thống

### 19.1. Xử lý Culture Shock

Hệ thống AI nên được bổ sung khả năng điều chỉnh sắc thái diễn giải đối với những nội dung có thể gây bỡ ngỡ hoặc hiểu lầm cho người dùng quốc tế. Ví dụ, với những phong tục có yếu tố hiến tế, nghi lễ liên quan đến cái chết hoặc tập quán tín ngưỡng khác biệt với tư duy phương Tây, AI không chỉ giải thích khái niệm mà cần trình bày dưới góc nhìn tôn trọng sự đa dạng văn hoá, tránh phán xét hoặc đơn giản hoá vấn đề.

### 19.2. Nguồn dữ liệu chuẩn

Để tăng độ tin cậy học thuật, cần làm rõ rằng dữ liệu đưa vào hệ thống phải được thu thập từ các nguồn có thẩm quyền, ví dụ:

- công trình nghiên cứu của Viện Văn hoá
- sách của các nhà nghiên cứu uy tín như Hữu Ngọc, Toan Ánh
- tư liệu từ bảo tàng, thư viện, cơ quan quản lý văn hoá
- nguồn tư liệu chính thống đã được kiểm chứng

Điều này giúp hệ thống có cơ sở dữ liệu chuẩn để vừa phục vụ hiển thị nội dung, vừa bảo đảm AI không sinh phản hồi thiếu căn cứ.

### 19.3. Cá nhân hoá theo quốc gia của người dùng

Hệ thống AI có thể nâng cao trải nghiệm bằng cách phân tích ngữ cảnh tiếp nhận của người dùng. Ví dụ:

- một người Nhật hỏi về Tết có thể được giải thích bằng cách so sánh với một số đặc điểm quen thuộc trong văn hoá Nhật
- một người Mỹ hỏi về Tết có thể được diễn đạt theo hướng giúp họ liên hệ với khái niệm đoàn tụ gia đình, năm mới âm lịch hoặc nghi thức cộng đồng

Việc cá nhân hoá như vậy giúp AI truyền đạt hiệu quả hơn, dễ hiểu hơn và phù hợp hơn với nền tảng văn hoá của từng nhóm người dùng.

### 19.4. Làm rõ mô hình bản đồ tương tác

Cần xác định rõ bản đồ trong hệ thống là:

- **bản đồ địa lý 2D**, gắn với ranh giới hành chính hiện đại, hoặc
- **bản đồ vùng văn hoá**, phản ánh không gian văn hoá thực tế, vốn có thể không trùng khít hoàn toàn với địa giới hành chính

Đối với đề tài này, bản đồ vùng văn hoá thường phù hợp hơn về mặt học thuật và nghiệp vụ, vì nó phản ánh đúng bản chất lan toả, giao thoa và đặc trưng của đời sống văn hoá Việt Nam.

---

## 20. Kết luận

Từ các phân tích trên, có thể xác định rằng **VNCultureBridge AI** là một hệ thống tích hợp nhiều nhóm nghiệp vụ quan trọng, bao gồm quản trị tri thức văn hoá, tra cứu thông minh, hỗ trợ song ngữ, hỏi đáp bằng AI và theo dõi dữ liệu vận hành để cải tiến liên tục.

Hệ thống không chỉ phục vụ nhu cầu tra cứu thông tin đơn thuần mà còn đóng vai trò như một nền tảng trung gian giúp truyền tải bản sắc văn hoá Việt Nam tới cộng đồng quốc tế theo cách chính xác, trực quan, hiện đại và có chiều sâu ngữ nghĩa.

Điểm cốt lõi của hệ thống nằm ở việc kết hợp giữa kho tri thức văn hoá đã kiểm duyệt với AI Chatbot sử dụng cơ chế **prompt có kiểm soát** và **ngữ cảnh dữ liệu nội bộ** để tạo ra các phản hồi vừa tự nhiên, vừa đáng tin cậy. Điều này giúp hệ thống vượt ra khỏi mô hình website giới thiệu nội dung truyền thống, tiến tới một nền tảng tri thức số có giá trị học thuật và ứng dụng thực tiễn cao.
