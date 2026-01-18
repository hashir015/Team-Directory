/**
 * API Service Layer
 * Centralized API communication for Team Directory
 * 
 * Provides consistent error handling and JSON parsing
 * for all CRUD operations
 */

const API_BASE_URL = 'http://localhost:8500/team-directory/backend/api.cfm';

/**
 * Generic fetch wrapper with error handling
 * @param {string} url - API endpoint URL
 * @param {object} options - Fetch options
 * @returns {Promise<any>} Parsed JSON response
 */
async function apiRequest(url, options = {}) {
    const defaultOptions = {
        headers: {
            'Content-Type': 'application/json',
        },
    };

    const response = await fetch(url, { ...defaultOptions, ...options });

    if (!response.ok) {
        const errorData = await response.json().catch(() => ({}));
        throw new Error(errorData.error || `HTTP Error: ${response.status} ${response.statusText}`);
    }

    return response.json();
}

/**
 * Fetch all employees
 * @returns {Promise<Array>} Array of employee objects
 */
export async function fetchEmployees() {
    const data = await apiRequest(API_BASE_URL);
    return Array.isArray(data) ? data : [];
}

/**
 * Create a new employee
 * @param {object} employeeData - Employee data { firstName, lastName, role }
 * @returns {Promise<object>} Created employee object
 */
export async function createEmployee(employeeData) {
    return apiRequest(API_BASE_URL, {
        method: 'POST',
        body: JSON.stringify({
            FIRSTNAME: employeeData.firstName,
            LASTNAME: employeeData.lastName,
            ROLE: employeeData.role,
        }),
    });
}

/**
 * Update an existing employee
 * @param {number} id - Employee ID
 * @param {object} employeeData - Updated employee data
 * @returns {Promise<object>} Updated employee object
 */
export async function updateEmployee(id, employeeData) {
    return apiRequest(`${API_BASE_URL}?id=${id}`, {
        method: 'PUT',
        body: JSON.stringify({
            FIRSTNAME: employeeData.firstName,
            LASTNAME: employeeData.lastName,
            ROLE: employeeData.role,
        }),
    });
}

/**
 * Delete an employee
 * @param {number} id - Employee ID
 * @returns {Promise<object>} Deletion confirmation
 */
export async function deleteEmployee(id) {
    return apiRequest(`${API_BASE_URL}?id=${id}`, {
        method: 'DELETE',
    });
}

export default {
    fetchEmployees,
    createEmployee,
    updateEmployee,
    deleteEmployee,
};
