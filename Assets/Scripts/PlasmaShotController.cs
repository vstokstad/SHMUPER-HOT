using UnityEngine;

public class PlasmaShotController : MonoBehaviour {
    public float plasmaDamage = 1f;
    private readonly string enemyTag = "Enemy";
    private ParticleSystem _particleSystem;

    private void Awake(){
        _particleSystem = GetComponent<ParticleSystem>();
    }

    private void OnEnable(){
        _particleSystem.Play();
        enabled = true;
    }

    private void OnDisable(){
        _particleSystem.Stop();
        enabled = true;
    }

    private void OnBecameInvisible(){
        gameObject.SetActive(false);
    }

    private void OnTriggerEnter(Collider other){
        if (!other.gameObject.CompareTag(enemyTag)) return;
        FindObjectOfType<WeaponManager.PlasmaShot>().ammunition += 1;
        other.gameObject.GetComponent<EnemyController>().TakeDamage(plasmaDamage);
        gameObject.SetActive(false);
    }
}