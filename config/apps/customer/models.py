import re

from django.core import validators
from django.db import models
from django.utils.translation import gettext_lazy as _

from config.apps.core.models import CreationUpdatedBaseModel


# Create your models here.
class Customer(CreationUpdatedBaseModel):
    username = models.CharField(
        db_index=True,
        verbose_name="Username",
        unique=True,
        max_length=255,
        help_text=(
            "Required. 255 characters or fewer. Letters, numbers and @/./+/-/_ characters"
        ),
        validators=[
            validators.RegexValidator(
                re.compile("^[\w.@+-]+$"), "Enter a valid username.", "invalid"
            )
        ],
    )
    phone_number = models.CharField(
        max_length=12,
        verbose_name="phone_number",
        unique=True,
        help_text=(
            "Phone number must be entered in the format: '+27815742271'. Up to 11 digits allowed."
        ),
        validators=[
            validators.RegexValidator(
                re.compile("^\+?27?[6-8][0-9]{8}$"),
                "Enter a valid phone number",
                "Invalid phone number",
            )
        ],
    )
    amount_repaid = models.FloatField(_("Amount repaid"))
    loan_amount = models.FloatField(_("Loan amount"))
    arrears_prepayment = models.FloatField(_("Arrears prepayment"))
    expected_pay_date = models.DateField(_("Expected pay date"))
    coordinates = models.CharField(_("Coordinates"), max_length=50)
    region = models.CharField(_("Region"), max_length=50)
    
    def __str__(self) -> str:
        return self.username