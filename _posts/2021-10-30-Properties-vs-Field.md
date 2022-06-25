---
layout: post
title: "Properties vs Field vs Attribute. Quen mà lạ, lạ nhưng lại quen?"
date: 2021-10-30 00:00:00
description: 'Chắc hẳn ai từng đã học và làm việc với lập trình hướng đối tượng cũng đã từng sử dụng một trong ba (hoặc cả ba) khái niệm này. Vậy bạn đã thực sự hiểu những khái niệm này và sự khác nhau giữa chúng chưa?'
tags: 
 - Những điều khác biệt
 - CSharp
 - Programming
---
Trong chuỗi bài viết [Những điều khác biệt](/tag/Những%20điều%20khác%20biệt/) mình so sánh về những điều khác nhau giữa những khái niệm dễ gây nhầm lẫn trong lập trình, ở bài viết trước, mình đã viết về [Interface vs Abstract class](/2021/10/Interface-vs-Abstract-class-Xài-sao-cho-đúng/). Tiếp tục trong bài viết này, chúng ta sẽ cùng nhau tìm hiểu về khái niệm, cách sử dụng Property, Field và Attribute trong lập trình và sự khác nhau giữa chúng là gì nhé.

*Trong bài viết này (và những bài viết về sau), mình sẽ dùng các khái niệm với tên tiếng Anh và đi kèm chú thích tiếng Việt trong ngoặc ngay sau đó nhằm giúp bạn đọc có thể dễ dàng quen với tên gọi tiếng Anh của các khái niệm, dễ dàng tự tra cứu tìm kiếm về chúng hơn trên Internet. Mình tôn trọng sự trong sáng của tiếng Việt và sẽ viết thuần tiếng Việt nhiều nhất có thể. Cảm ơn bạn đã quan tâm và đọc bài viết của mình.*

Vào một ngày đẹp trời trong quá khứ, mình mở máy lên và code như mọi ngày. Tay gõ tổ hợp quen thuộc <br><code>prop</code> <code>tab</code> <code>tab</code> để sinh ra dòng code <code>public int Property { get; set; }</code> , mình chợt đặt ra câu hỏi, tại sao 

# Định nghĩa [^1]
## Field là gì?

