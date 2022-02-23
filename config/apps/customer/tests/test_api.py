from django.contrib.auth.models import User
from django.urls import reverse

from rest_framework import status
from rest_framework.test import APITestCase

from config.apps.customer.models import Customer


class CustomerTests(APITestCase):
    @classmethod 
    def setUpClass(cls) -> None:
        super().setUpClass()

        cls.superuser = User.objects.create_superuser (
            username='admin',
            email='admin@gmail.com',
            password='admin'
        )

        cls.customer = Customer.objects.create (
            username='tassimo',
            phone_number='+27815042200',
            amount_repaid=300.0,
            loan_amount=400.0,
            arrears_prepayment=100.0,
            expected_pay_date='2022-02-20',
            coordinates='23345.332',
            region='Cape Town'
        )

        cls.customer_to_delete = Customer.objects.create (
            username='moyo',
            phone_number='+27815742200',
            amount_repaid=500.0,
            loan_amount=500.0,
            arrears_prepayment=0.0,
            expected_pay_date='2022-02-20',
            coordinates='233055.332',
            region='Cape Town'
        )

    def test_list_customers(self):
        # login
        #self.client.force_authenticate(self.superuser)
        self.client.force_authenticate(self.superuser)
        url = reverse('customers-list')
        data = {}
        res = self.client.get(url, data, format='json')
        self.assertEqual(res.status_code, status.HTTP_200_OK)
        self.assertEqual(len(res.data),  Customer.objects.count() )

    def test_get_song(self):
        # login
        self.client.force_authenticate(self.superuser)
        url = reverse('customers-detail', kwargs={"pk": self.customer.pk})
        data = {}
        res = self.client.get(url, data, format='json')
        self.assertEqual(res.status_code, status.HTTP_200_OK)
        self.assertEqual(res.data['id'], self.customer.pk) 
        self.assertEqual(res.data['username'], self.customer.username) 
        self.assertEqual(res.data["amount_repaid"], self.customer.amount_repaid) 
        self.assertEqual(res.data["arrears_prepayment"], self.customer.arrears_prepayment)

    def test_create_customer_allowed(self):
        #login
        self.client.force_authenticate(self.superuser)
        url = reverse('customers-list')
        data = {
            "username":'kevin',
            "phone_number":'+27816342200',
            "amount_repaid": 2500.0,
            "loan_amount": 2000.0,
            "arrears_prepayment": 500.0,
            "expected_pay_date": '2022-02-20',
            "coordinates": '253055.332',
            "region": 'Cape Town'
        }
        
        res = self.client.post(url, data, format='json')
        self.assertEqual(res.status_code, status.HTTP_201_CREATED)

        # logout
        self.client.logout()

    def test_create_customer_restricted(self):
        #logout user if login
        self.client.logout()

        url = reverse('customers-list')
        data = {
            "username":'enow',
            "phone_number":'+27816311100',
            "amount_repaid": 2500.0,
            "loan_amount": 2000.0,
            "arrears_prepayment": 500.0,
            "expected_pay_date": '2022-02-20',
            "coordinates": '253055.332',
            "region": 'Cape Town'
        }
        
        res = self.client.post(url, data, format='json')
        self.assertEqual(res.status_code, status.HTTP_401_UNAUTHORIZED)
    """
    testing if we could modify a customer's detail
    """
    def test_change_customer_allowed(self):
        # login
        self.client.force_authenticate(self.superuser)

        url = reverse('customers-detail', kwargs={'pk': self.customer.pk})
        data = {
            'amount_repaid': 400.0,
            'arrears_prepayment': 0.0,
        }
        res = self.client.patch(url, data, format='json')
        self.assertEqual(res.status_code, status.HTTP_200_OK)
        self.assertEqual(res.data['id'], self.customer.pk)
        self.assertEqual(res.data['amount_repaid'], data['amount_repaid'])
        self.assertEqual(res.data['arrears_prepayment'], data['arrears_prepayment'])

        # logout
        self.client.logout()


    def test_change_customer_restricted(self):
        # logout if login
        self.client.logout()

        url = reverse('customers-detail', kwargs={'pk': self.customer.pk})
        data = {
            'amount_repaid': 200.0,
            'arrears_prepayment': 200.0,
        }
        res = self.client.patch(url, data, format='json')
        self.assertEqual(res.status_code, status.HTTP_401_UNAUTHORIZED)

    def test_delete_customer_restricted(self):
        # logout if login
        self.client.logout()

        url = reverse('customers-detail', kwargs={'pk': self.customer_to_delete.pk})
        data = {}

        res = self.client.delete(url, data, format='json')
        self.assertEqual(res.status_code, status.HTTP_401_UNAUTHORIZED)

    def test_delete_customer_allowed(self):
        # logout if login
        self.client.force_authenticate(self.superuser)

        url = reverse('customers-detail', kwargs={'pk': self.customer_to_delete.pk})
        data = {}

        res = self.client.delete(url, data, format='json')
        self.assertEqual(res.status_code, status.HTTP_204_NO_CONTENT)



    @classmethod
    def tearDownClass(cls) -> None:
        super().tearDownClass()
        cls.customer.delete()
        cls.customer_to_delete.delete()
        cls.superuser.delete()
