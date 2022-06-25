---
layout: post
title: "The Tao of Go - Đạo lập trình Go"
date: 2022-05-10 00:00:00
description: "Bài dịch từ trang https://bitfieldconsulting.com/golang/tao-of-go"
tags: 
 - Golang
 - Programming
---


# Đặt vấn đề



Trên đây là những gì mình biết về tính kết thúc của một giao dịch trong các giao thức đồng thuận (consensus protocol). Hi vọng thông qua những nội dung mình truyền tải đã giúp các bạn phần nào hiểu được như thế nào là tính kết thúc của giao dịch và có thể đánh giá được một giao thức là đủ tốt (ở nhiều khía cạnh) để có thể sử dụng trong việc thanh toán. Nếu bạn thấy bài viết này hay, đừng ngần ngại chia sẽ cho những người có cùng sự quan tâm với chúng ta nhé.

*Lời cuối cùng xin cảm ơn tác giả Alexis Gauba và bài viết Finality in Blockchain Consensus của cô ở Medium. Bạn đọc có thể đọc bài viết này tại [link](https://medium.com/mechanism-labs/finality-in-blockchain-consensus-d1f83c120a9a).*

**Disclamer: Mình chưa phải là một chuyên gia về lập trình hay blockchain nên trong bài viết có thể còn nhiều thiếu sót hoặc nhầm lẫn. Mọi ý kiến đóng góp vui lòng mang tính lịch sự và cùng nhau phát triển. Chúc mọi người ngày càng phát triển hơn trên con đường của mình đã chọn.**

[^1]: *Nếu sử dụng Bitcoin. Lời người viết.*
[^2]: *Lời người viết.*
[^3]: [Towards Robust Distributed Systems. Eric A. Brewer.](https://people.eecs.berkeley.edu/~brewer/cs262b-2004/PODC-keynote.pdf)
[comment]: (/assets/documents/Towards_Robust_Distributed_Systems_Eric_A_Brewer.pdf)
[^4]: [ThunderCore \(LitePaper\). Rafael Pass and Elaine Shi.](https://docs.thundercore.com/thunder-litepaper.pdf)
[comment]: (/assets/documents/ThunderCore_(LitePaper)_Rafael_Pass_and_Elaine_Shi.pdf)
[^5]: [Thunderella: Blockchains with Optimistic Instant Confirmation. Rafael Pass and Elaine Shi.](https://eprint.iacr.org/2017/913.pdf)
[comment]: (/assets/documents/Thunderella_Blockchains_with_Optimistic_Instant_Confirmation_Rafael_Pass_and_Elaine_Shi.pdf)
[^6]: [Ouroboros Genesis: Composable Proof-of-Stake Blockchains with Dynamic Availability.](https://eprint.iacr.org/2018/378.pdf)
[comment]: (/assets/documents/Ouroboros_Genesis_Composable_Proof-of-Stake_Blockchains_with_Dynamic_Availability.pdf)
