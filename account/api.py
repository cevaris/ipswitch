from tastypie.resources import ModelResource
from account.models import BetAccount
from tastypie.bundle import Bundle
from django.forms.models import model_to_dict


class BetAccountResource(ModelResource):
    class Meta:
        queryset = BetAccount.objects.all()
        resource_name = 'betAccount'
        
    def alter_list_data_to_serialize(self, request, data):
        """
        A hook to alter list data just before it gets serialized & sent to the user.
    
        Useful for restructuring/renaming aspects of the what's going to be
        sent.
    
        Should accommodate for a list of objects, generally also including
        meta data.
        """
        
        response = []
        for element in data[ 'objects' ]:
            print type(element), type(element.obj)
            response.append(model_to_dict(element.obj))
        
        return { 'objects' : response}
        
#        return { 'objects' : data[ 'objects' ], 'total_amount' : total_amount }            
#        return data
            
#        for object in data[ 'objects' ]:
#            total_amount += object[ 'amount' ]
#        return { 'objects' : data[ 'objects' ], 'total_amount' : total_amount }
