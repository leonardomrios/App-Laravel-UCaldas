<template>
    <AppLayout title="Crear Evento">
        <template #header>
            <div class="flex justify-between items-center">
                <h2 class="font-semibold text-xl text-gray-800 dark:text-gray-200 leading-tight">
                    Crear Nuevo Evento
                </h2>
                <Link
                    :href="route('events.index')"
                    class="px-4 py-2 bg-gray-800 dark:bg-gray-700 text-white rounded-md hover:bg-gray-700 dark:hover:bg-gray-600"
                >
                    Volver a Eventos
                </Link>
            </div>
        </template>

        <div class="py-12">
            <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
                <div class="bg-white dark:bg-gray-800 overflow-hidden shadow-xl sm:rounded-lg p-6">
                    <form @submit.prevent="submitForm">
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                            <!-- Nombre del Evento -->
                            <div>
                                <InputLabel for="event_name" value="Nombre del Evento" class="dark:text-gray-300" />
                                <TextInput
                                    id="event_name"
                                    v-model="form.event_name"
                                    type="text"
                                    class="mt-1 block w-full"
                                    :class="{'border-red-500': form.errors.event_name}"
                                    required
                                    autofocus
                                />
                                <div v-if="form.errors.event_name" class="text-red-600 dark:text-red-400 text-sm mt-1">
                                    {{ form.errors.event_name }}
                                </div>
                            </div>

                            <!-- Selección de Venue -->
                            <div>
                                <InputLabel for="fk_venue_event" value="Venue" class="dark:text-gray-300" />
                                <select
                                    id="fk_venue_event"
                                    v-model="form.fk_venue_event"
                                    class="mt-1 block w-full border-gray-300 dark:border-gray-700 dark:bg-gray-900 dark:text-gray-300 focus:border-indigo-300 focus:ring focus:ring-indigo-200 focus:ring-opacity-50 rounded-md shadow-sm"
                                    :class="{'border-red-500': form.errors.fk_venue_event}"
                                    required
                                >
                                    <option value="">Seleccionar Venue</option>
                                    <option v-for="venue in venues" :key="venue.id" :value="venue.id">
                                        {{ venue.venue_name }} (Cap: {{ venue.venue_max_capacity }})
                                    </option>
                                </select>
                                <div v-if="form.errors.fk_venue_event" class="text-red-600 dark:text-red-400 text-sm mt-1">
                                    {{ form.errors.fk_venue_event }}
                                </div>
                            </div>

                            <!-- Fecha del Evento -->
                            <div>
                                <InputLabel for="event_date" value="Fecha y Hora del Evento" class="dark:text-gray-300" />
                                <TextInput
                                    id="event_date"
                                    v-model="form.event_date"
                                    type="datetime-local"
                                    class="mt-1 block w-full"
                                    :class="{'border-red-500': form.errors.event_date}"
                                    required
                                />
                                <div v-if="form.errors.event_date" class="text-red-600 dark:text-red-400 text-sm mt-1">
                                    {{ form.errors.event_date }}
                                </div>
                            </div>

                            <!-- Nombre del Orador -->
                            <div>
                                <InputLabel for="event_speaker_name" value="Nombre del Orador" class="dark:text-gray-300" />
                                <TextInput
                                    id="event_speaker_name"
                                    v-model="form.event_speaker_name"
                                    type="text"
                                    class="mt-1 block w-full"
                                    :class="{'border-red-500': form.errors.event_speaker_name}"
                                />
                                <div v-if="form.errors.event_speaker_name" class="text-red-600 dark:text-red-400 text-sm mt-1">
                                    {{ form.errors.event_speaker_name }}
                                </div>
                            </div>

                            <!-- Tipo de Evento -->
                            <div>
                                <InputLabel value="Tipo de Evento" class="dark:text-gray-300" />
                                <div class="mt-2 flex space-x-6">
                                    <label class="flex items-center">
                                        <input
                                            type="radio"
                                            v-model="form.event_is_virtual"
                                            :value="false"
                                            class="text-indigo-600 focus:ring-indigo-500 border-gray-300 dark:border-gray-600"
                                            required
                                        />
                                        <span class="ml-2 text-sm text-gray-700 dark:text-gray-300">Presencial</span>
                                    </label>
                                    <label class="flex items-center">
                                        <input
                                            type="radio"
                                            v-model="form.event_is_virtual"
                                            :value="true"
                                            class="text-indigo-600 focus:ring-indigo-500 border-gray-300 dark:border-gray-600"
                                            required
                                        />
                                        <span class="ml-2 text-sm text-gray-700 dark:text-gray-300">Virtual</span>
                                    </label>
                                </div>
                                <div v-if="form.errors.event_is_virtual" class="text-red-600 dark:text-red-400 text-sm mt-1">
                                    {{ form.errors.event_is_virtual }}
                                </div>
                            </div>

                            <!-- Imagen del Evento -->
                            <div>
                                <InputLabel for="image" value="Imagen del Evento" class="dark:text-gray-300" />
                                <input
                                    id="event_image"
                                    type="file"
                                    @input="form.event_image = $event.target.files[0]"
                                    class="mt-1 block w-full text-sm text-gray-500 file:mr-4 file:py-2 file:px-4 file:rounded-full file:border-0 file:text-sm file:font-semibold file:bg-blue-50 file:text-blue-700 hover:file:bg-blue-100"
                                    accept="image/*"
                                />
                                <div v-if="form.errors.event_image" class="text-red-600 dark:text-red-400 text-sm mt-1">
                                    {{ form.errors.event_image }}
                                </div>
                            </div>
                        </div>

                        <!-- Botones de Acción -->
                        <div class="flex items-center justify-end mt-6">
                            <Link
                                :href="route('events.index')"
                                class="inline-flex items-center px-4 py-2 bg-gray-600 dark:bg-gray-700 border border-transparent rounded-md font-semibold text-xs text-white uppercase tracking-widest hover:bg-gray-700 dark:hover:bg-gray-600 active:bg-gray-900 focus:outline-none focus:border-gray-900 focus:ring focus:ring-gray-300 disabled:opacity-25 transition mr-4"
                            >
                                Cancelar
                            </Link>
                            
                            <PrimaryButton 
                                class="ml-4" 
                                :class="{'opacity-25': form.processing}" 
                                :disabled="form.processing"
                            >
                                <svg v-if="form.processing" class="animate-spin -ml-1 mr-3 h-4 w-4 text-white" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
                                    <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
                                    <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
                                </svg>
                                {{ form.processing ? 'Guardando...' : 'Crear Evento' }}
                            </PrimaryButton>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </AppLayout>
</template>

<script setup>
import { ref } from 'vue'
import { useForm } from '@inertiajs/vue3'
import AppLayout from '@/Layouts/AppLayout.vue'
import InputLabel from '@/Components/InputLabel.vue'
import TextInput from '@/Components/TextInput.vue'
import PrimaryButton from '@/Components/PrimaryButton.vue'
import { Link } from '@inertiajs/vue3'

// Props
const props = defineProps({
    venues: Array
})

// Form
const form = useForm({
    event_name: '',
    event_date: '',
    event_speaker_name: '',
    event_is_virtual: false,
    fk_venue_event: '',
    event_image: null
})

// Methods
const submitForm = () => {
    form.post(route('events.store'), {
        onSuccess: () => {
            // El redirect se maneja automáticamente por el controlador
        }
    })
}
</script>