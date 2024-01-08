install:
	install -d /usr/local/bin/
	install -m 755 pyoc /usr/local/bin/

install-rule:
	@test $(vendor) || (echo "vendor is not set"; exit 1)
	@test $(product) || (echo "product is not set"; exit 1)
	sed "s/VENDOR/$(vendor)/g;s/PRODUCT/$(product)/g" 99-overclock-amdgpu.rules > /etc/udev/rules.d/99-overclock-amdgpu.rules
	udevadm control --reload-rules
	udevadm trigger
