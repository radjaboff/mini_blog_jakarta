package dasturlash.uz.mini_blog.dto;


import java.time.LocalDateTime;

public record PostDTO(
        Integer id,
        String title,
        String content,
        Integer userId,
        String username,
        LocalDateTime createdDate,
        Integer likesCount,
        Integer viewsCount // 'time' emas, 'createdDate' bo'lishi kerak
) {
    public Integer getId() { return id; }
    public String getTitle() { return title; }
    public String getContent() { return content; }
    public Integer getUserId() { return userId; }
    public String getUsername() { return username; }
    public LocalDateTime getCreatedDate() { return createdDate; }
    public Integer getLikesCount() { return likesCount; }
    public Integer getViewsCount() { return viewsCount; }
}