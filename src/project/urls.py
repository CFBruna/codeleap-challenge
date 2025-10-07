from django.contrib import admin
from django.urls import include, path
from drf_spectacular.views import (
    SpectacularAPIView,
    SpectacularRedocView,
    SpectacularSwaggerView,
)
from rest_framework.routers import DefaultRouter

from src.apps.core.views import HealthCheckView
from src.apps.posts.views import PostViewSet

router = DefaultRouter()
router.register(r"careers", PostViewSet, basename="post")


urlpatterns = [
    path("admin/", admin.site.urls),
    path("api/v1/status/", HealthCheckView.as_view(), name="health_check"),
    path("api/v1/schema/", SpectacularAPIView.as_view(), name="schema"),
    path(
        "api/v1/schema/swagger-ui/",
        SpectacularSwaggerView.as_view(url_name="schema"),
        name="swagger-ui",
    ),
    path(
        "api/v1/schema/redoc/",
        SpectacularRedocView.as_view(url_name="schema"),
        name="redoc",
    ),
    path("", include(router.urls)),
]
