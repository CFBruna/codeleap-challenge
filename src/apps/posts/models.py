from django.db import models


class Post(models.Model):
    """
    Represents a single post entry for the CodeLeap challenge.
    """

    username = models.CharField(max_length=150)
    created_datetime = models.DateTimeField(auto_now_add=True)
    title = models.CharField(max_length=255)
    content = models.TextField()

    class Meta:
        ordering = ["-created_datetime"]
        verbose_name = "Post"
        verbose_name_plural = "Posts"

    def __str__(self) -> str:
        return f'"{self.title}" by {self.username}'
