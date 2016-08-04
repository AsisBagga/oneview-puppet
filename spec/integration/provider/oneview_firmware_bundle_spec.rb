################################################################################
# (C) Copyright 2016 Hewlett Packard Enterprise Development LP
#
# Licensed under the Apache License, Version 2.0 (the "License");
# You may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
################################################################################

require 'spec_helper'

provider_class = Puppet::Type.type(:oneview_firmware_bundle).provider(:ruby)

describe provider_class do
  let(:resource) do
    Puppet::Type.type(:oneview_firmware_bundle).new(
      name: 'firmware_bundle',
      ensure: 'present',
      data:
          {
            'firmware_bundle_path' => './spec/support/cp022594.exe'
          }
    )
  end

  before(:each) do
    provider.exists?
  end

  let(:provider) { resource.provider }

  let(:instance) { provider.class.instances.first }

  context 'given the minimum parameters' do
    it 'should be an instance of the provider Ruby' do
      expect(provider).to be_an_instance_of Puppet::Type.type(:oneview_firmware_bundle).provider(:ruby)
    end

    it 'should raise error when firmware bundle is not found' do
      expect { provider.found }.to raise_error(/"Found" is not a valid ensurable for firmware bundle./)
    end

    it 'should raise an error since the destroy operation is not supported' do
      expect { provider.destroy }.to raise_error(/"Absent" is not a valid ensurable for firmware bundle./)
    end

    it 'should create/add the firmware bundle' do
      expect(provider.create).to be
    end
  end
end