from django.db import models
from django.utils.translation import gettext_lazy as _ 

# Create your models here.
class CreationUpdatedBaseModel(models.Model):
   created_at = models.DateTimeField(_("Created at"), auto_now_add=True)
   updated_at = models.DateTimeField(_("Upated at"), auto_now=True)

   class Meta:
       abstract = True 
    
 