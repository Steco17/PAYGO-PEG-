from tabnanny import verbose
from django.contrib import admin
from django.contrib.auth.models import User
from django.contrib.auth.admin import UserAdmin
from .models import Agent
# Register your models here.

class AgentInLine(admin.StackedInline):
    model = Agent

class CustomUserAdmin(UserAdmin):
    fieldsets = (
        (                 
            'Personal Info',  
            {
                'fields': (
                    'username', 'password','is_staff'
                ),
            },
        ),
    )
    
    add_fieldsets = (
        (                 
            'Personal Info',  
            {
                'fields': (
                    'username', 'password1','password2'
                ),
            },
        ),
    )
    inlines = [AgentInLine]


# Register your models here.
admin.site.register(User, CustomUserAdmin)