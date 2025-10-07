from django.http import JsonResponse
from django.views import View


class HealthCheckView(View):
    """
    A simple view that returns a 200 OK status if the service is running.
    Used by the deployment script to verify application health.
    """

    def get(self, request, *args, **kwargs):
        return JsonResponse({"status": "ok", "service": "api"})