Trước khi biết về Property thì chúng ta sẽ tìm hiểu khái niệm về **Field (trường)** trước. Theo tài liệu  của Microsoft về [Field trong ngôn ngữ lập trình C#](https://docs.microsoft.com/en-us/dotnet/csharp/programming-guide/classes-and-structs/fields), **Field** là một biến với kiểu dữ liệu tùy ý được khai báo trực tiếp trong struct (cấu trúc) hoặc class (lớp) và là members (thành phần) của class và struct. Field **nên** được dùng với **access modifiers** (cấp độ truy cập) là **private** hoặc **protected** (dù bạn vẫn có thể khai báo cấp độ truy cập là public) để bên ngoài không thể truy cập tùy tiện.

Field trong ngôn ngữ lập trình C# có hai dạng:
- Instance field: Instance field thuộc về đối tượng. Nghĩa là, nếu bạn tạo hai đối tượng từ class T có instance field F1, hai giá trị F1 của hai đối tượng vừa được tạo ra là độc lập với nhau. 
Cách truy cập: <code>instanceName._fieldName<code>.
- Static field:  Static field đi kèm theo class (hoặc struct) và thuộc về class (hoặc struct) đó. Nghĩa là, nếu bạn tạo hai đối tượng từ class T có static field F2, giá trị F2 của hai đối tượng vừa được tạo ra là như nhau, và khi thay đổi F2 của một trong hai đối tượng thì đối tượng còn lại cũng sẽ bị thay đổi. 
Cách truy cập: <code>className._fieldName<code>.

Ví dụ về field:
```c#
public class Student
{
    // public field
    public string id;
    
    // private field
    private DateTime birthday;
    private int age;

    // protected field
    protected string name;

    // static field
    public static string accessToken;
}
```

## Property là gì?
Tiếp đến chúng ta sẽ cùng tìm hiểu về khái niệm [**Property (thuộc tính)**](https://docs.microsoft.com/en-us/dotnet/csharp/programming-guide/classes-and-structs/properties) trong C#. Đối với Property, Microsoft định nghĩa Property là members (thành phần) cung cấp các cơ chế đọc, ghi và tính toán giá trị cho **private field** (field có access modifiers là private). Property có thể được dùng như một public data member (thành phần dữ liệu công khai) của class, nhưng người ta thường dùng kèm với những get-set accessors (trình truy cập) để đạt được tính đóng gói (encapsulation), tính bảo mật và linh hoạt của dữ liệu. 
Như vậy, bạn có thể thấy rằng Property giống như một lớp vỏ của Field, cung cấp các cơ chế tính toán trên dữ liệu, còn Field giống như công cụ đằng sau Property để lưu trữ dữ liệu. Nên nếu bạn tạo Property với những phương thức get-set chưa được cài đặt (chưa cài đặt cho hai phương thức này thì C# cũng sẽ không hiểu Field đằng sau lưu trữ dữ liệu của bạn là gì), thì C# sẽ tự động tạo cho bạn Field ẩn dùng để lưu dữ liệu cho Property này, đây gọi là **auto-implemented properties**.

Ví dụ về property:
```c#
public class Person
{
    string _name; // private field
    
    public string Name1 // property with field called "_name"
    {
        get => _name;
        set => _name = value;
    }

    public string Name2 { get; set; } // property with hiding field
}
```

## Backing store/Backing field
Ở trên chúng ta đã tìm hiểu sơ lược về property và field. Và hiểu thêm về khái niệm **backing store/backing field** là một điều cần thiết. Trong các ví dụ trên về property, ta thấy rằng trong phương thức get-set của public property có truy cập đến một (hoặc/có thể là một vài) private field khác. Việc làm này được gọi là backing store/backing field, nghĩa là việc bạn tường minh dùng một private field để lưu trữ dữ liệu cho public property. Việc làm này giúp bạn có thể trực tiếp tác động vào backing field, thay đổi hoặc chỉnh sửa field này trong phạm vi class. Nếu sử dụng auto-implemented properties bạn sẽ không tác động được vào hiding field của property này.
Sử dụng backing field/backing store có thể hữu ích trong một vài trường hợp, ví dụ như việc khi bạn cần thay đổi dữ liệu của property đồng thời cần thay đổi dữ liệu của một (hoặc một vài) field khác, hoặc cần gọi một function nào đó mỗi khi property này thay đổi giá trị. Mình sẽ cho ví dụ cụ thể hơn để dễ hiểu trong trường hợp này.
```c#
public class Person
{
    int _age = 0;

    DateTime _birthDate;
    public DateTime BirthDate
    {
        get => _birthDate;
        set { _birthDate = value; UpdateAge(); }
    }

    public void UpdateAge()
    {
        _age = (DateTime.Now - _birthDate).TotalDays / 365;
    }
}
```
*Trong ví dụ này, vì một lý do nào đó bạn vừa có thông tin về tuổi (_age) và ngày sinh (_birthDate) của một người (dù điều này không được khuyến khích, vì có thể gây bất đồng nhất dữ liệu khi bạn thay đổi một field và quên mất việc phải thay đổi field còn lại), và khi thông tin về ngày sinh thay đổi, bạn muốn cùng lúc đó thông tin về tuổi cũng được cập nhật tương ứng, thì việc dùng backing field và implement (cài đặt) phương thức set sẽ giúp bạn ngay sau khi cập nhật _birthDate có thể gọi hàm **UpdateAge()** ngay sau đó để cập nhật _age mà không bị quên hay bỏ sót dẫn đến việc bất đồng nhất dữ liệu*. [^2]

# So sánh



# Cách sử dụng

# Kết

**Disclamer: Do mình cũng chưa phải là một chuyên gia về lập trình hay ngôn ngữ C# nên trong bài viết chắc hẳn còn nhiều thiếu sót hoặc nhầm lẫn. Mọi ý kiến đóng góp vui lòng mang tính lịch sự và cùng nhau phát triển. Bài này khá dài và mình xin cảm ơn sự quan tâm của mọi khi đã đọc đến đây. Chúc mọi người ngày càng phát triển hơn trên con đường lập trình của mình.**

[^1]: Đây là bài viết nhằm so sánh và giúp bạn phân biệt rõ ràng hơn về Property và Field trong C# nên mình chỉ nêu ra những đặc trưng nhất của hai khái niệm này. Về chi tiết hơn trong từng khái niệm, hãy cùng mình chờ đọc những bài viết sau nói cụ thể hơn về một khái niệm nhất định nhé.
[^2]: *Lời người viết*.