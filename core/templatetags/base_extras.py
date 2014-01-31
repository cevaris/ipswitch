from django import template
from django.core.urlresolvers import reverse

register = template.Library()

@register.simple_tag
def navactive(path, urls):
    
    # For root case
    if path == '/' and urls == '':
        return 'active'

    if path in ( reverse(url) for url in urls.split() ):
        return 'active'
    
    return ""