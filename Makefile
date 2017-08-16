.PHONY: all test release

all: test

test:
	mvn test

-include tchannel-crossdock/rules.mk

release:
	@echo "please make sure you are using java 7."
	@read -p "Press any key to continue, or press Control+C to cancel. " x;
	mvn -Dbuild=release release:clean release:prepare
	mvn -Dbuild=release release:perform

install_ci:
ifdef CROSSDOCK
	$(MAKE) install_docker_ci
else
	true
endif


test_ci:
ifdef CROSSDOCK
	$(MAKE) crossdock_ci
else
	mvn --show-version clean org.jacoco:jacoco-maven-plugin:prepare-agent test org.jacoco:jacoco-maven-plugin:report-aggregate
endif
