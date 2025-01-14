# Copyright (C) 2009-2020 MongoDB Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

module BSON

  # Represents a $minKey type, which compares less than any other value in the
  # specification.
  #
  # @see http://bsonspec.org/#/specification
  #
  # @since 2.0.0
  class MinKey
    include Comparable
    include JSON
    include Specialized

    # A $minKey is type 0xFF in the BSON spec.
    #
    # @since 2.0.0
    BSON_TYPE = 255.chr.force_encoding(BINARY).freeze

    # Constant for always evaluating lesser in a comparison.
    #
    # @since 2.0.0
    LESSER = -1.freeze

    # When comparing a min key with any other object, the min key will always
    # be lesser.
    #
    # @example Compare with another object.
    #   min_key <=> 1000
    #
    # @param [ Object ] other The object to compare against.
    #
    # @return [ Integer ] Always -1.
    #
    # @since 2.0.0
    def <=>(other)
      LESSER
    end

    # Return a representation of the object for use in
    # application-level JSON serialization. Since BSON::MinKey
    # is used exclusively in BSON-related contexts, this
    # method returns the canonical Extended JSON representation.
    #
    # @return [ Hash ] The extended json representation.
    def as_json(*_args)
      as_extended_json
    end

    # Converts this object to a representation directly serializable to
    # Extended JSON (https://github.com/mongodb/specifications/blob/master/source/extended-json.rst).
    #
    # @option opts [ nil | :relaxed | :legacy ] :mode Serialization mode
    #   (default is canonical extended JSON)
    #
    # @return [ Hash ] The extended json representation.
    def as_extended_json(**options)
      { "$minKey" => 1 }
    end

    # Register this type when the module is loaded.
    #
    # @since 2.0.0
    Registry.register(BSON_TYPE, self)
  end
end
