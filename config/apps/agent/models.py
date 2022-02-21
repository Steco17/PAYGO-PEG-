from django.contrib.auth.models import User
from django.db import models
from django.utils.translation import gettext_lazy as _

from config.apps.core.models import CreationUpdatedBaseModel

from .app_settings import AGENT_DUTY_POST_CHOICES
"""
creating aganet model which will have the same properties as
the default django user model.
the Agant also have duty post
"""

# Create your models here.
class Agent(CreationUpdatedBaseModel):
    #linking Agent model to default django model
    user = models.OneToOneField(User, verbose_name=_("User Agent"), on_delete=models.CASCADE)
    duty_post = models.CharField(
        _("Duty post"),
        choices=AGENT_DUTY_POST_CHOICES,
        default=AGENT_DUTY_POST_CHOICES[0][0],
        max_length=50
    )


    
