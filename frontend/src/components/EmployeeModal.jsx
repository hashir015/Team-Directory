import React, { useState, useEffect } from 'react';
import PropTypes from 'prop-types';

/**
 * EmployeeModal Component
 * Modal form for adding or editing employees
 * 
 * @param {boolean} isOpen - Modal visibility state
 * @param {string} mode - 'add' or 'edit'
 * @param {object} employee - Employee data for editing (null for add)
 * @param {Function} onSave - Handler for save action
 * @param {Function} onClose - Handler for close action
 */
function EmployeeModal({ isOpen, mode, employee, onSave, onClose }) {
    // Form state
    const [formData, setFormData] = useState({
        firstName: '',
        lastName: '',
        role: '',
    });
    const [errors, setErrors] = useState({});
    const [isSubmitting, setIsSubmitting] = useState(false);

    // Reset form when modal opens or employee changes
    useEffect(() => {
        if (isOpen) {
            if (mode === 'edit' && employee) {
                setFormData({
                    firstName: employee.FIRSTNAME || employee.FirstName || '',
                    lastName: employee.LASTNAME || employee.LastName || '',
                    role: employee.ROLE || employee.Role || '',
                });
            } else {
                setFormData({ firstName: '', lastName: '', role: '' });
            }
            setErrors({});
        }
    }, [isOpen, mode, employee]);

    // Handle input changes
    const handleChange = (e) => {
        const { name, value } = e.target;
        setFormData((prev) => ({ ...prev, [name]: value }));
        // Clear error when user types
        if (errors[name]) {
            setErrors((prev) => ({ ...prev, [name]: '' }));
        }
    };

    // Validate form
    const validateForm = () => {
        const newErrors = {};

        if (!formData.firstName.trim()) {
            newErrors.firstName = 'First name is required';
        } else if (formData.firstName.length > 50) {
            newErrors.firstName = 'First name must be less than 50 characters';
        }

        if (!formData.lastName.trim()) {
            newErrors.lastName = 'Last name is required';
        } else if (formData.lastName.length > 50) {
            newErrors.lastName = 'Last name must be less than 50 characters';
        }

        if (!formData.role.trim()) {
            newErrors.role = 'Role is required';
        } else if (formData.role.length > 100) {
            newErrors.role = 'Role must be less than 100 characters';
        }

        setErrors(newErrors);
        return Object.keys(newErrors).length === 0;
    };

    // Handle form submission
    const handleSubmit = async (e) => {
        e.preventDefault();

        if (!validateForm()) {
            return;
        }

        setIsSubmitting(true);

        const id = employee?.ID || employee?.id;
        const result = await onSave(formData, mode === 'edit' ? id : null);

        setIsSubmitting(false);

        if (result.success) {
            onClose();
        } else {
            setErrors({ submit: result.error });
        }
    };

    // Handle overlay click
    const handleOverlayClick = (e) => {
        if (e.target === e.currentTarget) {
            onClose();
        }
    };

    // Handle escape key
    useEffect(() => {
        const handleEscape = (e) => {
            if (e.key === 'Escape' && isOpen) {
                onClose();
            }
        };

        document.addEventListener('keydown', handleEscape);
        return () => document.removeEventListener('keydown', handleEscape);
    }, [isOpen, onClose]);

    if (!isOpen) return null;

    return (
        <div className="modal-overlay" onClick={handleOverlayClick} role="dialog" aria-modal="true">
            <div className="modal">
                <h2>{mode === 'add' ? 'Add New Employee' : 'Edit Employee'}</h2>

                {errors.submit && (
                    <div className="form-error-banner">{errors.submit}</div>
                )}

                <form onSubmit={handleSubmit} noValidate>
                    <div className="form-group">
                        <label htmlFor="firstName">First Name</label>
                        <input
                            type="text"
                            id="firstName"
                            name="firstName"
                            value={formData.firstName}
                            onChange={handleChange}
                            placeholder="Enter first name"
                            maxLength={50}
                            className={errors.firstName ? 'input-error' : ''}
                            disabled={isSubmitting}
                        />
                        {errors.firstName && <span className="field-error">{errors.firstName}</span>}
                    </div>

                    <div className="form-group">
                        <label htmlFor="lastName">Last Name</label>
                        <input
                            type="text"
                            id="lastName"
                            name="lastName"
                            value={formData.lastName}
                            onChange={handleChange}
                            placeholder="Enter last name"
                            maxLength={50}
                            className={errors.lastName ? 'input-error' : ''}
                            disabled={isSubmitting}
                        />
                        {errors.lastName && <span className="field-error">{errors.lastName}</span>}
                    </div>

                    <div className="form-group">
                        <label htmlFor="role">Role</label>
                        <input
                            type="text"
                            id="role"
                            name="role"
                            value={formData.role}
                            onChange={handleChange}
                            placeholder="Enter role (e.g., Software Engineer)"
                            maxLength={100}
                            className={errors.role ? 'input-error' : ''}
                            disabled={isSubmitting}
                        />
                        {errors.role && <span className="field-error">{errors.role}</span>}
                    </div>

                    <div className="modal-actions">
                        <button
                            type="button"
                            className="btn-cancel"
                            onClick={onClose}
                            disabled={isSubmitting}
                        >
                            Cancel
                        </button>
                        <button
                            type="submit"
                            className="btn-save"
                            disabled={isSubmitting}
                        >
                            {isSubmitting ? 'Saving...' : (mode === 'add' ? 'Add Employee' : 'Save Changes')}
                        </button>
                    </div>
                </form>
            </div>
        </div>
    );
}

EmployeeModal.propTypes = {
    isOpen: PropTypes.bool.isRequired,
    mode: PropTypes.oneOf(['add', 'edit']).isRequired,
    employee: PropTypes.object,
    onSave: PropTypes.func.isRequired,
    onClose: PropTypes.func.isRequired,
};

EmployeeModal.defaultProps = {
    employee: null,
};

export default EmployeeModal;
