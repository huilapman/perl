##Perl
### sock.pl - Socket Programming
Start Server 

	MacBook-Pro:perl sysroot$ ./sock.pl server

Start client 

	MacBook-Pro:perl sysroot$ ./sock.pl
	123
	456
	789

Switch to server

	MacBook-Pro:perl sysroot$ ./sock.pl server
	123
	456
	789

		
### google.pl - Google Social Login

 1. Register Credential in Google Developer Console 
 2. Redirect URIs: http://localhost/cgi-bin/google.pl
 3. Create file "google.ini"
 4. Surf http://localhost/cgi-bin/google.pl in browser
 5. Click the login link
 6. Allow application to use your google profile
 7. Response from Google

		Response from access token request
		
		 { "access_token" : "ya29.Glv1A2p0QfIGUgXuIa9-OMeoQ_rXPErcZSBayqqRMtmBgKBp6RoLYkZPKwbMQLik4SUhrhlRp7hRK2ubO5fY152R3HrSkLFt6wh6WZJtIC_bbW3owLv1Q0UlEvh5", "expires_in" : 3599, "id_token" : "eyJhbGciOiJSUzI1NiIsImtpZCI6IjM0ZWNjNzM3OGJiM2RjNDhkNGNlMDRmNzkyNGMxNjM0MjM0OTMyYmQifQ.eyJpc3MiOiJhY2NvdW50cy5nb29nbGUuY29tIiwiaWF0IjoxNDg3MzAyMTQ3LCJleHAiOjE0ODczMDU3NDcsImF0X2hhc2giOiI3alFvU3B4Ujk4NkNPVHpJQmJOTDFnIiwiYXVkIjoiNDAwODE4MDg1Mjk2LTY1cGRhcHIxZ3VlbDViODlwamozaTZubDZoN2N2YmtjLmFwcHMuZ29vZ2xldXNlcmNvbnRlbnQuY29tIiwic3ViIjoiMTA5NjA2OTM3MDk3OTY2MDE5NDY0IiwiZW1haWxfdmVyaWZpZWQiOnRydWUsImF6cCI6IjQwMDgxODA4NTI5Ni02NXBkYXByMWd1ZWw1Yjg5cGpqM2k2bmw2aDdjdmJrYy5hcHBzLmdvb2dsZXVzZXJjb250ZW50LmNvbSIsImVtYWlsIjoiaHVpbGFwbWFuQGdtYWlsLmNvbSJ9.LZvlgZYTVRlncRGktBxuy3qhI4gDHT9QpSYa76zeJcnzQx2NxUp2HBqEpZtXYs3a5hDAfFvDbfKlDNJdJC0HiTSKd2Hd099eVL0Kg0av66WCjgOBY4Nlu_HIBrAqzxWatTS3YlhZVD9fHAPlNH37lzOxR3sskm9lutTT1DUM5pLBU9e22p6GY4WDfiPy8xap7_lHpzzjaQ4RnRh9wv70g3qFEpVHoqc10Q-4jvzLqVTZsLPyCZF3mlE0BzWAg4PI9GOOReA9_SjZYSrnEwv-znDOm4BhDKEt8DpaKiSsxjeME4VYk9zs-scvoBfUgVXoziDGm_pS0iC7s2Vrlt7Ehg", "token_type" : "Bearer" }
		 
		Extract JSON Content
			
		access_token=ya29.Glv1A2p0QfIGUgXuIa9-OMeoQ_rXPErcZSBayqqRMtmBgKBp6RoLYkZPKwbMQLik4SUhrhlRp7hRK2ubO5fY152R3HrSkLFt6wh6WZJtIC_bbW3owLv1Q0UlEvh5
		expires_in=3599
		token_type=Bearer

		Response from info request
			
		{ "id": "X", "email": "X@gmail.com", "verified_email": true, "name": "X", "given_name": "X", "family_name": "X", "link": "X", "picture": "X", "gender": "X", "locale": "en" }
		
 8. Enable redirect if you want to have a clear link rather than http://localhost/cgi-bin/google.pl?state=random&code=4/2UlLYJlrQY52SXIrCvoCMhQIrN7grlBBiA-sR-3Kuk4#
