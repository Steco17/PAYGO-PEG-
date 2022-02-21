from django.contrib import admin
from django.contrib.auth.models import Group, User

from .models import Customer

# Register your models here.

class CustomerAdmin(admin.ModelAdmin):
    pass

# Unregister your models here
admin.site.unregister(Group)
admin.site.unregister(User)

# Register your models here.
admin.site.register(Customer, CustomerAdmin)