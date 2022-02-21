from django.apps import AppConfig
from django.utils.translation import gettext_lazy as _


class AgentConfig(AppConfig):
    default_auto_field = 'django.db.models.BigAutoField'
    name = 'config.apps.agent'
    verbose_name = _('Agent')

