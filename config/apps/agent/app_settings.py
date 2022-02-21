from django.conf import settings
from django.utils.translation import gettext_lazy as _
#creating a specific atrribute agents duty post
AGENT_DUTY_POST_CHOICES = getattr(settings, 
'DUTY_POST_CHOICES',
[ 
    ('agent_1', _('Agent 1')),
    ('agent_2', _('Agent 2')),
    ('agent_3', _('Agent 3')),
    ('agent_4', _('Agent 4')),
]
)