package dasturlash.uz.mini_blog.entity;


import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.CreationTimestamp;

import java.time.LocalDateTime;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@Builder

@Entity
public class Post {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    private String title;
    @Column(columnDefinition = "TEXT")
    private String content;
    @Column(name = "user_id")
    private Integer userId;
    @Column(name = "created_date",columnDefinition = "Timestamp default now()")
    @CreationTimestamp
    private LocalDateTime createdDate;
}
