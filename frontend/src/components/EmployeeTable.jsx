import React from 'react';
import PropTypes from 'prop-types';

/**
 * EmployeeTable Component
 * Displays employees in a table with Edit and Delete actions
 * 
 * @param {Array} employees - Array of employee objects
 * @param {Function} onEdit - Handler for edit action
 * @param {Function} onDelete - Handler for delete action
 */
function EmployeeTable({ employees, onEdit, onDelete }) {
    // Helper to safely get employee property (handles case variations)
    const getField = (emp, field) => {
        return emp[field.toUpperCase()] || emp[field] || emp[field.toLowerCase()] || '';
    };

    if (employees.length === 0) {
        return (
            <div className="empty-state">
                <p>No employees found. Click "Add Employee" to get started.</p>
            </div>
        );
    }

    return (
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>First Name</th>
                    <th>Last Name</th>
                    <th>Role</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                {employees.map((employee) => {
                    const id = getField(employee, 'ID');
                    return (
                        <tr key={id}>
                            <td>{id}</td>
                            <td>{getField(employee, 'FIRSTNAME')}</td>
                            <td>{getField(employee, 'LASTNAME')}</td>
                            <td>{getField(employee, 'ROLE')}</td>
                            <td className="actions">
                                <button
                                    className="btn-edit"
                                    onClick={() => onEdit(employee)}
                                    aria-label={`Edit ${getField(employee, 'FIRSTNAME')}`}
                                >
                                    Edit
                                </button>
                                <button
                                    className="btn-delete"
                                    onClick={() => onDelete(employee)}
                                    aria-label={`Delete ${getField(employee, 'FIRSTNAME')}`}
                                >
                                    Delete
                                </button>
                            </td>
                        </tr>
                    );
                })}
            </tbody>
        </table>
    );
}

EmployeeTable.propTypes = {
    employees: PropTypes.arrayOf(
        PropTypes.shape({
            ID: PropTypes.number,
            FIRSTNAME: PropTypes.string,
            LASTNAME: PropTypes.string,
            ROLE: PropTypes.string,
        })
    ).isRequired,
    onEdit: PropTypes.func.isRequired,
    onDelete: PropTypes.func.isRequired,
};

export default EmployeeTable;
