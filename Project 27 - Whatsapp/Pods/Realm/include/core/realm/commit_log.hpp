/*************************************************************************
 *
 * Copyright 2016 Realm Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 **************************************************************************/

#ifndef REALM_COMMIT_LOG_HPP
#define REALM_COMMIT_LOG_HPP

#include <stdexcept>
#include <string>

#include <realm/binary_data.hpp>
#include <realm/replication.hpp>


namespace realm {

// FIXME: Why is this exception class exposed?
class LogFileError: public std::runtime_error {
public:
    LogFileError(const std::string& file_name):
        std::runtime_error(file_name)
    {
    }
};

/// Create a writelog collector and associate it with a filepath. You'll need
/// one writelog collector for each shared group. Commits from writelog
/// collectors for a specific filepath may later be obtained through other
/// writelog collectors associated with said filepath.  The caller assumes
/// ownership of the writelog collector and must destroy it, but only AFTER
/// destruction of the shared group using it.
std::unique_ptr<Replication>
make_client_history(const std::string& path, const char* encryption_key = nullptr);

} // namespace realm


#endif // REALM_COMMIT_LOG_HPP
