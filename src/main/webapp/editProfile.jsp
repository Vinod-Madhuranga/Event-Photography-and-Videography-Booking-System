<div class="container mt-5 mb-4">
    <div class="profile-card">
        <h3>Edit Profile</h3>
        <form action="UpdateProfileServlet" method="POST">
            <div class="row">
                <div class="col-md-4 mb-3">
                    <label for="fullName" class="form-label text-white">Full Name</label>
                    <input type="text" class="form-control" id="fullName" name="fullName" value="<%= (adminFName != null && adminLName != null) ? adminFName + ' ' + adminLName : '' %>">
                </div>
                <div class="col-md-4 mb-3">
                    <label for="username" class="form-label text-white">Username</label>
                    <input type="text" class="form-control" id="username" name="username" value="<%= (adminUsername != null) ? adminUsername : '' %>">
                </div>
                <div class="col-md-4 mb-3">
                    <label for="email" class="form-label text-white">Email</label>
                    <input type="email" class="form-control" id="email" name="email" value="<%= (adminEmail != null) ? adminEmail : '' %>">
                </div>
                <div class="col-md-4 mb-3">
                    <label for="gender" class="form-label text-white">Gender</label>
                    <select class="form-select" id="gender" name="gender">
                        <option value="Male" <%= "Male".equals(adminGender) ? "selected" : "" %>>Male</option>
                        <option value="Female" <%= "Female".equals(adminGender) ? "selected" : "" %>>Female</option>
                        <option value="Other" <%= "Other".equals(adminGender) ? "selected" : "" %>>Other</option>
                        <option value="Prefer not to say" <%= "Prefer not to say".equals(adminGender) ? "selected" : "" %>>Prefer not to say</option>
                    </select>
                </div>
                <div class="col-md-4 mb-3">
                    <label for="phone" class="form-label text-white">Phone</label>
                    <input type="text" class="form-control" id="phone" name="phone" value="<%= (adminPhone != null) ? adminPhone : '' %>">
                </div>
                <div class="col-md-4 mb-3">
                    <label for="address" class="form-label text-white">Address</label>
                    <input type="text" class="form-control" id="address" name="address" value="<%= (adminAddress != null) ? adminAddress : '' %>">
                </div>
            </div>
            <button type="submit" class="btn btn-primary">Save Changes</button>
            <a href="profile.jsp" class="btn btn-secondary">Cancel</a>
        </form>
    </div>
</div>